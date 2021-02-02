using Microsoft.Xrm.Sdk;
using Microsoft.Xrm.Sdk.Query;
using Microsoft.Xrm.Tooling.Connector;
using System;
using System.ServiceModel;
using System.Linq;
using System.Collections.Generic;
using TDG.CORE.ETL.EXTENSIONS;
using TDG.CORE.ETL.MODELS.QUESTIONNAIRE;
using TDG.CORE.ETL.MODELS.LEGISLATION;
using Microsoft.Xrm.Sdk.Messages;
using EntityReference = Microsoft.Xrm.Sdk.EntityReference;
using Entity = Microsoft.Xrm.Sdk.Entity;
using TC.Legislation.EarlyBound;

namespace TDG.CORE.ETL.CDS
{
    public static class CrmSdkHelper
    {
        static string legislationEntityName = "qm_rclegislation";
        static string characteristicEntityName = qm_tylegislationcharacteristic.EntityLogicalName;
        static string legislationCharacteristicEntityName = "qm_rclegislation_tylegislationcharacteristic";//qm_rylegislationcharacteristics.EntityLogicalName;
        static string groupEntityName = qm_sygroup.EntityLogicalName;
        static string questionEntityName = qm_syquestion.EntityLogicalName;
        static string responseEntityName = qm_syresponse.EntityLogicalName;
        static string keyName = "qm_name";
        static string legKeyName = "qm_justiceid";


        #region QUESTIONNAIRE

        /*
        IMPORTANT: 
        Do not update an entity using a retrieved entity instance.
        Always instantiate a new Entity and 
        set the primary key value to match the entity you want to update.
        Only set the attribute values you are changing.
        */
        public static void CreateOrUpdateCrmTemplate(CrmServiceClient service, Questionnaire questionnaireData)
        {
            if (questionnaireData == null) throw new ArgumentNullException(nameof(questionnaireData));

            string entityName = qm_sytemplate.EntityLogicalName;
            string keyValue   = questionnaireData.Template.Name;

            //check to see if there is an existing entity 
            var existingEntity = GetEntityUsingSimpleQuery(service, entityName, keyName, keyValue);

            var entity = new Entity(entityName);
            if (existingEntity == null)
            {
                entity.Id = Guid.NewGuid();
            }
            else
            {
                entity.Id = existingEntity.Id;
            }

            MapTemplateDataToEntity(ref entity, questionnaireData.Template);

            CreateOrUpdateEntity(ref service, ref entity, keyName, existingEntity == null);
        }

        private static void CreateOrUpdateCrmQuestionGroup(CrmServiceClient service, Questionnaire questionnaireData)
        {
            if (questionnaireData == null) throw new ArgumentNullException(nameof(questionnaireData));

            //groups from excel
            var excelTemplateGroups = questionnaireData.QuestionGroups;

            var crmTemplate = GetEntityUsingSimpleQuery(service, qm_sytemplate.EntityLogicalName, keyName, questionnaireData.Template.Name);

            foreach (var item in excelTemplateGroups)
            {
                if (string.IsNullOrEmpty(item.Name)) continue;

                var group = new Entity(groupEntityName);

                //get list of pre-existing question groups  0
                Entity existingGroup = GetEntityUsingSimpleQuery(service, groupEntityName, keyName, item.Name);

                if (existingGroup != null)
                {
                    group.Id = existingGroup.Id;
                }
                else
                {
                    group.Id = Guid.NewGuid();
                }

                MapQuestionGroupDataToEntity(ref group, item);

                CreateOrUpdateEntity(ref service, ref group, keyName, existingGroup == null);

                var entityReference = new List<EntityReference>
                {
                    crmTemplate.ToEntityReference()
                };

                var entityReferenceCollection = new EntityReferenceCollection(entityReference);

                //service.Associate(groupEntityName, group.Id, new Relationship("qm_Template_Questions_Group"), entityReferenceCollection);

                service.CreateEntityAssociation(groupEntityName, group.Id, crmTemplate.LogicalName, crmTemplate.Id, "qm_sytemplate_sygroup");
            }
        }

        private static void CreateOrUpdateCrmQuestions(CrmServiceClient service, Questionnaire questionnaireData)
        {
            Entity group = null;
            //var requirementOptionSet = service.GetGlobalOptionSetMetadata("qm_qtn_field_requirement");

            foreach (var question in questionnaireData.Questions)
            {
                if (question.Name == null) continue;

                var crmQuestion = GetEntityUsingSimpleQuery(service, questionEntityName, keyName, question.Name);

                var questionEntity = new Entity(questionEntityName);

                if (crmQuestion != null)
                {
                    questionEntity.Id = crmQuestion.Id;
                }
                else
                {
                    questionEntity.Id = Guid.NewGuid();
                }

                MapQuestionDataToEntity(ref questionEntity, question);

                CreateOrUpdateEntity(ref service, ref questionEntity, keyName, crmQuestion == null);

                if (group == null || question.GroupName != question.Name)
                {
                    group = GetEntityUsingSimpleQuery(service, groupEntityName, keyName, question.GroupName);
                    question.GroupId = group.Id;
                    Associate(service, questionEntity, "qm_sygroup_syquestion", group);
                }

                //parent question
                if (!String.IsNullOrEmpty(question.ParentQuestionName))
                {
                    var parentQuestion = GetEntityUsingSimpleQuery(service, questionEntityName, keyName, question.ParentQuestionName);
                    question.ParentQuestionId = parentQuestion.Id;
                    AssociateRequest(service, questionEntity, parentQuestion, "qm_syquestion_syquestion");
                }


                //Associate(service, questionEntity, "qm_syquestion_syquestion",)
                //var entityReference = new List<EntityReference>
                //{
                //    group.ToEntityReference()
                //};
                //var entityReferenceCollection = new EntityReferenceCollection(entityReference);

                //service.Associate(questionEntityName, questionEntity.Id, new Relationship("qm_Questions_Group_Question"), entityReferenceCollection);

            }
        }

        private static void CreateOrUpdateCrmResponses(CrmServiceClient service, Questionnaire questionnaireData)
        {
            //var requirementOptionSet = service.GetGlobalOptionSetMetadata("qm_qtn_field_requirement");
            //var problemOptionSet     = service.GetGlobalOptionSetMetadata("qm_qtn_problem_type");
            //var safetyOptionSet      = service.GetGlobalOptionSetMetadata("qm_qtn_safety_type");

            //var optional      = requirementOptionSet.Options.FirstOrDefault(e => e.Label.LocalizedLabels[0].Label == "Optional").Value;
            //var required      = requirementOptionSet.Options.FirstOrDefault(e => e.Label.LocalizedLabels[0].Label == "Required").Value;
            //var notApplicable = requirementOptionSet.Options.FirstOrDefault(e => e.Label.LocalizedLabels[0].Label == "Not Applicable").Value;

            //var YesProblem  = problemOptionSet.Options.FirstOrDefault(e => e.Label.LocalizedLabels[0].Label == "Problem - Yes").Value;
            //var NoProblem   = problemOptionSet.Options.FirstOrDefault(e => e.Label.LocalizedLabels[0].Label == "Problem - No").Value;
            //var NearProblem = problemOptionSet.Options.FirstOrDefault(e => e.Label.LocalizedLabels[0].Label == "Problem - Near").Value;

            //var YesSafety = safetyOptionSet.Options.FirstOrDefault(e => e.Label.LocalizedLabels[0].Label == "Safety - Yes").Value;
            //var NoSafety  = safetyOptionSet.Options.FirstOrDefault(e => e.Label.LocalizedLabels[0].Label == "Safety - No").Value;

            Entity question = null;

            foreach (var response in questionnaireData.QuestionResponses)
            {
                if (response.Name == null) continue;
                if (question == null || question.Attributes[keyName].ToString() != response.QuestionName)
                {
                    question = GetEntityUsingSimpleQuery(service, questionEntityName, keyName, response.QuestionName);

                    if (question == null)
                    {
                        Console.WriteLine("question is null!");
                    }
                }

                var crmResponse = GetEntityUsingSimpleQuery(service, responseEntityName, keyName, response.Name);

                var responseEntity = new Entity(responseEntityName);

                if (crmResponse != null) 
                     { responseEntity.Id = crmResponse.Id; } 
                else 
                    { responseEntity.Id = Guid.NewGuid(); }

                MapResponseDataToEntity(ref responseEntity, response);



                if (responseEntity.Attributes.ContainsKey("qm_syquestionid"))
                {
                    var entityRef = responseEntity.GetAttributeValue<EntityReference>("qm_syquestionid");
                    response.QuestionId = entityRef.Id;
                }

                CreateOrUpdateEntity(ref service, ref responseEntity, keyName, crmResponse == null);

                var entityReference = new List<EntityReference>
                {
                    question.ToEntityReference()
                };

                var entityReferenceCollection = new EntityReferenceCollection(entityReference);

                service.Associate(qm_syresponse.EntityLogicalName, responseEntity.Id, new Relationship("qm_syquestion_syresponse"), entityReferenceCollection);

                //Associate(service, responseEntity, "qm_syquestionid", question);


                //if (response.Picture == "0" || response.Picture == "1")
                //{
                //    bool isRequired = response.Picture == "1";

                //    //TODO add child question for picture
                //}

                //if (response.ExternalComment == "0" || response.ExternalComment == "1")
                //{
                //    bool isRequired = response.ExternalComment == "1";

                //    //TODO add child question for ExternalComment
                //}

                //if (response.InternalComment == "0" || response.InternalComment == "1")
                //{
                //    bool isRequired = response.InternalComment == "1";

                //    //TODO add child question for InternalComment
                //}

                //responseEntity.Attributes["qm_isproblem"] = new OptionSetValue(Convert.ToInt32(response.IsProblem == "0" ? NoProblem : response.IsProblem == "1" ? YesProblem : NearProblem));
                //responseEntity.Attributes["qm_issafetyconcern"] = new OptionSetValue(Convert.ToInt32(response.IsSafetyConcern == "0" ? NoSafety : response.IsSafetyConcern == "1" ? YesSafety : NoSafety));

                ////responseEntity.Attributes["qm_picture"] = new OptionSetValue(Convert.ToInt32(response.Picture == "0" ? optional : response.Picture == "1" ? required : notApplicable));
                //responseEntity.Attributes["qm_externalcomment"] = new OptionSetValue(Convert.ToInt32(response.ExternalComment == "0" ? optional : response.ExternalComment == "1" ? required : notApplicable));
                //responseEntity.Attributes["qm_internalcomment"] = new OptionSetValue(Convert.ToInt32(response.InternalComment == "0" ? optional : response.InternalComment == "1" ? required : notApplicable));
                //responseEntity.Attributes["qm_displayingroupheader"] = response.GroupAlternateKey == "0" ? false : true;

                //var entityReference = new List<EntityReference>
                //{
                //    question.ToEntityReference()
                //};
                //var entityReferenceCollection = new EntityReferenceCollection(entityReference);

                //associate input control type to lookup value

                //Entity responseInputType = GetEntityUsingSimpleQuery(service, "qm_questionnaire_question_response_input", keyName, response.ControlInputType);
                //entityReference = new List<EntityReference>();
                //entityReference.Add(responseInputType.ToEntityReference());
                //entityReferenceCollection = new EntityReferenceCollection(entityReference);
                //service.Associate(responseEntityName, responseEntity.Id, new Relationship("qm_Questionnaire_Question_Response_Contro"), entityReferenceCollection);

                //AssociateResponseWithLegislation(service, response, responseEntity);
            }
        }

        private static void AssociateResponseWithLegislation(CrmServiceClient service, Response response, Entity crmResponse)
        {
            //associate input control type to lookup value
            string[] regs = new[] { response.Reg1, response.Reg2, response.Reg3 }.Where(e => !string.IsNullOrEmpty(e)).ToArray();

            foreach (var reg in regs)
            {
                Entity legislation = GetEntityUsingSimpleQuery(service, "qm_qclegislation", "qm_qclegislationid", reg);

                try
                {
                    var entityReferenceCollection = new EntityReferenceCollection(new List<EntityReference>
                    {
                        legislation.ToEntityReference()
                    });

                    //TODO service.Associate(responseEntityName, crmResponse.Id, new Relationship("qm_syquestion_syresponse"), new EntityReferenceCollection(new List<EntityReference> { legislation.ToEntityReference() }));
                }
                catch (Exception e)
                {
                    throw e;
                }
            }
        }
        //private static void CreateOrUpdateCrmQuestionOrders(CrmServiceClient service, Questionnaire questionnaireData)
        //{
        //    try
        //    {
        //        Entity question = null;
        //        foreach (var order in questionnaireData.QuestionOrders)
        //        {
        //            if (string.IsNullOrEmpty(order.Name)) continue;

        //            if (question == null || question.Attributes[keyName].ToString() != order.QuestionName)
        //            {
        //                question = GetEntityUsingSimpleQuery(service, questionEntityName, keyName, order.QuestionName);
        //            }

        //            var crmOrder = GetEntityUsingSimpleQuery(service, questionOrderEntityName, keyName, order.Name);

        //            var orderEntity = new Entity(questionOrderEntityName);

        //            if (crmOrder != null)
        //            {
        //                orderEntity.Id = crmOrder.Id;
        //            }
        //            else
        //            {
        //                orderEntity.Id = Guid.NewGuid();
        //            }

        //            MapQuestionOrderDataToEntity(ref orderEntity, order);

        //            CreateOrUpdateEntity(ref service, ref orderEntity, keyName, crmOrder == null);

        //            var entityReference = new List<EntityReference>
        //            {
        //                question.ToEntityReference()
        //            };
        //            var entityReferenceCollection = new EntityReferenceCollection(entityReference);

        //            service.Associate(questionOrderEntityName, orderEntity.Id, new Relationship("qm_Qtn_Question_Order_Question_qm_Questio"), entityReferenceCollection);
        //        }
        //    }
        //    catch (Exception e)
        //    {
        //        throw e;
        //        //tdg_grp_mns_f_cntnmnt_qstn_ctgr_b_mrk_sctn_order
        //    }
        //}

        //private static void CreateOrUpdateCrmGroupOrders(CrmServiceClient service, Questionnaire questionnaireData)
        //{
        //    try
        //    {
        //        Entity group = null;
        //        foreach (var order in questionnaireData.GroupOrders)
        //        {

        //            if (string.IsNullOrEmpty(order.Name)) continue;

        //            if (group == null || group.Attributes[keyName].ToString() != order.GroupName)
        //            {
        //                group = GetEntityUsingSimpleQuery(service, groupEntityName, keyName, order.GroupName);
        //            }

        //            var crmOrder = GetEntityUsingSimpleQuery(service, groupOrderEntityName, keyName, order.Name);

        //            var orderEntity = new Entity(groupOrderEntityName);

        //            if (crmOrder != null)
        //            {
        //                orderEntity.Id = crmOrder.Id;
        //            }
        //            else
        //            {
        //                orderEntity.Id = Guid.NewGuid();
        //            }

        //            MapGroupOrderDataToEntity(ref orderEntity, order);


        //            var responseDelimiterOptionSet = service.GetGlobalOptionSetMetadata("qm_responsedelimiter");
        //            if (order.ResponseDelimeter != null) orderEntity.Attributes["qm_responsedelimiter"] = new OptionSetValue(Convert.ToInt32(responseDelimiterOptionSet.Options.FirstOrDefault(e => e.Label.LocalizedLabels[0].Label == order.ResponseDelimeter).Value));


        //            CreateOrUpdateEntity(ref service, ref orderEntity, keyName, crmOrder == null);

        //            try
        //            {
        //                var entityReference = new List<EntityReference>();
        //                entityReference.Add(group.ToEntityReference());
        //                var entityReferenceCollection = new EntityReferenceCollection(entityReference);
        //                service.Associate(groupOrderEntityName, orderEntity.Id, new Relationship("qm_Qtn_Question_Group_Order_Group_qm_Ques"), entityReferenceCollection);
        //            }
        //            catch (Exception e)
        //            {
        //                HandleException(e);
        //            }
        //        }
        //    }
        //    catch (Exception e)
        //    {
        //        throw e;
        //    }
        //}



        public static string ExecuteQuestionnaireFetchXml(string fetch)
        {
            try
            {
                CrmServiceClient conn = Connect();

                //var fetchExpression = new FetchExpression(fetch);


                // Instantiate QueryExpression QEqm_sytemplate
                var QEqm_sytemplate = new QueryExpression("qm_sytemplate");
                QEqm_sytemplate.ColumnSet.AddColumns("qm_sytemplateid", "qm_name", "qm_templateenm", "qm_templatefnm", "qm_templatedescetxt", "qm_templatedescftxt");

                // Add link-entity QEqm_sytemplate_qm_sytemplate_sygroup
                var QEqm_sytemplate_qm_sytemplate_sygroup = QEqm_sytemplate.AddLink("qm_sytemplate_sygroup", "qm_sytemplateid", "qm_sytemplateid");
                QEqm_sytemplate_qm_sytemplate_sygroup.EntityAlias = "template_groups";

                // Add link-entity QEqm_sytemplate_qm_sytemplate_sygroup_qm_sygroup
                var QEqm_sytemplate_qm_sytemplate_sygroup_qm_sygroup = QEqm_sytemplate_qm_sytemplate_sygroup.AddLink("qm_sygroup", "qm_sygroupid", "qm_sygroupid", JoinOperator.LeftOuter);
                QEqm_sytemplate_qm_sytemplate_sygroup_qm_sygroup.EntityAlias = "groups";

                // Add columns to QEqm_sytemplate_qm_sytemplate_sygroup_qm_sygroup.Columns
                QEqm_sytemplate_qm_sytemplate_sygroup_qm_sygroup.Columns.AddColumns("qm_groupf", "qm_groupe", "qm_name", "qm_ordernbr", "qm_isvisibleind", "qm_sygroupid");

                // Add link-entity QEqm_sytemplate_qm_sytemplate_sygroup_qm_sygroup_qm_syquestion
                var QEqm_sytemplate_qm_sytemplate_sygroup_qm_sygroup_qm_syquestion = QEqm_sytemplate_qm_sytemplate_sygroup_qm_sygroup.AddLink("qm_syquestion", "qm_sygroupid", "qm_sygroupid");
                QEqm_sytemplate_qm_sytemplate_sygroup_qm_sygroup_qm_syquestion.EntityAlias = "questions";

                // Add columns to QEqm_sytemplate_qm_sytemplate_sygroup_qm_sygroup_qm_syquestion.Columns
                QEqm_sytemplate_qm_sytemplate_sygroup_qm_sygroup_qm_syquestion.Columns.AddColumns("qm_name", "qm_questione", "qm_questionf", "qm_ordernbr", "qm_isvisibleind", "qm_questionresponsetypecd", "qm_syquestionid", "qm_syquestionid_self");

                // Add link-entity QEqm_sytemplate_qm_sytemplate_sygroup_qm_sygroup_qm_syquestion_qm_syresponse
                var QEqm_sytemplate_qm_sytemplate_sygroup_qm_sygroup_qm_syquestion_qm_syresponse = QEqm_sytemplate_qm_sytemplate_sygroup_qm_sygroup_qm_syquestion.AddLink("qm_syresponse", "qm_syquestionid", "qm_syquestionid", JoinOperator.LeftOuter);
                QEqm_sytemplate_qm_sytemplate_sygroup_qm_sygroup_qm_syquestion_qm_syresponse.EntityAlias = "responses";

                // Add columns to QEqm_sytemplate_qm_sytemplate_sygroup_qm_sygroup_qm_syquestion_qm_syresponse.Columns
                QEqm_sytemplate_qm_sytemplate_sygroup_qm_sygroup_qm_syquestion_qm_syresponse.Columns.AddColumns("qm_name", "qm_syresponseid");

                EntityCollection fetchResult = conn.RetrieveMultiple(QEqm_sytemplate);

                var results = fetchResult.Entities.Select(row => new QuestionnaireFetchResult
                {
                    TemplateId         = row.GetValue<Guid>("qm_sytemplateid"),
                    TemplatePrimaryKey = row.GetValue<string>("qm_name"),
                    TemplateTitleEn    = row.GetValue<string>("qm_templateenm"),
                    TemplateTitleFr    = row.GetValue<string>("qm_templatefnm"),
                    //TemplateDescEtxt   = row.GetValue<string>("qm_templatedescetxt"),
                    //TemplateDescFtxt   = row.GetValue<string>("qm_templatedescftxt"),
                    GroupPrimaryKey    = row.GetFetchValue<string>("groups.qm_name"),
                    GroupTitleEn       = row.GetFetchValue<string>("groups.qm_groupe"),
                    GroupTitleFr       = row.GetFetchValue<string>("groups.qm_groupf"),
                    GroupOrder         = row.GetFetchValue<string>("groups.qm_ordernbr"),
                    GroupIsVisible     = row.GetFetchValue<string>("groups.qm_isvisibleind"),
                    GroupId            = row.GetFetchValue<Guid>("groups.qm_sygroupid"),
                    QuestionPrimaryKey = row.GetFetchValue<string>("questions.qm_name"),
                    QuestionTitleEn    = row.GetFetchValue<string>("questions.qm_questione"),
                    QuestionTitleFr    = row.GetFetchValue<string>("questions.qm_questionf"),
                    QuestionOrder      = row.GetFetchValue<string>("questions.qm_ordernbr"),
                    QuestionIsVisible  = row.GetFetchValue<string>("questions.qm_isvisibleind"),
                    QuestionType       = row.GetFetchValue<OptionSetValue>("questions.qm_questionresponsetypecd"), //OptionSetValue
                    QuestionId         = row.GetFetchValue<Guid>("questions.qm_syquestionid"),
                    QuestionParentId   = row.GetFetchValue<EntityReference>("questions.qm_syquestionid_self"),
                    ResponsePrimaryKey = row.GetFetchValue<string>("responses.qm_name"),
                    ResponseId         = row.GetFetchValue<Guid>("responses.qm_syresponseid")
                }).ToList();

                var template = ParseToTree(ref results);

                var json = Newtonsoft.Json.JsonConvert.SerializeObject(template);
                return json;

            }
            catch (Exception ex)
            {
                //handle the exception
                throw ex;
            }
        }

        private static Template ParseToTree(ref List<QuestionnaireFetchResult> results)
        {
            var template = results.Select(e => new Template { Id = new Guid(e.TemplateId), Name = e.TemplatePrimaryKey, TitleEnglish = e.TemplateTitleEn, TitleFrench = e.TemplateTitleFr, Groups = new List<Group>() }).Distinct().ToList();

            var groups = results.Select(e => new Group { Id = new  Guid(e.GroupId), Name = e.GroupPrimaryKey, TitleEnglish = e.GroupTitleEn, TitleFrench = e.GroupTitleFr, IsVisible = e.GroupIsVisible.ToBool(), SortOrder = e.GroupOrder.ToInt(), TemplateId = e.TemplateId, Questions = new List<Question>() }).Distinct().ToList();

            var questions = results.Select(e => new Question { Id = new Guid(e.QuestionId), Name = e.QuestionPrimaryKey, TextEnglish = e.QuestionTitleEn, TextFrench = e.QuestionTitleFr, Type = e.QuestionType, IsVisible = e.QuestionIsVisible.ToBool(), SortOrder = e.QuestionOrder.ToInt(), ParentQuestionId = e.QuestionParentId == null ? new Guid() : new Guid(e.QuestionParentId), GroupName = e.GroupPrimaryKey, GroupId = new Guid(e.GroupId) }).Distinct().ToList();

            var responses = results.Select(e => new Response { Id = new Guid(e.ResponseId), Name = e.ResponsePrimaryKey, QuestionId = new Guid(e.QuestionId) }).Distinct().ToList();

            for (int i = 0; i < questions.Count(); i++)
            {
                var question = questions[i];
                var questionResponses = responses.Where(e => e.QuestionId == question.Id);
                questions[i].Responses.AddRange(questionResponses);
            }

            for (int i = 0; i < groups.Count(); i++)
            {
                var group = groups[i];
                var groupQuestions = questions.Where(e => e.GroupId == group.Id);
                groups[i].Questions.AddRange(groupQuestions);   
            }

            template[0].Groups.AddRange(groups);

            return template[0];
        }

        public static void CreateOrUpdateCrmWithExcelData(ref CrmServiceClient service, Questionnaire questionnaireData)
        {
            try
            {
                //create or update the template data
                CreateOrUpdateCrmTemplate(service, questionnaireData);

                //create or update all the question group data for the template 
                CreateOrUpdateCrmQuestionGroup(service, questionnaireData);

                CreateOrUpdateCrmQuestions(service, questionnaireData);

                CreateOrUpdateCrmResponses(service, questionnaireData);

                //CreateOrUpdateCrmQuestionOrders(service, questionnaireData);

                //CreateOrUpdateCrmGroupOrders(service, questionnaireData);
            }
            catch (Exception ex)
            {
                //handle the exception
                throw ex;
            }
        }

        public static void DeleteQuestionnaireData(CrmServiceClient service)
        {
            DeleteTemplate(service);
        }

        private static void DeleteTemplate(CrmServiceClient service)
        {
            DeleteEntity(service, qm_sytemplate.EntityLogicalName, "qm_name");
            DeleteEntity(service, qm_sygroup.EntityLogicalName, "qm_name");
            DeleteEntity(service, qm_syquestion.EntityLogicalName, "qm_name");
            DeleteEntity(service, qm_syresponse.EntityLogicalName, "qm_name");
            DeleteEntity(service, qm_sydependencygroup.EntityLogicalName, "qm_name");
            DeleteEntity(service, qm_sydependencygroupitem.EntityLogicalName, "qm_name");
            DeleteEntity(service, qm_syquestionvalidationrule.EntityLogicalName, "qm_name");
        }

        #endregion


        #region LEGISLATION

        //static Entity Act        = null;
        //static Entity Regulation = null;
        //static Entity Standard   = null;
        static int OrderCount = 1;
        public static void DeleteLegislation(CrmServiceClient service)
        {
            DeleteEntity(service, "qm_rclegislation", "qm_rclegislationid");
        }

        public static string ExecuteLegislationFetchXml()
        {
            try
            {
                CrmServiceClient conn = Connect();

                #region queryexpression XRMToolbox
                // Instantiate QueryExpression QEqm_rclegislation
                var QEqm_rclegislation = new QueryExpression("qm_rclegislation");

                // Add columns to QEqm_rclegislation.ColumnSet
                QEqm_rclegislation.ColumnSet.AddColumns("qm_name", "qm_rclegislationid", "qm_rcparentlegislationid", "qm_justiceid", "qm_justicefid", "qm_inforcedte", "qm_lastamendeddte", "qm_ordernbr", "qm_legislationlbl", "qm_legislationetxt", "qm_legislationftxt");
                QEqm_rclegislation.AddOrder("qm_ordernbr", OrderType.Ascending);

                // Add link-entity QEqm_rclegislation_qm_tylegislationsource
                var QEqm_rclegislation_qm_tylegislationsource = QEqm_rclegislation.AddLink("qm_tylegislationsource", "qm_tylegislationsourceid", "qm_tylegislationsourceid", JoinOperator.LeftOuter);

                // Add columns to QEqm_rclegislation_qm_tylegislationsource.Columns
                QEqm_rclegislation_qm_tylegislationsource.Columns.AddColumns("qm_legislationsourceelbl", "qm_tylegislationsourceid", "qm_legislationsourceetxt", "qm_legislationsourceftxt", "qm_legislationsourceflbl");

                // Add link-entity QEqm_rclegislation_qm_tylegislationtype
                var QEqm_rclegislation_qm_tylegislationtype = QEqm_rclegislation.AddLink("qm_tylegislationtype", "qm_tylegislationtypeid", "qm_tylegislationtypeid", JoinOperator.LeftOuter);

                // Add columns to QEqm_rclegislation_qm_tylegislationtype.Columns
                QEqm_rclegislation_qm_tylegislationtype.Columns.AddColumns("qm_tylegislationtypeid", "qm_name");

                // Add link-entity QEqm_rclegislation_qm_rclegislation_tylegislationcharacterist
                var QEqm_rclegislation_qm_rclegislation_tylegislationcharacterist = QEqm_rclegislation.AddLink("qm_rclegislation_tylegislationcharacterist", "qm_rclegislationid", "qm_rclegislationid", JoinOperator.LeftOuter);

                // Add link-entity QEqm_rclegislation_qm_rclegislation_tylegislationcharacterist_qm_tylegislationcharacteristic
                var QEqm_rclegislation_qm_rclegislation_tylegislationcharacterist_qm_tylegislationcharacteristic = QEqm_rclegislation_qm_rclegislation_tylegislationcharacterist.AddLink("qm_tylegislationcharacteristic", "qm_tylegislationcharacteristicid", "qm_tylegislationcharacteristicid", JoinOperator.LeftOuter);

                // Add columns to QEqm_rclegislation_qm_rclegislation_tylegislationcharacterist_qm_tylegislationcharacteristic.Columns
                QEqm_rclegislation_qm_rclegislation_tylegislationcharacterist_qm_tylegislationcharacteristic.Columns.AddColumns("qm_name", "qm_legislationcharacteristicflbl", "qm_tylegislationcharacteristicid", "qm_legislationcharacteristicelbl");
                #endregion

                EntityCollection fetchResult = conn.RetrieveMultiple(QEqm_rclegislation);

                var results = new List<qm_rclegislation>();

                foreach (var row in fetchResult.Entities)
                {
                    var leg = new qm_rclegislation();
                    MapLegislationEntityToModel(ref leg, row);
                    results.Add(leg);
                }

                var regulation = ParseLegislationToTree(results);

                var json = Newtonsoft.Json.JsonConvert.SerializeObject(regulation);
                return json;

            }
            catch (Exception ex)
            {
                //handle the exception
                throw ex;
            }
        }

            private static Regulation ParseLegislationToTree(List<qm_rclegislation> results)
            {
                var legislationGrouped = results.Select(e => new Regulation {  
                    CrmId              = e.Id, 
                    AdditionalMetadata = e.qm_AdditionalMetadataEtxt, 
                    HistoricalNote     = e.qm_HistoricalNoteEtxt, 
                    InforceStartDate   = e.qm_InforceDte?.ToString("yyyy-M-d"), 
                    JusticeId          = e.qm_JusticeId?.ToString(), 
                    Label              = e.qm_LegislationLbl, 
                    LastAmendedDate    = e.qm_LastAmendedDte?.ToString("yyyy-M-d") ?? null, 
                    Order              = e.qm_OrderNbr ?? 0, 
                    TextEnglish        = e.qm_LegislationEtxt, 
                    ParentCrmId        = e.qm_rcParentLegislationId?.EntityId}
                ).Distinct().ToList();

                //var characteristics = results.Select(e => new
                //{
                //    e.qm_rclegislationId, 
                //    e.
                //})

                for (int i = 0; i < legislationGrouped.Count(); i++)
                {
                    var leg = legislationGrouped[i];

                    if (leg.ParentCrmId == null) continue;

                    var parent = legislationGrouped.FirstOrDefault(e => e.CrmId == leg.ParentCrmId);

                    parent.Children.Add(leg);
                }

                return legislationGrouped.FirstOrDefault(e => e.ParentCrmId == null);
            }

        public static void CreateOrUpdateLegislations(CrmServiceClient service, Regulation legData, int top = 0)
        {
            if (legData == null) throw new ArgumentNullException(nameof(legData));

            //get once
            //Regulation = GetEntityUsingSimpleQuery(service, "qm_legislationTypeCd", "qm_LegislationType", "TDG Regulations | Réglementation sur le TMD");

            var characteristics = GetAllCharacteristics(legData);

            var simple = characteristics.Where(e => bool.TryParse(e.Value?.ToString(), out _))
                                        .Select(e => e.Key)
                                        .Distinct();

            var unNumbers = characteristics.Where(e => e.Key == CONSTANTS.Constants.DataFlags_UNNumbers).
                                            Select(e => e.Value?.ToString().Split(',')).
                                            SelectMany(e => e).
                                            Distinct();

            CreateOrUpdateCharacteristics(service, simple.Union(unNumbers));

            OrderCount = 1; //reset the temp order
            RecursivelyUploadLegislation(ref service, legData, null, top);
        }

        static void CreateOrUpdateCharacteristics(CrmServiceClient service, IEnumerable<string> characteristics)
        {
            foreach (var c in characteristics)
            {
                var characteristic = new Entity(qm_tylegislationcharacteristic.EntityLogicalName);

                Entity existingChar = GetEntityUsingSimpleQuery(service, qm_tylegislationcharacteristic.EntityLogicalName, qm_tylegislationcharacteristic.Fields.qm_Name, c);

                if (existingChar != null)
                {
                    characteristic.Id = existingChar.Id;
                }
                else
                {
                    characteristic.Id = Guid.NewGuid();
                }

                characteristic[qm_tylegislationcharacteristic.Fields.qm_Name] = c;
                characteristic[qm_tylegislationcharacteristic.Fields.qm_legislationcharacteristicelbl] = c;
                characteristic[qm_tylegislationcharacteristic.Fields.qm_legislationcharacteristicflbl] = "FR_" + c;

                CreateOrUpdateEntity(ref service, ref characteristic, qm_tylegislationcharacteristic.Fields.qm_Name, existingChar == null);

                characteristicsHash.Add(new KeyValuePair<string, Guid>(c, characteristic.Id));
            }
        }

        static List<KeyValuePair<string,object>> GetAllCharacteristics(Regulation reg)
        {
            var flags = reg.DataFlags;

            foreach (var cr in reg.Children)
            {
                if (cr.Children.Count > 0)
                {
                    flags.AddRange(GetAllCharacteristics(cr));
                }
                else
                {
                    flags.AddRange(cr.DataFlags);
                }
            }

            return flags;
        }


        static Entity UploadLegislation(ref CrmServiceClient service, Regulation element, Entity parent = null)
        {
            var leg = new Entity(legislationEntityName);

            // check for existing
            Entity existingLeg = GetEntityUsingSimpleQuery(service, legislationEntityName, legKeyName, element.JusticeId);

            if (existingLeg != null) 
                leg.Id = existingLeg.Id;
            else 
                leg.Id = Guid.NewGuid();
            
            // add values
            MapLegislationDataToEntity(ref leg, element);

            // upsert
            CreateOrUpdateEntity(ref service, ref leg, legKeyName, existingLeg == null); //note use of justiceid for primary key name


            // associate parent if exists
            if (parent != null)
            {
                AssociateRequest(service, parent, leg, "qm_qm_rclegislation_qm_rclegislation");
            }


            //if there is no label, and there is no text, then we don't really need to associate to characteristics
            //avoids huge loop for the tree top node
            if (!(string.IsNullOrEmpty(element.Label) && string.IsNullOrEmpty(element.TextEnglish)))
            {
                // associate any characteristics
                foreach (var c in element.DataFlags)
                {
                    var ch = characteristicsHash.FirstOrDefault(e => e.Key == c.Key);
                    if (!string.IsNullOrEmpty(ch.Key))
                    {
                        if (Associated(service, qm_rclegislation.PrimaryIdAttribute, leg.Id, qm_tylegislationcharacteristic.PrimaryIdAttribute, ch.Value, "qm_rclegislation_tylegislationcharacterist"))
                        {
                            continue;
                        }

                        AssociateWithId(ch.Value, service, leg, qm_tylegislationcharacteristic.EntityLogicalName, qm_tylegislationcharacteristic.PrimaryIdAttribute, "qm_rclegislation_tylegislationcharacteristic");
                    }
                }
            }


            // associate correct leg type
            Guid legType = new Guid();
            if (element.Type.ToUpper() == "SECTION")      legType = LegislationTypeSection;
            if (element.Type.ToUpper() == "SUBSECTION")   legType = LegislationTypeSubsection;
            if (element.Type.ToUpper() == "PARAGRAPH")    legType = LegislationTypeParagraph;
            if (element.Type.ToUpper() == "SUBPARAGRAPH") legType = LegislationTypeSubparagraph;
            if (element.Type.ToUpper() == "CLAUSE")       legType = LegislationTypeClause;
            if (element.Type.ToUpper() == "SCHEDULE")     legType = LegislationTypeSchedule;
            if (element.Type.ToUpper() == "APPENDIX")     legType = LegislationTypeAppendix;
            if (element.Type.ToUpper() == "BODY")         legType = LegislationTypeBody;
            if (element.Type.ToUpper() == "HEADING")      legType = LegislationTypeHeading;

            if (legType.CompareTo(default) != 0)
                AssociateWithId(legType, service, leg, qm_tylegislationtype.EntityLogicalName, qm_tylegislationtype.PrimaryIdAttribute, "qm_tylegislationtype_rclegislation");


            // associate to legislation source = TDG Regs
            AssociateWithId(new Guid("b4033f0d-6820-eb11-a813-000d3af3ac0d"), service, leg, qm_tylegislationsource.EntityLogicalName,qm_tylegislationsource.PrimaryIdAttribute, "qm_tylegislationsource_rclegislation");

            OrderCount++;

            return leg;
        }

        static Guid LegislationTypeSection      = new Guid("0d256aab-6720-eb11-a813-000d3af3ac0d");
        static Guid LegislationTypeSubsection   = new Guid("0e256aab-6720-eb11-a813-000d3af3ac0d");
        static Guid LegislationTypeParagraph    = new Guid("38a28fb1-6720-eb11-a813-000d3af3ac0d");
        static Guid LegislationTypeSubparagraph = new Guid("b5a38fb1-6720-eb11-a813-000d3af3ac0d");
        static Guid LegislationTypeClause       = new Guid("b56cb0b7-6720-eb11-a813-000d3af3ac0d");
        static Guid LegislationTypeSchedule     = new Guid("cab778c0-6720-eb11-a813-000d3af3ac0d");
        static Guid LegislationTypeAppendix     = new Guid("cdb778c0-6720-eb11-a813-000d3af3ac0d");
        static Guid LegislationTypeBody         = new Guid("b1015ef4-d729-eb11-a813-000d3af3a7a7");
        static Guid LegislationTypeHeading      = new Guid("1829d66a-962b-eb11-a813-000d3af3fc19");

        static HashSet<KeyValuePair<string, Guid>> characteristicsHash = new HashSet<KeyValuePair<string, Guid>>();

        private static void AssociateWithId(Guid id, CrmServiceClient service, Entity primaryEntity, string associatedEntityName, string associatedEntityIdFieldName, string relationshipName)
        {
            var associatedEntity = new Entity(associatedEntityName, associatedEntityIdFieldName, id)
            {
                Id = id
            };

            Associate(service, primaryEntity, relationshipName, associatedEntity);
        }

        static void Associate(CrmServiceClient service, Entity entity1, string relationshipLogicalName, Entity entity2)
        {
            //associate legislation to XREF
            var entityReferenceCollection = new EntityReferenceCollection(new List<EntityReference>
            {
                entity2.ToEntityReference()
            });

            service.Associate(entity1.LogicalName, entity1.Id, new Relationship(relationshipLogicalName), entityReferenceCollection);

            Console.WriteLine($"new associated between {entity1.LogicalName}({entity1.Id}) and {entity2.LogicalName}({entity2.Id}) created");
        }

        static bool Associated(CrmServiceClient service, string entity1KeyName, Guid entity1Id, string entity2KeyName, Guid entity2Id, string relationshipLogicalName)
        {
            try
            {
                var rel = new QueryExpression(relationshipLogicalName);

                rel.ColumnSet.AllColumns = true;

                // Define filter
                rel.Criteria.AddCondition(entity1KeyName, ConditionOperator.Equal, entity1Id);
                rel.Criteria.AddCondition(entity2KeyName, ConditionOperator.Equal, entity2Id);

                EntityCollection fetchResult = service.RetrieveMultiple(rel);

                var associated = fetchResult.Entities.Count > 0;


                if (associated)
                {
                    Console.WriteLine($"relationship {relationshipLogicalName} between {entity1KeyName}({entity1Id}) and {entity2KeyName}({entity2Id}) already exists.");
                }


                return associated;
            }
            catch (Exception ex)
            {
                //handle the exception
                throw ex;
            }
        }

        static OrganizationResponse AssociateRequest(CrmServiceClient service, Entity entity1, Entity entity2, string relationshipLogicalName)
        {
            AssociateRequest associateRequest = new AssociateRequest();
            associateRequest.Target = new EntityReference(entity1.LogicalName, entity1.Id);
            associateRequest.RelatedEntities = new EntityReferenceCollection();
            associateRequest.RelatedEntities.Add(new EntityReference(entity2.LogicalName, entity2.Id));
            associateRequest.Relationship = new Relationship(relationshipLogicalName);
            associateRequest.Relationship.PrimaryEntityRole = EntityRole.Referenced;

            return service.Execute(associateRequest);
        }

        static void RecursivelyUploadLegislation(ref CrmServiceClient service, Regulation element, Entity parent = null, int top = 0)
        {
            if (top != 0 && OrderCount > top) return;

            if (element.Children != null && element.Children.Where(e => CONSTANTS.Constants.RegTypes.Contains(e.Type) || e.Type == "Body").Count() > 0)
            {
                var newParent = UploadLegislation(ref service, element, parent);

                foreach (var child in element.Children)
                {
                    RecursivelyUploadLegislation(ref service, child, newParent, top);
                }
            }
            else
            {
                UploadLegislation(ref service, element, parent);
            }
        }

        #endregion


        #region COMMON


        #region QUERY
        private static QueryExpression GetSimpleEntityQuery(string entityName, string keyName, string keyValue)
        {
            return new QueryExpression
            {
                EntityName = entityName,
                ColumnSet = new ColumnSet(true),
                Criteria = new FilterExpression
                {
                    FilterOperator = LogicalOperator.And,
                    Conditions =
                    {
                        new ConditionExpression
                        {
                            AttributeName = keyName,
                            Operator = ConditionOperator.Equal,
                            Values = { keyValue }
                        }
                    }
                },
            };
        }
        private static QueryExpression XrefEntityQuery(string xrefTableName, string keyName, Guid keyValue, string key2Name, Guid key2Value)
        {
            return new QueryExpression
            {
                EntityName = xrefTableName,
                ColumnSet = new ColumnSet(true),
                Criteria = new FilterExpression
                {
                    FilterOperator = LogicalOperator.And,
                    Conditions =
                    {
                        new ConditionExpression
                        {
                            AttributeName = keyName,
                            Operator = ConditionOperator.Equal,
                            Values = { keyValue }
                        },
                        new ConditionExpression
                        {
                            AttributeName = key2Name,
                            Operator = ConditionOperator.Equal,
                            Values = { key2Value }
                        }
                    }
                },
            };
        }

        private static Entity GetEntityUsingXrefEntityQuery(CrmServiceClient service, string xrefTableName, string idFieldName, Guid id, string id2FieldName, Guid id2)
        {
            var questionnaireQuery = XrefEntityQuery(xrefTableName, idFieldName, id, id2FieldName, id2);
            var queryResult = service?.RetrieveMultiple(questionnaireQuery);

            if (queryResult == null || questionnaireQuery == null)
            {
                throw new NullReferenceException($"did not find a matching entity when trying to delete {xrefTableName}");
            }

            if (queryResult.Entities.Count > 0)
            {
                var firstMatch = queryResult.Entities[0];

                return firstMatch;
            }

            return null;
        }

        private static QueryExpression GetAllEntityQuery(string entityName)
        {
            return new QueryExpression
            {
                EntityName = entityName,
                ColumnSet = new ColumnSet(true)
            };
        }

        private static Entity GetEntityUsingSimpleQuery(CrmServiceClient service, string entityName, string keyName, string keyValue)
        {
            var questionnaireQuery = GetSimpleEntityQuery(entityName, keyName, keyValue);
            var queryResult = service?.RetrieveMultiple(questionnaireQuery);

            if (queryResult == null || questionnaireQuery == null)
            {
                throw new NullReferenceException($"did not find a matching entity when trying to delete {entityName}");
            }

            if (queryResult.Entities.Count > 0)
            {
                var firstMatch = queryResult.Entities[0];

                return firstMatch;
            }

            return null;
        }
        #endregion

        public static string GetFetchValue<T>(this Entity row, string attribute)
        {
            var aliasVal = GetAliasedValue<T>(row, attribute);

            if (aliasVal == null)
            {
                var val = GetValue<T>(row, attribute);
                if (val == null) return null;
                return val.ToString();
            }

            return aliasVal.ToString();
        }

        public static string GetAliasedValue<T>(this Entity row, string attribute)
        {
            var alias = row.GetAttributeValue<AliasedValue>(attribute);

            if (alias == null) return null;
;
            Type type = typeof(T);
            if (type == typeof(OptionSetValue))
            {
                var option = (OptionSetValue)alias.Value;
                return option.Value.ToString();
            }
            if (type == typeof(EntityReference))
            {
                var entityId = ((EntityReference)alias.Value).Id;
                return entityId.ToString();
            }

            return alias.Value.ToString();
        }

        public static string GetValue<T>(this Entity row, string attribute)
        {
            var alias = row.GetAttributeValue<T>(attribute);

            if (alias == null)
            {
                var t = typeof(T);
                var isNullable = Nullable.GetUnderlyingType(t) != null;

                return null;
            }

            Type tType = typeof(T);
            if (tType == typeof(DateTime))
            {
                object temp = alias;
                return ((DateTime)temp).ToString("yyyy-MM-dd HH:mm:ss");
            }
            if (tType == typeof(DateTime?))
            {
                object temp = alias;
                return ((DateTime?)temp).Value.ToString("yyyy-MM-dd HH:mm:ss");
            }

            return alias.ToString();
        }

        public static int GetInt(this Entity row, string attribute)
        {
            var alias = row.GetAttributeValue<int>(attribute);

            int.TryParse(alias.ToString(), out int result);

            return result;
        }

        /// <summary>
        /// Checks whether the current environment will support this sample.
        /// </summary>
        /// <param name="service">The service to use to check the version. </param>
        /// <param name="minVersion">The minimum version.</param>
        /// <returns>true when the version is higher than the minimum verions, otherwise false.</returns>
        public static bool CheckVersion(CrmServiceClient service, Version minVersion)
        {
            if (service?.ConnectedOrgVersion.CompareTo(minVersion) >= 0)
            {
                return true;
            }
            else
            {
                Console.WriteLine("This sample cannot be run against the current version.");
                Console.WriteLine($"Upgrade your instance to a version above {minVersion?.ToString()} to run this sample.");
                return false;
            }
        }


        public static void OutputAllEntityMetadata(CrmServiceClient service)
        {
            if (service == null) throw new ArgumentNullException(nameof(service));

            var entities = service.GetAllEntityMetadata(true, Microsoft.Xrm.Sdk.Metadata.EntityFilters.Entity);
            entities = entities.OrderBy(e => e.LogicalName).ToList();

            Console.WriteLine("the following entities exist in this organization");
            foreach (var item in entities)
            {
                Console.WriteLine($"logical: {item.LogicalName}     physical: {item.DisplayName?.UserLocalizedLabel?.Label}");
            }
        }

        private static void CreateOrUpdateEntity(ref CrmServiceClient service, ref Entity entity, string keyName, bool isNew = false)
        {
            if (isNew)
            {
                Guid newEntityId = service.Create(entity);
                entity.Id = newEntityId;
                Console.WriteLine("Created {0} entity named {1} with GUID {2}.", entity.LogicalName, entity.Attributes.Contains(keyName) ? entity.Attributes[keyName] : entity.Id, newEntityId);
            }
            else
            {
                service.Update(entity);

                Console.WriteLine("Existing {0} entity named {1} updated.", entity.LogicalName, entity.Attributes.Contains(keyName) ? entity.Attributes[keyName] : entity.Id);
            }
        }

        /// <summary>
        /// Imports a solution if it is not already installed.
        /// </summary>
        /// <param name="service">The service to use to import the solution. </param>
        /// <param name="uniqueName">The unique name of the solution to install.</param>
        /// <param name="pathToFile">The path to the solution file.</param>
        /// <returns>true if the solution was installed, otherwise false.</returns>
        public static bool ImportSolution(CrmServiceClient service, string uniqueName, string pathToFile)
        {
            if (service == null) throw new ArgumentNullException(nameof(service));

            QueryByAttribute queryCheckForSampleSolution = new QueryByAttribute();
            queryCheckForSampleSolution.AddAttributeValue("uniquename", uniqueName);
            queryCheckForSampleSolution.EntityName = "solution";

            EntityCollection querySampleSolutionResults = service.RetrieveMultiple(queryCheckForSampleSolution);

            if (querySampleSolutionResults.Entities.Count > 0)
            {
                Console.WriteLine("The {0} solution is already installed.", uniqueName);

                return false;
            }
            else
            {
                Console.WriteLine("The {0} solution is not installed. Importing the solution....", uniqueName);
                service.ImportSolutionToCrm(pathToFile, out _);
                return true;
            }
        }
        /// <summary>
        /// Prompts user to delete solution. Deletes solution if they choose.
        /// </summary>
        /// <param name="service">The service to use to delete the solution. </param>
        /// <param name="uniqueName">The unique name of the solution to delete.</param>
        /// <returns>true when the solution was deleted, otherwise false.</returns>
        public static bool DeleteSolution(CrmServiceClient service, string uniqueName)
        {
            Console.WriteLine("Do you want to delete the {0} solution? (y/n)", uniqueName);
            string answer = Console.ReadLine();

            bool deleteSolution = answer.StartsWith("y") || answer.StartsWith("Y");
            if (deleteSolution)
            {
                Console.WriteLine("Deleting the {0} solution....", uniqueName);
                QueryExpression solutionQuery = new QueryExpression
                {
                    EntityName = "solution",
                    ColumnSet = new ColumnSet(new string[] { "solutionid", "friendlyname" }),
                    Criteria = new FilterExpression()
                };
                solutionQuery.Criteria.AddCondition("uniquename", ConditionOperator.Equal, uniqueName);


                Entity solution = service.RetrieveMultiple(solutionQuery).Entities[0];

                if (solution != null)
                {
                    service.Delete("solution", (Guid)solution["solutionid"]);

                    Console.WriteLine("Deleted the {0} solution.", solution["friendlyname"]);
                    return true;
                }
                else
                {
                    Console.WriteLine("No solution named {0} is installed.");
                }
            }
            return false;
        }
        /// <summary>
        /// A function to manage exceptions thrown by console application samples
        /// </summary>
        /// <param name="exceptionFromSample">The exception thrown</param>
        public static void HandleException(Exception exceptionFromSample)
        {
            Console.WriteLine("The application terminated with an error.");

            try
            {
                throw exceptionFromSample;
            }
            catch (FaultException<OrganizationServiceFault> fe)
            {
                Console.WriteLine("Timestamp: {0}", fe.Detail.Timestamp);
                Console.WriteLine("Code: {0}", fe.Detail.ErrorCode);
                Console.WriteLine("Message: {0}", fe.Detail.Message);
                Console.WriteLine("Plugin Trace: {0}", fe.Detail.TraceText);
                Console.WriteLine("Inner Fault: {0}",
                    null == fe.Detail.InnerFault ? "No Inner Fault" : "Has Inner Fault");
            }
            catch (TimeoutException te)
            {
                Console.WriteLine("Message: {0}", te.Message);
                Console.WriteLine("Stack Trace: {0}", te.StackTrace);
                Console.WriteLine("Inner Fault: {0}",
                te.InnerException.Message ?? "No Inner Fault");

            }
            catch (Exception ex)
            {
                // Display the details of the inner exception.
                if (ex.InnerException != null)
                {
                    Console.WriteLine(ex.InnerException.Message);

                    if (ex.InnerException is FaultException<OrganizationServiceFault> fe)
                    {
                        Console.WriteLine("Timestamp: {0}", fe.Detail.Timestamp);
                        Console.WriteLine("Code: {0}", fe.Detail.ErrorCode);
                        Console.WriteLine("Message: {0}", fe.Detail.Message);
                        Console.WriteLine("Plugin Trace: {0}", fe.Detail.TraceText);
                        Console.WriteLine("Inner Fault: {0}",
                            null == fe.Detail.InnerFault ? "No Inner Fault" : "Has Inner Fault");
                    }
                }
            }

        }

        public static CrmServiceClient Connect()
        {
            // Try to create via connection string. 
            var service = new CrmServiceClient("AuthType=ClientSecret; url=https://rom-dev-tcd365.crm3.dynamics.com; ClientId=a6adc57f-f130-4e0e-8cab-c0d6a26f8273; ClientSecret=Hi7_X5DvnZf.j0._3mnPWKCu.KRA2~2.2b");

            return service;
        }

        public static void DeleteEntity(CrmServiceClient service, string entityName, string keyName)
        {
            try
            {
                var questionnaireQuery = GetAllEntityQuery(entityName);
                var queryResult = service?.RetrieveMultiple(questionnaireQuery);

                if (queryResult == null || questionnaireQuery == null)
                {
                    throw new NullReferenceException($"did not find a matching entity when trying to delete {entityName}");
                }

                foreach (var entity in queryResult.Entities)
                {
                    if (entity != null)
                    {
                        service.DeleteEntity(entityName, entity.Id);

                        Console.WriteLine("Deleted {0} entity named {1} with GUID {2}.", entity.LogicalName, entity.Attributes[keyName], entity.Id);
                    }
                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        #endregion


        #region Data Mappings


        #region QUESTIONNAIRE
        // static string DefaultHtmlSuffix = "#001"; removed

        private static void MapResponseDataToEntity(ref Entity responseEntity, Response response)
        {
            //responseEntity.Attributes["tc_controlinputid"]          = response.ControlInputId;
            //responseEntity.Attributes["qm_controlinputname"] = response.ControlInputName;
            //responseEntity.Attributes[qm_syresponse.Fields.Id] = response.Id;
            responseEntity.Attributes[qm_syresponse.Fields.qm_name] = response.Name;
            //responseEntity.Attributes[qm_syresponse.Fields.qm_syresponseId] = response.Id;
            //responseEntity.Attributes[qm_syresponse.Fields.qm_SYQuestionId] = response.QuestionId;
            responseEntity.Attributes[qm_syresponse.Fields.qm_SYQuestionIdName] = response.QuestionName;

            //responseEntity.Attributes[qm_syresponse.Fields.qm_SYQuestionIdName] = response.QuestionName;
            //responseEntity.Attributes[qm_syresponse.Fields._qm_SYQuestionId_value] = response.QuestionCrmId;
            //responseEntity.Attributes["qm_order"] = response.SortOrder;
            //responseEntity.Attributes[qm_syresponse.Fields.qm_syresponseId] = response.CrmId;
        }
        private static void MapTemplateDataToEntity(ref Entity templateEntity, Template template)
        {
            //templateEntity.Attributes["qm_TemplateDescEtxt"] = template.DescriptionEnglish;
            templateEntity.Attributes[qm_sytemplate.Fields.qm_TemplateE] = template.TitleEnglish;
            //templateEntity.Attributes["qm_TemplateDescFtxt"] = template.DescriptionFrench;
            templateEntity.Attributes[qm_sytemplate.Fields.qm_TemplateF] = template.TitleFrench;
            templateEntity.Attributes[qm_sytemplate.Fields.qm_name] = template.Name;
        }

        private static void MapQuestionGroupDataToEntity(ref Entity groupEntity, Group group)
        {
            groupEntity.Attributes[qm_sygroup.Fields.qm_GroupE] = group.TitleEnglish;
            groupEntity.Attributes[qm_sygroup.Fields.qm_GroupF] = group.TitleFrench;
            //groupEntity.Attributes[qm_sygroup.Fields.] = group.IsRepeatable;
            groupEntity.Attributes["qm_name"] = group.Name;

            //TODO: Group Model
            //sort order
            groupEntity.Attributes[qm_sygroup.Fields.qm_OrderNbr] = group.SortOrder;
            //isVisible
            groupEntity.Attributes[qm_sygroup.Fields.qm_IsVisibleInd] = group.IsVisible;
        }
        private static void MapQuestionDataToEntity(ref Entity questionEntity, Question question)
        {
            questionEntity.Attributes[qm_syquestion.Fields.qm_QuestionE]           = question.TextEnglish;
            questionEntity.Attributes[qm_syquestion.Fields.qm_QuestionF]           = question.TextFrench;
            questionEntity.Attributes["qm_name"]                                   = question.Name;
            questionEntity.Attributes[qm_syquestion.Fields.qm_QuestionTypeCd]      = new OptionSetValue(Convert.ToInt32("930840000"));
            questionEntity.Attributes[qm_syquestion.Fields.qm_OrderNbr]            = question.SortOrder;
            questionEntity.Attributes[qm_syquestion.Fields.qm_IsVisibleInd]        = question.IsVisible;
        }

        #endregion


        #region LEGISLATION

        private static void MapLegislationMetaData(ref qm_rclegislation leg, Entity legEntity)
        {
            leg.qm_LegislationLbl = legEntity.GetValue<string>("qm_legislationlbl");
            leg.qm_InforceDte = legEntity.GetValue<DateTime?>("qm_inforcedte").ToDateTime();
            leg.qm_LastAmendedDte = legEntity.GetValue<DateTime?>("qm_lastamendeddte").ToDateTime();
            leg.qm_JusticeId = legEntity.GetValue<int?>("qm_justiceid").ToNullableInt();
            leg.qm_LegislationEtxt = legEntity.GetValue<string>("qm_legislationetxt");
            leg.qm_LegislationFtxt = legEntity.GetValue<string>("qm_legislationftxt");
            leg.qm_OrderNbr = legEntity.GetValue<int?>("qm_ordernbr").ToNullableInt();
            leg.qm_JusticeFId = legEntity.GetValue<int?>("qm_justicefid").ToNullableInt();
            leg.qm_HistoricalNoteEtxt = legEntity.GetValue<string>("qm_historicalnoteetxt");
            leg.qm_HistoricalNoteFtxt = legEntity.GetValue<string>("qm_historicalnoteftxt");
            leg.qm_AdditionalMetadataEtxt = legEntity.GetValue<string>("qm_additionalmetadataetxt");
            leg.qm_AdditionalMetadataFtxt = legEntity.GetValue<string>("qm_additionalmetadataftxt");
            leg.qm_name = legEntity.GetValue<string>("qm_name");
            leg.Id = legEntity.Id;
        }

        private static void MapLegislationDataToEntity(ref Entity legEntity, Regulation reg)
        {
            var leg = reg.ConvertToTCModel();

            legEntity.Attributes["qm_legislationlbl"]         = leg.qm_LegislationLbl;
            legEntity.Attributes["qm_inforcedte"]             = leg.qm_InforceDte;
            legEntity.Attributes["qm_lastamendeddte"]         = leg.qm_LastAmendedDte;
            legEntity.Attributes["qm_justiceid"]              = leg.qm_JusticeId;
            legEntity.Attributes["qm_legislationetxt"]        = leg.qm_LegislationEtxt;
            legEntity.Attributes["qm_legislationftxt"]        = leg.qm_LegislationFtxt;
            legEntity.Attributes["qm_ordernbr"]               = leg.qm_OrderNbr;
            legEntity.Attributes["qm_justicefid"]             = leg.qm_JusticeFId;
            legEntity.Attributes["qm_historicalnoteetxt"]     = leg.qm_HistoricalNoteEtxt;
            legEntity.Attributes["qm_historicalnoteftxt"]     = leg.qm_HistoricalNoteFtxt;
            legEntity.Attributes["qm_additionalmetadataetxt"] = leg.qm_AdditionalMetadataEtxt;
            legEntity.Attributes["qm_additionalmetadataftxt"] = leg.qm_AdditionalMetadataFtxt;
            // legEntity.Attributes["qm_rcparentlegislationid"]  = leg.qm_rcParentLegislationId != null ? new EntityReference (leg.qm_rcParentLegislationId.EntitySetName, leg.qm_rcParentLegislationId.EntityId) : null;
            legEntity.Attributes["qm_name"]                   = leg.qm_name;
        }

        private static void MapLegislationEntityToModel (ref qm_rclegislation leg, Entity legEntity)
        {
             leg.qm_LegislationLbl         = legEntity.GetValue<string>("qm_legislationlbl");    
             leg.qm_InforceDte             = legEntity.GetValue<DateTime?>("qm_inforcedte").ToDateTime();
             leg.qm_LastAmendedDte         = legEntity.GetValue<DateTime?>("qm_lastamendeddte").ToDateTime();          
             leg.qm_JusticeId              = legEntity.GetValue<int?>("qm_justiceid").ToNullableInt(); 
             leg.qm_LegislationEtxt        = legEntity.GetValue<string>("qm_legislationetxt"); 
             leg.qm_LegislationFtxt        = legEntity.GetValue<string>("qm_legislationftxt");
             leg.qm_OrderNbr               = legEntity.GetValue<int?>("qm_ordernbr").ToNullableInt();
             leg.qm_JusticeFId             = legEntity.GetValue<int?>("qm_justicefid").ToNullableInt();
             leg.qm_HistoricalNoteEtxt     = legEntity.GetValue<string>("qm_historicalnoteetxt");        
             leg.qm_HistoricalNoteFtxt     = legEntity.GetValue<string>("qm_historicalnoteftxt");       
             leg.qm_AdditionalMetadataEtxt = legEntity.GetValue<string>("qm_additionalmetadataetxt"); 
             leg.qm_AdditionalMetadataFtxt = legEntity.GetValue<string>("qm_additionalmetadataftxt");
             leg.qm_name                   = legEntity.GetValue<string>("qm_name");
             leg.Id                        = legEntity.Id;

            if (legEntity.Attributes.ContainsKey("qm_rcparentlegislationid")){
                var entityRef = legEntity.GetAttributeValue<EntityReference>("qm_rcparentlegislationid");
                leg.qm_rcParentLegislationId = new TC.Legislation.EarlyBound.EntityReference(qm_rclegislation.EntitySetName, entityRef.Id);
            }
        }

        #endregion

        #endregion


    }
}
