using Microsoft.EntityFrameworkCore;

namespace Persistence;

public class CerberDbContext : DbContext
{
    public CerberDbContext(DbContextOptions<CerberDbContext> options) : base(options) { }
    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
    }
}