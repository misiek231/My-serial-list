using MySerialList.Model.Review;
using MySerialList.Repository.Interfaces;
using MySerialList.Service.Exception;
using MySerialList.Service.Interfaces;
using System;
using System.Collections.Generic;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace MySerialList.Service.Services
{
    public class ReviewService : IReviewService
    {
        private readonly IReviewRepository _reviewRepository;
        private readonly IUserMoviesRepository _userMoviesRepository;

        public ReviewService(IReviewRepository reviewRepository, IUserMoviesRepository userMoviesRepository)
        {
            _reviewRepository = reviewRepository;
            _userMoviesRepository = userMoviesRepository;
        }

        public async Task AddComment(AddCommentModel addCommentModel, int userId)
        {
            if (!await _userMoviesRepository.IsMovieAdded(addCommentModel.MovieId, userId))
                throw new HttpStatusCodeException(HttpStatusCode.BadRequest, "Movie is not in user's movies list.");

            if (await _reviewRepository.IsCommentAdded(addCommentModel.MovieId, userId))
                throw new HttpStatusCodeException(HttpStatusCode.BadRequest, "Comment is already added");

            await _reviewRepository.AddComment(addCommentModel, userId);
        }

        public async Task AddReview(AddReviewModel addReviewModel, int userId)
        {
            if (!await _userMoviesRepository.IsMovieAdded(addReviewModel.MovieId, userId))
                throw new HttpStatusCodeException(HttpStatusCode.BadRequest, "Movie is not in user's movies list.");

            if (await _reviewRepository.IsReviewAdded(addReviewModel.MovieId, userId))
                throw new HttpStatusCodeException(HttpStatusCode.BadRequest, "Review is already added");

            await _reviewRepository.AddReview(addReviewModel, userId);

        }

        public async Task<RatingModel> GetRating(string movieId)
        {
            return await _reviewRepository.GetRating(movieId);
        }

        public async Task<IEnumerable<CommentModel>> GetComments(string movieId)
        {
            return await _reviewRepository.GetComments(movieId);
        }
    }
}
