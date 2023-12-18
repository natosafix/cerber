using AutoMapper;
using Domain.Entities;
using Web.Dtos.Request;
using Web.Dtos.Response;

namespace Web.Mapping;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<CreateEventDto, Event>();
        CreateMap<CreateTicketDto, Ticket>();
        CreateMap<CreateOrderDto, Order>();
        CreateMap<CreateAnswerDto, Answer>();
        CreateMap<CreateQuestionDto, Question>();
        
        CreateMap<Event, EventResponseDto>();
        CreateMap<Ticket, TicketResponseDto>();
        CreateMap<Question, QuestionResponseDto>();
        CreateMap<Order, OrderResponseDto>();
        CreateMap<Answer, AnswerResponseDto>();
    }
}