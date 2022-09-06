using ApiChessMeet.DTO;

namespace ApiChessMeet.Mappers
{
    public static class MapperExtensions
    {
        public static DalChessMeet.Entities.Member FormToDalMembers(this MemberFormDTO dto)
        {
            return new DalChessMeet.Entities.Member
            {
                Pseudo = dto.Pseudo,
                Email = dto.Email,
                Birthdate = dto.Birthdate,
                Gender = dto.Gender,
                Elo = dto.Elo
            };
        }
    }
}
