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
    public class ReviewEpisodeService : IReviewEpisodeService
    {
        private readonly IReviewEpisodeRepository _reviewEpisodeRepository;
        private readonly IUserEpisdeRepository _userEpisodeRepository;
        private readonly IEpisodeRepository _episodeRepository;

        public ReviewEpisodeService(IReviewEpisodeRepository reviewRepository, IUserEpisdeRepository userEpisodeRepository, IEpisodeRepository episodeRepository)
        {
            _reviewEpisodeRepository = reviewRepository;
            _userEpisodeRepository = userEpisodeRepository;
            _episodeRepository = episodeRepository;
        }
        public async Task AddOrUpdateReviewAsync(AddReviewEpisodeModel addReviewModel, string userId)
        {
            await CheckEpisodeExist(addReviewModel.EpisodeId);

            if (!await _userEpisodeRepository.IsEisodeAddedAsync(addReviewModel.EpisodeId, userId))
            {
                throw new HttpStatusCodeException(HttpStatusCode.BadRequest, "Dodaj odcinek do listy aby móc go ocenić");
            }
            await _reviewEpisodeRepository.AddOrUpdateReviewAsync(addReviewModel, userId);
        }

        public async Task<RatingModel> GetRatingAsync(int episodeId)
        {
            await CheckEpisodeExist(episodeId);

            return await _reviewEpisodeRepository.GetRatingAsync(episodeId);
        }

        public Task<int?> GetUserReviewAsync(int episodeId, string userId)
        {
            return _reviewEpisodeRepository.GetUserReviewAsync(episodeId, userId);
        }

        private async Task CheckEpisodeExist(int episodeId)
        {
            if (!await _episodeRepository.ExsistsAsync(episodeId))
            {
                throw new HttpStatusCodeException(HttpStatusCode.NotFound, "Podany odcinek nie istnieje.");
            }
        }
    }
}
