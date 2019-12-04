using MySerialList.Model.User;
using System.Threading.Tasks;

namespace MySerialList.Service.Interfaces
{
    public interface IAccountService
    {
        Task<TokenModel> AuthenticateAsync(string username, string password);
        Task CreateAsync(CreateUserModel value);
        Task UpdateAsync(int id, EditUserModel value);
        Task DeleteAsync(int id);
        Task ConfirmEmail(string userId, string emailToken);
        Task LogoutAsync();
    }
}
