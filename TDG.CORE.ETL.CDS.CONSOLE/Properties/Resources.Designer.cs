﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TDG.CORE.ETL.CDS.CONSOLE.Properties {
    using System;
    
    
    /// <summary>
    ///   A strongly-typed resource class, for looking up localized strings, etc.
    /// </summary>
    // This class was auto-generated by the StronglyTypedResourceBuilder
    // class via a tool like ResGen or Visual Studio.
    // To add or remove a member, edit your .ResX file then rerun ResGen
    // with the /str option, or rebuild your VS project.
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Resources.Tools.StronglyTypedResourceBuilder", "16.0.0.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    public class Resources {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal Resources() {
        }
        
        /// <summary>
        ///   Returns the cached ResourceManager instance used by this class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        public static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("TDG.CORE.ETL.CDS.CONSOLE.Properties.Resources", typeof(Resources).Assembly);
                    resourceMan = temp;
                }
                return resourceMan;
            }
        }
        
        /// <summary>
        ///   Overrides the current thread's CurrentUICulture property for all
        ///   resource lookups using this strongly typed resource class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        public static global::System.Globalization.CultureInfo Culture {
            get {
                return resourceCulture;
            }
            set {
                resourceCulture = value;
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to &lt;fetch&gt;
        ///  &lt;entity name=&quot;tc_legislation&quot; /&gt;
        ///&lt;/fetch&gt;.
        /// </summary>
        public static string legislation_fetch {
            get {
                return ResourceManager.GetString("legislation_fetch", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to &lt;fetch&gt;
        ///  &lt;entity name=&quot;tc_questionnaire_template&quot;&gt;
        ///    &lt;attribute name=&quot;tc_name&quot; alias=&quot;template_name&quot; /&gt;
        ///    &lt;attribute name=&quot;tc_englishtitle&quot; alias=&quot;template_title_english&quot; /&gt;
        ///    &lt;attribute name=&quot;tc_englishdescription&quot; alias=&quot;template_description_english&quot; /&gt;
        ///    &lt;filter type=&quot;and&quot;&gt;
        ///      &lt;condition attribute=&quot;tc_name&quot; operator=&quot;eq&quot; value=&quot;__TEMPLATE_ID__&quot; /&gt;
        ///    &lt;/filter&gt;
        ///    &lt;link-entity name=&quot;tc_template_questions_group&quot; from=&quot;tc_questionnaire_templateid&quot; to=&quot;tc_questionnaire_templateid&quot; link- [rest of string was truncated]&quot;;.
        /// </summary>
        public static string schema_fetch {
            get {
                return ResourceManager.GetString("schema_fetch", resourceCulture);
            }
        }
    }
}
