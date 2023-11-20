using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Web.Persistence.Configurations;

public class AnswerConfiguration : IEntityTypeConfiguration<Answer>
{
    public void Configure(EntityTypeBuilder<Answer> builder)
    {
        builder.ToTable("answers");

        builder.HasKey(e => e.Id);
        
        builder.Property(e => e.Content)
            .IsRequired();
        
        builder.HasOne(answer => answer.Order)
            .WithMany(order => order.Answers)
            .HasForeignKey(answer => answer.OrderId)
            .OnDelete(DeleteBehavior.SetNull);
        
        builder.HasOne(answer => answer.Question)
            .WithMany(question => question.Answers)
            .HasForeignKey(answer => answer.QuestionId)
            .OnDelete(DeleteBehavior.SetNull);
    }
}