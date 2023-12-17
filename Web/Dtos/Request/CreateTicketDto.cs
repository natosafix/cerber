using System.ComponentModel.DataAnnotations;

namespace Web.Dtos.Request;

public class CreateTicketDto
{
    [Required]
    public string Price { get; set; }

    [Required]
    public string EventId { get; set; }
}