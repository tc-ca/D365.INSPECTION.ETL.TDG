namespace TDG.CORE.INTEGRATION.LEGAPI
{
    using System;
    using System.Linq;
    using System.Net;
    using System.Net.Http;
    using System.Net.Http.Headers;
    using System.Threading.Tasks;
    using Newtonsoft.Json;
    using RestSharp;

    public static class LegApiClient
    {
        static readonly Uri baseUrl = new Uri("https://tclrr-tc-apicast-production.dev.api.canada.ca/");
        static readonly string APIKEY = "057485b3402989467770e7592313faa0";
        static readonly int timeoutInMs = 60000;


        private static readonly HttpClient httpClient = new HttpClient();

        public static string GetActFromJustice(string lang = "eng")
        {
            var result = GetResponseText($"https://laws-lois.justice.gc.ca/{lang}/XML/T-19.01.xml");

            return result?.Result;
        }

        public static async Task<string> GetResponseText(string address)
        {
            return await httpClient.GetStringAsync(address);
        }

        public static string GetRegulationFromJustice(string lang = "eng")
        {
            var result = GetResponseText($"https://laws-lois.justice.gc.ca/{lang}/XML/SOR-2001-286.xml");

            return result?.Result;
        }
        
        public static string GetAct(string actId, string threeLetterLangId) //tdg = Acts/T-19.01/eng
        {
            IRestClient client = MakeClient();
            IRestRequest request = MakeRequest($"actdetails/{actId}/{threeLetterLangId}", Method.GET);
            IRestResponse response = client.Execute(request);

            if (response.IsSuccessful)
            {
                var jsonString = response.Content;
                
                return jsonString;
            }
            else
            {
                throw new WebException(response.ErrorMessage);
            }
        }

        public static CORE.ETL.MODELS.LEGSANDREGS.LegsAndRegsActResult GetActSerialized(string actId, string threeLetterLangId) //tdg = Acts/T-19.01/eng
        {
            IRestClient client = MakeClient();
            IRestRequest request = MakeRequest($"actdetails/{actId}/{threeLetterLangId}", Method.GET);
            IRestResponse response = client.Execute(request);

            if (response.IsSuccessful)
            {
                var jsonString = response.Content;

                var serializedResult = TDG.CORE.ETL.MODELS.LEGSANDREGS.LegsAndRegsActResult.FromJson(jsonString);

                return serializedResult;
            }
            else
            {
                throw new WebException(response.ErrorMessage);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="requestTimeout">time in milliseconds for requests to timeout. Default 60 seconds.</param>
        /// <returns></returns>
        private static IRestClient MakeClient()
        {
            IRestClient client      = new RestClient(baseUrl);
            client.Timeout          = timeoutInMs;
            client.ReadWriteTimeout = timeoutInMs;
            client.Encoding         = System.Text.Encoding.UTF8;

            return client;
        }

        private static IRestRequest MakeRequest(string url, Method method, DataFormat format = DataFormat.Json)
        {
            IRestRequest request = new RestRequest(url, method, format);
            request.AddHeader("Accept", "*/*");
            request.AddHeader("Accept-Encoding", "gzip, deflate, br");
            request.AddHeader("Connection", "keep-alive");
            request.AddHeader("user_key", APIKEY);
            request.AddHeader("authorization", "Basic gt");
            request.Timeout = timeoutInMs;
            request.ReadWriteTimeout = timeoutInMs;

            ServicePointManager.Expect100Continue = false;
            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

            return request;
        }

        public static string GetRegulation(string regulationId) // tdg = /RegDetails/672172E
        {
            IRestClient client = MakeClient();
            IRestRequest request = MakeRequest($"regdetails/{regulationId}", Method.GET);
            IRestResponse response = client.Execute(request);

            if (response.IsSuccessful)
            {
                var jsonString = response.Content;

                return jsonString;
            }
            else
            {
                var serializedError = JsonConvert.SerializeObject(response);
                throw new WebException(serializedError);
            }
        }
    }
}