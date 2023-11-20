using Microsoft.AspNetCore.Identity;

namespace Domain.Entities;

public class User : IdentityUser
{
    public List<Event> OwnedEvents { get; set; }

    public int EventId { get; set; }
    public Event Event { get; set; }
}