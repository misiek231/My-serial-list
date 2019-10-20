using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using MySerialList.Component;
using MySerialList.Model.Movie;
using MySerialList.Model.UserMovies;

namespace MySerialList.Service.Interfaces
{
    public interface IUserMoviesService
    {
        Task AddMovie(AddUserMovieModel addUserMovieModel, int userId);
        Task<IEnumerable<UserMovieList>> GetUserMovies(int UserId, WatchingStatus status);
        Task DeleteMovie(int userId, string movieId);
    }
}
