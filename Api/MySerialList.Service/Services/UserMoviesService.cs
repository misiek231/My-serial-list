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

        public async Task AddFilmProductionAsync(AddUserFilmProductionModel addUserFilmProductionModel, string userId)
        {
            if (await _userFilmProductionsRepository.IsFilmProductionAddedAsync(addUserFilmProductionModel.FilmProductionId, userId))
            {
                throw new HttpStatusCodeException(HttpStatusCode.BadRequest, "Film jest już na twojej liście.");
            }
            else
            {
                await _userFilmProductionsRepository.AddFilmProductionAsync(addUserFilmProductionModel, userId);
            }
        }

        public async Task DeleteFilmProductionAsync(string userId, int movieId)
        {
            await _userFilmProductionsRepository.DeleteFilmProductionAsync(movieId, userId);
        }

        public async Task<IEnumerable<FilmProductionRating>> GetUserFilmProductionsAsync(string username, WatchingStatus status, int page)
        {
            int filmProductionsPerPage = 100;
            return await _userFilmProductionsRepository.GetUserFilmProductionsAsync(username, status, page * filmProductionsPerPage - 100, filmProductionsPerPage);
        }
    }
}
