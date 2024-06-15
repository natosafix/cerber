using System.ComponentModel.DataAnnotations;

namespace Web.Dtos.Request;

public class CreateTicketDto : IValidatableObject
{
    [Required]
    [MaxLength(100)]
    public string Name { get; set; }

    [Required]
    public int Price { get; set; }
    
    [Required]
    public IFormFile CoverImage { get; set; }

    public int? ImageId { get; set; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (Price < 0)
            yield return new ValidationResult("Can't be negative", new[] {nameof(Price)});
    }
}