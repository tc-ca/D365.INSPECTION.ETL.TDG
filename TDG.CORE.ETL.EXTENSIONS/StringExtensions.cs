using System;
using System.Linq;

namespace TDG.CORE.ETL.EXTENSIONS
{
    public static class StringExtensions
    {
        public static string ToInputName(this string text)
        {
            var result = "";
            try
            {
                text = new string(text.Where(char.IsLetter).ToArray()).Replace(" ", "_");
                //result = text.Substring(0, 16);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return result;
        }
        public static string ToIsProblemOrIsSafety(this string text)
        {
            return text == "0" ? "No" : text == "1" ? "Yes" : text == "2" ? "Near" : "No";
        }
        public static string ToResponseRequirement(this string text)
        {
            return text == "0" ? "Optional" : text == "1" ? "Required" : text == "2" ? "Not Applicable" : "Not Applicable";
        }

        public static string GetUntilOrEmpty(this string text, string stopAt = "-")
        {
            if (!String.IsNullOrWhiteSpace(text))
            {
                int charLocation = text.IndexOf(stopAt, StringComparison.Ordinal);

                if (charLocation > 0)
                {
                    return text.Substring(0, charLocation);
                }
            }

            return String.Empty;
        }

        public static string Increment(this string str)
        {
            if (!str.Contains("_"))
            {
                str += "_2";
                return str;
            }

            var number = int.Parse(str.Substring(str.LastIndexOf('_') + 1));

            var stringBefore = GetUntilOrEmpty(str, "_");

            return $"{stringBefore}_{++number}";
        }
    }
}
