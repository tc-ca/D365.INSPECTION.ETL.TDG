//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TC.Legislation.EarlyBound {
    using System.Reflection;
    using System.Linq;
    using System;
    using System.Collections.Generic;
    using System.Dynamic;
    using System.Diagnostics.CodeAnalysis;
    
    
    [ExcludeFromCodeCoverageAttribute()]
    public class qm_syquestionvalidationrule : Entity {
        
        public new const string EntityLogicalName = "qm_syquestionvalidationrule";
        
        public new const string EntitySetName = "qm_syquestionvalidationrules";
        
        public new const string PrimaryIdAttribute = "qm_syquestionvalidationruleid";
        
        public qm_syquestionvalidationrule() {
        }
        
        public qm_syquestionvalidationrule(ExpandoObject expandoObject) : 
                base(expandoObject) {
        }
        
        // <summary>
        // Unique identifier of the user who created the record.
        //Identificateur unique de l'utilisateur ayant créé l'enregistrement.
        // </summary>
        [EntityReference("systemusers", "_createdby_value")]
        public EntityReference CreatedBy {
            get {
                return this.GetAttributeValue<EntityReference>("createdby@odata.bind");
            }
            set {
                this.SetAttributeValue("createdby@odata.bind", value);
            }
        }
        
        // <summary>
        // Date and time when the record was created.
        //Date et heure de création de l'enregistrement.
        // </summary>
        public DateTime? CreatedOn {
            get {
                return this.GetAttributeValue<DateTime?>("CreatedOn");
            }
            set {
                this.SetAttributeValue("CreatedOn", value);
            }
        }
        
        // <summary>
        // Unique identifier of the delegate user who created the record.
        //Identificateur unique de l'utilisateur délégué ayant créé l'enregistrement.
        // </summary>
        [EntityReference("systemusers", "_createdonbehalfby_value")]
        public EntityReference CreatedOnBehalfBy {
            get {
                return this.GetAttributeValue<EntityReference>("createdonbehalfby@odata.bind");
            }
            set {
                this.SetAttributeValue("createdonbehalfby@odata.bind", value);
            }
        }
        
        // <summary>
        // Sequence number of the import that created this record.
        //Numéro séquentiel de l'importation ayant créé cet enregistrement.
        // </summary>
        public int? ImportSequenceNumber {
            get {
                return this.GetAttributeValue<int?>("ImportSequenceNumber");
            }
            set {
                this.SetAttributeValue("ImportSequenceNumber", value);
            }
        }
        
        // <summary>
        // Unique identifier of the user who modified the record.
        //Identificateur unique de l'utilisateur ayant modifié l'enregistrement.
        // </summary>
        [EntityReference("systemusers", "_modifiedby_value")]
        public EntityReference ModifiedBy {
            get {
                return this.GetAttributeValue<EntityReference>("modifiedby@odata.bind");
            }
            set {
                this.SetAttributeValue("modifiedby@odata.bind", value);
            }
        }
        
        // <summary>
        // Date and time when the record was modified.
        //Date et heure de modification de l'enregistrement.
        // </summary>
        public DateTime? ModifiedOn {
            get {
                return this.GetAttributeValue<DateTime?>("ModifiedOn");
            }
            set {
                this.SetAttributeValue("ModifiedOn", value);
            }
        }
        
        // <summary>
        // Unique identifier of the delegate user who modified the record.
        //Identificateur unique de l'utilisateur délégué ayant modifié l'enregistrement.
        // </summary>
        [EntityReference("systemusers", "_modifiedonbehalfby_value")]
        public EntityReference ModifiedOnBehalfBy {
            get {
                return this.GetAttributeValue<EntityReference>("modifiedonbehalfby@odata.bind");
            }
            set {
                this.SetAttributeValue("modifiedonbehalfby@odata.bind", value);
            }
        }
        
        // <summary>
        // Unique identifier for the organization
        //Identificateur unique de l'organisation
        // </summary>
        [EntityReference("organizations", "_organizationid_value")]
        public EntityReference OrganizationId {
            get {
                return this.GetAttributeValue<EntityReference>("organizationid@odata.bind");
            }
            set {
                this.SetAttributeValue("organizationid@odata.bind", value);
            }
        }
        
        // <summary>
        // Date and time that the record was migrated.
        //Date et heure de migration de l'enregistrement.
        // </summary>
        [OnlyDate()]
        public DateTime? OverriddenCreatedOn {
            get {
                return this.GetAttributeValue<DateTime?>("OverriddenCreatedOn");
            }
            set {
                this.SetAttributeValue("OverriddenCreatedOn", value);
            }
        }
        
        public bool? qm_IsEnabledInd {
            get {
                return this.GetAttributeValue<bool?>("qm_IsEnabledInd");
            }
            set {
                this.SetAttributeValue("qm_IsEnabledInd", value);
            }
        }
        
        // <summary>
        // The name of the custom entity.
        // </summary>
        public String qm_name {
            get {
                return this.GetAttributeValue<String>("qm_name");
            }
            set {
                this.SetAttributeValue("qm_name", value);
            }
        }
        
        // <summary>
        // Unique identifier for Question associated with Question Validation Rule.
        // </summary>
        [EntityReference("qm_syquestions", "_qm_syquestionid_value")]
        public EntityReference qm_SYQuestionId {
            get {
                return this.GetAttributeValue<EntityReference>("qm_SYQuestionId@odata.bind");
            }
            set {
                this.SetAttributeValue("qm_SYQuestionId@odata.bind", value);
            }
        }
        
        // <summary>
        // Unique identifier for Question associated with Question Validation Rule.
        // </summary>
        [Entity("qm_syquestion", "qm_SYQuestionId")]
        public qm_syquestion qm_SYQuestionIdEntity {
            get {
                return this.GetAttributeValue<qm_syquestion>("qm_SYQuestionId");
            }
            set {
                this.SetAttributeValue("qm_SYQuestionId", value);
            }
        }
        
        // <summary>
        // Unique identifier for entity instances
        //Identificateur unique des instances d'entité
        // </summary>
        public Guid? qm_syquestionvalidationruleId {
            get {
                return this.GetAttributeValue<Guid?>("qm_syquestionvalidationruleId");
            }
            set {
                this.SetAttributeValue("qm_syquestionvalidationruleId", value);
            }
        }
        
        public String qm_ValidationValue {
            get {
                return this.GetAttributeValue<String>("qm_ValidationValue");
            }
            set {
                this.SetAttributeValue("qm_ValidationValue", value);
            }
        }
        
        // <summary>
        // Status of the Question Validation Rule
        //Statut de l'élément Question Validation Rule
        // </summary>
        public int? statecode {
            get {
                return this.GetAttributeValue<int?>("statecode");
            }
            set {
                this.SetAttributeValue("statecode", value);
            }
        }
        
        // <summary>
        // Reason for the status of the Question Validation Rule
        //Raison du statut de l'élément Question Validation Rule
        // </summary>
        public int? statuscode {
            get {
                return this.GetAttributeValue<int?>("statuscode");
            }
            set {
                this.SetAttributeValue("statuscode", value);
            }
        }
        
        // <summary>
        // For internal use only.
        //Utilisation interne uniquement.
        // </summary>
        public int? TimeZoneRuleVersionNumber {
            get {
                return this.GetAttributeValue<int?>("TimeZoneRuleVersionNumber");
            }
            set {
                this.SetAttributeValue("TimeZoneRuleVersionNumber", value);
            }
        }
        
        // <summary>
        // Time zone code that was in use when the record was created.
        //Code du fuseau horaire utilisé à la création de l'enregistrement.
        // </summary>
        public int? UTCConversionTimeZoneCode {
            get {
                return this.GetAttributeValue<int?>("UTCConversionTimeZoneCode");
            }
            set {
                this.SetAttributeValue("UTCConversionTimeZoneCode", value);
            }
        }
        
        // <summary>
        // Version Number
        //Numéro de version
        // </summary>
        public long? VersionNumber {
            get {
                return this.GetAttributeValue<long?>("VersionNumber");
            }
            set {
                this.SetAttributeValue("VersionNumber", value);
            }
        }
        
        public class Fields {
            
            public const string _CreatedBy_value = "_createdby_value";
            
            public const string _CreatedOnBehalfBy_value = "_createdonbehalfby_value";
            
            public const string _ModifiedBy_value = "_modifiedby_value";
            
            public const string _ModifiedOnBehalfBy_value = "_modifiedonbehalfby_value";
            
            public const string _OrganizationId_value = "_organizationid_value";
            
            public const string _qm_SYQuestionId_value = "_qm_syquestionid_value";
            
            public const string CreatedBy = "createdby";
            
            public const string CreatedByName = "createdbyname";
            
            public const string CreatedByYomiName = "createdbyyominame";
            
            public const string CreatedOn = "createdon";
            
            public const string CreatedOnBehalfBy = "createdonbehalfby";
            
            public const string CreatedOnBehalfByName = "createdonbehalfbyname";
            
            public const string CreatedOnBehalfByYomiName = "createdonbehalfbyyominame";
            
            public const string ImportSequenceNumber = "importsequencenumber";
            
            public const string ModifiedBy = "modifiedby";
            
            public const string ModifiedByName = "modifiedbyname";
            
            public const string ModifiedByYomiName = "modifiedbyyominame";
            
            public const string ModifiedOn = "modifiedon";
            
            public const string ModifiedOnBehalfBy = "modifiedonbehalfby";
            
            public const string ModifiedOnBehalfByName = "modifiedonbehalfbyname";
            
            public const string ModifiedOnBehalfByYomiName = "modifiedonbehalfbyyominame";
            
            public const string OrganizationId = "organizationid";
            
            public const string OrganizationIdName = "organizationidname";
            
            public const string OverriddenCreatedOn = "overriddencreatedon";
            
            public const string qm_IsEnabledInd = "qm_isenabledind";
            
            public const string qm_isenabledindName = "qm_isenabledindname";
            
            public const string qm_name = "qm_name";
            
            public const string qm_SYQuestionId = "qm_syquestionid";
            
            public const string qm_SYQuestionIdName = "qm_syquestionidname";
            
            public const string qm_syquestionvalidationruleId = "qm_syquestionvalidationruleid";
            
            public const string qm_ValidationValue = "qm_validationvalue";
            
            public const string statecode = "statecode";
            
            public const string statecodeName = "statecodename";
            
            public const string statuscode = "statuscode";
            
            public const string statuscodeName = "statuscodename";
            
            public const string TimeZoneRuleVersionNumber = "timezoneruleversionnumber";
            
            public const string UTCConversionTimeZoneCode = "utcconversiontimezonecode";
            
            public const string VersionNumber = "versionnumber";
            
            public const string Id = "qm_syquestionvalidationruleid";
        }
        
        public class Properties {
            
            public const string createdby = "createdby";
            
            public const string createdonbehalfby = "createdonbehalfby";
            
            public const string modifiedby = "modifiedby";
            
            public const string modifiedonbehalfby = "modifiedonbehalfby";
            
            public const string organizationid = "organizationid";
            
            public const string qm_SYQuestionId = "qm_SYQuestionId";
        }
        
        public class Schemas {
            
            public const string CreatedBy = "CreatedBy";
            
            public const string CreatedByName = "CreatedByName";
            
            public const string CreatedByYomiName = "CreatedByYomiName";
            
            public const string CreatedOn = "CreatedOn";
            
            public const string CreatedOnBehalfBy = "CreatedOnBehalfBy";
            
            public const string CreatedOnBehalfByName = "CreatedOnBehalfByName";
            
            public const string CreatedOnBehalfByYomiName = "CreatedOnBehalfByYomiName";
            
            public const string ImportSequenceNumber = "ImportSequenceNumber";
            
            public const string ModifiedBy = "ModifiedBy";
            
            public const string ModifiedByName = "ModifiedByName";
            
            public const string ModifiedByYomiName = "ModifiedByYomiName";
            
            public const string ModifiedOn = "ModifiedOn";
            
            public const string ModifiedOnBehalfBy = "ModifiedOnBehalfBy";
            
            public const string ModifiedOnBehalfByName = "ModifiedOnBehalfByName";
            
            public const string ModifiedOnBehalfByYomiName = "ModifiedOnBehalfByYomiName";
            
            public const string OrganizationId = "OrganizationId";
            
            public const string OrganizationIdName = "OrganizationIdName";
            
            public const string OverriddenCreatedOn = "OverriddenCreatedOn";
            
            public const string qm_IsEnabledInd = "qm_IsEnabledInd";
            
            public const string qm_isenabledindName = "qm_isenabledindName";
            
            public const string qm_name = "qm_name";
            
            public const string qm_SYQuestionId = "qm_SYQuestionId";
            
            public const string qm_SYQuestionIdName = "qm_SYQuestionIdName";
            
            public const string qm_syquestionvalidationruleId = "qm_syquestionvalidationruleId";
            
            public const string qm_ValidationValue = "qm_ValidationValue";
            
            public const string statecode = "statecode";
            
            public const string statecodeName = "statecodeName";
            
            public const string statuscode = "statuscode";
            
            public const string statuscodeName = "statuscodeName";
            
            public const string TimeZoneRuleVersionNumber = "TimeZoneRuleVersionNumber";
            
            public const string UTCConversionTimeZoneCode = "UTCConversionTimeZoneCode";
            
            public const string VersionNumber = "VersionNumber";
        }
    }
}
