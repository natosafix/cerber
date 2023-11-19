using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Web.Persistence.Configurations;

public class EventConfiguration : IEntityTypeConfiguration<Event>
{
    public void Configure(EntityTypeBuilder<Event> builder)
    {
        builder.ToTable("events");

        builder.HasKey(e => e.Id);
        
        builder.Property(e => e.Name)
            .IsRequired();
        builder.Property(e => e.ShortDescription)
            .HasMaxLength(50)
            .IsRequired();
        builder.Property(e => e.Description);
        builder.Property(e => e.City)
            .IsRequired();
        builder.Property(e => e.Address)
            .IsRequired();
        builder.Property(e => e.From);
        builder.Property(e => e.To);
    }
}