using DinkToPdf;
using DinkToPdf.Contracts;
using RabbitMqListener.Listeners.TicketSender.TicketViewModel;
using RazorEngine;
using RazorEngine.Templating;

namespace RabbitMqListener.Listeners.TicketSender.TicketViewGenerator;

public class WkHtmlToPdfTicketGenerator : ITicketViewGenerator<HtmlTicketViewModel>
{
    public static WkHtmlToPdfTicketGenerator WithDefaultSettings(string ticketTemplate) => new(
        ticketTemplate,
        new GlobalSettings
        {
            ColorMode = ColorMode.Color,
            Orientation = Orientation.Portrait,
            PaperSize = new PechkinPaperSize("480px", "160px"),
            Margins = new MarginSettings {Top = 0, Bottom = 0, Left = 0, Right = 0},
            DocumentTitle = "Your ticket"
        });

    private readonly string ticketTemplate;
    private readonly GlobalSettings settings;
    private readonly IConverter converter = new SynchronizedConverter(new PdfTools());

    //  Нужно для хэширования, чтобы Razor не компилил файл несколько раз
    private const string TicketTemplateKey = "ticketTemplate";

    public WkHtmlToPdfTicketGenerator(string ticketTemplate, GlobalSettings settings)
    {
        this.ticketTemplate = ticketTemplate;
        this.settings = settings;
    }

    public byte[] Generate(HtmlTicketViewModel ticketViewModel)
    {
        var html = Engine.Razor.RunCompile(
            ticketTemplate,
            TicketTemplateKey,
            typeof(HtmlTicketViewModel),
            ticketViewModel);

        var pdf = ConvertHtmlToPdf(html, ticketViewModel.StylesPath);

        // TODO delete
        // File.WriteAllText("Result.html", html);
        // File.WriteAllBytes("Result.pdf", pdf);

        return pdf;
    }

    private byte[] ConvertHtmlToPdf(string html, string pathToStyles)
    {
        var objectSettings = new ObjectSettings
        {
            PagesCount = true,
            ProduceForms = true,
            HtmlContent = html,
            WebSettings = {DefaultEncoding = "utf-8", UserStyleSheet = pathToStyles, LoadImages = true},
            LoadSettings = {BlockLocalFileAccess = false, StopSlowScript = false},
        };

        var pdf = new HtmlToPdfDocument
        {
            GlobalSettings = settings,
            Objects = {objectSettings}
        };

        return converter.Convert(pdf);
    }
}