using MovieBook.Data.Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace MySerialList.Data.Model
{
    public class FilmProduction
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public DateTime Released { get; set; }
        public string Runtime { get; set; }
        public string Genre { get; set; }
        public string Director { get; set; }
        public string Actors { get; set; }
        public string Plot { get; set; }
        public string Language { get; set; }
        public string Country { get; set; }
        public string Awards { get; set; }
        public string Poster { get; set; }
        public string BoxOffice { get; set; }
        public string Production { get; set; }
        public string Website { get; set; }
        public bool IsSeries { get; set; }

        public virtual IEnumerable<Episode> Episodes { get; set; }
        public virtual IEnumerable<Review> Reviews { get; set; }
        public virtual IEnumerable<Comment> Comments { get; set; }
    }
}