namespace TDG.CORE.ETL.MODELS.QUESTIONNAIRE
{
    public class QuestionsGroupQuestion : BaseEntityModel
    {
        QuestionnaireQuestion Question { get; set; }
        QuestionnaireQuestionsGroup QuestionGroup { get; set; }
    }
}
