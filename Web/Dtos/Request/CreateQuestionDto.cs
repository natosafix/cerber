namespace Web.Dtos.Request;

public class CreateQuestionDto
{
    public int Type { get; set; }
    
    public string Content { get; set; }
    
    public string Required { get; set; }
    
    public string EventId { get; set; }
}