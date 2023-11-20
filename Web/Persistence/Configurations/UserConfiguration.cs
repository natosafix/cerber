using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Web.Persistence.Configurations;

public class UserConfiguration : IEntityTypeConfiguration<User>
{
    public void Configure(EntityTypeBuilder<User> builder)
    {
        builder.HasOne(user => user.Event)
            .WithMany(@event => @event.Inspectors)
            .HasForeignKey(user => user.EventId)
            .OnDelete(DeleteBehavior.SetNull);

        builder.HasMany(user => user.OwnedEvents)
            .WithOne(@event => @event.Owner);
    }
}