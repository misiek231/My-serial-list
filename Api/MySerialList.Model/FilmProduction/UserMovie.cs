﻿namespace MySerialList.Model.FilmProduction
{
    public class UserFilmProductionList
    {
        public int FilmProductionId { get; set; }
        public string Title { get; set; }
        public string Released { get; set; }
        public string Poster { get; set; }
        public int? Episodes { get; set; }
        public double Rating { get; set; }
    }
}
