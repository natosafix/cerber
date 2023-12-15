﻿using Domain.Entities;
using Web.Models;
using Web.Persistence.Repositories;

namespace Web.Services;

public class EventsService : IEventsService
{
    private readonly IUsersRepository usersRepository;
    private readonly IEventsRepository eventsRepository;

    public EventsService(IUsersRepository usersRepository, IEventsRepository eventsRepository)
    {
        this.usersRepository = usersRepository;
        this.eventsRepository = eventsRepository;
    }

    public async Task<Event> Create(Event @event)
    {
        return await eventsRepository.Create(@event);
    }
    
    public async Task AddInspector(int id, Guid inspectorId)
    {
        var inspector = await usersRepository.Get(inspectorId);
        await eventsRepository.AddInspector(id, inspector);
    }

    public async Task<PageList<Event>> GetInspected(string username, int offset, int limit)
    {
        return await eventsRepository.GetInspected(username, offset, limit);
    }
}