using Robokassa.Models;

namespace Robokassa
{
    public interface IRobokassaService
    {
        PaymentUrl GenerateAuthLink(decimal totalAmount, RobokassaReceiptRequest receipt = null, CustomShpParameters shpParameters = null);
    }
}