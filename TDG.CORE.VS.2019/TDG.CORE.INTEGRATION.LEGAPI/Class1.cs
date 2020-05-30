namespace TDG.CORE.INTEGRATION.LEGAPI
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using System.Reflection;
    using System.Text;
    using RestSharp;

    public static class Program
    {
        public static void Main()
        {
            Uri baseUrl = new Uri("https://legsregsdev01.azurewebsites.net/api/Acts/T-19.01/eng");
            IRestClient client = new RestClient(baseUrl);
            IRestRequest request = new RestRequest("get", Method.GET) { 
                //Credentials = new NetworkCredential("testUser", "P455w0rd") 
            };

            //request.AddHeader("Authorization", "Bearer qaPmk9Vw8o7r7UOiX-3b-8Z_6r3w0Iu2pecwJ3x7CngjPp2fN3c61Q_5VU3y0rc-vPpkTKuaOI2eRs3bMyA5ucKKzY1thMFoM0wjnReEYeMGyq3JfZ-OIko1if3NmIj79ZSpNotLL2734ts2jGBjw8-uUgKet7jQAaq-qf5aIDwzUo0bnGosEj_UkFxiJKXPPlF2L4iNJSlBqRYrhw08RK1SzB4tf18Airb80WVy1Kewx2NGq5zCC-SCzvJW-mlOtjIDBAQ5intqaRkwRaSyjJ_MagxJF_CLc4BNUYC3hC2ejQDoTE6HYMWMcg0mbyWghMFpOw3gqyfAGjr6LPJcIly__aJ5__iyt-BTkOnMpDAZLTjzx4qDHMPWeND-TlzKWXjVb5yMv5Q6Jg6UmETWbuxyTdvGTJFzanUg1HWzPr7gSs6GLEv9VDTMiC8a5sNcGyLcHBIJo8mErrZrIssHvbT8ZUPWtyJaujKvdgazqsrad9CO3iRsZWQJ3lpvdQwucCsyjoRVoj_mXYhz3JK3wfOjLff16Gy1NLbj4gmOhBBRb8rJnUXnP7rBHs00FAk59BIpKLIPIyMgYBApDCut8V55AgXtGs4MgFFiJKbuaKxq8cdMYEVBTzDJ-S1IR5d6eiTGusD5aFlUkAs9NV_nFw");
            //request.AddParameter("clientId", 123);

            IRestResponse<RootObject> response = client.Execute<RootObject>(request);

            if (response.IsSuccessful)
            {
                response.Data.Write();
            }
            else
            {
                Console.WriteLine(response.ErrorMessage);
            }

            Console.WriteLine();

            string path = Assembly.GetExecutingAssembly().Location;
            string name = Path.GetFileName(path);

            request = new RestRequest("post", Method.POST);
            request.AddFile(name, File.ReadAllBytes(path), name, "application/octet-stream");
            response = client.Execute<RootObject>(request);
            if (response.IsSuccessful)
            {
                response.Data.Write();
            }
            else
            {
                Console.WriteLine(response.ErrorMessage);
            }


            //curl -X GET "https://legsregsdev01.azurewebsites.net/api/Acts/T-19.01/eng" -H "accept: text/plain"
            /*
             * {
                  "regs": [
                    {
                      "actUniqueId": "T-19.01",
                      "actLang": "eng",
                      "regId": "672172E",
                      "reg": null
                    }
                  ],
                  "uniqueId": "T-19.01",
                  "officialNum": "1992, c. 34",
                  "title": "Transportation of Dangerous Goods Act, 1992",
                  "lang": "eng",
                  "currentToDate": "2020-02-26"
                }             
             */


            //curl -X GET "https://legsregsdev01.azurewebsites.net/api/RegDetails/672172E" -H "accept: text/plain"
            /*
             * "Body": {
                "@lims:inforce-start-date": "2020-02-19",
                "@lims:fid": "1227365",
                "@lims:id": "1227365",
                "Heading": [
                    {
                    "@lims:inforce-start-date": "2020-02-19",
                    "@lims:fid": "1227366",
                    "@lims:id": "1227366",
                    "@level": "1",
                    "Label": "PART 1",
                    "TitleText": "Coming into Force, Repeal, Interpretation, General Provisions and Special Cases"
                    }            
             */






            Console.ReadLine();
        }


    }
}