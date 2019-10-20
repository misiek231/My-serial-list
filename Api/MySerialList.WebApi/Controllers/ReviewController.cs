using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MySerialList.Model.Review;
using MySerialList.Service.Interfaces;

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
        public async Task<ActionResult> AddReview([FromBody]AddReviewModel addReviewModel)
        {
            await _reviewService.AddReview(addReviewModel, int.Parse(User.Identity.Name));
            return Ok();
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