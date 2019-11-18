using Microsoft.EntityFrameworkCore;
using MySerialList.Component;
using MySerialList.Data;
using MySerialList.Data.Model;
using MySerialList.Model.FilmProduction;
using MySerialList.Repository.Interfaces;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MySerialList.Repository.Repositories
{
    public class FilmProductionRepository : IFilmProductionRepository
    {
        private readonly MySerialListDBContext _dbContext;

        public FilmProductionRepository(MySerialListDBContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async Task AddFilmProductionAsync(AddFilmProduction addFilmProduction, string fileName)
        {
            await _dbContext.FilmProductions.AddAsync(new FilmProduction
            {
                Title = addFilmProduction.Title,
                Released = addFilmProduction.Released,
                Genre = addFilmProduction.Genre,
                Director = addFilmProduction.Director,
                Actors = addFilmProduction.Actors,
                Plot = addFilmProduction.Plot,
                Language = addFilmProduction.Language,
                Poster = fileName,
                IsSeries = addFilmProduction.IsSeries
            });
            await _dbContext.SaveChangesAsync();
        }

        public async Task<bool> ExsistsAsync(int filmProductionId)
        {
            return await _dbContext.FilmProductions.Where(f => f.Id == filmProductionId).AnyAsync();
        }

        public async Task<FilmProductionData> GetFilmProduction(int id)
        {
            return await _dbContext.FilmProductions.Include(f => f.Reviews).Include(f => f.Episodes).Where(f => f.Id == id).Select(f => new FilmProductionData
            {
                FilmProductionId = f.Id,
                Actors = f.Actors,
                Director = f.Director,
                IsSeries = f.IsSeries,
                Language = f.Language,
                Plot = f.Plot,
                Genre = f.Genre,
                Poster = f.Poster,
                Rating = Average(f),
                Released = f.Released,
                Title = f.Title,
                Episodes = f.IsSeries ? f.Episodes.Count() : 1,
                Votes = f.Reviews.Count()
            }).FirstOrDefaultAsync();
        }

        public async Task<IEnumerable<FilmProductionRating>> GetAll(int from, int to, FilmProductionType type, string search)
        {
            int? lastId = (await _dbContext.FilmProductions
                .Where(f => type == FilmProductionType.all ? true : (f.IsSeries == (type == FilmProductionType.serials)))
                .Where(f => f.Title.Contains(search)).LastOrDefaultAsync())?.Id;
            List<FilmProduction> d = await _dbContext.FilmProductions
                .Include(f => f.Reviews)
                .Include(f => f.Episodes)
                .Where(f => type == FilmProductionType.all ? true : (f.IsSeries == (type == FilmProductionType.serials)))
                .Where(f => f.Title.Contains(search))
                .Skip(from).Take(to).ToListAsync();
            return d.OrderBy(f => Average(f))
                .Select(f => new FilmProductionRating
                {
                    FilmProductionId = f.Id,
                    IsSeries = f.IsSeries,
                    Seasons = f.Episodes.Any() ? (int?)f.Episodes.OrderByDescending(i => i.Season).Select(s => s.Season).FirstOrDefault() : null,
                    Genre = f.Genre,
                    Poster = f.Poster,
                    Rating = Average(f),
                    Plot = f.Plot,
                    Released = f.Released,
                    Title = f.Title,
                    Votes = f.Reviews.Count(),
                    Last = lastId == null ? true : f.Id == lastId
                });
        }

        public async Task<bool> IsSeriesAsync(int filmProductionId)
        {
            return await _dbContext.FilmProductions.Where(f => f.Id == filmProductionId).Select(f => f.IsSeries).FirstOrDefaultAsync();
        }

        public async Task<IEnumerable<FilmProductionSearch>> SearchFilmProductions(string title, int from, int to)
        {
            return await _dbContext.FilmProductions
                .Include(f => f.Reviews)
                .Where(f => f.Title.Contains(title))
                .Select(f => new FilmProductionSearch
                {
                    FilmProductionId = f.Id,
                    IsSeries = f.IsSeries,
                    Genre = f.Genre,
                    Poster = f.Poster,
                    Rating = Average(f),
                    Released = f.Released,
                    Title = f.Title,
                }).Skip(from).Take(to).ToListAsync();
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
