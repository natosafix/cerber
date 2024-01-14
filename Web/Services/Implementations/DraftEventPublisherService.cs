using System.Security.Cryptography;
using Domain.Entities;
using Domain.Enums;
using Web.Persistence.Repositories;

namespace Web.Services.Implementations;

public class DraftEventPublisherService : IDraftEventPublisherService
{
    private readonly IEventsPublisherRepository eventsPublisherRepository;

    public DraftEventPublisherService(IEventsPublisherRepository eventsPublisherRepository)
    {
        this.eventsPublisherRepository = eventsPublisherRepository;
    }

    public async Task<int> Publish(
        DraftEvent srcDraftEvent,
        Event dstEvent,
        IReadOnlyCollection<Question> dstQuestions)
    {
        var defaultQuestions = new[]
        {
            new Question
            {
                AnswerChoices = null,
                Required = true,
                Title = "Имя",
                Type = QuestionType.SingleString
            },
            new Question
            {
                AnswerChoices = null,
                Required = true,
                Title = "Фамилия",
                Type = QuestionType.SingleString
            },
            new Question
            {
                AnswerChoices = null,
                Required = true,
                Title = "Email",
                Type = QuestionType.SingleString
            }
        };
        
        var bytes = new byte[16];
        RandomNumberGenerator.Create().GetBytes(bytes);
        dstEvent.CryptoKey = Convert.ToBase64String(bytes);

        return await eventsPublisherRepository.Publish(
            srcDraftEvent, dstEvent,
            defaultQuestions.Concat(dstQuestions).ToList());
    }
}