using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using MySerialList.Model.Review;

namespace MySerialList.Repository.Interfaces
{
    public interface IReviewEpisodeRepository
    {
        Task AddOrUpdateReviewAsync(AddReviewEpisodeModel addReviewModel, string userId);
        Task<RatingModel> GetRatingAsync(int episodeId);
        Task<int?> GetUserReviewAsync(int episodeId, string userId);
    }
}
