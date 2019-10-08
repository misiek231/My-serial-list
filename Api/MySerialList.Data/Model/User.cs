using System;
using System.Collections.Generic;
using System.Text;

namespace MovieBook.Data.Model
{
    public class User
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string HashedPassword { get; set; }
        public string Email { get; set; }
        public byte[] Salt { get; set; }
    }
}
