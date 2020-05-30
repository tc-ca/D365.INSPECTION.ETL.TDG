namespace TDG.CORE.ETL.MODELS.QUESTIONNAIRE
{
    public class QuestionOrder : BaseEntityModel
    {
        public string ShowKey { get; set; }
        public string HideKey { get; set; }
        public int Order { get; set; }
        public string QuestionName { get; set; }
        public string TemplateName { get; set; }
        public bool Visible { get; set; }
    }
}
