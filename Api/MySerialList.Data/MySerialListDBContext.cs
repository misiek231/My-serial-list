using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using MovieBook.Data.Model;
using MySerialList.Data.Model;

namespace MovieBook.Data
{
    public class MySerialListDBContext : IdentityDbContext<User>
    {
        public virtual DbSet<WatchingFilmProductionStatus> WatchingFilmProductionStatuses { get; set; }
        public virtual DbSet<WatchingEpisodeStatus> WatchingEpisodeStatuses { get; set; }
        public virtual DbSet<Episode> Episodes { get; set; }
        public virtual DbSet<FilmProduction> FilmProductions { get; set; }
        public virtual DbSet<Review> Reviews { get; set; }
        public virtual DbSet<Comment> Comments { get; set; }


        public MySerialListDBContext(DbContextOptions<MySerialListDBContext> options) : base(options) { }
    }
}
