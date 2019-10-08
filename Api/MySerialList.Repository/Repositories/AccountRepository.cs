using Microsoft.EntityFrameworkCore;
using MovieBook.Component;
using MovieBook.Data;
using MovieBook.Data.Model;
using MovieBook.Model.User;
using MovieBook.Repository.Interfaces;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace MovieBook.Repository.Repositories
{
    public class AccountRepository : IAccountRepository
    {
        private MySerialListDBContext DbContext { get; set; }
        public AccountRepository(MySerialListDBContext dbContext)
        {
            DbContext = dbContext;
        }

        public async Task<bool> CheckIfAccountExistAsync(string email)
        {
            return await DbContext.Users.Where(a => a.Email == email).AnyAsync();
        }

        public async Task CreateUserAccountAsync(CreateUserModel value)
        {
            byte[] salt = Helpers.GenerateSalt();

            User user = new User
            {
                Email = value.Email,
                HashedPassword = Helpers.HashPassword(value.Password, salt),
                Salt = salt,
                Username = value.Username
            };

            await DbContext.Users.AddAsync(user);
            await DbContext.SaveChangesAsync();
        }

        public async Task<User> FindByUserNameAsync(string userName)
        {
            return await DbContext.Users.Where(a => a.Username == userName).FirstOrDefaultAsync();
        }
    }
}
