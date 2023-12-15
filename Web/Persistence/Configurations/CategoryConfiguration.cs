using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Web.Persistence.Configurations;

public class CategoryConfiguration : IEntityTypeConfiguration<Category>
{
    public void Configure(EntityTypeBuilder<Category> builder)
    {
        builder.ToTable("categories");

        builder.HasKey(e => e.Id);
        
        builder.Property(e => e.Name)
            .IsRequired();
        
        builder.HasMany(category => category.Events)
            .WithOne(@event => @event.Category)
            .OnDelete(DeleteBehavior.SetNull);
    }
}