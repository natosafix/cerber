namespace Robokassa.Models
{
    public class PaymentUrl
    {
        public string Link { get; }

        public PaymentUrl(string link)
        {
            Link = link;
        }
    }
}