namespace Domain.Entities;

public class Order
{
    public Guid Customer { get; set; }

    public bool Paid { get; set; }
        
    public List<Answer> Answers { get; set; }
    
    public int TicketId { get; set; }
    public Ticket Ticket { get; set; }
    
    public string? InspectorName { get; set; }
}