using System;

namespace TDG.CORE.ETL.MODELS.QUESTIONNAIRE
{
    public class QuestionGroupOrder : BaseEntityModel
    {
        public string GroupName { get; set; }
        public string Hidekey { get; set; }
        public string Showkey { get; set; }
        public string TemplateName { get; set; }
        public int Order { get; set; }
        public Boolean Visible { get; set; }
        public bool IsVisible { get; set; }
        public string ResponseDelimeter { get; set; }
    }
}
