using MySerialList.Component;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace MySerialList.Model.UserMovies
{
    public class UpdateUserFilmProductionModel
    {
        [Required]
        public int FilmProductionId { get; set; }
        [Required]
        public WatchingStatus WatchingStatus { get; set; }
        [Required]
        public int Episodes { get; set; }
    }
}
