using AutoMapper;
using Domain.Entities;
using Web.Dtos;
using Web.Dtos.Request;
using Web.Dtos.Response;

namespace Web.Mapping;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        // Dto to Entity
        CreateMap<CreateEventDto, Event>();
        CreateMap<CreateOrderDto, Order>();
        CreateMap<CreateAnswerDto, Answer>().Configure();
        CreateMap<CreateQuestionDto, Question>();
        CreateMap<DraftQuestionDto, DraftQuestion>().Configure();
        CreateMap<DraftEventCoverDto, DraftEvent>();
        CreateMap<CreateTicketDto, DraftTicket>().Configure();

        // Entity to Dto
        CreateMap<Event, EventResponseDto>();
        CreateMap<Ticket, TicketResponseDto>();
        CreateMap<Question, QuestionResponseDto>().Configure();
        CreateMap<Order, OrderResponseDto>();
        CreateMap<Answer, AnswerResponseDto>().Configure();
        CreateMap<DraftQuestion, DraftQuestionDto>().Configure();
        CreateMap<DraftEvent, DraftEventCoverDto>();
        
        // Draft to Clean
        CreateMap<DraftEvent, Event>().Configure();
        CreateMap<DraftQuestion, Question>().Configure();
        CreateMap<DraftTicket, Ticket>(); // TODO config
    }
}