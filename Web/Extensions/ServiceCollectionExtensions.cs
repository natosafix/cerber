using Web.Persistence.Repositories;
using Web.Services;

namespace Web.Extensions;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddRepositories(this IServiceCollection services)
    {
        services.AddScoped<IDraftEventsRepository, DraftEventsRepository>();
        services.AddScoped<IEventsRepository, EventsRepository>();
        services.AddScoped<IUsersRepository, UsersRepository>();
        services.AddScoped<ITicketsRepository, TicketsRepository>();
        services.AddScoped<IOrdersRepository, OrdersRepository>();
        services.AddScoped<IQuestionsRepository, QuestionsRepository>();
        services.AddScoped<IAnswersRepository, AnswersRepository>();
        return services;
    }
    
    public static IServiceCollection AddServices(this IServiceCollection services)
    {
        services.AddScoped<IUserHelper, UserHelper>();
        services.AddScoped<IDraftEventService, DraftEventService>();
        services.AddScoped<IEventsService, EventsService>();
        services.AddScoped<ITicketsService, TicketsService>();
        services.AddScoped<IOrdersService, OrdersService>();
        services.AddScoped<IQuestionsService, QuestionsService>();
        services.AddScoped<IAnswersService, AnswersService>();
        return services;
    }
}