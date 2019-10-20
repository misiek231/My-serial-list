using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MySerialList.Model.Movie;
using MySerialList.Service.Interfaces;
using MySerialList.Model.FilmProduction;

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

        [HttpGet("search")]
        public async Task<ActionResult<IEnumerable<MovieSearchList>>> SearchFilmProduction(string title, int page)
        {
            return Ok(await _filmProductionService.SearchMovies(title, page));
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Movie>> GetFilmProduction(string id)
        {
            return Ok(await _filmProductionService.GetMovie(id));
        }

        [HttpGet("top_rated")]
        public async Task<ActionResult<IEnumerable<FilmProductionRating>>> GetTopRated()
        {
            return Ok(await _filmProductionService.GetTopRated());
        }
    }
}