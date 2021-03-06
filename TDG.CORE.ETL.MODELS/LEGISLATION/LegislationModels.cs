using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using TDG.CORE.ETL.CONSTANTS;

namespace TDG.CORE.ETL.MODELS.LEGISLATION
{
    public class BaseLegislationModel
    {
        public string Name { get; set; }
        public string Id { get; set; }
    }

    public class LegislationType : BaseLegislationModel
    {
        public string LegislationTypeEnglish { get; set; }
        public string LegislationTypeFrench { get; set; }
    }

    public class LegislationCharacteristic
    {
        public string LegislationId { get; set; }
        public string Characteristic { get; set; }
    }

    public class CharacteristicCategory
    {
        public string Category { get; set; }
        public string[] Characteristics { get; set; }
    }

    public class Regulation
    {
        public Regulation()
        {
            Children  = new List<Regulation>();
            DataFlags = new List<KeyValuePair<string, object>>();
            UnNumbers = new List<string>();
            Classes   = new List<string>();
        }

        public string Type { get; set; }
        public string TextEnglish { get; set; }
        public string TextFrench
        {
            //TODO: This has to be read in from the french justice file
            get
            {
                var eng = string.IsNullOrEmpty(TextEnglish) ? "" : TextEnglish;
                return $"FR_{eng}";
            }
        }

        public string UniqueId { get; set; }
        public int Order { get; set; }
        public string Label { get; set; }
        public string JusticeId { get; set; }
        public string JusticeFId { get; set; }
        public string InforceStartDate { get; set; }
        public string PitDate { get; set; }
        public string LastAmendedDate { get; set; }
        public string CurrentDate { get; set; }
        public string GazettePart { get; set; }
        public string RegulationType { get; set; }
        public string AdditionalMetadata { get; set; }
        public List<Regulation> Children { get; set; }
        public string HistoricalNote { get; set; }
        public string Lang { get; set; }
        public List<KeyValuePair<string, object>> DataFlags { get; set; }
        public Guid CrmId { get; set; }
        public Guid? ParentCrmId { get; set; }
        public List<string> UnNumbers { get; set; }
        public List<string> Classes { get; set; }

        public object GetDataFlag(string flag)
        {
            var dataFlag = DataFlags?.FirstOrDefault(e => e.Key == flag);
            return (DataFlags != null && 
                    dataFlag.HasValue && 
                    DataFlags.Count > 0) ? dataFlag.Value.Value ?? false : false;
        }
    }

    public static class LegislationExtensions
    {
        public static void PopulateDataFlags(this Regulation reg)
        {
            if (reg.Children != null && reg.Children.Where(e => Constants.RegTypes.Contains(e.Type) || e.Type == "Body").Count() > 0)
            {
                ParseDataFlags(reg);

                foreach (var child in reg.Children)
                {
                    PopulateDataFlags(child);
                }
            }
            else
            {
                ParseDataFlags(reg);
            }

            reg.DataFlags = reg.DataFlags.Distinct().ToList();
        }

        private static void ParseDataFlags(this Regulation reg)
        {
            if (!string.IsNullOrEmpty(reg?.TextEnglish))
            {
                //TODO French
                var text = reg.TextEnglish;

                //must be utf-8
                byte[] bytes = Encoding.Default.GetBytes(text);
                text = Encoding.UTF8.GetString(bytes);

                text = Regex.Replace(text, "[^ -~]", ""); //strip non ascii char
                text = text.ToUpper();


                foreach (var flag in Constants.DataFlags_Keywords)
                {
                    if (Regex.IsMatch(text, WildCardToRegular($"*{flag}*")))
                    {
                        reg.DataFlags.Add(new KeyValuePair<string, object>(flag, true));
                    }

                    //UN NUMBERS
                    if (Regex.IsMatch(text, @"^.*UN\d{4}.*$"))
                    {
                        var matches = Regex.Matches(text, @"UN\d{4}");
                        var matchesArray = new List<string>();

                        foreach (Match match in matches)
                        {
                            matchesArray.Add(match.Value); // match csv values outside commas
                            reg.UnNumbers.Add(match.Value);
                        }

                        var matchesCsv = string.Join(",", matchesArray);

                        reg.DataFlags.Add(new KeyValuePair<string, object>(Constants.DataFlags_HasUNNumber, true));
                        reg.DataFlags.Add(new KeyValuePair<string, object>(Constants.DataFlags_UNNumbers, matchesCsv));
                    }

                    //CLASS
                    if (Regex.IsMatch(text, @"^.*CLASS\s*\d\.*\d*.*$"))
                    {
                        var matches = Regex.Matches(text, @"CLASS\s*\d\.*\d*");
                        var matchesArray = new List<string>();

                        foreach (Match match in matches)
                        {
                            char[] charsToTrim = { ',', '.', ' ' };
                            var trimmed = match.Value.TrimEnd(charsToTrim).TrimStart(charsToTrim);

                            matchesArray.Add(trimmed); // match csv values outside commas
                            reg.Classes.Add(trimmed);
                        }

                        var matchesCsv = string.Join(",", matchesArray);

                        reg.DataFlags.Add(new KeyValuePair<string, object>(Constants.DataFlags_HasClasses, true));
                        reg.DataFlags.Add(new KeyValuePair<string, object>(Constants.DataFlags_Classes, matchesCsv));
                    }
                }
            }
        }

        // If you want to implement both "*" and "?"
        private static string WildCardToRegular(string value)
        {
            return "^" + Regex.Escape(value).Replace("\\?", ".").Replace("\\*", ".*") + "$";
        }
    }
}