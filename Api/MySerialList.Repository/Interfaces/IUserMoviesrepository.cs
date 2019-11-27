using MySerialList.Component;
using MySerialList.Model.FilmProduction;
using MySerialList.Model.UserFilmProductions;
using MySerialList.Model.UserMovies;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MySerialList.Repository.Interfaces
{
    public interface IUserFilmProductionsRepository
    {
        Task AddFilmProductionAsync(AddUserFilmProductionModel addUserFilmProductionModel, string userId);
        Task<IEnumerable<FilmProductionRating>> GetUserFilmProductionsAsync(string username, string userId, WatchingStatus status, int from, int to);
        Task<bool> IsFilmProductionAddedAsync(int movieId, string userId);
        Task DeleteFilmProductionAsync(int movieId, string userId);
        Task UpdateFilmProductionAsync(UpdateUserFilmProductionModel updateUserFilmProductionModel, string userId);
    }
}
