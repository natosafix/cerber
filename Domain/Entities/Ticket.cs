namespace Domain.Entities;

public class Ticket
{
    public int Id { get; set; }
    
    public int Price { get; set; }
    
    public Event Event { get; set; }
    public List<Order> Order { get; set; }
}