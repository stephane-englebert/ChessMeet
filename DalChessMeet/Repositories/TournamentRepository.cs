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

        }
    }
}
