using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using MySerialList.Model.Review;

namespace MySerialList.Service.Interfaces
{
    public interface IReviewEpisodeService
    {
        Task AddOrUpdateReviewAsync(AddReviewEpisodeModel addReviewModel, string userId);
        Task<int?> GetUserReviewAsync(int episodeId, string userId);
        Task<RatingModel> GetRatingAsync(int episodeId);
    }
}
