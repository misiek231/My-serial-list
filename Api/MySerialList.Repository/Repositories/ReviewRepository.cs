using Microsoft.EntityFrameworkCore;
using MovieBook.Data;
using MovieBook.Data.Model;
using MovieBook.Model.Movie;
using MovieBook.Model.Review;
using MovieBook.Repository.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MovieBook.Repository.Repositories
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
                MovieId = addCommentModel.MovieId,
                Description = addCommentModel.Description,
                CreateAt = DateTime.Now,
                UserId = userId
            });

            await _movieBookDBContext.SaveChangesAsync();
        }

        public async Task AddReview(AddReviewModel addReviewModel, int userId)
        {
            await _movieBookDBContext.Reviews.AddAsync(new Review
            {
                MovieId = addReviewModel.MovieId,
                Grade = addReviewModel.Grade,
                UserId = userId
            });

            await _movieBookDBContext.SaveChangesAsync();
        }

        public async Task<RatingModel> GetRating(string movieId)
        {
            RatingModel i = await _movieBookDBContext.Reviews
                .Where(r => r.MovieId == movieId)
                .GroupBy(o => new { o.MovieId })
                .Select(g => new RatingModel
                {
                    Rating = Math.Round(g.Average(r => r.Grade), 1) ,
                    Votes = g.Count()
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
                .Where(r => r.MovieId == movieId)
                .Select(r => new CommentModel
                {
                    Description = r.Description,
                    CreateAt = r.CreateAt.ToString(@"dd/MM/yyyy hh\:mm"),
                    Username = r.User.UserName
                }).ToListAsync();
        }

        public async Task<IEnumerable<MovieRating>> GetTopRated()
        {
            return await _movieBookDBContext.Reviews
                .GroupBy(o => new { o.MovieId })
                .OrderByDescending(g => g.Average(r => r.Grade))
                .Select(g => new MovieRating
                {
                    MovieId = g.Key.MovieId,
                    Rating = Math.Round(g.Average(r => r.Grade), 1),
                    Votes = g.Count()
                }).ToListAsync();
        }

        public async Task<bool> IsCommentAdded(string movieId, int userId)
        {
            return await _movieBookDBContext.Comments
                .Where(r => r.MovieId == movieId)
                .Where(r => r.UserId == userId)
                .AnyAsync();
        }

        public async Task<bool> IsReviewAdded(string movieId, int userId)
        {
            return await _movieBookDBContext.Reviews
                 .Where(r => r.MovieId == movieId)
                 .Where(r => r.UserId == userId)
                 .AnyAsync();
        }
    }
}
