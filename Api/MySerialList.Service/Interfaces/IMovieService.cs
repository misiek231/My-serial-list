using MySerialList.Model.Movie;
using MySerialList.Model.FilmProduction;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace MySerialList.Service.Interfaces
{
    public interface IFilmProductionService
    {
        Task<MovieSearchList> SearchMovies(string title, int page);
        Task<Movie> GetMovie(string id);
        Task<IEnumerable<FilmProductionRating>> GetTopRated();
        Task AddFilmProductionAsync(AddFilmProduction addFilmProduction);
    }
}
