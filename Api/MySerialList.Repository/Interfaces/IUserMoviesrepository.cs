using MySerialList.Component;
using MySerialList.Model.FilmProduction;
using MySerialList.Model.UserFilmProductions;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MySerialList.Repository.Interfaces
{
    public interface IUserFilmProductionsRepository
    {
        Task AddFilmProductionAsync(AddUserFilmProductionModel addUserFilmProductionModel, string userId);
        Task<IEnumerable<UserFilmProductionList>> GetUserFilmProductionsAsync(string username, WatchingStatus status);
        Task<bool> IsFilmProductionAddedAsync(int movieId, string userId);
        Task DeleteFilmProductionAsync(int movieId, string userId);
    }
}
