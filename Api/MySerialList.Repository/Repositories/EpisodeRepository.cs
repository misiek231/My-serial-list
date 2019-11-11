using Microsoft.EntityFrameworkCore;
using MySerialList.Data;
using MySerialList.Data.Model;
using MySerialList.Model.Episode;
using MySerialList.Repository.Interfaces;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MySerialList.Repository.Repositories
{
    public class EpisodeRepository : IEpisodeRepository
    {
        private readonly MySerialListDBContext _dbContext;

        public EpisodeRepository(MySerialListDBContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async Task AddEpisodeAsync(AddEpisode addEpisode)
        {
            await _dbContext.Episodes.AddAsync(new Episode
            {
                EpisodeNumber = addEpisode.EpisodeNumber,
                FilmProductionId = addEpisode.FilmProductionId,
                Released = addEpisode.Released,
                Season = addEpisode.Season,
                Title = addEpisode.Title
            });

            await _dbContext.SaveChangesAsync();
        }

        public Task<bool> ExsistsAsync(int episodeId)
        {
            return _dbContext.Episodes.Where(e => e.Id == episodeId).AnyAsync();
        }

        public async Task<IEnumerable<EpisodeData>> GetAllEpisodes(int filmProductionId, int season)
        {
            return await _dbContext.Episodes.Where(e => e.FilmProductionId == filmProductionId)
                .OrderBy(e => e.EpisodeNumber)
                .Where(e => e.Season == season)
                .Select(e => new EpisodeData
                {
                    EpisodeNumber = e.EpisodeNumber,
                    FilmProductionId = e.FilmProductionId,
                    Released = e.Released,
                    Season = e.Season,
                    Title = e.Title
                }).ToListAsync();
        }

        public async Task<EpisodeData> GetEpisodeAsync(int id)
        {
            return await _dbContext.Episodes.Where(e => e.Id == id)
                .Select(e => new EpisodeData
                {
                    EpisodeNumber = e.EpisodeNumber,
                    FilmProductionId = e.FilmProductionId,
                    Released = e.Released,
                    Season = e.Season,
                    Title = e.Title
                }).FirstOrDefaultAsync();
        }
    }
}
