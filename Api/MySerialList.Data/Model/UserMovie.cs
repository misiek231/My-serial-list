using MovieBook.Component;
using System;
using System.Collections.Generic;
using System.Text;

namespace MovieBook.Data.Model
{
    public class UserMovie
    {
        public int Id { get; set; }
        public string MovieId { get; set; }
        public int UserId { get; set; }
        public WatchingStatus Status { get; set; }
        public int? Episodes { get; set; }

        public virtual User User { get; set; }
    }
}
