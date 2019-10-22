using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MySerialList.Component;
using MySerialList.Model.FilmProduction;
using MySerialList.Model.UserFilmProductions;
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

        [HttpPost("add_movie")]
        public async Task<ActionResult> AddFilmProduction([FromBody]AddUserFilmProductionModel addUserFilmProductionModel)
        {
            await _userFilmProductionsService.AddFilmProduction(addUserFilmProductionModel, User.Identity.Name);
            return Ok();
        }

        [HttpGet("get_movies")]
        public async Task<ActionResult<IEnumerable<UserFilmProductionList>>> GetFilmProductions(WatchingStatus status)
        {
            return Ok(await _userFilmProductionsService.GetUserFilmProductions(User.Identity.Name, status));
        }

        [HttpDelete("delete_movie")]
        public async Task<ActionResult> DeleteFilmProduction(string movieId)
        {
            await _userFilmProductionsService.DeleteFilmProduction(User.Identity.Name, movieId);
            return Ok();
        }
    }
}