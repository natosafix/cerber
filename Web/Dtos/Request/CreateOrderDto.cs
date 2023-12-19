using System.ComponentModel.DataAnnotations;

namespace Web.Dtos.Request;

public class CreateOrderDto
{
    [Required]
    public string TicketId { get; set; }

    [Required]
    public List<CreateAnswerDto> Answers { get; set; }
}