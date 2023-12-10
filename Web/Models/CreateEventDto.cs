using System.ComponentModel.DataAnnotations;

namespace Web.Models;

public class CreateEventDto
{
    [Required]
    public string Name;

    [Required]
    public string ShortDescription;

    public string Description;

    [Required]
    public string City;

    [Required]
    public string Address;

    public DateTimeOffset From;
    
    public DateTimeOffset To;
    
    [Required]
    public string OwnerId;
    
    public string CategoryId;
}