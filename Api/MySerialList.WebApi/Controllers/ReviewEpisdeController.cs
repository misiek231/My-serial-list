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
    public class ReviewEpisdeController : ControllerBase
    {
        private readonly IReviewEpisodeService _reviewEpisodeService;
        public ReviewEpisdeController(IReviewEpisodeService reviewEpisodeService)
        {
            _reviewEpisodeService = reviewEpisodeService;
        }

        [HttpPost("add_review")]
        public async Task<ActionResult> AddOrUpdateReviewAsync([FromBody]AddReviewEpisodeModel addReviewModel)
        {
            await _reviewEpisodeService.AddOrUpdateReviewAsync(addReviewModel, User.Identity.Name);
            return Ok();
        }

        [HttpGet("get_review")]
        public async Task<ActionResult<int?>> GetUserReviewAsync(int episodeId)
        {
            return Ok(await _reviewEpisodeService.GetUserReviewAsync(episodeId, User.Identity.Name));
        }

        [AllowAnonymous]
        [HttpGet("get_rating/{episodeId}")]
        public async Task<ActionResult<RatingModel>> GetRatingAsync(int episodeId)
        {
            return Ok(await _reviewEpisodeService.GetRatingAsync(episodeId));
        }
    }
}