using Domain.Entities;

namespace Web.Models;

public class EventResponseDto
{
    public int Id { get; set; }
    
    public string Name { get; set; }

    public string ShortDescription { get; set; }

    public string Description { get; set; }
    
    public string City { get; set; }

    public string Address { get; set; }

    public DateTimeOffset From { get; set; }
    
    public DateTimeOffset To { get; set; }
    
    public Category Category { get; set; }
    
    public UserFile Cover { get; set; }
}