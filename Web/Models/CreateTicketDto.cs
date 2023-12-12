using System.ComponentModel.DataAnnotations;

namespace Web.Models;

public class CreateTicketDto
{
    [Required]
    public string Price { get; set; }

    [Required]
    public string EventId { get; set; }
}