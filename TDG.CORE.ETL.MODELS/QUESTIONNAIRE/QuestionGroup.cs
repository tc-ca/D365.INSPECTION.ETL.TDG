namespace TDG.CORE.ETL.MODELS.QUESTIONNAIRE
{
    public class QuestionGroup : BaseEntityModel
    {
        public string TitleEnglish { get; set; }
        public string TitleFrench { get; set; }
        public bool IsRepeatable { get; set; }
        public string TemplateName { get; set; }
    }
}
