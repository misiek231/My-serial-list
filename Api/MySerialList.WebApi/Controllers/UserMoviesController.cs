using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MovieBook.Component;
using MovieBook.Model.Movie;
using MovieBook.Model.UserMovies;
using MovieBook.Service.Interfaces;

namespace MovieBook.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class UserMoviesController : ControllerBase
    {
        private readonly IUserMoviesService _userMoviesService;
        public UserMoviesController(IUserMoviesService userMoviesService)
        {
            _userMoviesService = userMoviesService;
        }

        [HttpPost("add_movie")]
        public async Task<ActionResult> AddMovie([FromBody]AddUserMovieModel addUserMovieModel)
        {         
            await _userMoviesService.AddMovie(addUserMovieModel, int.Parse(User.Identity.Name));
            return Ok();
        }

        [HttpGet("get_movies")]
        public async Task<ActionResult<IEnumerable<UserMovieList>>> GetMovies(WatchingStatus status)
        {
            return Ok(await _userMoviesService.GetUserMovies(int.Parse(User.Identity.Name), status));
        }

        [HttpDelete("delete_movie")]
        public async Task<ActionResult> DeleteMovie(string movieId)
        {
            await _userMoviesService.DeleteMovie(int.Parse(User.Identity.Name), movieId);
            return Ok();
        }
    }
}