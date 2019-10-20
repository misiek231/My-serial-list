using MySerialList.Data.Model;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace MySerialList.Data.Model
{
    public class Episode
    {

        public int Id { get; set; }
        public string Title { get; set; }
        public DateTime Released { get; set; }
        public int FilmProductionId { get; set; }
        public int Season { get; set; }
        public int EpisodeNumber { get; set; }

        [ForeignKey("FilmProductionId")]
        public virtual FilmProduction FilmProduction { get; set; }
        public virtual IEnumerable<ReviewFilmProduction> Reviews { get; set; }
    }
}
