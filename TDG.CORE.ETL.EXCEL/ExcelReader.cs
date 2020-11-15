using TC.Legislation.EarlyBound;
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
        private static List<Response> responses = new List<Response>();
        //private static List<QuestionOrder> questionOrders = new List<QuestionOrder>();
        //private static List<GroupOrder> groupOrders = new List<GroupOrder>();
        #endregion

        public static Questionnaire ReadQuestionnaireWorkbook(string path)
        { 
            Microsoft.Office.Interop.Excel.Application xlApp                   = new Microsoft.Office.Interop.Excel.Application();
            Microsoft.Office.Interop.Excel.Workbook xlWorkbook                 = xlApp.Workbooks.Open(path);
            Microsoft.Office.Interop.Excel._Worksheet xlWorksheetTemplate      = (Microsoft.Office.Interop.Excel._Worksheet)xlWorkbook.Sheets[1];
            Microsoft.Office.Interop.Excel._Worksheet xlWorksheetGroups        = (Microsoft.Office.Interop.Excel._Worksheet)xlWorkbook.Sheets[2];
            Microsoft.Office.Interop.Excel._Worksheet xlWorksheetQuestions     = (Microsoft.Office.Interop.Excel._Worksheet)xlWorkbook.Sheets[3];
            Microsoft.Office.Interop.Excel._Worksheet xlWorksheetResponses     = (Microsoft.Office.Interop.Excel._Worksheet)xlWorkbook.Sheets[4];
            //Microsoft.Office.Interop.Excel._Worksheet xlWorksheetQuestionOrder = (Microsoft.Office.Interop.Excel._Worksheet)xlWorkbook.Sheets[5];
            //Microsoft.Office.Interop.Excel._Worksheet xlWorksheetGroupOrder    = (Microsoft.Office.Interop.Excel._Worksheet)xlWorkbook.Sheets[6];
            Microsoft.Office.Interop.Excel.Range xlRange                       = xlWorksheetTemplate.UsedRange;

            xlApp.Visible = false;
            xlApp.ScreenUpdating = false;

            //sheet 1 = template
            int rowCount = xlRange.Rows.Count;
            int colCount = xlRange.Columns.Count;

            var Template = new Template();
            var questions = new List<Question>();
            var groups = new List<Group>();

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
                var question = new Group
                {
                    TemplateId   = ReadCell(xlRange, i, 1),
                    Name         = ReadCell(xlRange, i, 2),
                    IsRepeatable = ReadCell(xlRange, i, 6).ToBool(),
                    TitleEnglish = ReadCell(xlRange, i, 4),
                    TitleFrench  = ReadCell(xlRange, i, 5),
                    IsVisible    = ReadCell(xlRange, i, 7).ToBool(),
                    SortOrder    = ReadCell(xlRange, i, 8).ToInt()
                };

                groups.Add(question);
            }

            //sheet 2 - questions
            xlRange  = xlWorksheetQuestions.UsedRange;
            rowCount = xlRange.Rows.Count;
            colCount = xlRange.Columns.Count;

            for (int i = 2; i <= rowCount; i++)
            {
                var GroupId                  = ReadCell(xlRange, i, 4);
                var QuestionId               = ReadCell(xlRange, i, 2);
                var QuestionEn               = ReadCell(xlRange, i, 5);
                var QuestionFr               = ReadCell(xlRange, i, 6);
                var QuestionTypeCd           = ReadCell(xlRange, i, 7);
                var QuestionIsVisible        = ReadCell(xlRange, i, 10).ToBool();
                var Order                    = ReadCell(xlRange, i, 9).ToInt();
                var parent                   = ReadCell(xlRange,i,8);

                var question = new Question
                {
                    Name              = QuestionId,
                    TextEnglish       = QuestionEn,
                    TextFrench        = QuestionFr,
                    Type              = QuestionTypeCd,
                    IsVisible         = QuestionIsVisible,
                    ParentQuestionName  = parent,
                    GroupName           = GroupId, 
                    SortOrder         = Order
                };

                questions.Add(question);
            }

            //responses
            xlRange = xlWorksheetResponses.UsedRange;
            rowCount = xlRange.Rows.Count;
            colCount = xlRange.Columns.Count;

            for (int i = 2; i <= rowCount; i++)
            {
                var question = new Response
                {

                    QuestionName            = ReadCell(xlRange, i, 1),
                    Name              = ReadCell(xlRange, i, 2),
                    TextEnglish     = ReadCell(xlRange, i, 3),
                    TextFrench      = ReadCell(xlRange, i, 4),
                    IsProblem       = ReadCell(xlRange, i, 5),
                    IsSafetyConcern = ReadCell(xlRange, i, 6),
                    ExternalComment = ReadCell(xlRange, i, 7),
                    InternalComment = ReadCell(xlRange, i, 8),
                    Picture         = ReadCell(xlRange, i, 9),
                    SortOrder       = ReadCell(xlRange, i, 10).ToInt(),
                    Reg1            = ReadCell(xlRange, i, 11),
                    Reg2            = ReadCell(xlRange, i, 12),
                    Reg3            = ReadCell(xlRange, i, 13)
                };

                responses.Add(question);
            }

            //question orders
            //xlRange  = xlWorksheetQuestionOrder.UsedRange;
            //rowCount = xlRange.Rows.Count;
            //colCount = xlRange.Columns.Count;

            //for (int i = 2; i <= rowCount; i++)
            //{
            //    var question = new QuestionOrder
            //    {
            //        TemplateName = ReadCell(xlRange, i, 1),
            //        QuestionName = ReadCell(xlRange, i, 7),
            //        Name         = ReadCell(xlRange, i, 12),
            //        ShowKey      = ReadCell(xlRange, i, 13),
            //        HideKey      = ReadCell(xlRange, i, 14),
            //        Order        = ReadCell(xlRange, i, 15).ToInt(),
            //        Visible      = ReadCell(xlRange, i, 16).ToBool()
            //    };

            //    questionOrders.Add(question);
            //}

            //group orders
            //xlRange  = xlWorksheetGroupOrder.UsedRange;
            //rowCount = xlRange.Rows.Count;
            //colCount = xlRange.Columns.Count;

            //for (int i = 2; i <= rowCount; i++)
            //{
            //    var question = new GroupOrder
            //    {
            //        TemplateName      = ReadCell(xlRange, i, 1),
            //        GroupName         = ReadCell(xlRange, i, 2),
            //        Name              = ReadCell(xlRange, i, 6),
            //        IsVisible         = ReadCell(xlRange, i, 9).ToBool(),
            //        Order             = ReadCell(xlRange, i, 10).ToInt(),
            //        Showkey           = ReadCell(xlRange, i, 11),
            //        Hidekey           = ReadCell(xlRange, i, 12), 
            //        Visible           = ReadCell(xlRange, i, 9).ToBool(), 
            //        ResponseDelimeter = ReadCell(xlRange, i, 13)
            //    };

            //    groupOrders.Add(question);
            //}

            var questionnaire = new Questionnaire
            {
                Template          = Template,
                Questions         = questions,
                QuestionGroups    = groups,
                QuestionResponses = responses
                //QuestionOrders    = questionOrders,
                //GroupOrders       = groupOrders
            };


            xlWorkbook.Close(false);
            xlApp.Quit();

            xlRange                  = null;
            xlWorksheetTemplate      = null;
            xlWorksheetGroups        = null;
            xlWorksheetQuestions     = null;
            xlWorksheetResponses     = null;
            //xlWorksheetQuestionOrder = null;
            //xlWorksheetGroupOrder    = null;
            xlWorkbook               = null;
            xlApp                    = null;


            return questionnaire;
        }
        #endregion

        #region LEGISLATION

        public static List<Regulation> ReadLegislationWorkbook(string path)
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

            var legislation = new List<Regulation>();

            //start at second row
            for (int i = 2; i <= rowCount; i++)
            {
                var model = new Regulation();

                var legislationType        = ReadCell(xlRange, i, 1);
                var legislationReference   = ReadCell(xlRange, i, 2);
                var legislationTextEnglish = ReadCell(xlRange, i, 3);
                var legislationTextFrench  = ReadCell(xlRange, i, 4);
                var order                  = ReadCell(xlRange, i, 5).ToInt();
                var dateEffective          = ReadCell(xlRange, i, 7).ToDateTime();
                var dateRevoked            = ReadCell(xlRange, i, 8).ToDateTime();


                // TODO model.LegislationType        = legislationType;
                model.Label = legislationReference;
                model.TextEnglish = legislationTextEnglish;
                // model.TextFrench= legislationTextFrench;
                model.Order = order;
                model.InforceStartDate = dateEffective.ToString();
                model.LastAmendedDate = dateRevoked.ToString();

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
