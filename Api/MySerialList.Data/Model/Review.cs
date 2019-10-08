using System;
using System.Collections.Generic;
using System.Text;

namespace MovieBook.Data.Model
{
    public class Review
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public string MovieId { get; set; }
        public int Grade { get; set; }


        public virtual User User { get; set; }
    }
}
