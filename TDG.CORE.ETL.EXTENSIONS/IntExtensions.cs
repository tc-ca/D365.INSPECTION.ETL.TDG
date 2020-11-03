namespace TDG.CORE.ETL.EXTENSIONS
{
    public static class IntExtensions
    {
        public static int ToInt(this string text)
        {
            bool itConverted = int.TryParse(text, out int result);
            return itConverted == false ? 0 : result;
        }
        public static int? ToNullableInt(this string text)
        {
            if (string.IsNullOrEmpty((text ?? "").Trim())) return null;

            bool itConverted = int.TryParse(text, out int result);
            return itConverted == false ? 0 : result;
        }
    }
}
