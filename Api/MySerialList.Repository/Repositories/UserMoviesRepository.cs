using Microsoft.EntityFrameworkCore;
using MovieBook.Component;
using MovieBook.Data;
using MovieBook.Data.Model;
using MovieBook.Model.Movie;
using MovieBook.Model.UserMovies;
using MovieBook.Repository.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MovieBook.Repository.Repositories
{
    public class UserMoviesRepository : IUserMoviesRepository
    {
        public readonly MySerialListDBContext _movieBookDBContext;

        public UserMoviesRepository(MySerialListDBContext movieBookDBContext)
        {
            _movieBookDBContext = movieBookDBContext;
        }

        public async Task AddMovie(AddUserMovieModel addUserMovieModel, int userId)
        {
            await _movieBookDBContext.UserMovies.AddAsync(new UserMovie
            {
                MovieId = addUserMovieModel.MovieId,
                Status = addUserMovieModel.WatchingStatus,
                UserId = userId,
                Episodes = addUserMovieModel.Episodes
            });

            await _movieBookDBContext.SaveChangesAsync();
        }

        public async Task DeleteMovie(int userId, string movieId)
        {
            UserMovie i = await _movieBookDBContext.UserMovies.Where(u => u.UserId == userId).Where(u => u.MovieId == movieId).FirstOrDefaultAsync();
            _movieBookDBContext.UserMovies.Remove(i);
            await _movieBookDBContext.SaveChangesAsync();
        }

        public async Task<IEnumerable<UserMovieList>> GetUserMovies(int userId, WatchingStatus status)
        {
            return await _movieBookDBContext.UserMovies
                 .Where(u => u.UserId == userId)
                 .Where(u => u.Status == status)
                 .Select(u => new UserMovieList
                 {
                     Id = u.MovieId,
                     Episodes = u.Episodes,
                 })
                 .ToListAsync();

        }

        public async Task<bool> IsMovieAdded(string movieId, int userId)
        {
            return await _movieBookDBContext.UserMovies
                .Where(u => u.MovieId == movieId)
                .Where(u => u.UserId == userId)
                .AnyAsync();
        }
    }
}
