namespace TDG.CORE.ETL.MODELS.QUESTIONNAIRE
{
    public class QuestionnaireQuestionResponse : BaseEntityModel
    {
        public string ControlInputId { get; set; }
        public string ControlInputName { get; set; }
        public string ControlInputType { get; set; }
        public string ControlLabelEnglish { get; set; }
        public string ControlLabelFrench { get; set; }
        public string EmitValue { get; set; }
        public string ExternalComment { get; set; }
        public string InternalComment { get; set; }
        public string IsProblem { get; set; }
        public string IsSafetyConcern { get; set; }
        public string Picture { get; set; }
        public string QuestionName { get; set; }
        public int Order { get; set; }
        public string GroupAlternateKey { get; set; }

        public string Reg1 { get;set;}
        public string Reg2 { get;set;}
        public string Reg3 { get;set;}
    }
}
