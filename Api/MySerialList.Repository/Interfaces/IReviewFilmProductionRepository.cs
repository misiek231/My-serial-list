using MySerialList.Model.FilmProduction;
using MySerialList.Model.Review;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MySerialList.Repository.Interfaces
{
    public interface IReviewFilmProductionRepository
    {
        Task AddOrUpdateReviewAsync(AddReviewFilmProductionModel addReviewModel, string userId);
        Task<IEnumerable<CommentModel>> GetCommentsAsync(int filmProductionId, string userId);
        Task<RatingModel> GetRatingAsync(int filmProductionId);
        Task AddCommentAsync(AddCommentModel addCommentModel, string userId);
        Task<int?> GetUserReviewAsync(int filmProductionId, string userId);
        Task<bool> CommentExsistsAsync(int id);
        Task<bool> IsUserCommentAsync(int id, string userId);
        Task EditCommentAsync(AddCommentModel addCommentModel, int id);
    }
}
