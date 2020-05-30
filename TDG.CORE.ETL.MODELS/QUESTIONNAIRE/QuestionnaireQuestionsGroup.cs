namespace TDG.CORE.ETL.MODELS.QUESTIONNAIRE
{
    public class QuestionnaireQuestionsGroup : BaseEntityModel
    {
        public string EnglishTitle { get; set; }
        public string FrenchTitle { get; set; }
        public bool IsRepeatable { get; set; }
    }
}
