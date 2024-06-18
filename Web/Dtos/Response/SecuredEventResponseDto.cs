namespace Web.Dtos.Response;

public class SecuredEventResponseDto : EventResponseDto
{
    public string CryptoKey { get; set; }
}