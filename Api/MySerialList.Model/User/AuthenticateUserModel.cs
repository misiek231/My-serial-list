using System.ComponentModel.DataAnnotations;

namespace MySerialList.Model.User
{
    public class AuthenticateUserModel
    {
        [Required]
        public string Username { get; set; }
        [Required]
        public string Password { get; set; }
    }
}
