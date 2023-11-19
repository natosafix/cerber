namespace Domain.Entities;

public class Order
{
    public int Id { get; set; }
    
    public Guid Customer { get; set; }

    public int AnswerId { get; set; }
    public Answer Answer { get; set; }
    
    public int TicketId { get; set; }
    public Ticket Ticket { get; set; }
}