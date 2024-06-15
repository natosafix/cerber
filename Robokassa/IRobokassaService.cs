using Robokassa.Models;

namespace Robokassa
{
    public interface IRobokassaService
    {
        string GenerateAuthLink(
            decimal totalAmount, 
            string description,
            CustomShpParameters? shpParameters = null);
    }
}