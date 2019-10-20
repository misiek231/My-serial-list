using Microsoft.AspNetCore.Mvc;
using MySerialList.Model.User;
using MySerialList.Service.Interfaces;
using System.Threading.Tasks;

namespace MySerialList.WebApi.Controllers
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
            return Ok(await _accountService.AuthenticateAsync(userParam.Username, userParam.Password));
        }

        [HttpGet("verify/email")]
        public async Task<RedirectResult> ConfirmEmail(string userId, string emailToken)
        {
            await _accountService.ConfirmEmail(userId, emailToken);
            return Redirect($"{Request.Scheme}://{Request.Host.Value}");
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
