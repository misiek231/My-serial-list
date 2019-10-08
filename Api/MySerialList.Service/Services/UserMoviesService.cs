using MovieBook.Component;
using MovieBook.Model.Movie;
using MovieBook.Model.UserMovies;
using MovieBook.Repository.Interfaces;
using MovieBook.Service.Exception;
using MovieBook.Service.Interfaces;
using System;
using System.Collections.Generic;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace MovieBook.Service.Services
{
    public class UserMoviesService : IUserMoviesService
    {
        private readonly IUserMoviesRepository _userMoviesRepository;
        private readonly IMovieService _movieService;
        private readonly IReviewService _reviewService;
        public UserMoviesService(IUserMoviesRepository userMoviesRepository, IMovieService movieService, IReviewService reviewService)
        {
            _userMoviesRepository = userMoviesRepository;
            _movieService = movieService;
            _reviewService = reviewService;
        }

        public async Task AddMovie(AddUserMovieModel addUserMovieModel, int userId)
        {
            if (await _userMoviesRepository.IsMovieAdded(addUserMovieModel.MovieId, userId))
                throw new HttpStatusCodeException(HttpStatusCode.BadRequest, "Movie already added");
            else
                await _userMoviesRepository.AddMovie(addUserMovieModel, userId);
        }

        public async Task DeleteMovie(int userId, string movieId)
        {
            await _userMoviesRepository.DeleteMovie(userId, movieId);
        }

        public async Task<IEnumerable<UserMovieList>> GetUserMovies(int UserId, WatchingStatus status)
        {
            List<UserMovieList> movies = new List<UserMovieList>();
            foreach (UserMovieList userMovie in await _userMoviesRepository.GetUserMovies(UserId, status))
            {
                Movie movie = await _movieService.GetMovie(userMovie.Id);
                movies.Add(new UserMovieList
                {
                    Id = movie.Id,
                    Poster = movie.Poster,
                    Title = movie.Title,
                    Type = movie.Type,
                    Year = movie.Year,
                    Rating = (await _reviewService.GetRating(movie.Id)).Rating,
                    Episodes = userMovie.Episodes
                });
            }
            return movies;
        }
    }
}
