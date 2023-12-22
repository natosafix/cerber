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
    
    public static Guid? GetCustomer(this HttpContext? httpContext)
    {
        var orderId = httpContext?.Request.Query.ContainsKey("customer") == true
            ? httpContext.Request.Query["customer"].ToString()
            : httpContext?.GetRouteData().Values["customer"]?.ToString();
        
        if (orderId is not null)
            return Guid.Parse(orderId);

        return null;
    }
}