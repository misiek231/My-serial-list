using MySerialList.Model.Review;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MySerialList.Service.Interfaces
{
    public interface IReviewService
    {
        Task AddOrUpdateReview(AddReviewModel addReviewModel, string userId);
        Task<IEnumerable<CommentModel>> GetComments(string movieId);
        Task<RatingModel> GetRating(string movieId);
        Task AddComment(AddCommentModel addCommentModel, int userId);
        Task<int?> GetUserReviewAsync(int filmProductionId, string userId);
    }
}
