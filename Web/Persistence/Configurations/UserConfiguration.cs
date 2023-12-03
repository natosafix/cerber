using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Web.Persistence.Configurations;

public class UserConfiguration : IEntityTypeConfiguration<User>
{
    public void Configure(EntityTypeBuilder<User> builder)
    {
        builder.HasMany(user => user.InspectedEvents)
            .WithMany(@event => @event.Inspectors);

        builder.HasMany(user => user.OwnedEvents)
            .WithOne(@event => @event.Owner);
    }
}