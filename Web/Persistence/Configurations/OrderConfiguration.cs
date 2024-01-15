using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Web.Persistence.Configurations;

public class OrderConfiguration : IEntityTypeConfiguration<Order>
{
    public void Configure(EntityTypeBuilder<Order> builder)
    {
        builder.ToTable("orders");

        builder.HasKey(e => e.Customer);

        builder.Property(e => e.Paid)
            .HasDefaultValue(false);
        
        builder.HasMany(order => order.Answers)
            .WithOne(answer => answer.Order)
            .OnDelete(DeleteBehavior.SetNull);
        
        builder.HasOne(order => order.Ticket)
            .WithMany(ticket => ticket.Orders)
            .HasForeignKey(order => order.TicketId)
            .OnDelete(DeleteBehavior.SetNull);
    }
}