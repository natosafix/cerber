using Domain.Enums;

namespace Web.Dtos.Response;

public class QuestionResponseDto
{
    public int Id { get; set; }
    
    public QuestionType Type { get; set; }
    
    public string Title { get; set; }
    
    public string[] AnswerChoices { get; set; }
    
    public bool Required { get; set; }
}