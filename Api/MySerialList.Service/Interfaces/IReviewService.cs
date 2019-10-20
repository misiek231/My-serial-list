using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using MySerialList.Model.Review;

namespace MySerialList.Service.Interfaces
{
    public interface IReviewService
    {
        Task AddReview(AddReviewModel addReviewModel, int userId);
        Task<IEnumerable<CommentModel>> GetComments(string movieId);
        Task<RatingModel> GetRating(string movieId);
        Task AddComment(AddCommentModel addCommentModel, int userId);
    }
}
