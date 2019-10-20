using MySerialList.Component;
using MySerialList.Data.Model;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

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
