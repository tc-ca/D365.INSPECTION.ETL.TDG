using System.Collections.Generic;

namespace TDG.CORE.ETL.MODELS.QUESTIONNAIRE
{
    public class QuestionnaireModel : BaseEntityModel
    {
        public QuestionnaireTemplate Template { get; set; }
        public List<QuestionnaireQuestion> Questions { get; set; }
        public List<QuestionGroup> QuestionGroups { get; set; }
        public List<QuestionnaireQuestionResponse> QuestionResponses { get; set; }
        public List<QuestionOrder> QuestionOrders { get; set; }
        public List<QuestionGroupOrder> GroupOrders { get; set; }
    }
}
