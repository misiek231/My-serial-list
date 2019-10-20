using System;
using System.Collections.Generic;
using System.Text;

namespace MySerialList.Model.Movie
{
    public class UserMovieList
    {
        public string Id { get; set; }
        public string Title { get; set; }
        public string Year { get; set; }
        public string Type { get; set; }
        public string Poster { get; set; }
        public int? Episodes { get; set; }
        public double Rating { get; set; }
    }
}
