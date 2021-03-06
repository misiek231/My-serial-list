﻿using System.ComponentModel.DataAnnotations.Schema;

namespace MySerialList.Data.Model
{
    public class ReviewEpisode
    {
        public int Id { get; set; }
        public string UserId { get; set; }
        public int EpisodeId { get; set; }
        public int Grade { get; set; }

        [ForeignKey("UserId")]
        public virtual User User { get; set; }
        [ForeignKey("EpisodeId")]
        public virtual Episode Episode { get; set; }
    }
}
