﻿using System.ComponentModel.DataAnnotations;

namespace MovieBook.Model.User
{
    public class EditUserModel
    {
        [Required]
        public string UserName { get; set; }
        [Required]
        public string Password { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        [Required]
        [EmailAddress]
        public string Email { get; set; }
        [Required]
        public string UserType { get; set; }
    }
}
