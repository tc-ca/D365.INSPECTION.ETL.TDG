//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CrmWebApiEarlyBoundGenerator {
    using System.Reflection;
    using System.Linq;
    using System;
    using System.Collections.Generic;
    using System.Dynamic;
    using System.Diagnostics.CodeAnalysis;
    
    
    [ExcludeFromCodeCoverageAttribute()]
    public class qm_syresponse_rclegislation : Entity {
        
        public new const string EntityLogicalName = "qm_syresponse_rclegislation";
        
        public new const string EntitySetName = "qm_syresponse_rclegislationset";
        
        public new const string PrimaryIdAttribute = "qm_syresponse_rclegislationid";
        
        public qm_syresponse_rclegislation() {
        }
        
        public qm_syresponse_rclegislation(ExpandoObject expandoObject) : 
                base(expandoObject) {
        }
        
        public Guid? qm_rclegislationid {
            get {
                return this.GetAttributeValue<Guid?>("qm_rclegislationid");
            }
            set {
                this.SetAttributeValue("qm_rclegislationid", value);
            }
        }
        
        public Guid? qm_syresponse_rclegislationId {
            get {
                return this.GetAttributeValue<Guid?>("qm_syresponse_rclegislationId");
            }
            set {
                this.SetAttributeValue("qm_syresponse_rclegislationId", value);
            }
        }
        
        public Guid? qm_syresponseid {
            get {
                return this.GetAttributeValue<Guid?>("qm_syresponseid");
            }
            set {
                this.SetAttributeValue("qm_syresponseid", value);
            }
        }
        
        public long? VersionNumber {
            get {
                return this.GetAttributeValue<long?>("VersionNumber");
            }
            set {
                this.SetAttributeValue("VersionNumber", value);
            }
        }
        
        public class Fields {
            
            public const string qm_rclegislationid = "qm_rclegislationid";
            
            public const string qm_syresponse_rclegislationId = "qm_syresponse_rclegislationid";
            
            public const string qm_syresponseid = "qm_syresponseid";
            
            public const string VersionNumber = "versionnumber";
            
            public const string Id = "qm_syresponse_rclegislationid";
        }
        
        public class Properties {
            
            public const string qm_syresponse_rclegislation = "qm_syresponse_rclegislation";
        }
        
        public class Schemas {
            
            public const string qm_rclegislationid = "qm_rclegislationid";
            
            public const string qm_syresponse_rclegislationId = "qm_syresponse_rclegislationId";
            
            public const string qm_syresponseid = "qm_syresponseid";
            
            public const string VersionNumber = "VersionNumber";
        }
    }
}
