using System;
using System.Diagnostics;
using TDG.CORE.ETL.EXCEL;
using TDG.CORE.ETL.MODELS.LEGISLATION;
using TDG.CORE.INTEGRATION.LEGAPI;

namespace TDG.CORE.ETL.XML.CONSOLE
{
    class CoreXMLConsole
    {
        private const string actFileName = "TDG-ACT";
        private const string regFileName = "TDG-REGS";
        private const string schedule1FileName = "TDG-SCHEDULE-1";
        private const string schedule2FileName = "TDG-SCHEDULE-2";
        private const string schedule3FileName = "TDG-SCHEDULE-3";

        static ExcelHelper excel;

        static Regulation act;
        static Regulation tdgr;      
        static Regulation schedule1;
        static Regulation schedule2;
        static Regulation schedule3 ;


        static void Main(string[] args)
        {
            SetupBasicLogging();

            //don't need act rn
            var actXml = LegApiClient.GetActFromJustice();
            var regXml = LegApiClient.GetRegulationFromJustice();

            //XML to "Regulation" class
            act       = XMLFunctions.ParseRegs(actXml, "Body", "452135");
            tdgr      = XMLFunctions.ParseRegs(regXml, "Body", "1227365");
            schedule1 = XMLFunctions.ParseRegs(regXml, "Schedule", "1230876");
            schedule2 = XMLFunctions.ParseRegs(regXml, "Schedule", "1230890");
            schedule3 = XMLFunctions.ParseRegs(regXml, "Schedule", "1231645");

            //flag data we're interested in 
            //TODO: can be added in the parsing to avoid an extra sweep
            act.PopulateDataFlags();
            tdgr.PopulateDataFlags();
            schedule1.PopulateDataFlags();
            schedule2.PopulateDataFlags();
            schedule3.PopulateDataFlags();

            //output List of Regulations to JSON
            XMLFunctions.SerializeRegulationsToFile(act, actFileName);
            XMLFunctions.SerializeRegulationsToFile(tdgr, regFileName);
            XMLFunctions.SerializeRegulationsToFile(schedule1, schedule1FileName);
            XMLFunctions.SerializeRegulationsToFile(schedule2, schedule2FileName);
            XMLFunctions.SerializeRegulationsToFile(schedule3, schedule3FileName);

            CreateExcelWorkbook();
        }

        private static void CreateExcelWorkbook()
        {
            //create hidden excel application
            excel = new ExcelHelper();

            //faster if you don't see it happening
            excel.Hide();

            //resize and center excel sheet
            excel.Recenter();

            CreateProvisionExcelSheet(act, actFileName);
            CreateProvisionExcelSheet(tdgr, regFileName);
            CreateProvisionExcelSheet(schedule1, schedule1FileName);
            CreateProvisionExcelSheet(schedule2, schedule2FileName);
            CreateProvisionExcelSheet(schedule3, schedule3FileName, true);

            excel.SelectFirstSheet();

            excel.SaveFile();

            excel.Close();
        }

        private static void CreateProvisionExcelSheet(Regulation provision, string name, bool lastSheet = false)
        {
            //flatten list and output to DataTable <--faster output to excel 
            var dt = XMLFunctions.CreateDataTableFromRegulation(provision);

            //export to datatable
            excel.BulkExportDataTableToExcel(dt);

            excel.SetWorksheetName(name);

            excel.FreezeFrame(3, 1);

            //create new worksheet
            if (!lastSheet) 
            {
                excel.CreateNewWorksheet();
            }
        }

        private static void SetupBasicLogging()
        {
            TextWriterTraceListener[] listeners = new TextWriterTraceListener[] {
                new TextWriterTraceListener($"REGULATION_EXTRACTION_LOG_{DateTime.Now.ToString("DD/MM/yyyy_hh/mm/ss")}.log"),
                new TextWriterTraceListener(Console.Out)
            };

            Debug.Listeners.AddRange(listeners);
            Debug.WriteLine("Logging Started");
        }
    }
}
