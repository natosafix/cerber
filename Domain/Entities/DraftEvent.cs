namespace Domain.Entities;

public class DraftEvent
{
    public int Id { get; set; }

    public string OwnerId { get; set; }

    public Guid? CoverImageId { get; set; }

    public string? Title { get; set; }

    public string? Description { get; set; }

    public string? City { get; set; }

    public string? Address { get; set; }

    public DateTimeOffset? From { get; set; }

    public DateTimeOffset? To { get; set; }
}