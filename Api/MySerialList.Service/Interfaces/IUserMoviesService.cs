using MySerialList.Component;
using MySerialList.Model.FilmProduction;
using MySerialList.Model.UserFilmProductions;
using MySerialList.Model.UserMovies;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MySerialList.Service.Interfaces
{
    public interface IUserFilmProductionsService
    {
        Task AddFilmProductionAsync(AddUserFilmProductionModel addUserFilmProductionModel, string userId);
        Task<IEnumerable<FilmProductionRating>> GetUserFilmProductionsAsync(string username, WatchingStatus status, int page, string userId);
        Task DeleteFilmProductionAsync(string userId, int movieId);
        Task UpdateUserFilmProductionsAsync(string userId, UpdateUserFilmProductionModel updateUserFilmProductionModel);
    }
}
