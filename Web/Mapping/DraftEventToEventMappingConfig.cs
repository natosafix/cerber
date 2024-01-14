using AutoMapper;
using Domain.Entities;

namespace Web.Mapping;

public static class DraftEventToEventMappingConfig
{
    public static void Configure(this IMappingExpression<DraftEvent, Event> mapping)
    {
        mapping
            .ForMember(e => e.CoverId,
                opt => opt.MapFrom(de => de.CoverImageId))
            .ForMember(e => e.Name,
                opt => opt.MapFrom(de => de.Title))
            .ForMember(e => e.To,
                opt => opt.MapFrom(dr => dr.From)); // TODO добавить на фронт
    }
}