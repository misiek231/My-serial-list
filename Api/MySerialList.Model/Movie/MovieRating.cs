using System;
using System.Collections.Generic;
using System.Text;

namespace MovieBook.Model.Movie
{
    public class MovieRating
    {
        public string Title { get; set; }
        public string Type { get; set; }
        public string Year { get; set; }
        public string MovieId { get; set; }
        public string PosterUrl { get; set; }
        public int Votes { get; set; }
        public double Rating { get; set; }
    }
}
