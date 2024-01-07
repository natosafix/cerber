using System.ComponentModel.DataAnnotations;
using Domain.Enums;
using Web.Extensions;

namespace Web.Dtos;

public class DraftQuestionDto : IValidatableObject
{
    [Required] public string Title { get; set; }
    [Required] public QuestionType Type { get; set; }
    public string[] AnswerChoices { get; set; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (Type is QuestionType.OneSelection or QuestionType.MultipleSelection)
        {
            if (AnswerChoices.IsNullOrEmpty())
                yield return new ValidationResult("Value can't be null or empty with this type",
                    new[] {nameof(AnswerChoices)});
            else if (AnswerChoices.Any(string.IsNullOrWhiteSpace))
                yield return new ValidationResult("Answer choice can't be null or white space",
                    new[] {nameof(AnswerChoices)});
        }
    }
}