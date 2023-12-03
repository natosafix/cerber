using Microsoft.AspNetCore.Identity;

namespace Domain.Entities;

public class User : IdentityUser
{
    public List<Event> OwnedEvents { get; set; }

    public List<Event> InspectedEvents { get; set; }
}