using ApiChessMeet.DTO;
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
    }
}
