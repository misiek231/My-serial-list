using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MySerialList.Component;
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

        [HttpGet("{id}")]
        public async Task<ActionResult<FilmProductionData>> GetFilmProduction(int id)
        {
            return Ok(await _filmProductionService.GetFilmProduction(id, User.Identity.Name));
        }

        [HttpGet("get_all")]
        public async Task<ActionResult<IEnumerable<FilmProductionRating>>> GetAll(int page = 1, FilmProductionType type = FilmProductionType.all, string search = "")
        {
            return Ok(await _filmProductionService.GetAll(page, type, search));
        }
    }
}