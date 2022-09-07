using ApiChessMeet.DTO;
using ApiChessMeet.Mappers;
using DalChessMeet.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ApiChessMeet.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TournamentsController : ControllerBase
    {
        private readonly ITournamentRepository _tournamentRepository;

        public TournamentsController(ITournamentRepository tournamentRepository)
        {
            _tournamentRepository = tournamentRepository;
        }

        [HttpGet]
        public IActionResult Get()
        {
            return Ok(_tournamentRepository.GetTournaments().Select(t => new TournamentDTO(t)));
        }

        [HttpPost]
        public IActionResult Post(TournamentFormDTO dto)
        {
            DalChessMeet.Entities.Tournament entity = dto.FormToDalTournaments();
            Guid g = Guid.NewGuid();
            entity.Guid = g.ToString();
            entity.Status = "WaitingForPlayers";
            string[] categories = entity.Categories.Split(',');
            foreach(string category in categories)
            {
                if(Array.IndexOf(categories, category) == -1)
                {
                    return BadRequest("Catégorie invalide!");
                }
            }
            _tournamentRepository.AddTournament(entity);
            return NoContent();
        }
    }
}
