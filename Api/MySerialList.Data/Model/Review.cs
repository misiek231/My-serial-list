﻿using MySerialList.Data.Model;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace MovieBook.Data.Model
{
    public class Review
    {
        public int Id { get; set; }
        public string UserId { get; set; }
        public int? FilmProductionId { get; set; }
        public int? EpisodeId { get; set; }
        public int Grade { get; set; }

        [ForeignKey("UserId")]
        public virtual User User { get; set; }
        [ForeignKey("EpisodeId")]
        public virtual Episode Episode { get; set; }
        [ForeignKey("FilmProductionId")]
        public virtual FilmProduction FilmProduction { get; set; }

        
    }
}
