using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Text;

namespace MySerialList.Model.FilmProduction
{
    public class AddFilmProduction
    {
        public string Title { get; set; }
        public DateTime Released { get; set; }
        public string Genre { get; set; }
        public string Director { get; set; }
        public string Actors { get; set; }
        public string Plot { get; set; }
        public string Language { get; set; }
        public IFormFile Poster { get; set; }
        public bool IsSeries { get; set; }
    }
}
