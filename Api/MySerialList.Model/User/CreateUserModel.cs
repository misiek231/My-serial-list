using System.ComponentModel.DataAnnotations;

namespace MySerialList.Model.User
{
    public class CreateUserModel
    {
        [Required]
        public string Username { get; set; }
        [Required]
        public string Password { get; set; }
        [EmailAddress]
        [Required]
        public string Email { get; set; }
    }
}
