using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using MovieBook.Component;
using MovieBook.Model.Movie;
using MovieBook.Model.UserMovies;

namespace MovieBook.Service.Interfaces
{
    public interface IUserMoviesService
    {
        Task AddMovie(AddUserMovieModel addUserMovieModel, int userId);
        Task<IEnumerable<UserMovieList>> GetUserMovies(int UserId, WatchingStatus status);
        Task DeleteMovie(int userId, string movieId);
    }
}
