using System.ComponentModel.DataAnnotations;

namespace MySerialList.Model.Review
{
    public class AddCommentModel
    {
        [Required]
        public string FilmProductionId { get; set; }
        [Required]
        public string Description { get; set; }
    }
}
