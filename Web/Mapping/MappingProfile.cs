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
        CreateMap<CreateTicketDto, Ticket>();
        CreateMap<CreateOrderDto, Order>();
        CreateMap<CreateAnswerDto, Answer>();
        CreateMap<CreateQuestionDto, Question>();
        CreateMap<DraftQuestionDto, DraftQuestion>().Configure();
        CreateMap<DraftEventCoverDto, DraftEvent>();

        // Entity to Dto
        CreateMap<Event, EventResponseDto>();
        CreateMap<Ticket, TicketResponseDto>();
        CreateMap<Question, QuestionResponseDto>();
        CreateMap<Order, OrderResponseDto>();
        CreateMap<Answer, AnswerResponseDto>();
        CreateMap<DraftQuestion, DraftQuestionDto>().Configure();
        CreateMap<DraftEvent, DraftEventCoverDto>();
        
        // Draft to Clean
        CreateMap<DraftEvent, Event>().Configure();
        CreateMap<DraftQuestion, Question>().Configure();
    }
}