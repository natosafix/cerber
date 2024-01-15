namespace Web.Dtos.Response;

public class OrderResponseDto
{
    public Guid Customer { get; set; }
    
    public bool Paid { get; set; }
    
    public List<AnswerResponseDto> Answers { get; set; }
    
    public TicketResponseDto Ticket { get; set; }
}