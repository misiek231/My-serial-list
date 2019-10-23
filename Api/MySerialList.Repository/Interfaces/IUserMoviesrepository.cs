using MySerialList.Component;
using MySerialList.Model.FilmProduction;
using MySerialList.Model.UserFilmProductions;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MySerialList.Repository.Interfaces
{
    public interface IUserFilmProductionsRepository
    {
        Task AddFilmProduction(AddUserFilmProductionModel addUserFilmProductionModel, int userId);
        Task<IEnumerable<UserFilmProductionList>> GetUserFilmProductions(int userId, WatchingStatus status);
        Task<bool> IsFilmProductionAdded(int movieId, string userId);
        Task DeleteFilmProduction(int userId, string movieId);
    }
}
