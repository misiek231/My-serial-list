using MySerialList.Component;
using MySerialList.Model.FilmProduction;
using MySerialList.Model.UserFilmProductions;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MySerialList.Service.Interfaces
{
    public interface IUserFilmProductionsService
    {
        Task AddFilmProduction(AddUserFilmProductionModel addUserFilmProductionModel, string userId);
        Task<IEnumerable<UserFilmProductionList>> GetUserFilmProductions(string UserId, WatchingStatus status);
        Task DeleteFilmProduction(string userId, string movieId);
    }
}
