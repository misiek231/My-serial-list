﻿using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using MovieBook.Component;
using MovieBook.Data.Model;
using MovieBook.Model.User;
using MovieBook.Repository.Interfaces;
using MovieBook.Service.Exception;
using MovieBook.Service.Interfaces;
using System;
using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace MovieBook.Service.Services
{
    public class AccountService : IAccountService
    {
        private readonly IAccountRepository _accountRepository;
        private readonly AppSettings _appSettings;
        public AccountService(IOptions<AppSettings> appSettings, IAccountRepository accountRepository)
        {
            _accountRepository = accountRepository;
            _appSettings = appSettings.Value;
        }

        public async Task<TokenModel> AuthenticateAsync(string userName, string password)
        {
            User user = await _accountRepository.FindByUserNameAsync(userName);

            if (user == null || user.HashedPassword != Helpers.HashPassword(password, user.Salt))
            {
                throw new HttpStatusCodeException(HttpStatusCode.BadRequest, "Incorrect email or password");
            }

            return new TokenModel
            {
                Token = GenerateToken(user)
            };
        }

        public async Task CreateAsync(CreateUserModel value)
        {
            if (await _accountRepository.CheckIfAccountExistAsync(value.Email))
                throw new HttpStatusCodeException(HttpStatusCode.BadRequest, "User already exsist");

            await _accountRepository.CreateUserAccountAsync(value);
        }

        public Task DeleteAsync(int id)
        {
            throw new NotImplementedException();
        }

        public Task UpdateAsync(int id, EditUserModel value)
        {
            throw new NotImplementedException();
        }

        private string GenerateToken(User user)
        {
            JwtSecurityTokenHandler tokenHandler = new JwtSecurityTokenHandler();
            byte[] key = Encoding.ASCII.GetBytes(_appSettings.Secret);
            SecurityTokenDescriptor tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[] {
                    new Claim(ClaimTypes.Name, user.Id.ToString())
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            SecurityToken token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
    }
}
