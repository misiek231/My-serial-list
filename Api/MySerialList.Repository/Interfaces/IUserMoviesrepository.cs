using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using MySerialList.Component;
using MySerialList.Data.Model;
using MySerialList.Model.Movie;
using MySerialList.Model.UserMovies;

namespace MySerialList.Repository.Interfaces
{
    public interface IUserMoviesRepository
    {
        Task AddMovie(AddUserMovieModel addUserMovieModel, int userId);
        Task<IEnumerable<UserMovieList>> GetUserMovies(int userId, WatchingStatus status);
        Task<bool> IsMovieAdded(string movieId, int userId);
        Task DeleteMovie(int userId, string movieId);
    }
}
