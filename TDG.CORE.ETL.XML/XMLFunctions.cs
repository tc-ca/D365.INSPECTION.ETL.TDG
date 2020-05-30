using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Linq; 
using System.Reflection;
using System.Text;
using System.Xml.Linq;
using TDG.CORE.ETL.MODELS.LEGISLATION;

namespace TDG.CORE.ETL.XML
{
    public static class XMLFunctions
    {
        static readonly XNamespace jNs = CONSTANTS.Constants.jNs;

        public static List<Regulation> PopulateDataFlags(List<Regulation> unmodifiedRegulations)
        {
            if (unmodifiedRegulations != null && unmodifiedRegulations.Count > 0)
                unmodifiedRegulations.ForEach(e => e.PopulateDataFlags());

            return unmodifiedRegulations;
        }

        public static void SerializeRegulationsToFile(Regulation regs, string filename = "TDG-REGS")
        {
            var whereAmI = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);

            var json = JsonConvert.SerializeObject(regs, Formatting.Indented);

            var now = DateTime.Now.ToString("yyyy-MM-dd");

            File.WriteAllText(Path.Combine(whereAmI, $"{filename}-{now}.json"), json);
        }

        public static Regulation ParseRegs(string elementName = "Body",  string rootNodeId = "1227365") // rootNodeId = lims:id="[rootNodeId]"
        {
            tempRegId = 1;

            var source = XDocument.Parse(RESOURCES.Properties.Resources.SOR_2001_286);

            string findNode = $"{elementName}[@id='{rootNodeId}']";
            var rootNode = source.Root
                          .Elements(elementName)
                          .Single(e => e.Attribute(jNs + "id")?.Value == rootNodeId);

            Regulation rootValue = ReadRegulation(rootNode);

            RecurseHelper(rootNode, rootValue);

            return rootValue;
        }

        public static Regulation RecurseHelper(XElement currentElement, Regulation parent = null)
        {
            if (currentElement == null) return null;
            
            Queue<XElement> queue = new Queue<XElement>(currentElement.Elements().Where(e => CONSTANTS.Constants.RegTypes.Contains(e.Name.LocalName)));

            XElement childElement = null;
            Regulation childValue = null;

            Debug.WriteLine($"{Environment.NewLine}Recurse({currentElement.Name.LocalName}, {parent?.Label}){Environment.NewLine}");

            while (queue.Count > 0)
            {
                childElement=queue.Dequeue();
                childValue=ReadRegulation(childElement);

                //concat parent label to children
                if (parent != null)
                {
                    childValue.Label = string.Concat($"{parent.Label} {childValue.Label}"); 
                }

                if (childElement.Elements().Any(e => CONSTANTS.Constants.RegTypes.Contains(e.Name.LocalName)))
                {
                    RecurseHelper(childElement, childValue);
                    Debug.WriteLine(childValue.Type.PadRight(20) + childValue.Label.PadRight(20) + "is child of ".PadRight(20) +
                                    parent.Type.PadRight(20) + parent.Label.PadRight(20));
                    parent.Children.Add(childValue);
                }
                else
                {
                    Debug.WriteLine(childValue.Type.PadRight(20) + childValue.Label.PadRight(20) + "is child of ".PadRight(20) +
                                    parent.Type.PadRight(20) + parent.Label.PadRight(20));
                    parent.Children.Add(childValue);
                }

            }

            return parent;
        }


        //lims:pit-date="2020-02-19" lims:lastAmendedDate="2020-02-19" lims:current-date="2020-03-05" lims:inforce-start-date="2020-02-19" lims:fid="1227358" lims:id="1227358" gazette-part="II" regulation-type="SOR" xml:lang="en"
        static int tempRegId = 1;
        public static Regulation ReadRegulation(XElement element, string parentLabels = null)
        {
            Regulation reg             = new Regulation();
            var label                  = element.ReadNodeByType("Label");
            reg.Order                  = tempRegId;
            reg.UniqueId               = $"Reg{tempRegId++}";
            reg.Type                   = element.Name.LocalName;
            reg.Label                  = ConcatValues(label, parentLabels);
            reg.HistoricalNote         = element.ReadHistoricalNote();
            reg.JusticeId              = element.Attribute(jNs + CONSTANTS.Constants.JusticeId)?.Value;
            reg.JusticeFId             = element.Attribute(jNs + CONSTANTS.Constants.JusticeFId)?.Value;
            reg.InforceStartDate       = element.Attribute(jNs + CONSTANTS.Constants.InforceStartDate)?.Value;
            reg.PitDate                = element.Attribute(jNs + CONSTANTS.Constants.PitDate)?.Value;
            reg.Lang                   = element.Attribute(jNs + CONSTANTS.Constants.Lang)?.Value;
            reg.LastAmendedDate        = element.Attribute(jNs + CONSTANTS.Constants.LastAmendedDate)?.Value;
            reg.CurrentDate            = element.Attribute(jNs + CONSTANTS.Constants.CurrentDate)?.Value;
            reg.GazettePart            = element.Attribute(jNs + CONSTANTS.Constants.GazettePart)?.Value;
            reg.RegulationType         = element.Attribute(jNs + CONSTANTS.Constants.RegulationType)?.Value;

            var text = "";
            if (element.Name.LocalName != "Body") text = element.ParseElementsAsString();


            //TODO: read the text into the english or french text property based on the lang of the xml file
            if (string.IsNullOrEmpty(text) || element.Name.LocalName == "Body")
            {
                reg.TextEnglish = "";
            }
            else
            {
                string[] split = text.Split('|');
                if (split.Length > 0)
                {
                    //first split will be the text, anything left will be concatonated together into the additinoal Metadata
                    reg.TextEnglish = split[0];
                    reg.AdditionalMetadata = new string(string.Concat<string>(split.Skip(1).Select(e => ConcatValues(" ", e))).ToArray());
                }
                else
                {
                    reg.TextEnglish = text;
                }
            }

            return reg;
        }

        public static string ConcatValues(string elementLabel, string parentLabels) => string.IsNullOrEmpty(parentLabels) ?
                                                                                             string.IsNullOrEmpty(elementLabel) ?
                                                                                             "" : elementLabel
                                                                                             : parentLabels + " " + elementLabel;

        public static string ReadHistoricalNote(this XElement element)
        {
            var historicalNote = element.Elements().FirstOrDefault(e => e.Name.LocalName == CONSTANTS.Constants.HistoricalNote);
            return historicalNote == null ? "" : historicalNote.ParseElementsAsString();
        }

        public static string ParseElementsAsString(this XElement element) => new string(string.Concat<string>(element.Elements().
                                                                                                              Where(e => e.Name.LocalName != CONSTANTS.Constants.Label && 
                                                                                                                         e.Name.LocalName != CONSTANTS.Constants.HistoricalNote && 
                                                                                                                         !CONSTANTS.Constants.RegTypes.Contains(e.Name.LocalName)).
                                                                                                              Select(e => "|" + e.Value)).Skip(1).ToArray());
        public static string ReadNodeByType(this XElement element, string elementType) => element.Elements().FirstOrDefault(e => e.Name.LocalName == elementType)?.Value;

        public static System.Data.DataTable CreateDataTableFromRegulation(Regulation source)
        {
            System.Data.DataTable Dt = new System.Data.DataTable();
            Dt.Columns.Add(CONSTANTS.Constants.Order, typeof(int));
            Dt.Columns.Add(CONSTANTS.Constants.UniqueId, typeof(string));
            Dt.Columns.Add(CONSTANTS.Constants.Type, typeof(string));
            Dt.Columns.Add(CONSTANTS.Constants.Label, typeof(string));
            Dt.Columns.Add(CONSTANTS.Constants.Text, typeof(string));
            Dt.Columns.Add(CONSTANTS.Constants.TextFrench, typeof(string));
            Dt.Columns.Add(CONSTANTS.Constants.HistoricalNote, typeof(string));
            Dt.Columns.Add(CONSTANTS.Constants.AdditionalMetadata, typeof(string));
            Dt.Columns.Add(CONSTANTS.Constants.JusticeId, typeof(string));
            Dt.Columns.Add(CONSTANTS.Constants.JusticeFId, typeof(string));
            Dt.Columns.Add(CONSTANTS.Constants.InforceStartDate, typeof(string));
            Dt.Columns.Add(CONSTANTS.Constants.PitDate, typeof(string));
            Dt.Columns.Add(CONSTANTS.Constants.Lang, typeof(string));
            Dt.Columns.Add(CONSTANTS.Constants.LastAmendedDate, typeof(string));
            Dt.Columns.Add(CONSTANTS.Constants.CurrentDate, typeof(string));
            Dt.Columns.Add(CONSTANTS.Constants.GazettePart, typeof(string));
            Dt.Columns.Add(CONSTANTS.Constants.RegulationType, typeof(string));

            foreach (var flag in CONSTANTS.Constants.DataFlags_Keywords)
            {
                Dt.Columns.Add(flag, typeof(string));
            }

            Dt.Columns.Add(CONSTANTS.Constants.DataFlags_HasUNNumber, typeof(string));
            Dt.Columns.Add(CONSTANTS.Constants.DataFlags_UNNumbers, typeof(string));

            Dt.Columns.Add(CONSTANTS.Constants.DataFlags_HasClasses, typeof(string));
            Dt.Columns.Add(CONSTANTS.Constants.DataFlags_Classes, typeof(string));
            

            RecursivelyAddChildrenToDataTable(ref Dt, source);

            return Dt;
        }

        public static void RecursivelyAddChildrenToDataTable(ref System.Data.DataTable Dt, Regulation element)
        {
            if (element.Children != null && element.Children.Where(e => CONSTANTS.Constants.RegTypes.Contains(e.Type) || e.Type == "Body").Count() > 0)
            {
                AddElementToDataTable(ref Dt, element);
                
                foreach (var child in element.Children)
                {
                    RecursivelyAddChildrenToDataTable(ref Dt, child);
                }
            }
            else
            {
                AddElementToDataTable(ref Dt, element);
            }
        }

        public static void AddElementToDataTable(ref System.Data.DataTable Dt, Regulation element)
        {
            DataRow dtrow = Dt.NewRow();

            dtrow.SetField(CONSTANTS.Constants.Order             , element.Order);
            dtrow.SetField(CONSTANTS.Constants.UniqueId          , element.UniqueId);
            dtrow.SetField(CONSTANTS.Constants.Type              , element.Type);
            dtrow.SetField(CONSTANTS.Constants.Label             , element.Label);
            dtrow.SetField(CONSTANTS.Constants.Text              , element.TextEnglish);
            dtrow.SetField(CONSTANTS.Constants.TextFrench        , element.TextFrench);
            dtrow.SetField(CONSTANTS.Constants.HistoricalNote    , element.HistoricalNote);
            dtrow.SetField(CONSTANTS.Constants.AdditionalMetadata, element.AdditionalMetadata);
            dtrow.SetField(CONSTANTS.Constants.JusticeId         , element.JusticeId);
            dtrow.SetField(CONSTANTS.Constants.JusticeFId        , element.JusticeFId);
            dtrow.SetField(CONSTANTS.Constants.InforceStartDate  , element.InforceStartDate);
            dtrow.SetField(CONSTANTS.Constants.PitDate           , element.PitDate);
            dtrow.SetField(CONSTANTS.Constants.Lang              , element.Lang);
            dtrow.SetField(CONSTANTS.Constants.LastAmendedDate   , element.LastAmendedDate);
            dtrow.SetField(CONSTANTS.Constants.CurrentDate       , element.CurrentDate);
            dtrow.SetField(CONSTANTS.Constants.GazettePart       , element.GazettePart);
            dtrow.SetField(CONSTANTS.Constants.RegulationType    , element.RegulationType);

            foreach (var flag in element.DataFlags)
            {
                dtrow.SetField(flag.Key, flag.Value.ToString()); //todo: no check = dangerous 
            }

            Dt.Rows.Add(dtrow);
        }

    }
}
