using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Web.Persistence.Configurations;

public class UserFileConfiguration : IEntityTypeConfiguration<UserFile>
{
    public void Configure(EntityTypeBuilder<UserFile> builder)
    {
        builder.ToTable("userFiles");

        builder.HasKey(uf => uf.Id);

        builder.Property(uf => uf.Name)
            .IsRequired();
        
        builder.Property(uf => uf.Path)
            .IsRequired();
        
        builder.HasOne(userFile => userFile.Event)
            .WithOne(@event => @event.Cover)
            .HasForeignKey<Event>(@event => @event.CoverId)
            .OnDelete(DeleteBehavior.SetNull);
    }
}