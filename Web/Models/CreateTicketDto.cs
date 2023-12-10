using System.ComponentModel.DataAnnotations;

namespace Web.Models;

public class CreateTicketDto
{
    [Required]
    public string Price;

    [Required]
    public string EventId;
}