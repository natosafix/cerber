﻿namespace Domain.Entities;

public class Event
{
    public int Id { get; set; }
    
    public string Name { get; set; }

    public string? ShortDescription { get; set; }

    public string Description { get; set; }
    
    public Guid? CoverId { get; set; }
    public UserFile? Cover { get; set; }

    public string City { get; set; }

    public string Address { get; set; }

    public DateTimeOffset From { get; set; }
    
    public DateTimeOffset To { get; set; }
    
    public string OwnerId { get; set; }
    public User Owner { get; set; }
    
    public int? CategoryId { get; set; }
    public Category? Category { get; set; }
    
    public string CryptoKey { get; set; }
    
    public List<Ticket> Tickets { get; set; }
    
    public List<Question> Questions { get; set; }
    
    public List<User> Inspectors { get; set; }
}