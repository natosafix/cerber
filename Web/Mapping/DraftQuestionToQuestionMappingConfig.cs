﻿using AutoMapper;
using Domain.Entities;

namespace Web.Mapping;

public static class DraftQuestionToQuestionMappingConfig
{
    public static void Configure(this IMappingExpression<DraftQuestion, Question> mapping)
    {
        mapping
            .ForMember(d => d.Required,
                opt => opt.MapFrom(_ => true));
    }
}