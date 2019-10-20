using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using MySerialList.Model.Movie;
using MySerialList.Model.FilmProduction;

namespace MySerialList.Repository.Interfaces
{
    public interface IFilmProductionRepository
    {
        Task AddFilmProductionAsync(AddFilmProduction addFilmProduction, string fileName);
        Task<IEnumerable<FilmProductionRating>> GetTopRated();
    }
}
