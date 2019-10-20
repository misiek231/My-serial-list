using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Options;
using MySerialList.Model.Movie;
using MySerialList.Repository.Interfaces;
using MySerialList.Service.Exception;
using MySerialList.Service.Interfaces;
using MySerialList.Model.FilmProduction;
using MySerialList.Repository.Interfaces;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace MySerialList.Service.Services
{
    public class FilmProductionService : IFilmProductionService
    {

        private readonly string _apiKey;
        private readonly string _postersPath;
        private readonly IReviewRepository _reviewRepository;
        private readonly IHostingEnvironment _hostingEnvironment;
        private readonly IFilmProductionRepository _filmProductionRepository;

        public FilmProductionService(IOptions<AppSettings> appSettings, IReviewRepository reviewRepository, IHostingEnvironment hostingEnvironment, IFilmProductionRepository filmProductionRepository)
        {
            _apiKey = appSettings.Value.ApiKey;
            _postersPath = appSettings.Value.PostersPath;
            _reviewRepository = reviewRepository;
            _hostingEnvironment = hostingEnvironment;
            _filmProductionRepository = filmProductionRepository;
        }

        public Task<IEnumerable<FilmProductionRating>> GetTopRated() => _filmProductionRepository.GetTopRated();

        public async Task AddFilmProductionAsync(AddFilmProduction addFilmProduction)
        {
            var file = addFilmProduction.Poster;
            string fileName = null;
            
            if(file != null)
            {
                var uploads = Path.Combine(_hostingEnvironment.WebRootPath, _postersPath);

                if (file.Length > 0)
                {
                    fileName = Guid.NewGuid().ToString() + "." + file.FileName.Split('.').Last();
                    var filePath = Path.Combine(uploads, fileName);
                    using (var fileStream = new FileStream(filePath, FileMode.Create))
                    {
                        await file.CopyToAsync(fileStream);
                    }
                }
            }

            await _filmProductionRepository.AddFilmProductionAsync(addFilmProduction, fileName);
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
