using AutoMapper;
using Domain.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Web.Dtos.Request;
using Web.Services;

namespace Web.Controllers;

[Authorize]
[Route("[controller]")]
public class QuestionsController : Controller
{
    private readonly IMapper mapper;
    private readonly IQuestionsService questionsService;

    public QuestionsController(IMapper mapper, IQuestionsService questionsService)
    {
        this.mapper = mapper;
        this.questionsService = questionsService;
    }

    [HttpPost("")]
    [Produces("application/json")]
    public async Task<IActionResult> Create([FromBody] CreateQuestionDto createQuestionDto)
    {
        return Ok(await questionsService.Create(mapper.Map<Question>(createQuestionDto)));
    }
}