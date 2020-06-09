using System;
using System.Collections.Generic;

namespace TDG.CORE.ETL.MODELS.QUESTIONNAIRE
{
	public class BaseQuestionnaireModel
    {
        public string Name { get; set; }
        public string Id { get; set; }
    }

    #region Logic
    public enum DependencyGroupRuleTypes
    {
        Visibility,
        Validation,
        ValidationValue
    }

    public enum ValidationType
    {
        Required,
        MinLength,
        MaxLength,
        GreaterThan,
        LessThan,
        EqualTo,
        NotEqualTo
    }

    public class QuestionValidationRules : BaseQuestionnaireModel
    {
        public string QuestionId { get; set; }
        public string ValidationRuleId { get; set; }
        public string Value { get; set; }
        public bool IsEnabled { get; set; }
    }

    public class ValidationRule : BaseQuestionnaireModel
    {
        public ValidationType Type { get; set; }
        public string ErrorMessageEnglish { get; set; }
        public string ErrorMessageFrench { get; set; }
    }

    public class DependencyGroup : BaseQuestionnaireModel
    {
        public string GroupId { get; set; }
        public string QuestionId { get; set; }
        public DependencyGroupRuleTypes RuleType { get; set; }
    }

    public class DependencyGroupItems : BaseQuestionnaireModel
    {
        public string DependencyGroupId { get; set; }
        public string ParentQuestionId { get; set; }
        public string ValidationRuleId { get; set; }
        public string ValidationValue { get; set; }
    }
    #endregion

    #region Structure
    //public class GroupOrder : BaseQuestionnaireModel
    //{
    //    public string GroupName { get; set; }
    //    public string Hidekey { get; set; }
    //    public string Showkey { get; set; }
    //    public string TemplateName { get; set; }
    //    public int Order { get; set; }
    //    public Boolean Visible { get; set; }
    //    public bool IsVisible { get; set; }
    //    public string ResponseDelimeter { get; set; }
    //}

    //public class QuestionOrder : BaseQuestionnaireModel
    //{
    //    public string ShowKey { get; set; }
    //    public string HideKey { get; set; }
    //    public int Order { get; set; }
    //    public string QuestionName { get; set; }
    //    public string TemplateName { get; set; }
    //    public bool Visible { get; set; }
    //}

    public class FetchResult
    {
        public string template_name { get; set; }
        public string template_title_english { get; set; }
        public string template_description_english { get; set; }
        public string group_name { get; set; }
        // public string group_html_element_id                             { get; set; }
        public string group_is_repeatable { get; set; }
        public string group_visible { get; set; }
        public string group_title_english { get; set; }
        public string group_order { get; set; }
        public string question_text_english { get; set; }
        public string question_name { get; set; }
        // public string question_html_element_id                          { get; set; }
        public string question_order { get; set; }
        public string question_visible { get; set; }
        public QuestionType response_control_input_type { get; set; }
        public string response_control_label_text_english { get; set; }
        public string response_control_input_name { get; set; }
        //public string response_control_input_id                         { get; set; }
        public string response_name { get; set; }
        public string response_internal_comment { get; set; }
        public string response_is_problem { get; set; }
        public string response_external_comment { get; set; }
        public string response_picture { get; set; }
        public string response_is_safety_concern { get; set; }
        public string response_emit_value { get; set; }
        public string response_order { get; set; }
        public string question_show_key { get; set; }
        public string question_hide_key { get; set; }
        public string group_response_delimiter { get; set; }
        public string response_display_in_group_header { get; set; }
    }

    public class QuestionType : BaseQuestionnaireModel
    {
        public string EntityName { get; set; }
    }

    //public class QuestionsGroupQuestion : BaseQuestionnaireModel
    //   {
    //       QuestionnaireQuestion Question { get; set; }
    //       QuestionnaireQuestionsGroup QuestionGroup { get; set; }
    //   }

    //public class QuestionControlType : BaseQuestionnaireModel
    //   {
    //   }

    public class Group : BaseQuestionnaireModel
    {
        public string TitleEnglish { get; set; }
        public string TitleFrench { get; set; }
        public bool IsRepeatable { get; set; }
        public string TemplateId { get; set; }
        public bool IsVisible { get; set; }
        public int SortOrder { get; set; }
    }
	
	public class Questionnaire : BaseQuestionnaireModel
    {
        public Template Template { get; set; }
        public List<Question> Questions { get; set; }
        public List<Group> QuestionGroups { get; set; }
        public List<QuestionResponseOption> QuestionResponses { get; set; }
        //public List<QuestionOrder> QuestionOrders { get; set; }
        //public List<GroupOrder> GroupOrders { get; set; }
    }
	
	public class Question : BaseQuestionnaireModel
    {
        public string TextEnglish { get; set; }
        public string TextFrench { get; set; }
        //public string HideKey { get; set; }
        //public string ShowKey { get; set; }
        public string GroupId { get; set; }
        public QuestionType Type { get; set; }
        public string ParentQuestionId { get; set; }
        public int SortOrder { get; set; }
        public bool IsVisible { get; set; }
        public string GroupAlternateKey { get; set; }
    }

    public class QuestionResponseOption : BaseQuestionnaireModel
    {
        //public string ControlInputId { get; set; }
        //public string ControlInputName { get; set; }
        //public string ControlInputType { get; set; }
        public string TextEnglish { get; set; }
        public string TextFrench { get; set; }

        //public string EmitValue { get; set; }
        public string ExternalComment { get; set; }
        public string InternalComment { get; set; }
        public string Picture { get; set; }
        public string IsProblem { get; set; }
        public string IsSafetyConcern { get; set; }
        public string QuestionId { get; set; }
        public int SortOrder { get; set; }

        public string Reg1 { get;set;}
        public string Reg2 { get;set;}
        public string Reg3 { get;set;}
    }
	
	//public class ResponseInput : BaseQuestionnaireModel
 //   {
 //   }
	
	//public class QuestionnaireQuestionsGroup : BaseQuestionnaireModel
 //   {
 //       public string EnglishTitle { get; set; }
 //       public string FrenchTitle { get; set; }
 //       public bool IsRepeatable { get; set; }
 //   }
	
	public class Template : BaseQuestionnaireModel
    {
        public string TitleEnglish { get; set; }
        public string TitleFrench { get; set; }
        public string DescriptionEnglish { get; set; }
        public string DescriptionFrench { get; set; }
        public List<Group> Groups { get; set; }
    }
    #endregion
}
