﻿using Domain.Entities;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Web.Persistence.Configurations;

namespace Web.Persistence;

public sealed class CerberDbContext : IdentityDbContext<User>
{
    public DbSet<DraftEvent> DraftEvents { get; set; } = null!;
    public DbSet<DraftQuestion> DraftQuestions { get; set; } = null!;
    public DbSet<DraftTicket> DraftTickets { get; set; } = null!;
    public DbSet<Event> Events { get; set; } = null!;
    public DbSet<Answer> Answers { get; set; } = null!;
    public DbSet<Category> Categories { get; set; } = null!;
    public DbSet<Order> Orders { get; set; } = null!;
    public DbSet<Question> Questions { get; set; } = null!;
    public DbSet<Ticket> Tickets { get; set; } = null!;
    public DbSet<UserFile> UserFiles { get; set; } = null!;

    public CerberDbContext(DbContextOptions<CerberDbContext> options) : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfiguration(new DraftEventConfiguration());
        modelBuilder.ApplyConfiguration(new DraftQuestionConfiguration());
        modelBuilder.ApplyConfiguration(new DraftTicketConfiguration());
        modelBuilder.ApplyConfiguration(new EventConfiguration());
        modelBuilder.ApplyConfiguration(new AnswerConfiguration());
        modelBuilder.ApplyConfiguration(new CategoryConfiguration());
        modelBuilder.ApplyConfiguration(new OrderConfiguration());
        modelBuilder.ApplyConfiguration(new QuestionConfiguration());
        modelBuilder.ApplyConfiguration(new TicketConfiguration());
        modelBuilder.ApplyConfiguration(new UserConfiguration());
        modelBuilder.ApplyConfiguration(new UserFileConfiguration());
        base.OnModelCreating(modelBuilder);
    }
}