using System;
using System.Collections.Generic;
using System.Text;

namespace MovieBook.Model.Movie
{
    public class MovieSearchList
    {
        public int Pages { get; set; }
        public List<MovieSearch> Movies { get; set; }
    }
}
