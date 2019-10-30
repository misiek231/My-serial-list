using MySerialList.Component;
using MySerialList.Model.FilmProduction;
using MySerialList.Model.UserFilmProductions;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MySerialList.Service.Interfaces
{
    public interface IUserFilmProductionsService
    {
        Task AddFilmProductionAsync(AddUserFilmProductionModel addUserFilmProductionModel, string userId);
        Task<IEnumerable<UserFilmProductionList>> GetUserFilmProductionsAsync(string username, WatchingStatus status);
        Task DeleteFilmProductionAsync(string userId, int movieId);
    }
}
