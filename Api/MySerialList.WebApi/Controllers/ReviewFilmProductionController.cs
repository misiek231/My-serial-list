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
    public class ReviewFilmProductionController : ControllerBase
    {
        private readonly IReviewFilmProductionService _reviewFilmProductionService;

        public ReviewFilmProductionController(IReviewFilmProductionService reviewService)
        {
            _reviewFilmProductionService = reviewService;
        }

        [HttpPost("add_review")]
        [Authorize]
        public async Task<ActionResult> AddOrUpdateReviewAsync([FromBody]AddReviewFilmProductionModel addReviewModel)
        {
            await _reviewFilmProductionService.AddOrUpdateReviewAsync(addReviewModel, User.Identity.Name);
            return Ok();
        }

        [HttpGet("get_review")]
        [Authorize]
        public async Task<ActionResult<int?>> GetUserReviewAsync(int filmProductionId)
        {
            return Ok(await _reviewFilmProductionService.GetUserReviewAsync(filmProductionId, User.Identity.Name));
        }

        [HttpPost("add_comment")]
        [Authorize]
        public async Task<ActionResult> AddCommentAsync([FromBody]AddCommentModel addCommentModel)
        {
            await _reviewFilmProductionService.AddCommentAsync(addCommentModel, User.Identity.Name);
            return Ok();
        }

        [HttpPut("edit_comment/{id}")]
        [Authorize]
        public async Task<ActionResult> EditCommentAsync([FromBody]AddCommentModel addCommentModel, int id)
        {
            await _reviewFilmProductionService.EditCommentAsync(addCommentModel, id, User.Identity.Name);
            return Ok();
        }

        [AllowAnonymous]
        [HttpGet("get_comments/{filmProductionId}")]
        public async Task<ActionResult<IEnumerable<CommentModel>>> GetCommentsAsync(int filmProductionId)
        {
            return Ok(await _reviewFilmProductionService.GetCommentsAsync(filmProductionId, User.Identity.Name));
        }

        [AllowAnonymous]
        [HttpGet("get_rating/{filmProductionId}")]
        public async Task<ActionResult<RatingModel>> GetRatingAsync(int filmProductionId)
        {
            return Ok(await _reviewFilmProductionService.GetRatingAsync(filmProductionId));
        }
    }
}