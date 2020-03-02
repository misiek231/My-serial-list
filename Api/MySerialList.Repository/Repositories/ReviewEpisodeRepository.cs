using Microsoft.EntityFrameworkCore;
using MySerialList.Data;
using MySerialList.Data.Model;
using MySerialList.Model.Review;
using MySerialList.Repository.Interfaces;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace MySerialList.Repository.Repositories
{
    public class ReviewEpisodeRepository : IReviewEpisodeRepository
    {
        private readonly MySerialListDBContext _mySerialListDBContext;
        public ReviewEpisodeRepository(MySerialListDBContext movieBookDBContext)
        {
            _mySerialListDBContext = movieBookDBContext;
        }

        public async Task AddOrUpdateReviewAsync(AddReviewEpisodeModel addReviewModel, string userId)
        {
            IQueryable<ReviewEpisode> qr = _mySerialListDBContext.EpisodeReviews
                .Where(r => r.UserId == userId)
                .Where(r => r.EpisodeId == addReviewModel.EpisodeId);

            if (await qr.AnyAsync())
            {
                ReviewEpisode model = await qr.FirstAsync();
                model.Grade = addReviewModel.Grade;
                _mySerialListDBContext.EpisodeReviews.Update(model);
            }
            else
            {
                await _mySerialListDBContext.EpisodeReviews.AddAsync(new ReviewEpisode
                {
                    EpisodeId = addReviewModel.EpisodeId,
                    Grade = addReviewModel.Grade,
                    UserId = userId
                });
            }

            await _mySerialListDBContext.SaveChangesAsync();
        }

        public async Task<RatingModel> GetRatingAsync(int episodeId)
        {
            RatingModel i = await _mySerialListDBContext.EpisodeReviews
                .Where(r => r.EpisodeId == episodeId)
                .GroupBy(o => new { o.EpisodeId })
                .Select(g => new RatingModel
                {
                    Rating = Math.Round(g.Average(r => r.Grade), 1),
                    Votes = g.Count()
                }).FirstAsync();

            if (i == null)
            {
                i = new RatingModel
                {
                    Rating = 0,
                    Votes = 0
                };
            }

            return i;
        }

        public async Task<int?> GetUserReviewAsync(int episodeId, string userId)
        {
            IQueryable<int> qr = _mySerialListDBContext.EpisodeReviews
                .Where(r => r.UserId == userId)
                .Where(r => r.EpisodeId == episodeId)
                .Select(r => r.Grade);

            if (await qr.AnyAsync())
            {
                return await qr.FirstOrDefaultAsync();
            }
            else
            {
                return null;
            }
        }
    }
}
