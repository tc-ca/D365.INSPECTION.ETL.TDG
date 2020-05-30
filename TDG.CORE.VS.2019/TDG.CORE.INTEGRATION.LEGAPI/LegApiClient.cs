namespace TDG.CORE.INTEGRATION.LEGAPI
{
    using System;
    using System.Net;
    using System.Net.Http;
    using System.Net.Http.Headers;
    using System.Threading.Tasks;
    using Newtonsoft.Json;
    using RestSharp;

    public static class LegApiClient
    {
        static string _uriString = "https://legsregsdev01.azurewebsites.net/api/Acts/{actId}/{threeLetterLangId}";

        public static string GetAct(string actId, string threeLetterLangId) //tdg T-19.01, eng
        {
            Uri baseUrl = new Uri(string.Format(_uriString, actId, threeLetterLangId));
            IRestClient client = new RestClient(baseUrl);
            IRestRequest request = new RestRequest("get", Method.GET);
            IRestResponse<RootObject> response = client.Execute<RootObject>(request);
            
            if (response.IsSuccessful)
            {
                return response.Data.Write();
            }
            else
            {
                throw new WebException(response.ErrorMessage);
            }
        }

        static async Task RunAsync(string regulationId)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri("https://legsregsdev01.azurewebsites.net");
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                // HTTP GET
                HttpResponseMessage response = await client.GetAsync($"api/RegDetails/{regulationId}");
                if (response.IsSuccessStatusCode)
                {
                    string regulation = await response.Content.ReadAsStringAsync();
                }

                // HTTP POST
                //var gizmo = new Product() { Name = "Gizmo", Price = 100, Category = "Widget" };
                //response = await client.PostAsJsonAsync("api/products", gizmo);
                //if (response.IsSuccessStatusCode)
                //{
                //    Uri gizmoUrl = response.Headers.Location;

                //    // HTTP PUT
                //    gizmo.Price = 80;   // Update price
                //    response = await client.PutAsJsonAsync(gizmoUrl, gizmo);

                //    // HTTP DELETE
                //    response = await client.DeleteAsync(gizmoUrl);
                //}
            }
        }

        public static string GetRegulation(string regulationId) // tdg = 672172E
        {
            



            Uri baseUrl = new Uri($"https://legsregsdev01.azurewebsites.net");
            IRestClient client = new RestClient(baseUrl);
            //client.AddDefaultHeader("Content-Type", "application/json");
            //client.AddDefaultHeader("Accept", "application/json");
            //client.BaseHost = "https://legsregsdev01.azurewebsites.net";

            //legsregsdev01.azurewebsites.net	/api/RegDetails/672172E

            IRestRequest request = new RestRequest("api/RegDetails/672172E", Method.GET,DataFormat.Json);
            //request.AddParameter("id", regulationId, ParameterType.QueryString);

            IRestResponse response = client.Execute(request);
                        
            if (response.IsSuccessful)
            {
                return response.Content<RootObject>().Write();
            }
            else
            {
                throw new WebException(response.ErrorMessage);
            }
        }

        public static TResult Content<TResult>(this IRestResponse response)
        {
            return JsonConvert.DeserializeObject<TResult>(response.Content);
        }
    }
}