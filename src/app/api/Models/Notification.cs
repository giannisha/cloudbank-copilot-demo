using System.ComponentModel.DataAnnotations;

namespace Api.Models
{
    public class Notification
    {
        [Key]
        public string? Id { get; set; }
        public string? ImgSrc { get; set; }
        public string? Title { get; set; }
        public string? Description { get; set; }
        public string? Comments { get; set; }
        public DateTime? Date { get; set; }
    }
}