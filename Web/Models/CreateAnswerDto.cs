namespace Web.Models;

public class CreateAnswerDto
{
    public string Content { get; set; }

    public int QuestionId { get; set; }

    public int OrderId { get; set; }
}