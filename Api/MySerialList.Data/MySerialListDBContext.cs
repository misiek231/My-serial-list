using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using MySerialList.Data.Model;

namespace MySerialList.Data
{
    public class MySerialListDBContext : IdentityDbContext<User>
    {
        public virtual DbSet<WatchingFilmProductionStatus> WatchingFilmProductionStatuses { get; set; }
        public virtual DbSet<WatchingEpisodeStatus> WatchingEpisodeStatuses { get; set; }
        public virtual DbSet<Episode> Episodes { get; set; }
        public virtual DbSet<FilmProduction> FilmProductions { get; set; }
        public virtual DbSet<ReviewFilmProduction> FilmProductionReviews { get; set; }
        public virtual DbSet<ReviewEpisode> EpisodeReviews { get; set; }
        public virtual DbSet<Comment> Comments { get; set; }


        public MySerialListDBContext(DbContextOptions<MySerialListDBContext> options) : base(options) { }
    }
}
