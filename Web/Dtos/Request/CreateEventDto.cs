using System.ComponentModel.DataAnnotations;

namespace Web.Dtos.Request;

public class CreateEventDto : IValidatableObject
{
    [Required]
    public string Name { get; set; }

    [Required]
    public string ShortDescription { get; set; }

    public string Description { get; set; }

    [Required]
    public string City { get; set; }

    [Required]
    public string Address { get; set; }

    public DateTimeOffset From { get; set; }
    
    public DateTimeOffset To { get; set; }
    
    [Required]
    public string OwnerId { get; set; }
    
    [Required]
    public string CategoryId { get; set; }
    
    [Required]
    public string CoverId { get; set; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (From >= To)
            yield return new ValidationResult("to before from", new List<string> {"from", "to"});
    }
}