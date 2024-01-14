using System.ComponentModel.DataAnnotations;

namespace Web.Dtos;

public class DraftEventCoverDto : IValidatableObject
{
    public int? CoverImageId { get; set; }

    [Required] public string? Title { get; set; }

    [Required] public string? Description { get; set; }

    [Required] public string? Address { get; set; }

    [Required] public string? City { get; set; }

    [Required] public DateTimeOffset? From { get; set; }

    public DateTimeOffset? To { get; set; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (From < DateTime.Now)
            yield return new ValidationResult($"Event start should be in future", new[] {nameof(From)});
    }
}