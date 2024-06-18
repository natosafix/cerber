using Microsoft.AspNetCore.Authorization;
using RabbitMQListener;
using RabbitMqListener.Listeners;
using RabbitMqListener.Listeners.TicketSender;
using Web.Persistence.Repositories;
using Web.Requirements;
using Web.Services;
using Web.Services.Implementations;
using Web.Services.Validators;

namespace Web.Extensions;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddExternals(this IServiceCollection services)
    {
        services.AddSingleton<IRabbitMqConnectionsPool, RabbitMqConnectionsPool>();
        services.AddScoped<BaseRabbitMqProducer<TicketDestinationMessage>>(
            di => new TicketSenderListenerFactory(di.GetService<IRabbitMqConnectionsPool>()!, di.GetService<IConfiguration>()!).CreateProducer());
        // services.AddScoped<BaseRabbitMqProducer<TicketDestinationMessage>>(
        //     di => new StabRabbitMqProducer<TicketDestinationMessage>(di.GetService<IRabbitMqConnectionsPool>()!, ""));
        return services;
    }

    public static IServiceCollection AddRepositories(this IServiceCollection services)
    {
        services.AddScoped<IDraftEventsRepository, DraftEventsRepository>();
        services.AddScoped<IDraftQuestionRepository, DraftQuestionRepository>();
        services.AddScoped<IDraftTicketsRepository, DraftTicketsRepository>();
        services.AddScoped<IDraftEventPublisherService, DraftEventPublisherService>();
        services.AddScoped<IEventsRepository, EventsRepository>();
        services.AddScoped<IUsersRepository, UsersRepository>();
        services.AddScoped<ITicketsRepository, TicketsRepository>();
        services.AddScoped<IOrdersRepository, OrdersRepository>();
        services.AddScoped<IQuestionsRepository, QuestionsRepository>();
        services.AddScoped<IAnswersRepository, AnswersRepository>();
        services.AddScoped<IUserFilesRepository, UserFilesRepository>();
        return services;
    }

    public static IServiceCollection AddServices(this IServiceCollection services)
    {
        services.AddScoped<IUserHelper, UserHelper>();
        services.AddScoped<IDraftEventsService, DraftEventsService>();
        services.AddScoped<IDraftQuestionsService, DraftQuestionsService>();
        services.AddScoped<IDraftEventValidator, DraftEventValidator>();
        services.AddScoped<IDraftTicketsService, DraftTicketsService>();
        services.AddScoped<IEventsPublisherRepository, EventsPublisherRepository>();
        services.AddScoped<IEventsService, EventsService>();
        services.AddScoped<ITicketsService, TicketsService>();
        services.AddScoped<IOrdersService, OrdersService>();
        services.AddScoped<IQuestionsService, QuestionsService>();
        services.AddScoped<IAnswersService, AnswersService>();
        services.AddScoped<IUserFilesService, UserFilesService>();
        services.AddSingleton<IStorageManager, CloudStorageManager>();
        services.AddScoped<IMailService, MailService>();
        services.AddScoped<IQrCodeService, QrCodeService>();
        services.AddScoped<IEncryptionService, EncryptionService>();
        services.AddScoped<IAuthService, AuthService>();
        services.AddScoped<IUsersService, UsersService>();

        return services;
    }

    public static IServiceCollection AddRequirements(this IServiceCollection services)
    {
        services.AddScoped<IAuthorizationHandler, MustOwnEventHandler>();
        services.AddScoped<IAuthorizationHandler, MustInspectEventHandler>();
        services.AddScoped<IAuthorizationHandler, MustInspectOrderHandler>();

        return services;
    }
}