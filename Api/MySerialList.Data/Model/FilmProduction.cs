using System;
using System.Collections.Generic;

namespace MySerialList.Data.Model
{
    public class FilmProduction
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Released { get; set; }
        public string Genre { get; set; }
        public string Director { get; set; }
        public string Actors { get; set; }
        public string Plot { get; set; }
        public string Language { get; set; }
        public string Poster { get; set; }
        public bool IsSeries { get; set; }

        public virtual IEnumerable<Episode> Episodes { get; set; }
        public virtual IEnumerable<ReviewFilmProduction> Reviews { get; set; }
        public virtual IEnumerable<Comment> Comments { get; set; }
    }
}