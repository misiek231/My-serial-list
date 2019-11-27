using MySerialList.Component;
using System.ComponentModel.DataAnnotations;

namespace MySerialList.Model.UserFilmProductions
{
    public class AddUserFilmProductionModel
    {
        [Required]
        public int FilmProductionId { get; set; }
        [Required]
        public WatchingStatus WatchingStatus { get; set; }
        public int? Episodes { get; set; }
    }
}