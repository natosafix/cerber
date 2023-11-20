using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Web.Persistence.Configurations;

public class QuestionConfiguration : IEntityTypeConfiguration<Question>
{
    public void Configure(EntityTypeBuilder<Question> builder)
    {
        builder.ToTable("questions");

        builder.HasKey(e => e.Id);
        
        builder.Property(e => e.Type)
            .IsRequired();
        builder.Property(e => e.Content)
            .IsRequired();
        builder.Property(e => e.Required)
            .IsRequired();

        builder.HasOne(question => question.Event)
            .WithMany(@event => @event.Questions)
            .HasForeignKey(question => question.EventId)
            .OnDelete(DeleteBehavior.SetNull);
        
        builder.HasMany(question => question.Answers)
            .WithOne(answer => answer.Question)
            .OnDelete(DeleteBehavior.Cascade);
    }
}