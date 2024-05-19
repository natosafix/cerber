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


        public PaymentUrl GenerateAuthLink(
            decimal totalAmount,
            RobokassaReceiptRequest receipt,
            CustomShpParameters? customShpParameters = null)
        {
            var receiptEncodedJson = receipt?.ToString();

            var customFieldsLine = customShpParameters?.ToString();

            var amountStr = totalAmount.ToString("0.00", System.Globalization.CultureInfo.InvariantCulture);

            var signatureValue = Md5HashService.GenerateMd5Hash(PrepareMd5SumString(amountStr, receiptEncodedJson, customFieldsLine));

            return new PaymentUrl(BuildPaymentLink(amountStr, signatureValue, receiptEncodedJson,
                customShpParameters));
        }

        private string BuildPaymentLink(string amount, string signature, string receiptEncodedJson,
            CustomShpParameters? customShpParameters)
        {
            const string host = "https://auth.robokassa.ru/Merchant/Index.aspx?";

            var parameters = new Collection<string>();

            if (isTestEnv)
                parameters.Add("isTest=1");

            parameters.Add("MrchLogin=" + options.ShopName);
            parameters.Add("OutSum=" + amount);

            if (!string.IsNullOrEmpty(receiptEncodedJson))
                parameters.Add("Receipt=" + HttpUtility.UrlEncode(receiptEncodedJson));

            customShpParameters?
                .GetParameters
                .ForEach(parameter =>
                    parameters.Add($"{parameter.Key}={HttpUtility.UrlEncode(HttpUtility.UrlEncode(parameter.Value))}"));

            parameters.Add("SignatureValue=" + signature);
            parameters.Add("Culture=ru");

            var url = host + string.Join("&", parameters);
            return url;
        }

        private string PrepareMd5SumString(string amount, string receiptEncodedJson,
            string customParameters)
        {
            var str = string.Join(":", new List<string>
            {
                options.ShopName,
                amount,
                receiptEncodedJson,
                options.Password1,
                customParameters
            }.Where(x => x != null));

            return str;
        }
    }
}