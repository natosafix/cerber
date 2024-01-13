using Domain.Enums;

namespace Domain.Entities;

public class Question
{
    public int Id { get; set; }
    public QuestionType Type { get; set; }
    public string Title { get; set; }
    public bool Required { get; set; }
    public string? AnswerChoices { get; set; }
    public Event Event { get; set; }
    public int EventId { get; set; }
    public List<Answer> Answers { get; set; } = new();
}