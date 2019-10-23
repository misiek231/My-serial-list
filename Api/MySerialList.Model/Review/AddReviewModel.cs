using System.ComponentModel.DataAnnotations;

namespace MySerialList.Model.Review
{
    public class AddReviewModel
    {
        [Required]
        public int FilmProductionId { get; set; }
        [Required]
        [Range(1, 10)]
        public int Grade { get; set; }
    }
}
