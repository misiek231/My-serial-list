using Microsoft.EntityFrameworkCore;
using MovieBook.Data.Model;

namespace MovieBook.Data
{
    public class MySerialListDBContext : DbContext
    {
        public virtual DbSet<User> Users { get; set; }
        public virtual DbSet<UserMovie> UserMovies { get; set; }
        public virtual DbSet<Review> Reviews { get; set; }
        public virtual DbSet<Comment> Comments { get; set; }


        public MySerialListDBContext(DbContextOptions<MySerialListDBContext> options) : base(options) { }
    }
}
