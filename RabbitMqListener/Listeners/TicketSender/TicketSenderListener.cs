using System.IO;
using System.Threading.Tasks;
using RabbitMQListener.Config;
using RabbitMQListener.StaticFiles;
using RazorEngine;
using RazorEngine.Templating;

namespace RabbitMqListener.Listeners.TicketSender;

public class TicketSenderListener : BaseRabbitMqListener<TicketDestinationMessage>
{
    private static readonly string ticketTemplate = File.ReadAllText(Path.Combine(StaticFiles.BaseDirectory, "TicketTemplate.cshtml"));
    private const string TicketTemplateKey = "ticketTemplate"; // Нужно для хэширования, чтобы Razor не компилил файл несколько раз

    protected override async Task Handle(TicketDestinationMessage message)
    {
        var stylesPath = new FileInfo(Path.Combine(StaticFiles.BaseDirectory, "TicketTemplate.cshtml.css"));
        var model = new TicketTemplateModel("User name", stylesPath.FullName);

        var html = Engine.Razor.RunCompile(ticketTemplate, TicketTemplateKey, typeof(TicketTemplateModel), model);

        await File.WriteAllTextAsync("Result.html", html);
    }

    public override RabbitMqQueueConfig RabbitMqQueueConfig => RabbitMqQueueConfig.CreateDefault("Tickets.Sender");
}