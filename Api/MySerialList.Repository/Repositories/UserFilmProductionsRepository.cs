using MySerialList.Component;
using MySerialList.Data;
using MySerialList.Model.FilmProduction;
using MySerialList.Model.UserFilmProductions;
using MySerialList.Repository.Interfaces;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MySerialList.Repository.Repositories
{
    public class UserFilmProductionsRepository : IUserFilmProductionsRepository
    {
        public readonly MySerialListDBContext _movieBookDBContext;

        public UserFilmProductionsRepository(MySerialListDBContext movieBookDBContext)
        {
            _movieBookDBContext = movieBookDBContext;
        }

        public async Task AddFilmProduction(AddUserFilmProductionModel addUserFilmProductionModel, int userId)
        {
            //await _movieBookDBContext.UserFilmProductions.AddAsync(new WatchingFilmProductionStatus
            //{
            //    FilmProductionId = addUserFilmProductionModel.FilmProductionId,
            //    Status = addUserFilmProductionModel.WatchingStatus,
            //    UserId = userId,
            //    Episodes = addUserFilmProductionModel.Episodes
            //});

            //await _movieBookDBContext.SaveChangesAsync();
        }

        public async Task DeleteFilmProduction(int userId, string movieId)
        {
            //WatchingFilmProductionStatus i = await _movieBookDBContext.UserFilmProductions.Where(u => u.UserId == userId).Where(u => u.FilmProductionId == movieId).FirstOrDefaultAsync();
            //_movieBookDBContext.UserFilmProductions.Remove(i);
            //await _movieBookDBContext.SaveChangesAsync();
        }

        public async Task<IEnumerable<UserFilmProductionList>> GetUserFilmProductions(int userId, WatchingStatus status)
        {
            //return await _movieBookDBContext.UserFilmProductions
            //     .Where(u => u.UserId == userId)
            //     .Where(u => u.Status == status)
            //     .Select(u => new UserFilmProductionList
            //     {
            //         Id = u.FilmProductionId,
            //         Episodes = u.Episodes,
            //     })
            //     .ToListAsync();
            return null;

        }

        public async Task<bool> IsFilmProductionAddedAsync(int movieId, string userId)
        {
            //return await _movieBookDBContext.UserFilmProductions
            //    .Where(u => u.FilmProductionId == movieId)
            //    .Where(u => u.UserId == userId)
            //    .AnyAsync();

            return true;
        }
    }
}
