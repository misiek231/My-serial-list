using Microsoft.AspNetCore.Identity;
using MySerialList.Data.Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace MovieBook.Data.Model
{
    public class User : IdentityUser
    {
        public virtual IEnumerable<Review> Reviews { get; set; }
        public virtual IEnumerable<Comment> Comments { get; set; }
        public virtual IEnumerable<WatchingFilmProductionStatus> WatchingFilmProductionStatuses { get; set; }
        public virtual IEnumerable<WatchingEpisodeStatus> WatchingEpisodeStatuses { get; set; }
    }
}
