using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using TDG.CORE.ETL.EXTENSIONS;
using TDG.CORE.ETL.MODELS.LEGISLATION;
using TDG.CORE.ETL.MODELS.QUESTIONNAIRE;

namespace TDG.CORE.ETL.EXCEL
{
    public static class ExcelReader
    {
        #region string extensions
        public static string ReadCell(Microsoft.Office.Interop.Excel.Range xlRange, int i, int j)
        {
            string text;
            try
            {
                text = ((Microsoft.Office.Interop.Excel.Range)xlRange?.Cells[i, j])?.Value?.ToString();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                throw ex;
            }

            return text;
        }

        #endregion

        #region QUESTIONNAIRE
        #region questionnaire variables
        static int localAnswerIdCount = 1;
        static int localQuestionIdCount = 1;

        static int QuestionnaireNameENIndex = 1;
        static int QuestionnaireNameFRIndex = 2;
        static int QuestionnaireDescENIndex = 3;
        static int QuestionnaireDescFRIndex = 4;

        static int GroupIdIndex = 2;
        static int GroupTitleENIndex = 5;
        static int GroupTitleFRIndex = 6;
        static int GroupOrderIndex = 8;
        static int IsRepeatableIndex = 7;

        static int QuestionENIndex = 2;
        static int QuestionFRIndex = 3;
        static int QuestionShowKeyIndex = 5;
        static int QuestionHideKeyIndex = 6;
        static int QuestionVisibleIndex = 7;
        static int QuestionOrderIndex = 6;
        static int QuestionInputControlTypeIndex = 8;
        static int IdIndex = 1;
        static int IsVisibleIndex = 7;
        private static List<QuestionnaireQuestionResponse> responses = new List<QuestionnaireQuestionResponse>();
        private static List<QuestionOrder> questionOrders = new List<QuestionOrder>();
        private static List<QuestionGroupOrder> groupOrders = new List<QuestionGroupOrder>();
        #endregion

        public static QuestionnaireModel ReadQuestionnaireWorkbook(string path)
        { 
            Microsoft.Office.Interop.Excel.Application xlApp                   = new Microsoft.Office.Interop.Excel.Application();
            Microsoft.Office.Interop.Excel.Workbook xlWorkbook                 = xlApp.Workbooks.Open(path);
            Microsoft.Office.Interop.Excel._Worksheet xlWorksheetTemplate      = (Microsoft.Office.Interop.Excel._Worksheet)xlWorkbook.Sheets[1];
            Microsoft.Office.Interop.Excel._Worksheet xlWorksheetGroups        = (Microsoft.Office.Interop.Excel._Worksheet)xlWorkbook.Sheets[2];
            Microsoft.Office.Interop.Excel._Worksheet xlWorksheetQuestions     = (Microsoft.Office.Interop.Excel._Worksheet)xlWorkbook.Sheets[3];
            Microsoft.Office.Interop.Excel._Worksheet xlWorksheetResponses     = (Microsoft.Office.Interop.Excel._Worksheet)xlWorkbook.Sheets[4];
            Microsoft.Office.Interop.Excel._Worksheet xlWorksheetQuestionOrder = (Microsoft.Office.Interop.Excel._Worksheet)xlWorkbook.Sheets[5];
            Microsoft.Office.Interop.Excel._Worksheet xlWorksheetGroupOrder    = (Microsoft.Office.Interop.Excel._Worksheet)xlWorkbook.Sheets[6];
            Microsoft.Office.Interop.Excel.Range xlRange                       = xlWorksheetTemplate.UsedRange;

            xlApp.Visible = false;
            xlApp.ScreenUpdating = false;

            //sheet 1 = template
            int rowCount = xlRange.Rows.Count;
            int colCount = xlRange.Columns.Count;

            var Template = new QuestionnaireTemplate();
            var questions = new List<QuestionnaireQuestion>();
            var groups = new List<QuestionGroup>();

            //start at second row
            for (int i = 2; i <= rowCount; i++)
            {
                var TemplateName = ReadCell(xlRange, i, 1);
                var TemplateNameEn = ReadCell(xlRange, i, 2);
                var TemplateNameFr = ReadCell(xlRange, i, 3);
                var TemplateDescEn = ReadCell(xlRange, i, 4);
                var TemplateDescFr = ReadCell(xlRange, i, 5);

                Template.Name               = TemplateName;
                Template.TitleEnglish       = TemplateNameEn;
                Template.TitleFrench        = TemplateNameFr;
                Template.DescriptionEnglish = TemplateDescEn;
                Template.DescriptionFrench  = TemplateDescFr;
            }

            //groups
            xlRange  = xlWorksheetGroups.UsedRange;
            rowCount = xlRange.Rows.Count;
            colCount = xlRange.Columns.Count;

            for (int i = 2; i <= rowCount; i++)
            {
                var question = new QuestionGroup
                {
                    TemplateName = ReadCell(xlRange, i, 1),
                    Name         = ReadCell(xlRange, i, 2),
                    IsRepeatable = ReadCell(xlRange, i, 8).ToBool(),
                    TitleEnglish = ReadCell(xlRange, i, 6),
                    TitleFrench  = ReadCell(xlRange, i, 7)
                };

                groups.Add(question);
            }

            //sheet 2 - questions
            xlRange  = xlWorksheetQuestions.UsedRange;
            rowCount = xlRange.Rows.Count;
            colCount = xlRange.Columns.Count;

            for (int i = 2; i <= rowCount; i++)
            {
                var GroupId                  = ReadCell(xlRange, i, 1);
                var QuestionId               = ReadCell(xlRange, i, 6);
                var QuestionEn               = ReadCell(xlRange, i, 10);
                var QuestionFr               = ReadCell(xlRange, i, 11);
                var questionHideKey          = ReadCell(xlRange, i, 12);
                var questionShowKey          = ReadCell(xlRange, i, 13);
                var QuestionIsVisible        = ReadCell(xlRange, i, 14).ToBool();

                var question = new QuestionnaireQuestion
                {
                    Name        = QuestionId,
                    TextEnglish = QuestionEn,
                    TextFrench  = QuestionFr,
                    ShowKey     = questionShowKey,
                    HideKey     = questionHideKey,
                    GroupName   = GroupId
                };

                questions.Add(question);
            }

            //responses
            xlRange = xlWorksheetResponses.UsedRange;
            rowCount = xlRange.Rows.Count;
            colCount = xlRange.Columns.Count;

            for (int i = 2; i <= rowCount; i++)
            {
                var question = new QuestionnaireQuestionResponse
                {
                    QuestionName        = ReadCell(xlRange, i, 6),
                    ControlInputType    = ReadCell(xlRange, i, 11),
                    ControlInputId      = ReadCell(xlRange, i, 12),
                    ControlInputName    = ReadCell(xlRange, i, 13),
                    ControlLabelEnglish = ReadCell(xlRange, i, 14),
                    ControlLabelFrench  = ReadCell(xlRange, i, 15),
                    IsProblem           = ReadCell(xlRange, i, 16),
                    IsSafetyConcern     = ReadCell(xlRange, i, 17),
                    ExternalComment     = ReadCell(xlRange, i, 18),
                    InternalComment     = ReadCell(xlRange, i, 19),
                    Picture             = ReadCell(xlRange, i, 20),
                    EmitValue           = ReadCell(xlRange, i, 21), 
                    Order               = ReadCell(xlRange, i, 22).ToInt(),
                    GroupAlternateKey   = ReadCell(xlRange, i, 23), 
                    Reg1 = ReadCell(xlRange, i, 24),
                    Reg2 = ReadCell(xlRange, i, 25),
                    Reg3 = ReadCell(xlRange, i, 26)
                };

                responses.Add(question);
            }

            //question orders
            xlRange  = xlWorksheetQuestionOrder.UsedRange;
            rowCount = xlRange.Rows.Count;
            colCount = xlRange.Columns.Count;

            for (int i = 2; i <= rowCount; i++)
            {
                var question = new QuestionOrder
                {
                    TemplateName = ReadCell(xlRange, i, 1),
                    QuestionName = ReadCell(xlRange, i, 7),
                    Name         = ReadCell(xlRange, i, 12),
                    ShowKey      = ReadCell(xlRange, i, 13),
                    HideKey      = ReadCell(xlRange, i, 14),
                    Order        = ReadCell(xlRange, i, 15).ToInt(),
                    Visible      = ReadCell(xlRange, i, 16).ToBool()
                };

                questionOrders.Add(question);
            }

            //group orders
            xlRange  = xlWorksheetGroupOrder.UsedRange;
            rowCount = xlRange.Rows.Count;
            colCount = xlRange.Columns.Count;

            for (int i = 2; i <= rowCount; i++)
            {
                var question = new QuestionGroupOrder
                {
                    TemplateName      = ReadCell(xlRange, i, 1),
                    GroupName         = ReadCell(xlRange, i, 2),
                    Name              = ReadCell(xlRange, i, 6),
                    IsVisible         = ReadCell(xlRange, i, 9).ToBool(),
                    Order             = ReadCell(xlRange, i, 10).ToInt(),
                    Showkey           = ReadCell(xlRange, i, 11),
                    Hidekey           = ReadCell(xlRange, i, 12), 
                    Visible           = ReadCell(xlRange, i, 9).ToBool(), 
                    ResponseDelimeter = ReadCell(xlRange, i, 13)
                };

                groupOrders.Add(question);
            }

            var questionnaire = new QuestionnaireModel
            {
                Template          = Template,
                Questions         = questions,
                QuestionGroups    = groups,
                QuestionResponses = responses,
                QuestionOrders    = questionOrders,
                GroupOrders       = groupOrders
            };


            xlWorkbook.Close(false);
            xlApp.Quit();

            xlRange                  = null;
            xlWorksheetTemplate      = null;
            xlWorksheetGroups        = null;
            xlWorksheetQuestions     = null;
            xlWorksheetResponses     = null;
            xlWorksheetQuestionOrder = null;
            xlWorksheetGroupOrder    = null;
            xlWorkbook               = null;
            xlApp                    = null;


            return questionnaire;
        }
        #endregion

        #region LEGISLATION

        public static List<LegislationModel> ReadLegislationWorkbook(string path)
        {
            Microsoft.Office.Interop.Excel.Application xlApp                 = new Microsoft.Office.Interop.Excel.Application();
            Microsoft.Office.Interop.Excel.Workbook xlWorkbook               = xlApp.Workbooks.Open(path);
            Microsoft.Office.Interop.Excel._Worksheet xlWorksheetLegislation = (Microsoft.Office.Interop.Excel._Worksheet)xlWorkbook.Sheets[1];
            Microsoft.Office.Interop.Excel.Range xlRange                     = xlWorksheetLegislation.UsedRange;

            xlApp.Visible = false;
            xlApp.ScreenUpdating = false;

            //sheet 1 = template
            int rowCount = xlRange.Rows.Count;
            int colCount = xlRange.Columns.Count;

            var legislation = new List<LegislationModel>();

            //start at second row
            for (int i = 2; i <= rowCount; i++)
            {
                var model = new LegislationModel();

                var legislationType        = ReadCell(xlRange, i, 1);
                var legislationReference   = ReadCell(xlRange, i, 2);
                var legislationTextEnglish = ReadCell(xlRange, i, 3);
                var legislationTextFrench  = ReadCell(xlRange, i, 4);
                var order                  = ReadCell(xlRange, i, 5).ToInt();
                var dateEffective          = ReadCell(xlRange, i, 7).ToDateTime();
                var dateRevoked            = ReadCell(xlRange, i, 8).ToDateTime();


                model.LegislationType        = legislationType;
                model.LegislationReference   = legislationReference;
                model.LegislationTextEnglish = legislationTextEnglish;
                model.LegislationTextFrench  = legislationTextFrench;
                model.Order                  = order;
                model.DateEffective          = dateEffective;
                model.DateRevoked            = dateRevoked;

                legislation.Add(model);
            }

            xlWorkbook.Close(false);
            xlApp.Quit();

            xlRange = null;
            xlWorksheetLegislation = null;
            xlWorkbook = null;
            xlApp = null;

            return legislation;
        }

        #endregion
    }
}
