using MovieBook.Data.Model;
using MovieBook.Model.User;
using System.Threading.Tasks;

namespace MovieBook.Repository.Interfaces
{
    public interface IAccountRepository
    {
        Task<User> FindByUserNameAsync(string userName);
        Task<bool> CheckIfAccountExistAsync(string email);
        Task CreateUserAccountAsync(CreateUserModel value);
    }
}
