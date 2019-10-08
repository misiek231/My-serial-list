using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using MovieBook.Model.Review;

namespace MovieBook.Service.Interfaces
{
    public interface IReviewService
    {
        Task AddReview(AddReviewModel addReviewModel, int userId);
        Task<IEnumerable<CommentModel>> GetComments(string movieId);
        Task<RatingModel> GetRating(string movieId);
        Task AddComment(AddCommentModel addCommentModel, int userId);
    }
}
