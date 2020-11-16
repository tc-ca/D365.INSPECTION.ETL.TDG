using TC.Legislation.EarlyBound;
using Microsoft.Xrm.Tooling.Connector;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using TDG.CORE.ETL.EXCEL;
using TDG.CORE.ETL.MODELS.LEGISLATION;
using TDG.CORE.ETL.MODELS.QUESTIONNAIRE;
using TDG.CORE.INTEGRATION.LEGAPI;

namespace TDG.CORE.ETL.CDS.CONSOLE
{
    public class CoreCDSConsole
    {
        [STAThread] // Added to support UX
        static void Main(string[] args)
        {
            Console.BackgroundColor = ConsoleColor.Black;
            Console.ForegroundColor = ConsoleColor.Black;

            /////////////////////QUESTIONNAIRE EXCEL SHEETS
            //ProcessQuestionnaireTemplate();

            /////////////////////LEGISLATION
            //ProcessTDGRegulations();

            string generalComplianceFetchXml = GetGeneralComplianceFetchXml();
            ETLLogic.FetchQuestionnaireData(generalComplianceFetchXml);

            Console.WriteLine("Done. Press something.");
            Console.ReadKey();
        }

        private static void ProcessQuestionnaireTemplate()
        {
            ETLLogic.DeleteQuestionnaireData();

            Questionnaire excelTemplateGeneralCompliance = ReadExcelTemplateGeneralCompliance();
            ETLLogic.ETLQuestionnaireData(excelTemplateGeneralCompliance);
        }

        private static void ProcessTDGRegulations()
        {
            //ETLLogic.DeleteLegislation();
           
            //DIGITAL OVERSIGHT LEG AND REG API => // var regXml = LegApiClient.GetRegulation("672172E");

            //using below because faster
            var regXml = LegApiClient.GetRegulationFromJustice();
            
            //DOWNLOAD XML DIRECTLY FROM JUSTICE
            var tdgRegs = XML.XMLFunctions.ParseRegs(regXml, "Body", "1227365");

            tdgRegs.PopulateDataFlags();
            //var dtSchedule2 = XML.XMLFunctions.ParseRegs(regXml, "Schedule", "1230890");

            ETLLogic.ETLLegislationData(tdgRegs);

            //ETLLogic.ETLLegislationData(dtSchedule2);

            string legislationFetchXml = GetLegislationFetchXml();
            ETLLogic.FetchLegislationData(legislationFetchXml);

            var json = JsonConvert.SerializeObject(tdgRegs);
        }

        static string GetLegislationFetchXml()
        {
            var legFetchXml = Properties.Resources.legislation_fetch;

            return legFetchXml;
        }

        static string GetGeneralComplianceFetchXml()
        {
            var generalComplianceFetchXml = Properties.Resources.schema_fetch;

            generalComplianceFetchXml = generalComplianceFetchXml.Replace("__TEMPLATE_ID__", "tdg_tmplt_gnrl_cmplnc");
        
            return generalComplianceFetchXml;
        }

        static List<Regulation> ReadExcelTemplateLegislation()
        {
            //get template from embedded resource
            var legTemplate = TDG.CORE.ETL.RESOURCES.Properties.Resources.TDGActiveLegislation;

            //write temporary file that we can access
            string tempPath = System.IO.Path.GetTempFileName();
            System.IO.File.WriteAllBytes(tempPath, legTemplate);

            Console.BackgroundColor = ConsoleColor.Yellow;
            Console.WriteLine("-----READING LEGISTLATION DATA FROM EXCEL-----");

            //read the entire workbook into a set of model classes to make the data easier to use
            var legData = ExcelReader.ReadLegislationWorkbook(tempPath);

            return legData;
        }

        private static Questionnaire ReadExcelTemplateGeneralCompliance()
        {
            string tempPath = System.IO.Path.GetTempFileName();

            //get template from embedded resource
            var generalComplianceTemplate = TDG.CORE.ETL.RESOURCES.Properties.Resources.GeneralCompliance_V2;

            //write temporary file that we can access
            System.IO.File.WriteAllBytes(tempPath, generalComplianceTemplate);

            Console.BackgroundColor = ConsoleColor.Yellow;
            Console.WriteLine("-----READING QUESTIONNAIRE DATA FROM EXCEL-----");

            //read the entire workbook into a set of model classes to make the data easier to use
            var questionnaireData = ExcelReader.ReadQuestionnaireWorkbook(tempPath);

            return questionnaireData;
        }
    }
}
