using System;

namespace MySerialList.Model.FilmProduction
{
    public class FilmProductionSearch
    {
        public string Title { get; set; }
        public string Genre { get; set; }
        public string Released { get; set; }
        public int FilmProductionId { get; set; }
        public string Poster { get; set; }
        public double Rating { get; set; }
        public bool IsSeries { get; set; }
    }
}
