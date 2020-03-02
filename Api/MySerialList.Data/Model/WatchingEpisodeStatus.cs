using MySerialList.Component;
using System.ComponentModel.DataAnnotations.Schema;

namespace MySerialList.Data.Model
{
    public class WatchingEpisodeStatus
    {
        public int Id { get; set; }
        public string UserId { get; set; }
        public int EpisodeId { get; set; }
        public WatchingStatus WatchingStatus { get; set; }

        [ForeignKey("EpisodeId")]
        public virtual Episode Episode { get; set; }
        [ForeignKey("UserId")]
        public virtual User User { get; set; }
    }
}
