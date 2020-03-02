using MySerialList.Model.Review;
using MySerialList.Repository.Interfaces;
using MySerialList.Service.Exception;
using MySerialList.Service.Interfaces;
using System;
using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;

namespace MySerialList.Service.Services
{
    public class ReviewFilmProductionService : IReviewFilmProductionService
    {
        private readonly IReviewFilmProductionRepository _reviewFilmProductionRepository;
        private readonly IUserFilmProductionsRepository _userFilmProductionsRepository;
        private readonly IFilmProductionRepository _filmProductionRepository;

        public ReviewFilmProductionService(IReviewFilmProductionRepository reviewRepository, IUserFilmProductionsRepository userFilmProductionsRepository, IFilmProductionRepository filmProductionRepository)
        {
            _reviewFilmProductionRepository = reviewRepository;
            _userFilmProductionsRepository = userFilmProductionsRepository;
            _filmProductionRepository = filmProductionRepository;
        }

        public async Task AddCommentAsync(AddCommentModel addCommentModel, string userId)
        {
            await CheckFilmProductionExist(addCommentModel.FilmProductionId);

            if (!await _userFilmProductionsRepository.IsFilmProductionAddedAsync(addCommentModel.FilmProductionId, userId))
            {
                throw new HttpStatusCodeException(HttpStatusCode.BadRequest, "Dodaj Produkcje filmową do swojej list aby móc ją komentować.");
            }

            await _reviewFilmProductionRepository.AddCommentAsync(addCommentModel, userId);
        }

        public async Task EditCommentAsync(AddCommentModel addCommentModel, int id, string userId)
        {
            if (!await _reviewFilmProductionRepository.CommentExsistsAsync(id))
            {
                throw new HttpStatusCodeException(HttpStatusCode.NotFound, "Komentarz nie istnieje.");
            }

            if (!await _reviewFilmProductionRepository.IsUserCommentAsync(id, userId))
            {
                throw new HttpStatusCodeException(HttpStatusCode.BadRequest, "Nie możesz edytować tego komentarza.");
            }

            await _reviewFilmProductionRepository.EditCommentAsync(addCommentModel, id);
        }

        public async Task AddOrUpdateReviewAsync(AddReviewFilmProductionModel addReviewModel, string userId)
        {
            await CheckFilmProductionExist(addReviewModel.FilmProductionId);

            if (!await _userFilmProductionsRepository.IsFilmProductionAddedAsync(addReviewModel.FilmProductionId, userId))
            {
                throw new HttpStatusCodeException(HttpStatusCode.BadRequest, "Dodaj produkcję filmową do listy aby móc ją ocenić");
            }
            await _reviewFilmProductionRepository.AddOrUpdateReviewAsync(addReviewModel, userId);
        }

        public async Task<RatingModel> GetRatingAsync(int filmProductionId)
        {
            await CheckFilmProductionExist(filmProductionId);

            return await _reviewFilmProductionRepository.GetRatingAsync(filmProductionId);
        }

        public async Task<IEnumerable<CommentModel>> GetCommentsAsync(int filmProductionId, string userId)
        {
            await CheckFilmProductionExist(filmProductionId);

            return await _reviewFilmProductionRepository.GetCommentsAsync(filmProductionId, userId);
        }

        public Task<int?> GetUserReviewAsync(int filmProductionId, string userId)
        {
            return _reviewFilmProductionRepository.GetUserReviewAsync(filmProductionId, userId);
        }

        private async Task CheckFilmProductionExist(int filmProductionId)
        {
            if (!await _filmProductionRepository.ExsistsAsync(filmProductionId))
            {
                throw new HttpStatusCodeException(HttpStatusCode.NotFound, "Podana produkcja filmowa nie istnieje.");
            }
        }
    }
}
