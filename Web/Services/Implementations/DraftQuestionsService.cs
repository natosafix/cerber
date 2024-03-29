﻿using Domain.Entities;
using Domain.Enums;
using Web.Persistence.Repositories;

namespace Web.Services.Implementations;

public class DraftQuestionsService : IDraftQuestionsService
{
    private readonly IDraftQuestionRepository draftQuestionRepository;

    public DraftQuestionsService(IDraftQuestionRepository draftQuestionRepository)
    {
        this.draftQuestionRepository = draftQuestionRepository;
    }

    public async Task<IReadOnlyCollection<DraftQuestion>> GetDraftQuestionsByDraftEventIdAsync(int draftEventId)
    {
        return await draftQuestionRepository.GetDraftQuestionsByDraftEventIdAsync(draftEventId);
    }

    public async Task SetDraftQuestionsAsync(IReadOnlyCollection<DraftQuestion> draftQuestions, int dstDraftEventId)
    {
        foreach (var question in draftQuestions)
        {
            question.DraftEventId = dstDraftEventId;
            if (question.Type is QuestionType.SingleString or QuestionType.MultiString)
                question.AnswerChoices = null;
        }

        await draftQuestionRepository.SetDraftQuestionsAsync(draftQuestions);
    }
}