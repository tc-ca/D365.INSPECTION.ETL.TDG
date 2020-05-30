using System;
using System.Globalization;

namespace TDG.CORE.ETL.EXTENSIONS
{
    public static class DateExtensions
    {
        public static DateTime? ToDateTime(this string s, string format = "yyyy-MM-dd HH:mm:ss", string cultureString = "en-CA")
        {
            try
            {

                if (String.IsNullOrEmpty((s ?? "").Trim()))
                    return null;

                s = s.Replace(" AM", "").Replace(" PM", "").Replace("PM", "").Replace("PM", "");

                var r = DateTime.ParseExact(
                    s: s, format: format, provider: CultureInfo.GetCultureInfo(cultureString));
                return r;
            }
            catch (FormatException)
            {
                throw;
            }
            catch (CultureNotFoundException)
            {
                throw; // Given Culture is not supported culture
            }
        }

        public static DateTime? ToDateTime(this string s, string format, CultureInfo culture)
        {
            try
            {
                if (String.IsNullOrEmpty((s ?? "").Trim()))
                    return null;

                var r = DateTime.ParseExact(s: s, format: format, provider: culture);
                return r;
            }
            catch (FormatException)
            {
                throw;
            }
            catch (CultureNotFoundException)
            {
                throw; // Given Culture is not supported culture
            }

        }
    }
}
