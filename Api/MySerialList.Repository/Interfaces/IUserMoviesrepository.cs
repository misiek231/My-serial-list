using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using MovieBook.Component;
using MovieBook.Data.Model;
using MovieBook.Model.Movie;
using MovieBook.Model.UserMovies;

namespace MovieBook.Repository.Interfaces
{
    public interface IUserMoviesRepository
    {
        Task AddMovie(AddUserMovieModel addUserMovieModel, int userId);
        Task<IEnumerable<UserMovieList>> GetUserMovies(int userId, WatchingStatus status);
        Task<bool> IsMovieAdded(string movieId, int userId);
        Task DeleteMovie(int userId, string movieId);
    }
}
