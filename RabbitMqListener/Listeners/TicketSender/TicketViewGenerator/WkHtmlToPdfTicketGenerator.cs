using System;
using RabbitMqListener.Listeners.TicketSender.TicketViewModel;
using RazorEngine;
using RazorEngine.Templating;
using WkHtmlToPdfDotNet;
using WkHtmlToPdfDotNet.Contracts;

namespace RabbitMqListener.Listeners.TicketSender.TicketViewGenerator;

public class WkHtmlToPdfTicketGenerator : ITicketViewGenerator<HtmlTicketViewModel>
{
    public static WkHtmlToPdfTicketGenerator WithDefaultSettings(string ticketTemplate) => new(
        ticketTemplate,
        new GlobalSettings
        {
            ColorMode = ColorMode.Color,
            Orientation = Orientation.Portrait,
            PaperSize = PaperKind.A4,
            Margins = new MarginSettings {Top = 10, Bottom = 10, Left = 10, Right = 10},
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

        return ConvertHtmlToPdf(html, ticketViewModel.StylesPath);
    }

    private byte[] ConvertHtmlToPdf(string html, string pathToStyles)
    {
        var objectSettings = new ObjectSettings
        {
            PagesCount = true,
            HtmlContent = html,
            WebSettings = {DefaultEncoding = "utf-8", UserStyleSheet = pathToStyles, LoadImages = true},
            LoadSettings = {BlockLocalFileAccess = false},
        };

        var pdf = new HtmlToPdfDocument
        {
            GlobalSettings = settings,
            Objects = {objectSettings}
        };

        return converter.Convert(pdf);
    }
}