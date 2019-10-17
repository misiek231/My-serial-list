using MovieBook.Component;
using MySerialList.Data.Model;
using System.ComponentModel.DataAnnotations.Schema;

namespace MovieBook.Data.Model
{
    public class WatchingFilmProductionStatus
    {
        public int Id { get; set; }
        public int FilmProductionId { get; set; }
        public string UserId { get; set; }
        public WatchingStatus WatchingStatus { get; set; }

        [ForeignKey("UserId")]
        public virtual User User { get; set; }
        [ForeignKey("FilmProductionId")]
        public virtual FilmProduction FilmProduction { get; set; }
    }
}
