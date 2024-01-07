using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Web.Persistence.Configurations;

public class DraftQuestionConfiguration : IEntityTypeConfiguration<DraftQuestion>
{
    public void Configure(EntityTypeBuilder<DraftQuestion> builder)
    {
        builder.ToTable("draftQuestions");

        builder.HasKey(e => e.Id);

        builder.Property(e => e.Type).IsRequired();
        builder.Property(e => e.Title).IsRequired();
        builder.Property(e => e.DraftEventId).IsRequired();
        builder.Property(e => e.AnswerChoices);
    }
}