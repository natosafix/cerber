namespace Web.Models;

public class CreateQuestionDto
{
    public int Type { get; set; }
    
    public string Content { get; set; }
    
    public bool Required { get; set; }
    
    public int EventId { get; set; }
}