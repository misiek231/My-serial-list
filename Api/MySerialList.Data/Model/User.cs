using Microsoft.AspNetCore.Identity;
using System.Collections.Generic;

namespace MySerialList.Data.Model
{
    public class User : IdentityUser
    {
        public virtual IEnumerable<ReviewFilmProduction> Reviews { get; set; }
        public virtual IEnumerable<Comment> Comments { get; set; }
        public virtual IEnumerable<WatchingFilmProductionStatus> WatchingFilmProductionStatuses { get; set; }
        public virtual IEnumerable<WatchingEpisodeStatus> WatchingEpisodeStatuses { get; set; }
    }
}
