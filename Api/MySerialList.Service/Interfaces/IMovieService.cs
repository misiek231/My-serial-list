using MovieBook.Model.Movie;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace MovieBook.Service.Interfaces
{
    public interface IMovieService
    {
        Task<MovieSearchList> SearchMovies(string title, int page);
        Task<Movie> GetMovie(string id);
        Task<IEnumerable<MovieRating>> GetTopRated();
    }
}
