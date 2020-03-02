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
    public class ReviewFilmProductionRepository : IReviewFilmProductionRepository
    {
        private readonly MySerialListDBContext _mySerialListDBContext;
        public ReviewFilmProductionRepository(MySerialListDBContext movieBookDBContext)
        {
            _mySerialListDBContext = movieBookDBContext;
        }

        public async Task AddCommentAsync(AddCommentModel addCommentModel, string userId)
        {
            await _mySerialListDBContext.Comments.AddAsync(new Comment
            {
                FilmProductionId = addCommentModel.FilmProductionId,
                Description = addCommentModel.Description,
                CreateAt = DateTime.Now,
                UserId = userId
            });

            await _mySerialListDBContext.SaveChangesAsync();
        }

        public async Task AddOrUpdateReviewAsync(AddReviewFilmProductionModel addReviewModel, string userId)
        {
            IQueryable<ReviewFilmProduction> qr = _mySerialListDBContext.FilmProductionReviews
                .Where(r => r.UserId == userId)
                .Where(r => r.FilmProductionId == addReviewModel.FilmProductionId);

            if (await qr.AnyAsync())
            {
                ReviewFilmProduction model = await qr.FirstAsync();
                model.Grade = addReviewModel.Grade;
                _mySerialListDBContext.FilmProductionReviews.Update(model);
            }
            else
            {
                await _mySerialListDBContext.FilmProductionReviews.AddAsync(new ReviewFilmProduction
                {
                    FilmProductionId = addReviewModel.FilmProductionId,
                    Grade = addReviewModel.Grade,
                    UserId = userId
                });
            }

            await _mySerialListDBContext.SaveChangesAsync();
        }

        public async Task<RatingModel> GetRatingAsync(int filmProductionId)
        {
            RatingModel i = await _mySerialListDBContext.FilmProductionReviews
                 .Where(r => r.FilmProductionId == filmProductionId)
                 .GroupBy(o => new { o.FilmProductionId })
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

        public async Task<IEnumerable<CommentModel>> GetCommentsAsync(int filmProductionId, string userId)
        {
            return await _mySerialListDBContext.Comments
                .Where(r => r.FilmProductionId == filmProductionId)
                .Select(r => new CommentModel
                {
                    Description = r.Description,
                    CreateAt = r.CreateAt.ToString(@"dd/MM/yyyy hh\:mm"),
                    Username = r.User.UserName,
                    IsCurrentUserComment = userId != null ? (r.UserId == userId) : false
                }).ToListAsync();
        }

        public async Task<int?> GetUserReviewAsync(int filmProductionId, string userId)
        {
            IQueryable<int> qr = _mySerialListDBContext.FilmProductionReviews
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

        public Task<bool> CommentExsistsAsync(int id)
        {
            return _mySerialListDBContext.Comments.Where(c => c.Id == id).AnyAsync();
        }

        public Task<bool> IsUserCommentAsync(int id, string userId)
        {
            return _mySerialListDBContext.Comments.Where(c => c.Id == id).Where(c => c.UserId == userId).AnyAsync();
        }

        public async Task EditCommentAsync(AddCommentModel addCommentModel, int id)
        {
            Comment comment = await _mySerialListDBContext.Comments.Where(c => c.Id == id).FirstOrDefaultAsync();
            comment.Description = addCommentModel.Description;
            comment.CreateAt = DateTime.Now;

            await _mySerialListDBContext.SaveChangesAsync();
        }
    }
}
