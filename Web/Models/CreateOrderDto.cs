using System.ComponentModel.DataAnnotations;

namespace Web.Models;

public class CreateOrderDto
{
    [Required]
    public string TicketId;
}