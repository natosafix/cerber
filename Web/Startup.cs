﻿using System.Net;
using System.Text;
using Domain.Entities;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using Robokassa.NET;
using Web.Extensions;
using Web.Mapping;
using Web.Middlewares;
using Web.Persistence;
using Web.Requirements;

namespace Web;

public class Startup
{
    private readonly IConfiguration config;

    public Startup(IConfiguration config)
    {
        this.config = config;
    }

    public void ConfigureServices(IServiceCollection services)
    {
        services.AddPersistence(config);
        services.AddRepositories();
        services.AddServices();
        services.AddRequirements();

        services.AddIdentity<User, IdentityRole>(options => options.SignIn.RequireConfirmedAccount = false)
            .AddEntityFrameworkStores<CerberDbContext>()
            .AddDefaultTokenProviders();

        services.AddAutoMapper(typeof(MappingProfile));

        services.AddAuthorization(options =>
        {
            options.DefaultPolicy = new AuthorizationPolicyBuilder(JwtBearerDefaults.AuthenticationScheme)
                .RequireAuthenticatedUser()
                .Build();
            options.AddPolicy(
                "MustOwnEvent",
                policyBuilder =>
                {
                    policyBuilder.RequireAuthenticatedUser();
                    policyBuilder.AddRequirements(new MustOwnEventRequirement());
                });
            options.AddPolicy(
                "MustInspectEvent",
                policyBuilder =>
                {
                    policyBuilder.RequireAuthenticatedUser();
                    policyBuilder.AddRequirements(new MustInspectEventRequirement());
                });
            options.AddPolicy(
                "MustInspectOrder",
                policyBuilder =>
                {
                    policyBuilder.RequireAuthenticatedUser();
                    policyBuilder.AddRequirements(new MustInspectOrderRequirement());
                });
        });

        services.AddAuthentication()
            .AddJwtBearer(options =>
            {
                options.RequireHttpsMetadata = false;
                options.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidIssuer = config["JWT:ValidIssuer"],
                    ValidateAudience = true,
                    ValidAudience = config["JWT:ValidAudience"],
                    ValidateLifetime = true,
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(config["JWT:Secret"]!)),
                    ValidateIssuerSigningKey = true
                };
                options.Events = new JwtBearerEvents
                {
                    OnMessageReceived = c =>
                    {
                        c.Token = c.Request.Cookies[config["JWT:CookieName"]!];
                        return Task.CompletedTask;
                    }
                };
            });

        services.AddControllersWithViews()
            .AddNewtonsoftJson(options =>
            {
                options.SerializerSettings.ContractResolver = new CamelCasePropertyNamesContractResolver();
                options.SerializerSettings.DefaultValueHandling = DefaultValueHandling.Populate;
                options.SerializerSettings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
            });
        services.AddSwaggerGen();
    }

    public void Configure(IApplicationBuilder app, IWebHostEnvironment environment)
    {
        app.UseStatusCodePages(async context =>
        {
            var request = context.HttpContext.Request;
            var response = context.HttpContext.Response;

            if (response.HttpContext.Request.Path.Value is "/Auth/login" or "/Auth/register")
                return;
            
            if (response.StatusCode == (int) HttpStatusCode.Unauthorized)
                response.Redirect("/home/login");
            var firstDigit = response.StatusCode / 100;
            if (firstDigit is 4 or 5)
                response.Redirect($"/error?statusCode={response.StatusCode}");
        });

        if (environment.IsDevelopment())
            app.UseDeveloperExceptionPage();
        else
            app.UseMiddleware<ExceptionHandlerMiddleware>();

        app.UseStaticFiles();
        app.UseRouting();

        app.UseAuthentication();
        app.UseAuthorization();

        app.UseEndpoints(endpoints =>
        {
            endpoints.MapControllers();
            endpoints.MapSwagger();
        });

        app.UseSwagger();
        app.UseSwaggerUI();
    }
}