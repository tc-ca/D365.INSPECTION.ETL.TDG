namespace TDG.CORE.ETL.MODELS.QUESTIONNAIRE
{
    public class QuestionnaireQuestion : BaseEntityModel
    {
        public string TextEnglish { get; set; }
        public string TextFrench { get; set; }
        public string HideKey { get; set; }
        public string ShowKey { get; set; }
        public string GroupName { get; set; }
    }
}
