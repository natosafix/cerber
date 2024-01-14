using AutoMapper;
using Domain.Entities;
using Newtonsoft.Json;
using Web.Dtos.Response;

namespace Web.Mapping;

public static class QuestionToQuestionResponseDtoMappingConfig
{
    public static void Configure(this IMappingExpression<Question, QuestionResponseDto> mapping)
    {
        mapping.ForMember(
            dst => dst.AnswerChoices,
            opt => opt.MapFrom(src =>
                string.IsNullOrEmpty(src.AnswerChoices)
                    ? Array.Empty<string>()
                    : JsonConvert.DeserializeObject<string[]>(src.AnswerChoices)));
    }
}