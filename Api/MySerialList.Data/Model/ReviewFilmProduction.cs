﻿using System.ComponentModel.DataAnnotations.Schema;

namespace MySerialList.Data.Model
{
    public class ReviewFilmProduction
    {
        public int Id { get; set; }
        public string UserId { get; set; }
        public int FilmProductionId { get; set; }
        public int Grade { get; set; }

        [ForeignKey("UserId")]
        public virtual User User { get; set; }
        [ForeignKey("FilmProductionId")]
        public virtual FilmProduction FilmProduction { get; set; }
    }
}
