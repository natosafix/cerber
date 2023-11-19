﻿using Domain.Enums;

namespace Domain.Entities;

public class Question
{
    public int Id { get; set; }
    
    public QuestionType Type { get; set; }
    
    public Quiz Quiz { get; set; }
    public int QuizId { get; set; }
    
    public string Content { get; set; }
    
    public bool Required { get; set; }

    public List<Answer> Answers { get; set; } = new();
}