using System.ComponentModel.DataAnnotations;

namespace ApiChessMeet.DTO
{
    public class TournamentFormDTO
    {
        [Required]
        [MaxLength(255)]
        public string Name { get; set; } = string.Empty;
        
        [Required]
        [MaxLength(255)]
        public string Place { get; set; } = string.Empty;
        
        [Required]
        public int PlayersMin { get; set; }

        [Required]
        public int PlayersMax { get; set; }
        
        [Required]
        public int EloMin { get; set; }

        [Required]
        public int EloMax { get; set; }
        
        [Required]
        public string Categories { get; set; }

        [Required]
        public int CurrentRound { get; set; }

        [Required]
        public bool WomenOnly { get; set; }

        [Required]
        public DateTime EndRegistration { get; set; }
    }
}
