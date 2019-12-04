using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MySerialList.Model.User;
using MySerialList.Service.Interfaces;

namespace MySerialList.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly IAccountService _accountService;
        public AccountController(IAccountService accountService, IAuthenticationSchemeProvider authenticationSchemeProvider)
        {
            _accountService = accountService;
        }

        [HttpPost("login")]
        public async Task<ActionResult<string>> LoginAsync([FromBody]AuthenticateUserModel userParam)
        {
            return Ok(await _accountService.AuthenticateAsync(userParam.Username, userParam.Password));
        }

        [HttpPost("logout")]
        [Authorize]
        public async Task<ActionResult<string>> LogoutAsync()
        {
            await _accountService.LogoutAsync();
            return Ok();
        }

        [HttpGet("verify/email")]
        public async Task<RedirectResult> ConfirmEmail(string userId, string emailToken)
        {
            await _accountService.ConfirmEmail(userId, emailToken);
            return Redirect($"{Request.Scheme}://{Request.Host.Value}");
        }
    }
}