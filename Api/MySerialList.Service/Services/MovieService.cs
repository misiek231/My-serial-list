using Microsoft.Extensions.Options;
using MovieBook.Model.Movie;
using MovieBook.Repository.Interfaces;
using MovieBook.Service.Exception;
using MovieBook.Service.Interfaces;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace MovieBook.Service.Services
{
    public class MovieService : IMovieService
    {

        private readonly string _apiKey;
        private readonly IReviewRepository _reviewRepository;

        public MovieService(IOptions<AppSettings> appSettings, IReviewRepository reviewRepository)
        {
            _apiKey = appSettings.Value.ApiKey;
            _reviewRepository = reviewRepository;
        }

        public async Task<Movie> GetMovie(string id)
        {
            HttpClient client = new HttpClient
            {
                BaseAddress = new Uri("http://www.omdbapi.com/")
            };

            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            HttpResponseMessage response = await client.GetAsync($"?apikey={_apiKey}&plot=full&i={id}");

            string data;
            if (response.IsSuccessStatusCode)
            {
                data = await response.Content.ReadAsStringAsync();
            }
            else
            {
                throw new HttpStatusCodeException(HttpStatusCode.InternalServerError, "Error while getting movie from db. Check internet connection.");
            }

            dynamic stuff = JObject.Parse(data);

            if ((!(bool)stuff.Response))
                return null;

            return new Movie
            {
                Actors = stuff.Actors,
                Awards = stuff.Awards,
                BoxOffice = stuff.BoxOffice,
                Country = stuff.Country,
                Director = stuff.Director,
                Genre = stuff.Genre,
                Id = stuff.imdbID,
                Language = stuff.Language,
                Plot = stuff.Plot,
                Poster = stuff.Poster,
                Production = stuff.Production,
                Released = stuff.Released,
                Runtime = stuff.Runtime,
                Title = stuff.Title,
                Type = stuff.Type,
                Website = stuff.Website,
                Year = stuff.Year
            };
        }

        public async Task<IEnumerable<MovieRating>> GetTopRated()
        {
            List<MovieRating> movies = new List<MovieRating>();
            foreach (MovieRating movieRating in await _reviewRepository.GetTopRated())
            {
                Movie movie = await GetMovie(movieRating.MovieId);
                movies.Add(new MovieRating
                {
                    MovieId = movie.Id,
                    PosterUrl = movie.Poster,
                    Rating = movieRating.Rating,
                    Title = movie.Title,
                    Type = movie.Type,
                    Votes = movieRating.Votes,
                    Year = movie.Year
                });
            }
            return movies;
        }

        public async Task<MovieSearchList> SearchMovies(string title, int page)
        {
            HttpClient client = new HttpClient
            {
                BaseAddress = new Uri("http://www.omdbapi.com/")
            };

            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            HttpResponseMessage response = await client.GetAsync($"?apikey={_apiKey}&s={title}&page={page}");

            string data;

            if (response.IsSuccessStatusCode)
            {
                data = await response.Content.ReadAsStringAsync();
            }
            else
            {
                throw new HttpStatusCodeException(HttpStatusCode.InternalServerError, "Error while getting movies from db. Check internet connection.");
            }

            dynamic stuff = JObject.Parse(data);

            if ((!(bool)stuff.Response))
                return new MovieSearchList();


            int results = stuff.totalResults;

            MovieSearchList moviesList = new MovieSearchList
            {
                Pages = (((results > 100 ? 100 : results) + 9) / 10),
                Movies = new List<MovieSearch>()
            };

            foreach (dynamic a in stuff.Search)
            {
                moviesList.Movies.Add(new MovieSearch
                {
                    Id = a.imdbID,
                    PosterUrl = a.Poster,
                    Title = a.Title,
                    Year = a.Year,
                    Type = a.Type
                });
            }

            return moviesList;
        }
    }
}
