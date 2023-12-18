namespace Web.Dtos.Response;

public class AnswerResponseDto
{
    public int Id { get; set; }
    
    public string Content { get; set; }
    
    public int QuestionId { get; set; }
    
    public Guid Customer { get; set; }
}