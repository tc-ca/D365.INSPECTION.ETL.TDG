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
        static readonly Uri baseUrl = new Uri("https://legsregsdev01.azurewebsites.net/api/");
        private static readonly HttpClient httpClient = new HttpClient();

        public static string GetActFromJustice()
        {
            var result = GetResponseText("https://laws-lois.justice.gc.ca/eng/XML/T-19.01.xml");

            return result?.Result;
        }

        public static async Task<string> GetResponseText(string address)
        {
            return await httpClient.GetStringAsync(address);
        }

        public static string GetRegulationFromJustice()
        {
            var result = GetResponseText("https://laws-lois.justice.gc.ca/eng/XML/SOR-2001-286.xml");

            return result?.Result;
        }


        //raw result needs fixing before we can use this
        public static string GetAct(string actId, string threeLetterLangId) //tdg = Acts/T-19.01/eng
        {
            IRestClient client = new RestClient(baseUrl);
            IRestRequest request = new RestRequest($"ActDetails/{actId}/{threeLetterLangId}", Method.GET);
            request.AddHeader("Accept", "text/plain");
            IRestResponse response = client.Execute(request);

            if (response.IsSuccessful)
            {
                //var actDetails = MODELS.ActDetails.FromJson(response.Content);
                //return actDetails.FullDetails.Statute.Body;
                var jsonString = response.Content;
                var actDetails = JsonConvert.DeserializeXmlNode(jsonString, "ActDetails");

                return actDetails.ToString();
            }
            else
            {
                throw new WebException(response.ErrorMessage);
            }
        }

        public static string GetRegulation(string regulationId) // tdg = /RegDetails/672172E
        {
            IRestClient client = new RestClient(baseUrl);
            IRestRequest request = new RestRequest($"RegDetails/{regulationId}", Method.GET, DataFormat.Xml);

            request.AddHeader("Accept", "text/plain");
            IRestResponse response = client.Execute(request);

            if (response.IsSuccessful)
            {
                var jsonString = response.Content;
                var regDetails = JsonConvert.DeserializeXmlNode(jsonString, "fullDetails");//"RegDetails");

                return regDetails.ToString();
            }
            else
            {
                throw new WebException(response.ErrorMessage);
            }
        }
    }
}