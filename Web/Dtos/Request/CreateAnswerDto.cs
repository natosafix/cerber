using System.ComponentModel.DataAnnotations;

namespace Web.Dtos.Request;

public class CreateAnswerDto
{
    [Required]
    public string Content { get; set; }

    [Required]
    public string QuestionId { get; set; }
}