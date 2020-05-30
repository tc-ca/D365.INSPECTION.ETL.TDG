using System.Collections.Generic;

namespace TDG.CORE.ETL.MODELS.QUESTIONNAIRE
{
    public class QuestionnaireTemplate : BaseEntityModel
    {
        public string TitleEnglish { get; set; }
        public string TitleFrench { get; set; }
        public string DescriptionEnglish { get; set; }
        public string DescriptionFrench { get; set; }

        public List<QuestionGroup> QuestionGroups { get; set; }
    }
}
