using Microsoft.EntityFrameworkCore;
using MySerialList.Component;
using MySerialList.Data;
using MySerialList.Data.Model;
using MySerialList.Model.FilmProduction;
using MySerialList.Model.UserFilmProductions;
using MySerialList.Repository.Interfaces;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MySerialList.Repository.Repositories
{
    public class UserFilmProductionsRepository : IUserFilmProductionsRepository
    {
        public readonly MySerialListDBContext _mySerialListDBContext;

        public UserFilmProductionsRepository(MySerialListDBContext mySerialListDBContext)
        {
            _mySerialListDBContext = mySerialListDBContext;
        }

        public async Task AddFilmProductionAsync(AddUserFilmProductionModel addUserFilmProductionModel, string userId)
        {
            await _mySerialListDBContext.WatchingFilmProductionStatuses.AddAsync(new WatchingFilmProductionStatus
            {
                FilmProductionId = addUserFilmProductionModel.FilmProductionId,
                WatchingStatus = addUserFilmProductionModel.WatchingStatus,
                UserId = userId,
                Episodes = addUserFilmProductionModel.Episodes ?? 1
            }); 
            await _mySerialListDBContext.SaveChangesAsync();
        }

        public async Task DeleteFilmProductionAsync(int movieId, string userId)
        {
            WatchingFilmProductionStatus i = await _mySerialListDBContext.WatchingFilmProductionStatuses
                .Where(u => u.UserId == userId)
                .Where(u => u.FilmProductionId == movieId)
                .FirstOrDefaultAsync();
            _mySerialListDBContext.WatchingFilmProductionStatuses.Remove(i);
            await _mySerialListDBContext.SaveChangesAsync();
        }

        public async Task<IEnumerable<UserFilmProductionList>> GetUserFilmProductionsAsync(string username, WatchingStatus status)
        {
            var i = _mySerialListDBContext.WatchingFilmProductionStatuses
                .Include(w => w.User)
                .Include(w => w.FilmProduction)
                .ThenInclude(w => w.Reviews)
                .Where(u => u.User.UserName == username)
                .Where(u => u.WatchingStatus == status).ToAsyncEnumerable();


                return await i.Select(u => new UserFilmProductionList
                {
                    FilmProductionId = u.FilmProductionId,
                    Episodes = u.Episodes,
                    Poster = u.FilmProduction.Poster,
                    Rating = Average(u.FilmProduction),
                    Title = u.FilmProduction.Title,
                    Released = u.FilmProduction.Released
                }).ToList();
        }

        public async Task<bool> IsFilmProductionAddedAsync(int movieId, string userId)
        {
            return await _mySerialListDBContext.WatchingFilmProductionStatuses
                .Where(u => u.FilmProductionId == movieId)
                .Where(u => u.UserId == userId)
                .AnyAsync();
        }

        private double Average(FilmProduction f)
        {
            if (f.Reviews.Count() > 0)
            {
                return f.Reviews.Average(r => r.Grade);
            }
            else
            {
                return 0;
            }
        }
    }
}
