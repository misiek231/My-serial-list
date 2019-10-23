using System.ComponentModel.DataAnnotations;

namespace MySerialList.Model.Review
{
    public class AddReviewEpisodeModel
    {
        [Required]
        public int EpisodeId { get; set; }
        [Required]
        [Range(1, 10)]
        public int Grade { get; set; }
    }
}
