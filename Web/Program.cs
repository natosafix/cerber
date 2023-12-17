using Web.Extensions;

namespace Web;

public class Program
{
    public static void Main(string[] args)
    {
        using var factory = LoggerFactory.Create(builder => builder.AddConsole());
        var logger = factory.CreateLogger("Program");
        try
        {
            var hostBuilder = CreateHostBuilder(args);
            var host = hostBuilder.Build();
            host.PrepareData();
            host.Run();
        }
        catch (Exception ex)
        {
            logger.LogCritical(ex, "Host start failed");
        }
    }

    private static IHostBuilder CreateHostBuilder(string[] args) =>
        Host.CreateDefaultBuilder(args)
            .ConfigureWebHostDefaults(webHostBuilder => webHostBuilder.UseStartup<Startup>());
}