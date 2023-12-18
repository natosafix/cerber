using System.ComponentModel.DataAnnotations;

namespace Web.Dtos.Request;

public class CreateQuestionDto
{
    [Required]
    public int Type { get; set; }
    
    [Required]
    public string Content { get; set; }
    
    [Required]
    public string Required { get; set; }
    
    [Required]
    public string EventId { get; set; }
}