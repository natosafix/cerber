using Domain.Enums;

namespace Domain.Entities;

public class DraftQuestion
{
    public int Id { get; set; }
    public int DraftEventId { get; set; }
    public string Title { get; set; }
    public QuestionType Type { get; set; }
    public string? AnswerChoices { get; set; }
}