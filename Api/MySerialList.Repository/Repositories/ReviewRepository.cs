using Microsoft.EntityFrameworkCore;
using MySerialList.Data;
using MySerialList.Data.Model;
using MySerialList.Model.FilmProduction;
using MySerialList.Model.Review;
using MySerialList.Repository.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MySerialList.Repository.Repositories
{
    public class ReviewRepository : IReviewRepository
    {
        private readonly MySerialListDBContext _movieBookDBContext;
        public ReviewRepository(MySerialListDBContext movieBookDBContext)
        {
            _movieBookDBContext = movieBookDBContext;
        }

        public async Task AddComment(AddCommentModel addCommentModel, int userId)
        {
            await _movieBookDBContext.Comments.AddAsync(new Comment
            {
                //FilmProductionId = addCommentModel.FilmProductionId,
                Description = addCommentModel.Description,
                CreateAt = DateTime.Now,
                //  UserId = userId
            });

            await _movieBookDBContext.SaveChangesAsync();
        }

        public async Task AddOrUpdateReview(AddReviewModel addReviewModel, string userId)
        {
            IQueryable<ReviewFilmProduction> qr = _movieBookDBContext.FilmProductionReviews
                .Where(r => r.UserId == userId)
                .Where(r => r.FilmProductionId == addReviewModel.FilmProductionId);

            if (await qr.AnyAsync())
            {
                ReviewFilmProduction model = await qr.FirstAsync();
                model.Grade = addReviewModel.Grade;
                _movieBookDBContext.FilmProductionReviews.Update(model);
            }
            else
            {
                await _movieBookDBContext.FilmProductionReviews.AddAsync(new ReviewFilmProduction
                {
                    FilmProductionId = addReviewModel.FilmProductionId,
                    Grade = addReviewModel.Grade,
                    UserId = userId
                });
            }

            await _movieBookDBContext.SaveChangesAsync();
        }

        public async Task<RatingModel> GetRating(string movieId)
        {
            RatingModel i = await _movieBookDBContext.FilmProductionReviews
                // .Where(r => r.FilmProductionId == movieId)
                // .GroupBy(o => new { o.FilmProductionId })
                .Select(g => new RatingModel
                {
                    // Rating = Math.Round(g.Average(r => r.Grade), 1) ,
                    //Votes = g.Count()
                }).FirstOrDefaultAsync();

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

        public async Task<IEnumerable<CommentModel>> GetComments(string movieId)
        {
            return await _movieBookDBContext.Comments
                // .Where(r => r.FilmProductionId == movieId)
                .Select(r => new CommentModel
                {
                    Description = r.Description,
                    CreateAt = r.CreateAt.ToString(@"dd/MM/yyyy hh\:mm"),
                    Username = r.User.UserName
                }).ToListAsync();
        }

        public async Task<IEnumerable<FilmProductionRating>> GetTopRated()
        {
            return await _movieBookDBContext.FilmProductionReviews
                // .GroupBy(o => new { o.FilmProductionId })
                // .OrderByDescending(g => g.Average(r => r.Grade))
                .Select(g => new FilmProductionRating
                {
                    // FilmProductionId = g.Key.FilmProductionId,
                    //   Rating = Math.Round(g.Average(r => r.Grade), 1),
                    //   Votes = g.Count()
                }).ToListAsync();
        }

        public async Task<bool> IsCommentAdded(string movieId, int userId)
        {
            return await _movieBookDBContext.Comments
                //.Where(r => r.FilmProductionId == movieId)
                //   .Where(r => r.UserId == userId)
                .AnyAsync();
        }

        public async Task<int?> GetUserReviewAsync(int filmProductionId, string userId)
        {
            IQueryable<int> qr = _movieBookDBContext.FilmProductionReviews
                .Where(r => r.UserId == userId)
                .Where(r => r.FilmProductionId == filmProductionId)
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
