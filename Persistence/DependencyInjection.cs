using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;

namespace Persistence;

public static class DependencyInjection
{
    public static IServiceCollection AddPersistence(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddDbContext<CerberDbContext>(options =>
        {
            options.UseNpgsql(configuration.GetConnectionString("DbConnection"));
        });

        return services;
    }
}