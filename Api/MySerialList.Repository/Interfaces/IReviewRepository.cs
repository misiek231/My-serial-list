using MySerialList.Model.FilmProduction;
using MySerialList.Model.Review;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MySerialList.Repository.Interfaces
{
    public interface IReviewRepository
    {
        Task AddOrUpdateReview(AddReviewModel addReviewModel, string userId);
        Task<IEnumerable<CommentModel>> GetComments(string movieId);
        Task<RatingModel> GetRating(string movieId);
        Task<IEnumerable<FilmProductionRating>> GetTopRated();
        Task<bool> IsCommentAdded(string movieId, int userId);
        Task AddComment(AddCommentModel addCommentModel, int userId);
        Task<int?> GetUserReviewAsync(int filmProductionId, string userId);
    }
}
