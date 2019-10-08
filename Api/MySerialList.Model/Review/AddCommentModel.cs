using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace MovieBook.Model.Review
{
    public class AddCommentModel
    {
        [Required]
        public string MovieId { get; set; }
        [Required]
        public string Description { get; set; }
    }
}
