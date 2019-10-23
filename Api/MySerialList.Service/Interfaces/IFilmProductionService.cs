using MySerialList.Model.FilmProduction;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MySerialList.Service.Interfaces
{
    public interface IFilmProductionService
    {
        Task<IEnumerable<FilmProductionSearch>> SearchFilmProductions(string title, int page);
        Task<FilmProductionData> GetFilmProduction(int id);
        Task<IEnumerable<FilmProductionRating>> GetTopRated(int page);
        Task AddFilmProductionAsync(AddFilmProduction addFilmProduction);
    }
}
