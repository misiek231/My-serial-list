using MySerialList.Model.Review;
using MySerialList.Repository.Interfaces;
using MySerialList.Service.Exception;
using MySerialList.Service.Interfaces;
using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;

namespace MySerialList.Service.Services
{
    public class ReviewService : IReviewService
    {
        private readonly IReviewRepository _reviewRepository;
        private readonly IUserFilmProductionsRepository _userFilmProductionsRepository;
        private readonly IFilmProductionRepository _filmProductionRepository;

        public ReviewService(IReviewRepository reviewRepository, IUserFilmProductionsRepository userFilmProductionsRepository, IFilmProductionRepository filmProductionRepository)
        {
            _reviewRepository = reviewRepository;
            _userFilmProductionsRepository = userFilmProductionsRepository;
            _filmProductionRepository = filmProductionRepository;
        }

        public async Task AddComment(AddCommentModel addCommentModel, int userId)
        {
            //if (!await _userFilmProductionsRepository.IsFilmProductionAdded(addCommentModel.FilmProductionId, userId))
            //{
            //    throw new HttpStatusCodeException(HttpStatusCode.BadRequest, "FilmProduction is not in user's movies list.");
            //}

            if (await _reviewRepository.IsCommentAdded(addCommentModel.FilmProductionId, userId))
            {
                throw new HttpStatusCodeException(HttpStatusCode.BadRequest, "Comment is already added");
            }

            await _reviewRepository.AddComment(addCommentModel, userId);
        }

        public async Task AddOrUpdateReview(AddReviewModel addReviewModel, string userId)
        {
            if (!await _filmProductionRepository.Exsists(addReviewModel.FilmProductionId))
            {
                throw new HttpStatusCodeException(HttpStatusCode.NotFound, "Podana produkcja filmowa nie istnieje.");
            }

            if (!await _userFilmProductionsRepository.IsFilmProductionAdded(addReviewModel.FilmProductionId, userId))
            {
                throw new HttpStatusCodeException(HttpStatusCode.BadRequest, "Dodaj produkcję filmową do listy aby móc ją ocenić");
            }
            await _reviewRepository.AddOrUpdateReview(addReviewModel, userId);
        }

        public async Task<RatingModel> GetRating(string movieId)
        {
            return await _reviewRepository.GetRating(movieId);
        }

        public async Task<IEnumerable<CommentModel>> GetComments(string movieId)
        {
            return await _reviewRepository.GetComments(movieId);
        }

        public async Task<int?> GetUserReviewAsync(int filmProductionId, string userId)
        {
            return await _reviewRepository.GetUserReviewAsync(filmProductionId, userId);
        }
    }
}
