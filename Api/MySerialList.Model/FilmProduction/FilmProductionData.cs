using System;

namespace MySerialList.Model.FilmProduction
{
    public class FilmProductionData
    {
        public int FilmProductionId { get; set; }
        public string Title { get; set; }
        public string Released { get; set; }
        public string Genre { get; set; }
        public string Director { get; set; }
        public string Actors { get; set; }
        public string Plot { get; set; }
        public string Language { get; set; }
        public string Poster { get; set; }
        public int Votes { get; set; }
        public double Rating { get; set; }
        public bool IsSeries { get; set; }
    }
}
