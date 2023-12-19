namespace Domain.Entities;

public class Ticket
{
    public int Id { get; set; }

    public string Name { get; set; }
    
    public int Price { get; set; }
    
    public int EventId { get; set; }
    public Event Event { get; set; }

    public List<Order> Orders { get; set; }
}