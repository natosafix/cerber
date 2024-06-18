using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Web.Persistence.Configurations;

public class DraftTicketConfiguration : IEntityTypeConfiguration<DraftTicket>
{
    public void Configure(EntityTypeBuilder<DraftTicket> builder)
    {
        builder.ToTable("draftTickets");
        
        builder.HasKey(e => e.Id);
        
        builder.Property(e => e.DraftEventId).IsRequired();
        builder.Property(e => e.Name).IsRequired();
        builder.Property(e => e.CoverImageId).IsRequired();
        builder.Property(e => e.Price).IsRequired();
        builder.Property(e => e.QrCodeX).IsRequired();
        builder.Property(e => e.QrCodeY).IsRequired();
        builder.Property(e => e.QrCodeSize).IsRequired();
    }
}