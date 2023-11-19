using AutoMapper;
using Domain.Entities;
using Web.Models;

namespace Web.Mapping;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<CreateEventDto, Event>();
    }
}