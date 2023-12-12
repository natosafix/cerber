﻿namespace Domain.Entities;

public class Answer
{
    public int Id { get; set; }
    public string Content { get; set; }
    
    public int QuestionId { get; set; }
    public Question Question { get; set; }
    
    public Guid OrderId { get; set; }
    public Order Order { get; set; }
}