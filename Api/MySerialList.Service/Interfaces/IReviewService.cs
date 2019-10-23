using MySerialList.Model.Review;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MySerialList.Service.Interfaces
{
    public interface IReviewFilmProductionService
    {
        Task AddOrUpdateReviewAsync(AddReviewFilmProductionModel addReviewModel, string userId);
        Task<IEnumerable<CommentModel>> GetCommentsAsync(int filmProductionId, string name);
        Task<RatingModel> GetRatingAsync(int filmProductionId);
        Task AddCommentAsync(AddCommentModel addCommentModel, string userId);
        Task<int?> GetUserReviewAsync(int filmProductionId, string userId);
        Task EditCommentAsync(AddCommentModel addCommentModel, int id, string userId);
    }
}
