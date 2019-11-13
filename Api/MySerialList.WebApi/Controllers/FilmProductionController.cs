using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MySerialList.Model.FilmProduction;
using MySerialList.Service.Interfaces;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MySerialList.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FilmProductionController : ControllerBase
    {
        private readonly IFilmProductionService _filmProductionService;
        public FilmProductionController(IFilmProductionService filmProductionService)
        {
            _filmProductionService = filmProductionService;
        }

        [HttpPost("add")]
        [Authorize]
        public async Task<ActionResult> AddFilmProductionAsync([FromForm] AddFilmProduction addFilmProduction)
        {
            await _filmProductionService.AddFilmProductionAsync(addFilmProduction);
            return Ok();
        }

        [HttpGet("search/{title}")]
        public async Task<ActionResult<IEnumerable<FilmProductionSearch>>> SearchFilmProduction(string title, int page = 1)
        {
            return Ok(await _filmProductionService.SearchFilmProductions(title, page));
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<FilmProductionData>> GetFilmProduction(int id)
        {
            return Ok(await _filmProductionService.GetFilmProduction(id));
        }

        [HttpGet("top_rated")]
        public async Task<ActionResult<IEnumerable<FilmProductionRating>>> GetTopRated(int page = 1, int type = 1)
        {
            return Ok(await _filmProductionService.GetTopRated(page, type));
        }
    }
}