using Microsoft.Extensions.DependencyInjection;

namespace Robokassa
{
    public static class RobokassaServicesExtension
    {
        public static IServiceCollection AddRobokassa(this IServiceCollection services, string shopName,
            string password1, string password2, bool isTestEnv)
        {
            services.AddTransient<IRobokassaService>(x =>
                new RobokassaService(new RobokassaOptions(shopName, password1, password2), isTestEnv));

            services.AddTransient<IRobokassaPaymentValidator>(x => new RobokassaCallbackValidator(password2));
            return services;
        }
    }
}