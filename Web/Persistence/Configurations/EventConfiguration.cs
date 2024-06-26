﻿using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Web.Persistence.Configurations;

public class EventConfiguration : IEntityTypeConfiguration<Event>
{
    public void Configure(EntityTypeBuilder<Event> builder)
    {
        builder.ToTable("events");

        builder.HasKey(e => e.Id);

        builder.Property(e => e.Name).IsRequired();
        builder.Property(e => e.ShortDescription).HasMaxLength(50);
        builder.Property(e => e.Description);
        builder.Property(e => e.City).IsRequired();
        builder.Property(e => e.Address).IsRequired();
        builder.Property(e => e.From).IsRequired();
        builder.Property(e => e.To).IsRequired();
        builder.Property(e => e.CryptoKey).IsRequired();

        builder.HasMany(@event => @event.Questions)
            .WithOne(question => question.Event)
            .OnDelete(DeleteBehavior.Cascade);

        // builder.HasOne(@event => @event.Category)
        //     .WithMany(category => category.Events)
        //     .HasForeignKey(@event => @event.CategoryId)
        //     .OnDelete(DeleteBehavior.SetNull);
        // builder.Navigation(e => e.Category).AutoInclude();

        builder.HasOne(@event => @event.Owner)
            .WithMany(user => user.OwnedEvents)
            .HasForeignKey(@event => @event.OwnerId)
            .OnDelete(DeleteBehavior.SetNull);

        builder.HasMany(@event => @event.Tickets)
            .WithOne(ticket => ticket.Event)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasMany(@event => @event.Inspectors)
            .WithMany(user => user.InspectedEvents);
        
        builder.HasOne(@event => @event.Cover)
            .WithMany()
            .HasForeignKey(@event => @event.CoverId)
            .OnDelete(DeleteBehavior.SetNull);
        builder.Navigation(e => e.Cover).AutoInclude();
    }
}