namespace Web.Extensions;

public static class HttpContextExtensions
{
    public static int? GetEventId(this HttpContext? httpContext)
    {
        var eventId = httpContext?.Request.Query.ContainsKey("eventId") == true
            ? httpContext.Request.Query["eventId"].ToString()
            : httpContext?.GetRouteData().Values["id"]?.ToString();
        
        if (eventId is not null)
            return int.Parse(eventId);

        return null;
    }
}