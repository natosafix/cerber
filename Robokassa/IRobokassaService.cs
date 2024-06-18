using Robokassa.Models;

namespace Robokassa
{
    public interface IRobokassaService
    {
        string GeneratePaymentLink(
            decimal totalAmount, 
            string description,
            CustomShpParameters? shpParameters = null);
    }
}