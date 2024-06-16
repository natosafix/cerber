using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Web.Persistence.Configurations;

public class TicketConfiguration : IEntityTypeConfiguration<Ticket>
{
    public void Configure(EntityTypeBuilder<Ticket> builder)
    {
        builder.ToTable("tickets");

        builder.HasKey(e => e.Id);
        
        builder.Property(e => e.Name);
        
        builder.Property(e => e.Price)
            .IsRequired();

        builder.HasOne(ticket => ticket.Event)
            .WithMany(@event => @event.Tickets)
            .HasForeignKey(ticket => ticket.EventId)
            .OnDelete(DeleteBehavior.SetNull);

        builder.HasMany(ticket => ticket.Orders)
            .WithOne(order => order.Ticket)
            .OnDelete(DeleteBehavior.SetNull);
        
        builder.HasOne(ticket => ticket.Cover)
            .WithMany()
            .HasForeignKey(@event => @event.CoverId)
            .OnDelete(DeleteBehavior.SetNull);
        builder.Navigation(e => e.Cover).AutoInclude();
    }
}