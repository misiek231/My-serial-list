using MovieBook.Component;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace MovieBook.Model.UserMovies
{
    public class AddUserMovieModel
    {
        [Required]
        public string MovieId { get; set; }
        [Required]
        public WatchingStatus WatchingStatus { get; set; }
        public int? Episodes { get; set; }
    }
}
