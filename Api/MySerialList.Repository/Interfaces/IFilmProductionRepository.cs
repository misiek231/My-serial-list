using MySerialList.Component;
using MySerialList.Model.FilmProduction;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MySerialList.Repository.Interfaces
{
    public interface IFilmProductionRepository
    {
        Task AddFilmProductionAsync(AddFilmProduction addFilmProduction, string fileName);
        Task<IEnumerable<FilmProductionRating>> GetAll(int from, int to, FilmProductionType type, string search);
        Task<IEnumerable<FilmProductionSearch>> SearchFilmProductions(string title, int from, int to);
        Task<FilmProductionData> GetFilmProduction(int id);
        Task<bool> ExsistsAsync(int filmProductionId);
        Task<bool> IsSeriesAsync(int filmProductionId);
    }
}
