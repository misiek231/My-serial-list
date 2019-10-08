using System;
using System.Collections.Generic;
using System.Text;

namespace MovieBook.Data.Model
{
    public class Comment
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public string MovieId { get; set; }
        public string Description { get; set; }
        public DateTime CreateAt { get; set; }

        public virtual User User { get; set; }
    }
}
