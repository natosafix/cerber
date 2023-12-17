using Domain.Enums;
using Newtonsoft.Json;

namespace Domain.Entities;

public class Question
{
    public int Id { get; set; }
    
    public QuestionType Type { get; set; }
    
    public string Content { get; set; }
    
    public bool Required { get; set; }
    
    public Event Event { get; set; }
    public int EventId { get; set; }
    
    [JsonIgnore]
    public List<Answer> Answers { get; set; } = new();
}