using MySerialList.Data.Model;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace MovieBook.Data.Model
{
    public class Comment
    {
        public int Id { get; set; }
        public string UserId { get; set; }
        public int FilmProductionId { get; set; }
        public string Description { get; set; }
        public DateTime CreateAt { get; set; }

        [ForeignKey("UserId")]
        public virtual User User { get; set; }
        [ForeignKey("FilmProductionId")]
        public virtual FilmProduction FilmProduction { get; set; }
    }
}
