using MySerialList.Component;
using MySerialList.Model.FilmProduction;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MySerialList.Service.Interfaces
{
    public interface IFilmProductionService
    {
        Task<IEnumerable<FilmProductionSearch>> SearchFilmProductions(string title, int page);
        Task<FilmProductionData> GetFilmProduction(int id);
        Task<IEnumerable<FilmProductionRating>> GetAll(int page, FilmProductionType type, string search);
        Task AddFilmProductionAsync(AddFilmProduction addFilmProduction);
    }
}
