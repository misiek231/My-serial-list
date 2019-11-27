using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MySerialList.Model.Episode;
using MySerialList.Service.Interfaces;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MySerialList.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EpisodeController : ControllerBase
    {
        private readonly IEpisodeService _episodeService;
        public EpisodeController(IEpisodeService episodeService)
        {
            _episodeService = episodeService;
        }

        [HttpPost("add")]
        [Authorize]
        public async Task<ActionResult> AddEpisodeAsync([FromBody] AddEpisode addEpisode)
        {
            await _episodeService.AddEpisodeAsync(addEpisode);
            return Ok();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<EpisodeData>> GetEpisodeAsync(int id)
        {
            return Ok(await _episodeService.GetEpisodeAsync(id));
        }

        [HttpGet("get_all")]
        public async Task<ActionResult<IEnumerable<EpisodeData>>> GetAllEpisodesAsync(int filmProductionId, int season)
        {
            return Ok(await _episodeService.GetAllEpisodesAsync(filmProductionId, season, User.Identity.Name));
        }
    }
}