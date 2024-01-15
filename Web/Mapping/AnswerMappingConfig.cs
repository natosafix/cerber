using AutoMapper;
using Domain.Entities;
using Newtonsoft.Json;
using Web.Dtos.Request;
using Web.Dtos.Response;

namespace Web.Mapping;

public static class AnswerMappingConfig
{
    public static void Configure(this IMappingExpression<CreateAnswerDto, Answer> mapping)
    {
        mapping
            .ForMember(dst => dst.Content,
                opt => opt.MapFrom(src => 
                    JsonConvert.SerializeObject(src.Content)));
    }
    
    public static void Configure(this IMappingExpression<Answer, AnswerResponseDto> mapping)
    {
        mapping.ForMember(
            dst => dst.Content,
            opt => opt.MapFrom(src =>
                JsonConvert.DeserializeObject<string[]>(src.Content)));
    }
}