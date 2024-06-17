using System.IO;
using System.Threading.Tasks;
using RabbitMqListener.Listeners.TicketSender.TicketViewGenerator;
using RabbitMqListener.Listeners.TicketSender.TicketViewModel;
using RabbitMQListener.StaticFiles;

namespace RabbitMqListener.Listeners.TicketSender;

public class TicketSenderConsumer : BaseRabbitMqConsumer<TicketDestinationMessage>
{
    private static readonly ITicketViewGenerator<HtmlTicketViewModel> ticketViewGenerator =
        WkHtmlToPdfTicketGenerator.WithDefaultSettings(
            File.ReadAllText(Path.Combine(StaticFiles.BaseDirectory, "TicketTemplate.cshtml")));

    protected override Task Handle(TicketDestinationMessage message)
    {
        var stylesPath = new FileInfo(Path.Combine(StaticFiles.BaseDirectory, "TicketTemplate.cshtml.css"));
        var viewModel = HtmlTicketViewModel.CreateFromMessage(message, stylesPath.FullName);
        
        var pdf = ticketViewGenerator.Generate(viewModel);

        File.WriteAllBytes("Result.pdf", pdf);

        return Task.CompletedTask;
    }
}