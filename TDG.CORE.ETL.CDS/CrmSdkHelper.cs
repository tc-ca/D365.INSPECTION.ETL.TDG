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

namespace TDG.CORE.ETL.CDS
{
    public static class CrmSdkHelper
    {
        private const string templateEntity = "tc_questionnaire_template";
        static string legislationEntityName = "tc_legislation";
        static string groupEntityName = "tc_questionnaire_questions_group";
        static string questionEntityName = "tc_questionnaire_question";
        static string responseEntityName = "tc_questionnaire_question_response";
        //static string questionOrderEntityName = "tc_qtn_question_order";
        //static string groupOrderEntityName = "tc_qtn_question_group_order";
        static string keyName = "tc_name";
        static string legKeyName = "tc_legislationidentifier";


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

            string entityName = templateEntity;
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

            var crmTemplate = GetEntityUsingSimpleQuery(service, templateEntity, keyName, questionnaireData.Template.Name);

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

                //service.Associate(groupEntityName, group.Id, new Relationship("tc_Template_Questions_Group"), entityReferenceCollection);

                service.CreateEntityAssociation(groupEntityName, group.Id, crmTemplate.LogicalName, crmTemplate.Id, "tc_Template_Questions_Group");
            }
        }

        private static void CreateOrUpdateCrmQuestions(CrmServiceClient service, Questionnaire questionnaireData)
        {
            Entity group = null;

            foreach (var question in questionnaireData.Questions)
            {
                if (question.Name == null) continue;
                if (group == null || group.Attributes[keyName].ToString() != question.Name)
                {
                    group = GetEntityUsingSimpleQuery(service, groupEntityName, keyName, question.Name);
                }

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

                var entityReference = new List<EntityReference>
                {
                    group.ToEntityReference()
                };
                var entityReferenceCollection = new EntityReferenceCollection(entityReference);

                //service.Associate(questionEntityName, questionEntity.Id, new Relationship("tc_Questions_Group_Question"), entityReferenceCollection);

                service.CreateEntityAssociation(questionEntityName, questionEntity.Id, groupEntityName, group.Id, "tc_Questions_Group_Question");
            }
        }

        private static void CreateOrUpdateCrmResponses(CrmServiceClient service, Questionnaire questionnaireData)
        {
            var keyName = "tc_name";

            var requirementOptionSet = service.GetGlobalOptionSetMetadata("tc_qtn_field_requirement");
            var problemOptionSet     = service.GetGlobalOptionSetMetadata("tc_qtn_problem_type");
            var safetyOptionSet      = service.GetGlobalOptionSetMetadata("tc_qtn_safety_type");

            var optional      = requirementOptionSet.Options.FirstOrDefault(e => e.Label.LocalizedLabels[0].Label == "Optional").Value;
            var required      = requirementOptionSet.Options.FirstOrDefault(e => e.Label.LocalizedLabels[0].Label == "Required").Value;
            var notApplicable = requirementOptionSet.Options.FirstOrDefault(e => e.Label.LocalizedLabels[0].Label == "Not Applicable").Value;

            var YesProblem  = problemOptionSet.Options.FirstOrDefault(e => e.Label.LocalizedLabels[0].Label == "Problem - Yes").Value;
            var NoProblem   = problemOptionSet.Options.FirstOrDefault(e => e.Label.LocalizedLabels[0].Label == "Problem - No").Value;
            var NearProblem = problemOptionSet.Options.FirstOrDefault(e => e.Label.LocalizedLabels[0].Label == "Problem - Near").Value;

            var YesSafety = safetyOptionSet.Options.FirstOrDefault(e => e.Label.LocalizedLabels[0].Label == "Safety - Yes").Value;
            var NoSafety  = safetyOptionSet.Options.FirstOrDefault(e => e.Label.LocalizedLabels[0].Label == "Safety - No").Value;

            Entity question = null;

            foreach (var response in questionnaireData.QuestionResponses)
            {
                if (response.Name == null) continue;
                if (question == null || question.Attributes[keyName].ToString() != response.QuestionId)
                {
                    question = GetEntityUsingSimpleQuery(service, questionEntityName, keyName, response.QuestionId);

                    if (question == null)
                    {
                        Console.WriteLine("question is null!");
                    }
                }

                var crmResponse = GetEntityUsingSimpleQuery(service, responseEntityName, keyName, response.Name);

                var responseEntity = new Entity(responseEntityName);

                if (crmResponse != null)
                {
                    responseEntity.Id = crmResponse.Id;
                }
                else
                {
                    responseEntity.Id = Guid.NewGuid();
                }

                MapResponseDataToEntity(ref responseEntity, response);


                if (response.Picture == "0" || response.Picture == "1")
                {
                    bool isRequired = response.Picture == "1";

                    //TODO add child question for picture
                }

                if (response.ExternalComment == "0" || response.ExternalComment == "1")
                {
                    bool isRequired = response.ExternalComment == "1";

                    //TODO add child question for ExternalComment
                }

                if (response.InternalComment == "0" || response.InternalComment == "1")
                {
                    bool isRequired = response.InternalComment == "1";

                    //TODO add child question for InternalComment
                }

                responseEntity.Attributes["tc_isproblem"] = new OptionSetValue(Convert.ToInt32(response.IsProblem == "0" ? NoProblem : response.IsProblem == "1" ? YesProblem : NearProblem));
                responseEntity.Attributes["tc_issafetyconcern"] = new OptionSetValue(Convert.ToInt32(response.IsSafetyConcern == "0" ? NoSafety : response.IsSafetyConcern == "1" ? YesSafety : NoSafety));

                //responseEntity.Attributes["tc_picture"] = new OptionSetValue(Convert.ToInt32(response.Picture == "0" ? optional : response.Picture == "1" ? required : notApplicable));
                //responseEntity.Attributes["tc_externalcomment"] = new OptionSetValue(Convert.ToInt32(response.ExternalComment == "0" ? optional : response.ExternalComment == "1" ? required : notApplicable));
                //responseEntity.Attributes["tc_internalcomment"] = new OptionSetValue(Convert.ToInt32(response.InternalComment == "0" ? optional : response.InternalComment == "1" ? required : notApplicable));
                //responseEntity.Attributes["tc_displayingroupheader"] = response.GroupAlternateKey == "0" ? false : true;

                CreateOrUpdateEntity(ref service, ref responseEntity, keyName, crmResponse == null);

                var entityReference = new List<EntityReference>
                {
                    question.ToEntityReference()
                };
                var entityReferenceCollection = new EntityReferenceCollection(entityReference);

                service.Associate(responseEntityName, responseEntity.Id, new Relationship("tc_Questionnaire_Question_tc_Questionnair"), entityReferenceCollection);

                //associate input control type to lookup value

                //Entity responseInputType = GetEntityUsingSimpleQuery(service, "tc_questionnaire_question_response_input", keyName, response.ControlInputType);
                //entityReference = new List<EntityReference>();
                //entityReference.Add(responseInputType.ToEntityReference());
                //entityReferenceCollection = new EntityReferenceCollection(entityReference);
                //service.Associate(responseEntityName, responseEntity.Id, new Relationship("tc_Questionnaire_Question_Response_Contro"), entityReferenceCollection);

                //AssociateResponseWithLegislation(service, response, responseEntity);
            }
        }

        private static void AssociateResponseWithLegislation(CrmServiceClient service, QuestionResponseOption response, Entity crmResponse)
        {
            //associate input control type to lookup value
            string[] regs = new[] { response.Reg1, response.Reg2, response.Reg3 }.Where(e => !string.IsNullOrEmpty(e)).ToArray();

            foreach (var reg in regs)
            {
                Entity legislation = GetEntityUsingSimpleQuery(service, "tc_legislation", "tc_legislationidentifier", reg);

                try
                {
                    var entityReferenceCollection = new EntityReferenceCollection(new List<EntityReference>
                    {
                        legislation.ToEntityReference()
                    });

                    service.Associate(responseEntityName, crmResponse.Id, new Relationship("tc_Questionnaire_Question_Response_tc_leg"), new EntityReferenceCollection(new List<EntityReference> { legislation.ToEntityReference() }));
                    //service.CreateEntityAssociation(responseEntityName, crmResponse.Id, legislationEntityName, legislation.Id, "tc_Questionnaire_Question_Response_tc_leg");
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

        //            service.Associate(questionOrderEntityName, orderEntity.Id, new Relationship("tc_Qtn_Question_Order_Question_tc_Questio"), entityReferenceCollection);
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


        //            var responseDelimiterOptionSet = service.GetGlobalOptionSetMetadata("tc_responsedelimiter");
        //            if (order.ResponseDelimeter != null) orderEntity.Attributes["tc_responsedelimiter"] = new OptionSetValue(Convert.ToInt32(responseDelimiterOptionSet.Options.FirstOrDefault(e => e.Label.LocalizedLabels[0].Label == order.ResponseDelimeter).Value));


        //            CreateOrUpdateEntity(ref service, ref orderEntity, keyName, crmOrder == null);

        //            try
        //            {
        //                var entityReference = new List<EntityReference>();
        //                entityReference.Add(group.ToEntityReference());
        //                var entityReferenceCollection = new EntityReferenceCollection(entityReference);
        //                service.Associate(groupOrderEntityName, orderEntity.Id, new Relationship("tc_Qtn_Question_Group_Order_Group_tc_Ques"), entityReferenceCollection);
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

                var fetchExpression = new FetchExpression(fetch);
                EntityCollection fetchResult = conn.RetrieveMultiple(fetchExpression);

                List<FetchResult> results = new List<FetchResult>();

                foreach (var row in fetchResult.Entities)
                {

                    var responseControlInputType = row.GetAttributeValue<AliasedValue>("response_control_input_type");

                    AliasedValue alias = (AliasedValue)responseControlInputType;

                    if (alias == null)
                    {
                        var troubleInput = row.GetValue<string>("response_control_input_name");

                        var message = troubleInput + ": no matching control input type found in dynamics.";

                        Console.WriteLine(message);

                        throw new NullReferenceException(message);
                    }

                    EntityReference entityReference = (EntityReference)alias.Value;

                    var relatedEntity = GetEntityUsingSimpleQuery(conn, responseControlInputType.EntityLogicalName, responseControlInputType.AttributeLogicalName, entityReference.Id.ToString());

                    results.Add(new FetchResult
                    {
                        template_name                         = row.GetAliasedValue<string>("template_name"),
                        template_title_english                = row.GetAliasedValue<string>("template_title_english"),
                        template_description_english          = row.GetAliasedValue<string>("template_description_english"),
                        group_name                            = row.GetAliasedValue<string>("group_name"),
                        //group_html_element_id               = row.GetAliasedValue<string>("group_html_element_id"),
                        group_is_repeatable                   = row.GetAliasedValue<string>("group_is_repeatable"),
                        group_visible                         = row.GetAliasedValue<string>("group_visible"),
                        group_title_english                   = row.GetAliasedValue<string>("group_title_english"),
                        group_order                           = row.GetAliasedValue<string>("group_order"),
                        group_response_delimiter              = row.GetAliasedValue<OptionSetValue>("group_response_delimiter"),
                        question_text_english                 = row.GetAliasedValue<string>("question_text_english"),
                        question_name                         = row.GetAliasedValue<string>("question_name"),
                        //question_html_element_id            = row.GetAliasedValue<string>("question_html_element_id"),
                        question_order                        = row.GetAliasedValue<string>("question_order"),
                        question_visible                      = row.GetAliasedValue<string>("question_visible"),
                        response_control_input_type           = new QuestionType()
                        {
                            EntityName = entityReference.LogicalName,
                            Id         = entityReference.Id.ToString(),
                            Name       = entityReference.Name
                        },
                        response_control_label_text_english   = row.GetAliasedValue<string>("response_control_label_text_english"),
                        response_control_input_name           = row.GetAliasedValue<string>("response_control_input_name"),
                        //response_control_input_id           = row.GetAliasedValue<string>("response_control_input_id"),
                        response_name                         = row.GetAliasedValue<string>("response_name"),
                        response_internal_comment             = row.GetAliasedValue<OptionSetValue>("response_internal_comment"),
                        response_is_problem                   = row.GetAliasedValue<OptionSetValue>("response_is_problem"),
                        response_external_comment             = row.GetAliasedValue<OptionSetValue>("response_external_comment"),
                        response_picture                      = row.GetAliasedValue<OptionSetValue>("response_picture"),
                        response_is_safety_concern            = row.GetAliasedValue<OptionSetValue>("response_is_safety_concern"),
                        response_emit_value                   = row.GetAliasedValue<string>("response_emit_value"),
                        response_order                        = row.GetAliasedValue<string>("response_order"),
                        question_show_key                     = row.GetAliasedValue<string>("question_show_key"),
                        question_hide_key                     = row.GetAliasedValue<string>("question_hide_key"),
                        response_display_in_group_header      = row.GetAliasedValue<string>("response_display_in_group_header")
                    });
                }

                var json = Newtonsoft.Json.JsonConvert.SerializeObject(results);
                return json;

            }
            catch (Exception ex)
            {
                //handle the exception
                throw ex;
            }
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
            DeleteEntity(service, templateEntity, "tc_name");

            DeleteEntity(service, "tc_questionnaire_questions_group", "tc_name");

            DeleteEntity(service, "tc_questionnaire_question", "tc_name");

            DeleteEntity(service, "tc_questionnaire_question_response", "tc_name");

            DeleteEntity(service, "tc_qtn_question_order", "tc_name");

            DeleteEntity(service, "tc_qtn_question_group_order", "tc_name");
        }

        #endregion


        #region LEGISLATION

        //static Entity Act        = null;
        //static Entity Regulation = null;
        //static Entity Standard   = null;
        static int OrderCount = 1;
        public static void DeleteLegislation(CrmServiceClient service)
        {
            DeleteEntity(service, "tc_legislation", "tc_legislationidentifier");
        }

        public static string ExecuteLegislationFetchXml(string fetch)
        {
            try
            {
                CrmServiceClient conn = Connect();

                IOrganizationService service = (IOrganizationService)conn.OrganizationServiceProxy;

                var fetchExpression = new FetchExpression(fetch);
                EntityCollection fetchResult = service.RetrieveMultiple(fetchExpression);

                List<Legislation> results = new List<Legislation>();

                foreach (var row in fetchResult.Entities)
                {
                    var responseControlInputType = row.GetAttributeValue<EntityReference>("tc_legislationtype");

                    if (responseControlInputType == null)
                    {
                        var troubleInput = row.GetValue<string>("response_control_input_name");

                        var message = troubleInput + ": no matching control input type found in dynamics.";

                        Console.WriteLine(message);

                        throw new NullReferenceException(message);
                    }

                    var relatedEntity = GetEntityUsingSimpleQuery(conn, responseControlInputType.LogicalName, "tc_legislationtype", responseControlInputType.Name);

                    results.Add(new Legislation
                    {
                        LegislationType = relatedEntity.Attributes["tc_legislationtype"].ToString(),
                        LegislationTextEnglish = row.GetValue<string>("tc_legislationtextenglish"),
                        LegislationTextFrench = row.GetValue<string>("tc_legislationtextfrench"),
                        LegislationReference = row.GetValue<string>("tc_legislationidentifier"),
                        Order = row.GetInt("tc_order"),
                        DateRevoked = row.GetValue<DateTime?>("tc_daterevoked").ToDateTime(),
                        DateEffective = row.GetValue<DateTime>("tc_dateeffective").ToDateTime("yyyy-MM-dd H:mm:ss"),
                        Name = row.GetValue<string>("tc_legislation"),
                        Id = row.Id.ToString()
                    });
                }

                var json = Newtonsoft.Json.JsonConvert.SerializeObject(results);
                return json;

            }
            catch (Exception ex)
            {
                //handle the exception
                throw ex;
            }
        }

        public static void CreateOrUpdateLegislations(CrmServiceClient service, Regulation legData)
        {
            if (legData == null) throw new ArgumentNullException(nameof(legData));

            //get once
            //Act        = GetEntityUsingSimpleQuery(service, "tc_legislation_type", "tc_legislationtype", "TDG Act | Loi TMD");
            //Regulation = GetEntityUsingSimpleQuery(service, "tc_legislation_type", "tc_legislationtype", "TDG Regulations | Réglementation sur le TMD");
            //Standard   = GetEntityUsingSimpleQuery(service, "tc_legislation_type", "tc_legislationtype", "TDG Standards | Normes TMD");

            OrderCount = 1; //reset the temp order
            RecursivelyUploadLegislation(ref service, legData);
        }

        static Entity UploadLegislation(ref CrmServiceClient service, Regulation element, Entity parent = null)
        {
            var leg = new Entity(legislationEntityName);

            //get list of pre-existing question groups  0
            Entity existingLeg = GetEntityUsingSimpleQuery(service, legislationEntityName, legKeyName, element.JusticeId);

            if (existingLeg != null)
            {
                leg.Id = existingLeg.Id;
            }
            else
            {
                leg.Id = Guid.NewGuid();
            }

            MapLegislationDataToEntity(ref leg, element);


            //var responseDelimiterOptionSet = service.GetGlobalOptionSetMetadata("xxxxxTYPE_LOOKUPxxxxxx");
            //if (element.Type != null) leg.Attributes["xxxxxTYPExxxxxx"] = new OptionSetValue(Convert.ToInt32(responseDelimiterOptionSet.Options.FirstOrDefault(e => e.Label.LocalizedLabels[0].Label == element.Type).Value));


            CreateOrUpdateEntity(ref service, ref leg, legKeyName, existingLeg == null);

            if (parent != null)
            {
                service.Associate(legislationEntityName, leg.Id, new Relationship("xxxxxxxxxxxxxxxx"), new EntityReferenceCollection(new List<EntityReference>() { parent.ToEntityReference() }));
            }

            //switch (element.Type)
            //{
            //    case "Transportation of Dangerous Good Act (1992)":
            //        //service.CreateEntityAssociation(legislationEntityName, leg.Id, act.LogicalName, act.Id, "tc_legislation_legislationtype_tc_legisla");
            //        service.Associate(legislationEntityName, leg.Id, new Relationship("tc_legislation_legislationtype_tc_legisla"), new EntityReferenceCollection(new List<EntityReference>() { Act.ToEntityReference() }));
            //        break;
            //    case "Transportation of Dangerous Goods Regulation":
            //        //service.CreateEntityAssociation(legislationEntityName, leg.Id, regulation.LogicalName, regulation.Id, "tc_legislation_legislationtype_tc_legisla");

            //        service.Associate(legislationEntityName, leg.Id, new Relationship("tc_legislation_legislationtype_tc_legisla"), new EntityReferenceCollection(new List<EntityReference>() { Regulation.ToEntityReference() }));
            //        break;
            //    case "Transportation of Dangerous Goods Standard":
            //        //service.CreateEntityAssociation(legislationEntityName, leg.Id, standard.LogicalName, standard.Id, "tc_legislation_legislationtype_tc_legisla");

            //        service.Associate(legislationEntityName, leg.Id, new Relationship("tc_legislation_legislationtype_tc_legisla"), new EntityReferenceCollection(new List<EntityReference>() { Standard.ToEntityReference() }));
            //        break;
            //    default:
            //        throw new KeyNotFoundException(element.Type);
            //}

            OrderCount++;

            return leg;
        }

        static void RecursivelyUploadLegislation(ref CrmServiceClient service, Regulation element, Entity parent = null)
        {
            if (element.Children != null && element.Children.Where(e => CONSTANTS.Constants.RegTypes.Contains(e.Type) || e.Type == "Body").Count() > 0)
            {
                var newParent = UploadLegislation(ref service, element, parent);

                foreach (var child in element.Children)
                {
                    RecursivelyUploadLegislation(ref service, child, newParent);
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

        public static string GetAliasedValue<T>(this Entity row, string attribute)
        {
            var alias = row.GetAttributeValue<AliasedValue>(attribute);

            if (alias == null)
            {
                if (attribute != "response_emit_value" && !attribute.Contains("show_key") && !attribute.Contains("hide_key"))
                {
                    Console.WriteLine(attribute + " was provided a null value! Correct and reimport.");
                }
                return null;
            }


            Type type = typeof(T);
            if (type == typeof(OptionSetValue))
            {
                var option = (OptionSetValue)alias.Value;
                return option.Value.ToString();
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

                if (!isNullable && attribute != "response_emit_value" && !attribute.Contains("show_key") && !attribute.Contains("hide_key"))
                {
                    throw new NullReferenceException(attribute + " was provided a null value! Correct and reimport.");
                }
                return null;
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

                Console.WriteLine("Created {0} entity named {1} with GUID {2}.", entity.LogicalName, entity.Attributes[keyName], newEntityId);
            }
            else
            {
                service.Update(entity);

                Console.WriteLine("Existing {0} entity named {1} updated.", entity.LogicalName, entity[keyName]);
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
            var service = new CrmServiceClient("Url=https://xxxxxxxxxxxxxxxxx.xxxxx.dynamics.com; Username=xxxxxxxxxxxxxx; Password=xxxxxxxxxxxxxx; authtype=xxxxxxxxxxxxxx; RequireNewInstance=True");

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

        private static void MapResponseDataToEntity(ref Entity responseEntity, QuestionResponseOption response)
        {
            //responseEntity.Attributes["tc_controlinputid"]          = response.ControlInputId;
            //responseEntity.Attributes["tc_controlinputname"] = response.ControlInputName;
            responseEntity.Attributes["tc_controllabelenglishtext"] = response.TextEnglish;
            responseEntity.Attributes["tc_controllabelfrenchtext"] = response.TextFrench;
            //responseEntity.Attributes["tc_emitvalue"] = response.EmitValue;
            responseEntity.Attributes["tc_name"] = response.Name;
            responseEntity.Attributes["tc_order"] = response.SortOrder;
            //responseEntity.Attributes["tc_displayingroupheader"] = response.GroupAlternateKey;

        }
        //private static void MapGroupOrderDataToEntity(ref Entity orderEntity, GroupOrder order)
        //{
        //    orderEntity.Attributes["tc_hidekey"] = order.Hidekey;
        //    orderEntity.Attributes["tc_name"] = order.Name;
        //    orderEntity.Attributes["tc_order"] = order.Order;
        //    orderEntity.Attributes["tc_showkey"] = order.Showkey;
        //    orderEntity.Attributes["tc_visible"] = order.IsVisible;
        //}

        //private static void MapQuestionOrderDataToEntity(ref Entity orderEntity, QuestionOrder order)
        //{
        //    orderEntity.Attributes["tc_hidekey"] = order.HideKey;
        //    orderEntity.Attributes["tc_name"] = order.Name;
        //    orderEntity.Attributes["tc_order"] = order.Order;
        //    orderEntity.Attributes["tc_showkey"] = order.ShowKey;
        //    orderEntity.Attributes["tc_visible"] = order.Visible;
        //}
        private static void MapTemplateDataToEntity(ref Entity templateEntity, Template template)
        {
            templateEntity.Attributes["tc_englishdescription"] = template.DescriptionEnglish;
            templateEntity.Attributes["tc_englishtitle"] = template.TitleEnglish;
            templateEntity.Attributes["tc_frenchdescription"] = template.DescriptionFrench;
            templateEntity.Attributes["tc_frenchtitle"] = template.TitleFrench;
            templateEntity.Attributes["tc_name"] = template.Name;
        }

        private static void MapQuestionGroupDataToEntity(ref Entity groupEntity, Group group)
        {
            groupEntity.Attributes["tc_englishtitle"] = group.TitleEnglish;
            groupEntity.Attributes["tc_frenchtitle"] = group.TitleFrench;
            groupEntity.Attributes["tc_isrepeatable"] = group.IsRepeatable;
            groupEntity.Attributes["tc_name"] = group.Name;
            groupEntity.Attributes["tc_htmlelementid"] = group.Name;

            //TODO: Group Model
            //sort order
            groupEntity.Attributes["tc_qtnsortorder"] = group.SortOrder;
            //isVisible
            groupEntity.Attributes["tc_qtnisvisible"] = group.IsVisible;
        }
        private static void MapQuestionDataToEntity(ref Entity questionEntity, Question question)
        {
            questionEntity.Attributes["tc_englishtext"]      = question.TextEnglish;
            questionEntity.Attributes["tc_frenchtext"]       = question.TextFrench;
            questionEntity.Attributes["tc_name"]             = question.Name;
            questionEntity.Attributes["tc_questionTypeId"]   = question.Type.Name;
            questionEntity.Attributes["tc_groupId"]          = question.GroupId;
            questionEntity.Attributes["tc_parentQuestionId"] = question.ParentQuestionId;
            questionEntity.Attributes["tc_sortOrder"]        = question.SortOrder;
            questionEntity.Attributes["tc_isVisible"]        = question.IsVisible;
        }

        #endregion


        #region LEGISLATION

        private static void MapLegislationDataToEntity(ref Entity legEntity, Regulation reg)
        {
            legEntity.Attributes["tc_legislationtextenglish"] = reg.TextEnglish;
            legEntity.Attributes["tc_legislationtextfrench"] = reg.TextFrench;
            legEntity.Attributes["tc_legislationidentifier"] = reg.Label;
            legEntity.Attributes["tc_order"] = OrderCount;
            legEntity.Attributes["tc_daterevoked"] = null;
            legEntity.Attributes["tc_dateeffective"] = reg.InforceStartDate;

            legEntity.Attributes["tc_uniqueId"] = reg.UniqueId;
            legEntity.Attributes["tc_may"] = reg.GetDataFlag("MAY");
            legEntity.Attributes["tc_must"] = reg.GetDataFlag("MUST");
            legEntity.Attributes["tc_unless"] = reg.GetDataFlag("UNLESS");
            legEntity.Attributes["tc_consignor"] = reg.GetDataFlag("CONSIGNOR");
            legEntity.Attributes["tc_carrier"] = reg.GetDataFlag("CARRIER");
            legEntity.Attributes["tc_importer"] = reg.GetDataFlag("IMPORTER");
            legEntity.Attributes["tc_exemption"] = reg.GetDataFlag("EXEMPTION");
            legEntity.Attributes["tc_erap"] = reg.GetDataFlag("ERAP");
            legEntity.Attributes["tc_provision"] = reg.GetDataFlag("PROVISION");
            legEntity.Attributes["tc_largemoc"] = reg.GetDataFlag("LARGE MEANS OF CONTAINMENT");
            legEntity.Attributes["tc_smallmoc"] = reg.GetDataFlag("SMALL MEANS OF CONTAINMENT");
            legEntity.Attributes["tc_moc"] = reg.GetDataFlag("MEANS OF CONTAINMENT");
            legEntity.Attributes["tc_class"] = reg.GetDataFlag("CLASS");
            legEntity.Attributes["tc_unNumberText"] = reg.GetDataFlag("UN NUMBER");
            legEntity.Attributes["tc_hasUnNumber"] = reg.GetDataFlag("HAS UN NUMBER");
            legEntity.Attributes["tc_unNumbers"] = reg.GetDataFlag("UN NUMBERS");
            legEntity.Attributes["tc_hasClass"] = reg.GetDataFlag("HAS CLASS");
            legEntity.Attributes["tc_classes"] = reg.GetDataFlag("CLASSES");
        }

        #endregion

        #endregion


    }
}
