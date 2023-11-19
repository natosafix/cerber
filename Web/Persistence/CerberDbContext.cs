using Domain.Entities;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Web.Persistence.Configurations;

namespace Web.Persistence;

public sealed class CerberDbContext : IdentityDbContext<User>
{
    public DbSet<Event> Events { get; set; } = null!;

    public CerberDbContext(DbContextOptions<CerberDbContext> options) : base(options)
    {
        Database.EnsureCreated();
    }
    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfiguration(new EventConfiguration());
        base.OnModelCreating(modelBuilder);
    }
}