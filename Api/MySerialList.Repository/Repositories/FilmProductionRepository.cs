using Microsoft.EntityFrameworkCore;
using MySerialList.Data;
using MySerialList.Model.Movie;
using MySerialList.Data.Model;
using MySerialList.Model.FilmProduction;
using MySerialList.Repository.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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

        public async Task<IEnumerable<FilmProductionRating>> GetTopRated()
        {
            return await _dbContext.FilmProductions.Include(f => f.Reviews).Select(f => new FilmProductionRating {
                FilmProductionId = f.Id,
                Genre = f.Genre,
                Poster = f.Poster,
                Rating = Average(f),
                Released = f.Released,
                Title = f.Title,
                Votes = f.Reviews.Count()
            }).ToListAsync();
        }

        private double Average(FilmProduction f)
        {
            if (f.Reviews.Count() > 0)
                return f.Reviews.Average(r => r.Grade);
            else return 0;
        }
    }
}
