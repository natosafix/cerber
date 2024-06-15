using AutoMapper;
using Domain.Entities;
using Web.Dtos.Request;

namespace Web.Mapping;

public static class TicketsMappingConfig
{
    public static void Configure(this IMappingExpression<CreateTicketDto, DraftTicket> mapping)
    {
        mapping
            .ForMember(
                dst => dst.Id,
                opt => opt.Ignore());
    }
}