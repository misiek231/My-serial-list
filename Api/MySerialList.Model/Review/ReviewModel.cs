namespace MySerialList.Model.Review
{
    public class CommentModel
    {
        public string Description { get; set; }
        public string Username { get; set; }
        public string CreateAt { get; set; }
        public bool IsCurrentUserComment { get; set; }
    }
}
