namespace Web.Models;

public class CreateAnswerDto
{
    public string Content { get; set; }

    public string QuestionId { get; set; }

    public string OrderId { get; set; }
}