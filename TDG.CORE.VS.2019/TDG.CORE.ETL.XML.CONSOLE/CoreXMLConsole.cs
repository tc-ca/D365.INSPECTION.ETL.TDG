using System;
using System.Diagnostics;
using TDG.CORE.ETL.EXCEL;
using TDG.CORE.ETL.MODELS.LEGISLATION;
using TDG.CORE.INTEGRATION.LEGAPI;

namespace TDG.CORE.ETL.XML.CONSOLE
{
    class CoreXMLConsole
    {
        static void Main(string[] args)
        {
            TextWriterTraceListener[] listeners = new TextWriterTraceListener[] {
                new TextWriterTraceListener($"REGULATION_EXTRACTION_LOG_{DateTime.Now.ToString("DD/MM/yyyy_hh/mm/ss")}.log"),
                new TextWriterTraceListener(Console.Out)
            };

            Debug.Listeners.AddRange(listeners);

            Debug.WriteLine("Logging Started");

            var regJson = LegApiClient.GetRegulation("672172E"); 



            //XML to "Regulation" class
            var tdgr      = XMLFunctions.ParseRegs("Body", "1227365");
            //var schedule1 = XMLFunctions.ParseRegs("Schedule", "1230876");
            var schedule2 = XMLFunctions.ParseRegs("Schedule", "1230890");
            //var schedule3 = XMLFunctions.ParseRegs("Schedule", "1231645");

            //flag data we're interested in
            tdgr.PopulateDataFlags();
            //schedule1.PopulateDataFlags();
            schedule2.PopulateDataFlags();
            //schedule3.PopulateDataFlags();

            //output List of Regulations to JSON
            XML.XMLFunctions.SerializeRegulationsToFile(tdgr, "TDG-REGS");
            //XML.XMLFunctions.SerializeRegulationsToFile(schedule1, "TDG-SCHEDULE-1");
            XML.XMLFunctions.SerializeRegulationsToFile(schedule2, "TDG-SCHEDULE-2");
            //XML.XMLFunctions.SerializeRegulationsToFile(schedule3, "TDG-SCHEDULE-3");


            //convert list of Regulations to DataTable <--faster output to excel 
            var dt          = XMLFunctions.CreateDataTableFromRegulation(tdgr);
            //var dtSchedule1 = XMLFunctions.CreateDataTableFromRegulation(schedule1);
            var dtSchedule2 = XMLFunctions.CreateDataTableFromRegulation(schedule2);
            //var dtSchedule3 = XMLFunctions.CreateDataTableFromRegulation(schedule3);

            
            //export TDGR and Schedule 2 to an excel workbook
            //=====================================================

            //create hidden excel application
            var excel = new ExcelHelper();
            
            //faster if you don't see it happening
            excel.Hide();
            //excel.Show();

            //export regs
            excel.BulkExportDataTableToExcel(dt);
            
            //create new worksheet for schedule 2
            excel.CreateNewWorksheet("TDG SCHEDULE 2");

            //export schedule 2
            excel.BulkExportDataTableToExcel(dtSchedule2);

            //resize and center excel sheet
            excel.Recenter();
            
            excel.SelectFirstSheet();

            excel.FreezeFrame(3, 1);

            excel.SaveFile();

            excel.Close();
        }
    }
}
