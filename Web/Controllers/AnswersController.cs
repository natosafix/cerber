using AutoMapper;
using Domain.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Web.Dtos.Request;
using Web.Dtos.Response;
using Web.Services;

namespace Web.Controllers;

[Authorize]
[Route("[controller]")]
public class AnswersController : Controller
{
    private readonly IMapper mapper;
    private readonly IAnswersService answersService;
    
    public AnswersController(IMapper mapper, IAnswersService answersService)
    {
        this.mapper = mapper;
        this.answersService = answersService;
    }

    [HttpPost("")]
    public async Task<IActionResult> Create([FromBody] CreateAnswerDto createAnswerDto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);

        var answer = mapper.Map<Answer>(createAnswerDto);
        var createdAnswer = await answersService.Create(answer);
        var answerResponse = mapper.Map<AnswerResponseDto>(createdAnswer);
        
        return Ok(answerResponse);
    }
}