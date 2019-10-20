using System;
using System.Collections.Generic;
using System.Text;

namespace MySerialList.Model.Movie
{
    public class FilmProductionRating
    {
        public string Title { get; set; }
        public string Genre { get; set; }
        public DateTime Released { get; set; }
        public int FilmProductionId { get; set; }
        public string Poster { get; set; }
        public int Votes { get; set; }
        public double Rating { get; set; }
    }
}
