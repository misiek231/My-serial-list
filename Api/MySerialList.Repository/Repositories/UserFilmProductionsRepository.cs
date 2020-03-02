using Microsoft.EntityFrameworkCore;
using MySerialList.Component;
using MySerialList.Data;
using MySerialList.Data.Model;
using MySerialList.Model.FilmProduction;
using MySerialList.Model.UserFilmProductions;
using MySerialList.Model.UserMovies;
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

        public async Task<IEnumerable<FilmProductionRating>> GetUserFilmProductionsAsync(string username, string userId, WatchingStatus status, int from, int to)
        {
            int? lastId = null;
            try
            {
                lastId = await _mySerialListDBContext.WatchingFilmProductionStatuses
                   .Include(w => w.User)
                   .Where(u => u.User.UserName == username)
                   .Where(u => u.WatchingStatus == status)
                   .OrderBy(u => u.Id)
                   .Select(u => u.Id)
                   .LastOrDefaultAsync();
            }
            catch { }

            IAsyncEnumerable<WatchingFilmProductionStatus> i = _mySerialListDBContext.WatchingFilmProductionStatuses
                .Include(w => w.User)
                .Include(w => w.FilmProduction)
                .ThenInclude(w => w.Reviews)
                .Include(w => w.FilmProduction)
                .ThenInclude(f => f.Episodes)
                .Where(u => u.User.UserName == username)
                .Where(u => u.WatchingStatus == status)
                .OrderBy(u => u.Id)
                .Skip(from)
                .Take(to)
                .ToAsyncEnumerable();

            return await i.Select(u => new FilmProductionRating
            {
                FilmProductionId = u.FilmProductionId,
                Poster = u.FilmProduction.Poster,
                Rating = Average(u.FilmProduction),
                Title = u.FilmProduction.Title,
                Released = u.FilmProduction.Released,
                Genre = u.FilmProduction.Genre,
                IsSeries = u.FilmProduction.IsSeries,
                Plot = u.FilmProduction.Plot,
                Votes = u.FilmProduction.Reviews?.Count() ?? 1,
                Seasons = u.FilmProduction.Episodes.Any() ? (int?)u.FilmProduction.Episodes.OrderByDescending(k => k.Season).Select(s => s.Season).FirstOrDefault() : null,
                Last = u.Id == lastId.Value,
                MyRating = u.FilmProduction.Reviews.Where(r => r.User.UserName == username).Select(r => r.Grade).FirstOrDefault(),
                TotalEpisodes = u.FilmProduction.Episodes.Any() ? u.FilmProduction.Episodes.Count() : 0,
                WatchedEpisodes = u.FilmProduction.IsSeries ? u.Episodes : 0,
                CurrentUserItem = userId != null ? userId == u.UserId : false

            }).ToList();
        }

        public async Task<bool> IsFilmProductionAddedAsync(int movieId, string userId)
        {
            return await _mySerialListDBContext.WatchingFilmProductionStatuses
                .Where(u => u.FilmProductionId == movieId)
                .Where(u => u.UserId == userId)
                .AnyAsync();
        }

        public async Task UpdateFilmProductionAsync(UpdateUserFilmProductionModel updateUserFilmProductionModel, string userId)
        {
            WatchingFilmProductionStatus status = await _mySerialListDBContext.WatchingFilmProductionStatuses.Where(s => s.FilmProductionId == updateUserFilmProductionModel.FilmProductionId).FirstOrDefaultAsync();
            status.Episodes = updateUserFilmProductionModel.Episodes;
            status.WatchingStatus = updateUserFilmProductionModel.WatchingStatus;
            _mySerialListDBContext.WatchingFilmProductionStatuses.Update(status);
            await _mySerialListDBContext.SaveChangesAsync();
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
