﻿using Microsoft.AspNetCore.Authorization;
using Web.Persistence.Repositories;
using Web.Requirements;
using Web.Services;
using Web.Services.Implementations;
using Web.Services.Validators;

namespace Web.Extensions;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddRepositories(this IServiceCollection services)
    {
        services.AddScoped<IDraftEventsRepository, DraftEventsRepository>();
        services.AddScoped<IDraftQuestionRepository, DraftQuestionRepository>();
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
        services.AddScoped<IEventsPublisherRepository, EventsPublisherRepository>();
        services.AddScoped<IEventsService, EventsService>();
        services.AddScoped<ITicketsService, TicketsService>();
        services.AddScoped<IOrdersService, OrdersService>();
        services.AddScoped<IQuestionsService, QuestionsService>();
        services.AddScoped<IAnswersService, AnswersService>();
        services.AddScoped<IUserFilesService, UserFilesService>();
        services.AddScoped<IStorageManager, StorageManager>();
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