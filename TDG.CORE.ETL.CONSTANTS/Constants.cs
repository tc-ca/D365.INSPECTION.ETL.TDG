using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TDG.CORE.ETL.CONSTANTS
{
    public class Constants
    {
        //XML NODES
        public const string Type                = "Type";
        public const string Heading             = "Heading";
        public const string Section             = "Section";
        public const string Subsection          = "Subsection";
        public const string Paragraph           = "Paragraph";
        public const string Subparagraph        = "Subparagraph";
        public const string Clause              = "Clause";
        public const string Provision           = "Provision";
        public const string Label               = "Label";
        public const string Text                = "Text";
        public const string HistoricalNote      = "HistoricalNote";
        public const string AdditionalMetadata  = "AdditionalMetadata";
        public const string RegulationPiece     = "RegulationPiece";
        public const string ScheduleFormHeading = "ScheduleFormHeading";
        public const string Schedule            = "Schedule";

        //XML ATTRIBUTES
        public static string jNs              = "http://justice.gc.ca/lims";
        public static string JusticeId        = "id";
        public static string JusticeFId       = "fid";
        public static string InforceStartDate = "inforce-start-date";
        public static string PitDate          = "pit-date";
        public static string Lang             = "lang";
        public static string LastAmendedDate  = "lastAmendedDate";
        public static string CurrentDate      = "current-date";
        public static string GazettePart      = "gazette-part";
        public static string RegulationType   = "regulation-type";

        //doesnt exist, but need to seperate out the french, maintain original order and have unique id
        public static string TextFrench  = "TextFrench";
        public static string Order       = "Order";
        public static string UniqueId    = "UniqueId";
        public static string CrmId       = "CrmId";
        public static string ParentCrmId = "ParentCrmId";


        //valid nodes to output
        public static List<string> RegTypes = new List<string>(new[] { Heading, Schedule, ScheduleFormHeading, RegulationPiece, Section, Subsection, Paragraph, Subparagraph, Clause, Provision });

        public static string[] DataFlags_Keywords  = new[] { "MAY", "MUST", "UNLESS", "CONSIGNOR", "CARRIER", "IMPORTER", "EXEMPTION", "ERAP", "PROVISION", "LARGE MEANS OF CONTAINMENT", "SMALL MEANS OF CONTAINMENT", "MEANS OF CONTAINMENT", "CLASS", "UN NUMBER" };
        public static string DataFlags_HasUNNumber = "Has UN Number(s)";
        public static string DataFlags_UNNumbers   = "UN Number(s)";
        public static string DataFlags_HasClasses = "Has Classes";
        public static string DataFlags_Classes = "Classes";


    }
}
