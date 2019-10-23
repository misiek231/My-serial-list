using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MySerialList.Model.Review;
using MySerialList.Service.Interfaces;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MySerialList.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class ReviewController : ControllerBase
    {
        private readonly IReviewService _reviewService;

        public ReviewController(IReviewService reviewService)
        {
            _reviewService = reviewService;
        }

        [HttpPost("add_review")]
        public async Task<ActionResult> AddReviewAsync([FromBody]AddReviewModel addReviewModel)
        {
            await _reviewService.AddOrUpdateReview(addReviewModel, User.Identity.Name);
            return Ok();
        }

        [HttpGet("get_review")]
        public async Task<ActionResult<int?>> GetUserReviewAsync(int filmProductionId)
        {
            return Ok(await _reviewService.GetUserReviewAsync(filmProductionId, User.Identity.Name));
        }

        [HttpPost("add_comment")]
        public async Task<ActionResult> AddComment([FromBody]AddCommentModel addCommentModel)
        {
            await _reviewService.AddComment(addCommentModel, int.Parse(User.Identity.Name));
            return Ok();
        }

        [AllowAnonymous]
        [HttpGet("get_comments")]
        public async Task<ActionResult<IEnumerable<CommentModel>>> GetComments(string movieId)
        {
            return Ok(await _reviewService.GetComments(movieId));
        }

        [AllowAnonymous]
        [HttpGet("get_rating")]
        public async Task<ActionResult<RatingModel>> GetRating(string movieId)
        {
            return Ok(await _reviewService.GetRating(movieId));
        }
    }
}