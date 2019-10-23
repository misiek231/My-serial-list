using MySerialList.Component;
using MySerialList.Model.FilmProduction;
using MySerialList.Model.UserFilmProductions;
using MySerialList.Repository.Interfaces;
using MySerialList.Service.Exception;
using MySerialList.Service.Interfaces;
using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;

namespace MySerialList.Service.Services
{
    public class UserFilmProductionsService : IUserFilmProductionsService
    {
        private readonly IUserFilmProductionsRepository _userFilmProductionsRepository;
        private readonly IFilmProductionService _movieService;
        private readonly IReviewFilmProductionService _reviewService;
        public UserFilmProductionsService(IUserFilmProductionsRepository userFilmProductionsRepository, IFilmProductionService movieService, IReviewFilmProductionService reviewService)
        {
            _userFilmProductionsRepository = userFilmProductionsRepository;
            _movieService = movieService;
            _reviewService = reviewService;
        }

        public async Task AddFilmProduction(AddUserFilmProductionModel addUserFilmProductionModel, string userId)
        {
            if (await _userFilmProductionsRepository.IsFilmProductionAddedAsync(addUserFilmProductionModel.FilmProductionId, userId))
            {
                throw new HttpStatusCodeException(HttpStatusCode.BadRequest, "FilmProduction already added");
            }
            else
            {
               // await _userFilmProductionsRepository.AddFilmProduction(addUserFilmProductionModel, userId);
            }
        }

        public async Task DeleteFilmProduction(string userId, string movieId)
        {
            //await _userFilmProductionsRepository.DeleteFilmProduction(userId, movieId);
        }

        public async Task<IEnumerable<UserFilmProductionList>> GetUserFilmProductions(string UserId, WatchingStatus status)
        {
            List<UserFilmProductionList> movies = new List<UserFilmProductionList>();
            //foreach (UserFilmProductionList userFilmProduction in await _userFilmProductionsRepository.GetUserFilmProductions(UserId, status))
            //{
            //    FilmProductionData movie = await _movieService.GetFilmProduction(userFilmProduction.Id);
            //    movies.Add(new UserFilmProductionList
            //    {
            //        Id = movie.Id,
            //        Poster = movie.Poster,
            //        Title = movie.Title,
            //        Type = movie.Type,
            //        Year = movie.Year,
            //        Rating = (await _reviewService.GetRating(movie.Id)).Rating,
            //        Episodes = userFilmProduction.Episodes
            //    });
            //}
            return movies;
        }
    }
}
