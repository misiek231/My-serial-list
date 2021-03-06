﻿using System;

namespace MySerialList.Model.FilmProduction
{
    public class FilmProductionRating
    {
        public string Title { get; set; }
        public string Genre { get; set; }
        public string Released { get; set; }
        public int FilmProductionId { get; set; }
        public string Poster { get; set; }
        public string Plot { get; set; }
        public int Votes { get; set; }
        public double Rating { get; set; }
        public int? MyRating { get; set; }
        public bool IsSeries { get; set; }
        public int? Seasons { get; set; }
        public int TotalEpisodes { get; set; }
        public int WatchedEpisodes { get; set; }
        public bool CurrentUserItem { get; set; }
        public bool Last { get; set; }
    }
}
