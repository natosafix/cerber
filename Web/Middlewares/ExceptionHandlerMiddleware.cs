using Newtonsoft.Json;

namespace Web.Middlewares;

public class ExceptionHandlerMiddleware
{
    private readonly RequestDelegate next;
    private readonly ILogger<ExceptionHandlerMiddleware> logger;

    public ExceptionHandlerMiddleware(RequestDelegate next, ILogger<ExceptionHandlerMiddleware> logger)
    {
        this.next = next;
        this.logger = logger;
    }

    public async Task Invoke(HttpContext context)
    {
        try
        {
            await next.Invoke(context);
        }
        catch (Exception ex)
        {
            await HandleExceptionMessageAsync(context, ex).ConfigureAwait(false);
        }
    }

    private Task HandleExceptionMessageAsync(HttpContext context, Exception exception)
    {
        logger.LogError(exception, "Unhandled exception occured");

        var statusCode = GetStatusCode(exception);
        var result = JsonConvert.SerializeObject(new
        {
            StatusCode = statusCode,
            ErrorMessage = exception.Message
        });
        context.Response.ContentType = "application/json";
        context.Response.StatusCode = statusCode;
        return context.Response.WriteAsync(result);
    }

    private static int GetStatusCode(Exception exception)
    {
        return exception is BadHttpRequestException ? 400 : 500;
    }
}