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

        builder.Property(e => e.OwnerId).IsRequired();

        builder.Property(e => e.CoverImageId).HasDefaultValue(null);
        builder.Property(e => e.Title).HasDefaultValue(null);
        builder.Property(e => e.Description).HasDefaultValue(null);
        builder.Property(e => e.City).HasDefaultValue(null);
        builder.Property(e => e.Address).HasDefaultValue(null);
        builder.Property(e => e.From).HasDefaultValue(null);
        builder.Property(e => e.To).HasDefaultValue(null);
    }
}