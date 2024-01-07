using AutoMapper;
using Domain.Entities;
using Newtonsoft.Json;
using Web.Dtos;

namespace Web.Mapping;

public static class DraftQuestionMappingConfig
{
    public static void Configure(this IMappingExpression<DraftQuestionDto, DraftQuestion> mapping)
    {
        mapping.ForMember(
            dst => dst.AnswerChoices,
            opt => opt.MapFrom(src => JsonConvert.SerializeObject(src.AnswerChoices)));
    }

    public static void Configure(this IMappingExpression<DraftQuestion, DraftQuestionDto> mapping)
    {
        mapping.ForMember(
            dst => dst.AnswerChoices,
            opt => opt.MapFrom(src =>
                string.IsNullOrEmpty(src.AnswerChoices)
                    ? Array.Empty<string>()
                    : JsonConvert.DeserializeObject<string[]>(src.AnswerChoices)));
    }
}