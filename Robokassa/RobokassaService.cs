using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Web;
using Robokassa.Models;

namespace Robokassa
{
    public class RobokassaService : IRobokassaService
    {
        private readonly RobokassaOptions options;
        private readonly bool isTestEnv;

        public RobokassaService(RobokassaOptions options, bool isTestEnv)
        {
            this.isTestEnv = isTestEnv;
            this.options = options;
        }
        
        public string GenerateAuthLink(
            decimal totalAmount,
            string description,
            CustomShpParameters? customShpParameters = null)
        {
            var customFieldsLine = customShpParameters?.ToString();

            var amountStr = totalAmount.ToString("0.00", System.Globalization.CultureInfo.InvariantCulture);

            var signatureValue = Md5HashService.GenerateMd5Hash(PrepareMd5SumString(amountStr, customFieldsLine));

            return BuildPaymentLink(amountStr, description, signatureValue, customShpParameters);
        }

        private string BuildPaymentLink(string amount, string description, string signature,
            CustomShpParameters? customShpParameters)
        {
            const string host = "https://auth.robokassa.ru/Merchant/Index.aspx?";

            var parameters = new Collection<string>();

            if (isTestEnv)
                parameters.Add("isTest=1");

            parameters.Add("MrchLogin=" + options.ShopName);
            parameters.Add("OutSum=" + amount);
            parameters.Add("InvId=");
            parameters.Add("Description=" + description);

            customShpParameters?
                .GetParameters
                .ForEach(parameter =>
                    parameters.Add($"{parameter.Key}={HttpUtility.UrlEncode(parameter.Value)}"));

            parameters.Add("SignatureValue=" + signature);
            parameters.Add("Culture=ru");

            var url = host + string.Join("&", parameters);
            return url;
        }

        private string PrepareMd5SumString(string amount, string customParameters)
        {
            var str = string.Join(":", new List<string>
            {
                options.ShopName,
                amount,
                "",
                options.Password1,
                customParameters
            }.Where(x => x != null));

            return str;
        }
    }
}