using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace MySerialList.Model.Review
{
    public class AddReviewModel
    {
        [Required]
        public string MovieId { get; set; }
        [Required]
        public int Grade { get; set; }
    }
}
