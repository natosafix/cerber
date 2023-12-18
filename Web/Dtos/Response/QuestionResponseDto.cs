using Domain.Enums;

namespace Web.Dtos.Response;

public class QuestionResponseDto
{
    public int Id { get; set; }
    
    public QuestionType Type { get; set; }
    
    public string Content { get; set; }
    
    public bool Required { get; set; }
}