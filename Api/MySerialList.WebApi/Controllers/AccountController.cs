using Microsoft.AspNetCore.Mvc;
using MovieBook.Model.User;
using MovieBook.Service.Interfaces;
using System.Threading.Tasks;

namespace MovieBook.WebApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AccountController : ControllerBase
    {

        private readonly IAccountService _accountService;
        public AccountController(IAccountService accountService)
        {
            _accountService = accountService;
        }

        [HttpPost("login")]
        public async Task<ActionResult<TokenModel>> LoginAsync([FromBody]AuthenticateUserModel userParam)
        {
            return Ok(await _accountService.AuthenticateAsync(userParam.UserName, userParam.Password));
        }

        [HttpPost("create")]
        public async Task<ActionResult> CreateUserAsync([FromBody] CreateUserModel value)
        {
            await _accountService.CreateAsync(value);
            return Ok();
        }

       // [Authorize(Roles = "Administrator")]
        [HttpPut("update/{id}")]
        public async Task<ActionResult> UpdateUserAsync(int id, [FromBody] EditUserModel value)
        {
            await _accountService.UpdateAsync(id, value);
            return Ok();
        }

       // [Authorize(Roles = "Administrator")]
        [HttpDelete("delete/{id}")]
        public async Task<ActionResult> DeleteAsync(int id)
        {
            await _accountService.DeleteAsync(id);
            return Ok();
        }
    }
}
