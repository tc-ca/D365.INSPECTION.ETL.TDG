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

namespace TDG.CORE.ETL.CDS.CONSOLE
{
    public class CoreCDSConsole
    {
        [STAThread] // Added to support UX
        static void Main(string[] args)
        {
            Console.BackgroundColor = ConsoleColor.Black;
            Console.ForegroundColor = ConsoleColor.Black;


            //ETLLogic.DeleteQuestionnaireData();

            //ETLLogic.DeleteLegislation();
            //List<LegislationModel> legData = ReadExcelTemplateLegislation();
            
            var tdgRegs = TDG.CORE.ETL.XML.XMLFunctions.ParseRegs();
            var dtSchedule2 = TDG.CORE.ETL.XML.XMLFunctions.ParseRegs("Schedule", "1230890");

            ETLLogic.ETLLegislationData(tdgRegs);
            ETLLogic.ETLLegislationData(dtSchedule2);

            //QuestionnaireModel excelTemplateGeneralCompliance = ReadExcelTemplateGeneralCompliance();
            //ETLLogic.ETLQuestionnaireData(excelTemplateGeneralCompliance);

            //string generalComplianceFetchXml = GetGeneralComplianceFetchXml();
            //ETLLogic.FetchQuestionnaireData(generalComplianceFetchXml);
            //ETLLogic.FetchLegislationData();

            Console.WriteLine("Done. Press something.");
            Console.ReadKey();
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

        static List<LegislationModel> ReadExcelTemplateLegislation()
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

        private static QuestionnaireModel ReadExcelTemplateGeneralCompliance()
        {
            string tempPath = System.IO.Path.GetTempFileName();

            //get template from embedded resource
            var generalComplianceTemplate = TDG.CORE.ETL.RESOURCES.Properties.Resources.GeneralCompliance;

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
