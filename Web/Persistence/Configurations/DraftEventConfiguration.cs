using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Web.Persistence.Configurations;

public class DraftEventConfiguration : IEntityTypeConfiguration<DraftEvent>
{
    public void Configure(EntityTypeBuilder<DraftEvent> builder)
    {
        builder.ToTable("draftEvents");

        builder.HasKey(e => e.Id);

        builder.Property(e => e.Title);
        builder.Property(e => e.Description);
        builder.Property(e => e.City);
        builder.Property(e => e.Address);
        builder.Property(e => e.From);
        builder.Property(e => e.To);
    }
}