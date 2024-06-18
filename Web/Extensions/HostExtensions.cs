using Microsoft.EntityFrameworkCore;
using Web.Persistence;

namespace Web.Extensions;

public static class HostExtensions
{
    public static void PrepareData(this IHost host)
    {
        using var scope = host.Services.CreateScope();

        try
        {
            scope.ServiceProvider.GetRequiredService<CerberDbContext>().Database.Migrate();
        }
        catch (Exception e)
        {
            var logger = scope.ServiceProvider.GetRequiredService<ILogger<Program>>();
            logger.LogError(e, "An error occurred while migrating or seeding the database.");
        }
    }
}