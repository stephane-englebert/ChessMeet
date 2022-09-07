using DalChessMeet.Interfaces;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DalChessMeet.Repositories
{
    public class TournamentRepository : ITournamentRepository
    {
        private readonly string connectionString
        = @"server=(localdb)\MSSQLLocalDB;Initial Catalog = ChessDB; Integrated Security = True;";
        public IEnumerable<Entities.Tournament> GetTournaments()
        {
            using SqlConnection connection = new SqlConnection(connectionString);
            connection.Open();
            using SqlCommand cmd = connection.CreateCommand();
            cmd.CommandText = @"SELECT * FROM [Tournaments]";
            using SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                yield return new Entities.Tournament
                {
                    Guid = (string)reader["guid"],
                    Name = (string)reader["name"],
                    Place = (string)reader["place"],
                    PlayersMin = (int)reader["players_min"],
                    PlayersMax = (int)reader["players_max"],
                    EloMin = (int)reader["elo_min"],
                    EloMax = (int)reader["elo_max"],
                    Categories = (string)reader["categories"],
                    Status = (string)reader["status"],
                    CurrentRound = (int)reader["current_round"],
                    WomenOnly = (bool)reader["women_only"],
                    EndRegistration = (DateTime)reader["end_registration"]
                };
            }
        }
        public void AddTournament(Entities.Tournament tournament)
        {
            using SqlConnection connection = new SqlConnection(connectionString);
            connection.Open();
            using SqlCommand cmd = connection.CreateCommand();
            cmd.CommandText = @"INSERT INTO [Tournaments](guid,name,place,players_min,players_max,elo_min,elo_max,categories,status,current_round,women_only,end_registration) 
            VALUES(
                @guid,
                @name,
                @place,
                @players_min,
                @players_max,
                @elo_min,
                @elo_max,
                @categories,
                @status,
                @current_round,
                @women_only,
                @end_registration
            )";
            cmd.Parameters.AddWithValue("guid",tournament.Guid);
            cmd.Parameters.AddWithValue("name", tournament.Name);
            cmd.Parameters.AddWithValue("place", tournament.Place);
            cmd.Parameters.AddWithValue("players_min", tournament.PlayersMin);
            cmd.Parameters.AddWithValue("players_max", tournament.PlayersMax);
            cmd.Parameters.AddWithValue("elo_min", tournament.EloMin);
            cmd.Parameters.AddWithValue("elo_max", tournament.EloMax);
            cmd.Parameters.AddWithValue("categories", tournament.Categories);
            cmd.Parameters.AddWithValue("status", tournament.Status);
            cmd.Parameters.AddWithValue("current_round", tournament.CurrentRound);
            cmd.Parameters.AddWithValue("women_only", tournament.WomenOnly);
            cmd.Parameters.AddWithValue("end_registration", tournament.EndRegistration);
            cmd.ExecuteNonQuery();
        }
    }
}
