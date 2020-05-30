namespace TDG.CORE.ETL.EXTENSIONS
{
    public static class BoolExtensions
    {
        public static bool ToBool(this string text)
        {
            bool itConverted = int.TryParse(text, out int result);
            return itConverted == false ? false : result == 1 ? true : false;
        }
    }
}
