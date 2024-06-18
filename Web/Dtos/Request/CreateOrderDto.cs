using System.ComponentModel.DataAnnotations;

namespace Web.Dtos.Request;

public class CreateOrderDto
{
    [Required]
    public int TicketId { get; set; }

    [Required]
    public List<CreateAnswerDto> Answers { get; set; }
}