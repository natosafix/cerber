namespace Domain.Entities;

public class Quiz
{
    public int Id { get; set; }
    
    public Event Event { get; set; }
    public int EventId { get; set; }
    
    public List<Question> Questions { get; set; } = new();
}