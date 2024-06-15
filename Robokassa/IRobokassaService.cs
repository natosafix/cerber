using Robokassa.Models;

namespace Robokassa
{
    public interface IRobokassaService
    {
        PaymentUrl GenerateAuthLink(
            decimal totalAmount, 
            string description,
            RobokassaReceiptRequest receipt = null, 
            CustomShpParameters shpParameters = null);
    }
}