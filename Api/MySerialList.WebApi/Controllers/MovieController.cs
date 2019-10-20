using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MovieBook.Model.Movie;
using MovieBook.Service.Interfaces;

namespace MovieBook.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MovieController : ControllerBase
    {
        private readonly IMovieService _movieService;
        public MovieController(IMovieService movieService)
        {
            _movieService = movieService;
        }

        [HttpPost("add")]
        public async Task<ActionResult> AddMovieAsync(string title, int page)
        {
            await _movieService.SearchMovies(title, page);
            return Ok();
        }

        [HttpGet("search")]
        public async Task<ActionResult<IEnumerable<MovieSearchList>>> SearchMovies(string title, int page)
        {
            return Ok(await _movieService.SearchMovies(title, page));
        }

        [HttpGet("get_movie")]
        public async Task<ActionResult<Movie>> GetMovie(string id)
        {
            return Ok(await _movieService.GetMovie(id));
        }

        [HttpGet("get_top")]
        public async Task<ActionResult<IEnumerable<MovieRating>>> GetTopRated()
        {
            return Ok(await _movieService.GetTopRated());
        }
    }
}