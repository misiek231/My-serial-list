using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MySerialList.Component;
using MySerialList.Model.FilmProduction;
using MySerialList.Model.UserFilmProductions;
using MySerialList.Model.UserMovies;
using MySerialList.Service.Interfaces;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MySerialList.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class UserFilmProductionsController : ControllerBase
    {
        private readonly IUserFilmProductionsService _userFilmProductionsService;
        public UserFilmProductionsController(IUserFilmProductionsService userFilmProductionsService)
        {
            _userFilmProductionsService = userFilmProductionsService;
        }

        [HttpPost("add_film_production")]
        public async Task<ActionResult> AddFilmProductionAsync([FromBody]AddUserFilmProductionModel addUserFilmProductionModel)
        {
            await _userFilmProductionsService.AddFilmProductionAsync(addUserFilmProductionModel, User.Identity.Name);
            return Ok();
        }

        [HttpGet("get_film_productions/{username}")]
        [AllowAnonymous]
        public async Task<ActionResult<IEnumerable<FilmProductionRating>>> GetFilmProductionsAsync(string username, int page = 1, WatchingStatus status = WatchingStatus.Current)
        {
            return Ok(await _userFilmProductionsService.GetUserFilmProductionsAsync(username, status, page, User.Identity.Name));
        }

        [HttpPut("update")]
        public async Task<ActionResult> GetFilmProductionsAsync([FromBody] UpdateUserFilmProductionModel updateUserFilmProductionModel)
        {
            await _userFilmProductionsService.UpdateUserFilmProductionsAsync(User.Identity.Name, updateUserFilmProductionModel);
            return Ok();
        }

        [HttpDelete("delete_film_production/{filmProductionId}")]
        public async Task<ActionResult> DeleteFilmProductionAsync(int filmProductionId)
        {
            await _userFilmProductionsService.DeleteFilmProductionAsync(User.Identity.Name, filmProductionId);
            return Ok();
        }
    }
}