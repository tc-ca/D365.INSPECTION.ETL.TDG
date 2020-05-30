namespace TDG.CORE.INTEGRATION.LEGAPI
{
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;

    public class RootObject
    {
        public Args args { get; set; }

        public Headers headers { get; set; }

        public string origin { get; set; }

        public string url { get; set; }

        public string data { get; set; }

        public Dictionary<string, string> files { get; set; }
    }

    public static class RootObjectExtensions
    {
        public static string Write(this RootObject rootObject)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("clientId:       " + rootObject.args.clientId).AppendLine();
            sb.Append("Accept:         " + rootObject.headers.Accept).AppendLine();
            sb.Append("AcceptEncoding: " + rootObject.headers.AcceptEncoding).AppendLine();
            sb.Append("AcceptLanguage: " + rootObject.headers.AcceptLanguage).AppendLine();
            sb.Append("Authorization:  " + rootObject.headers.Authorization).AppendLine();
            sb.Append("Connection:     " + rootObject.headers.Connection).AppendLine();
            sb.Append("Dnt:            " + rootObject.headers.Dnt).AppendLine();
            sb.Append("Host:           " + rootObject.headers.Host).AppendLine();
            sb.Append("Origin:         " + rootObject.headers.Origin).AppendLine();
            sb.Append("Referer:        " + rootObject.headers.Referer).AppendLine();
            sb.Append("UserAgent:      " + rootObject.headers.UserAgent).AppendLine();
            sb.Append("origin:         " + rootObject.origin).AppendLine();
            sb.Append("url:            " + rootObject.url).AppendLine();
            sb.Append("data:           " + rootObject.data).AppendLine();

            sb.Append("files: ").AppendLine();
            foreach (KeyValuePair<string, string> kvp in rootObject.files ?? Enumerable.Empty<KeyValuePair<string, string>>())
            {
                sb.Append("\t" + kvp.Key + ": " + kvp.Value).AppendLine().AppendLine();
            }

            return sb.ToString();
        }
    }
}