namespace Domain.Entities;

public class DraftTicket
{
    public int Id { get; set; }
    public int DraftEventId { get; set; }
    public int CoverImageId { get; set; }
    public string Name { get; set; }
    public int Price { get; set; }
}