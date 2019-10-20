using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using MySerialList.Model.Movie;
using MySerialList.Model.Review;

namespace MySerialList.Repository.Interfaces
{
    public interface IReviewRepository
    {
        Task AddReview(AddReviewModel addReviewModel, int userId);
        Task<IEnumerable<CommentModel>> GetComments(string movieId);
        Task<bool> IsReviewAdded(string movieId, int userId);
        Task<RatingModel> GetRating(string movieId);
        Task<IEnumerable<FilmProductionRating>> GetTopRated();
        Task<bool> IsCommentAdded(string movieId, int userId);
        Task AddComment(AddCommentModel addCommentModel, int userId);
    }
}
