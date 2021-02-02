using System;
using System.Collections;
using System.Collections.Generic;

namespace TDG.CORE.ETL.MODELS.QUESTIONNAIRE
{
	public class BaseQuestionnaireModel : IEquatable<BaseQuestionnaireModel>
    {
        public string Name { get; set; }
        public Guid Id { get; set; }

        public override bool Equals(object obj)
        {
            if (obj is BaseQuestionnaireModel)
                return Equals((BaseQuestionnaireModel)obj);
            return false;
        }

        public bool Equals(BaseQuestionnaireModel obj)
        {
            if (obj == null) return false;
            if (!EqualityComparer<Guid>.Default.Equals(Id, obj.Id)) return false;
            return true;
        }

        public override int GetHashCode()
        {
            int hash = 0;
            hash ^= EqualityComparer<Guid>.Default.GetHashCode(Id);
            return hash;
        }
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
    public class QuestionnaireFetchResult
    {
        public string TemplateId { get; set; }
        public string TemplatePrimaryKey  { get; set; }
        public string TemplateTitleEn     { get; set; }
        public string TemplateTitleFr     { get; set; }
        public string GroupPrimaryKey     { get; set; }
        public string GroupTitleEn        { get; set; }
        public string GroupTitleFr        { get; set; }
        public string GroupOrder          { get; set; }
        public string GroupIsVisible      { get; set; }
        public string GroupId             { get; set; }
        public string QuestionPrimaryKey  { get; set; }
        public string QuestionTitleEn     { get; set; }
        public string QuestionTitleFr     { get; set; }
        public string QuestionOrder       { get; set; }
        public string QuestionIsVisible   { get; set; }
        public string QuestionType        { get; set; }
        public string QuestionId          { get; set; }
        public string QuestionParentId    { get; set; }
        public string ResponsePrimaryKey  { get; set; }
        public string ResponseId { get; set; }
    }

    public class Group : BaseQuestionnaireModel
    {
        public Group()
        {
            Questions = new List<Question>();
        }

        public string TitleEnglish { get; set; }
        public string TitleFrench { get; set; }
        public bool IsRepeatable { get; set; }
        public string TemplateId { get; set; }
        public bool IsVisible { get; set; }
        public int SortOrder { get; set; }
        public List<Question> Questions { get; set; }
    }
	
	public class Questionnaire : BaseQuestionnaireModel
    {
        public Template Template { get; set; }
        public List<Question> Questions { get; set; }
        public List<Group> QuestionGroups { get; set; }
        public List<Response> QuestionResponses { get; set; }
    }
	
	public class Question : BaseQuestionnaireModel
    {
        public Question()
        {
            Responses = new List<Response>();
        }
        public Guid GroupId { get; set; }
        public string TextEnglish { get; set; }
        public string TextFrench { get; set; }
        public string GroupName { get; set; }
        public string Type { get; set; }
        public string ParentQuestionName { get; set; }
        public Guid? ParentQuestionId { get;set; }
        public int SortOrder { get; set; }
        public bool IsVisible { get; set; }
        public List<Response> Responses { get;set;}
    }

    public class Response : BaseQuestionnaireModel
    {
        public string TextEnglish { get; set; }
        public string TextFrench { get; set; }
        public string ExternalComment { get; set; }
        public string InternalComment { get; set; }
        public string Picture { get; set; }
        public string IsProblem { get; set; }
        public string IsSafetyConcern { get; set; }
        public string QuestionName { get; set; }
        public Guid QuestionId { get; set; }
        public int SortOrder { get; set; }
        public string Reg1 { get;set;}
        public string Reg2 { get;set;}
        public string Reg3 { get;set;}
        public string ResponseType { get; set; }
    }
	
	public class Template : BaseQuestionnaireModel
    {
        public Template()
        {
            Groups = new List<Group>();
        }
        public string TitleEnglish { get; set; }
        public string TitleFrench { get; set; }
        public string DescriptionEnglish { get; set; }
        public string DescriptionFrench { get; set; }
        public List<Group> Groups { get; set; }
    }
    #endregion
}
