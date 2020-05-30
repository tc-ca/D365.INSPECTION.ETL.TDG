using Microsoft.Xrm.Tooling.Connector;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TDG.CORE.ETL.MODELS.LEGISLATION;
using TDG.CORE.ETL.MODELS.QUESTIONNAIRE;

namespace TDG.CORE.ETL.CDS
{
    public class ETLLogic
    {
        const string UNABLE_TO_LOGIN_ERROR = "Unable to Login to Common Data Service";

        public static void ETLQuestionnaireData(QuestionnaireModel questionnaireData, CrmServiceClient existingService = null, string outputPath = "general.integration.js")
        {
            CrmServiceClient service = null;

            try
            {
                service = CrmSdkHelper.Connect();

                if (service != null)
                {
                    Console.BackgroundColor = ConsoleColor.DarkGreen;

                    Console.WriteLine("Connected to the organization server for " + service?.CrmConnectOrgUriActual?.AbsoluteUri ?? service?.ConnectedOrgFriendlyName);

                    if (service.IsReady)
                    {
                        Console.BackgroundColor = ConsoleColor.DarkGreen;
                        Console.WriteLine(Environment.NewLine + "-----CREATING QUESTIONNAIRE DATA-----" + Environment.NewLine + ":)");

                        CrmSdkHelper.CreateOrUpdateCrmWithExcelData(ref service, questionnaireData);

                        Console.WriteLine("-----QUESTIONNAIRE DATA SAVED-----");
                    }
                    else
                    {
                        if (service.LastCrmError.Equals(UNABLE_TO_LOGIN_ERROR))
                        {
                            Console.WriteLine("Check the connection string values in cds/App.config.");
                            throw new Exception(service.LastCrmError);
                        }
                        else
                        {
                            throw service.LastCrmException;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                CrmSdkHelper.HandleException(ex);
            }
            finally
            {
                if (service != null)
                    service.Dispose();
            }
        }

        public static void FetchQuestionnaireData(string generalComplianceFetchXml, CrmServiceClient existingService = null, string outputPath = "general.integration.js")
        {
            CrmServiceClient service = null;

            try
            {
                service = existingService == null ? CrmSdkHelper.Connect() : existingService;

                if (service != null)
                {
                    Console.BackgroundColor = ConsoleColor.DarkGreen;

                    Console.WriteLine("Connected to the organization server for " + service?.CrmConnectOrgUriActual?.AbsoluteUri ?? service?.ConnectedOrgFriendlyName);

                    if (service.IsReady)
                    {
                        Console.BackgroundColor = ConsoleColor.DarkBlue;
                        Console.WriteLine(Environment.NewLine + "-----FETCHING QUESTIONNAIRE DATA-----" + Environment.NewLine + ":)");

                        var result = CrmSdkHelper.ExecuteQuestionnaireFetchXml(generalComplianceFetchXml);

                        JToken jsonFormatted = JToken.Parse(result);
                        var beautified = jsonFormatted.ToString(Formatting.Indented);
                        //var minified = parsedJson.ToString(Formatting.None);

                        string before = $"/* eslint-disable indent */{Environment.NewLine}export default {{{Environment.NewLine}  data: ";
                        string after = $"{Environment.NewLine}}}{Environment.NewLine}";

                        beautified = beautified.Replace("\"", "'");

                        using (StreamWriter file = File.CreateText(outputPath))
                        {
                            file.Write(before);
                            file.Write(beautified);
                            file.Write(after);
                        }

                        Console.WriteLine(outputPath);

                        Console.WriteLine("-----OPENING QUESTIONNAIRE FETCH RESULT-----");

                        Process myProcess = new Process();
                        Process.Start("notepad++.exe", outputPath);
                        myProcess.Dispose();
                    }
                    else
                    {
                        if (service.LastCrmError.Equals(UNABLE_TO_LOGIN_ERROR))
                        {
                            Console.WriteLine("Check the connection string values in cds/App.config.");
                            throw new Exception(service.LastCrmError);
                        }
                        else
                        {
                            throw service.LastCrmException;
                        }
                    }
                }
            }

            catch (Exception ex)
            {
                CrmSdkHelper.HandleException(ex);
            }


            finally
            {
                if (service != null)
                    service.Dispose();
            }

            Console.WriteLine("All Done! Press any key to close");
            //Console.Beep();
            Console.ReadKey();
        }

        public static void DeleteQuestionnaireData(CrmServiceClient existingService = null)
        {
            CrmServiceClient service = null;

            try
            {
                service = existingService == null ? CrmSdkHelper.Connect() : existingService;

                if (service != null)
                {
                    Console.BackgroundColor = ConsoleColor.DarkGreen;

                    Console.WriteLine("Connected to the organization server for " + service?.CrmConnectOrgUriActual?.AbsoluteUri ?? service?.ConnectedOrgFriendlyName);

                    if (service.IsReady)
                    {
                        //Delete everything
                        Console.BackgroundColor = ConsoleColor.DarkRed;
                        Console.WriteLine(Environment.NewLine + "-----DELETING ALL QUESTIONNAIRE DATA-----" + Environment.NewLine + ":)");

                        CrmSdkHelper.DeleteQuestionnaireData(service);

                        Console.WriteLine("-----QUESTIONNAIRE DATA DELETED-----");
                    }
                    else
                    {
                        if (service.LastCrmError.Equals(UNABLE_TO_LOGIN_ERROR))
                        {
                            Console.WriteLine("Check the connection string values in cds/App.config.");
                            throw new Exception(service.LastCrmError);
                        }
                        else
                        {
                            throw service.LastCrmException;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                CrmSdkHelper.HandleException(ex);
            }
            finally
            {
                if (service != null)
                    service.Dispose();
            }
        }

        public static void DeleteLegislation(CrmServiceClient existingService = null)
        {
            var doNotDispose = existingService != null ? true : false;

            CrmServiceClient service = null;

            try
            {
                service = existingService == null ? CrmSdkHelper.Connect() : existingService;

                if (service.IsReady)
                {
                    Console.BackgroundColor = ConsoleColor.DarkRed;
                    Console.WriteLine("-----DELETING ANY EXISTING LEGISTLATION DATA-----");

                    CrmSdkHelper.DeleteLegislation(service);

                    Console.WriteLine("-----LEGISLATION DATA DELETED-----");
                }
                else
                {
                    if (service.LastCrmError.Equals(UNABLE_TO_LOGIN_ERROR))
                    {
                        Console.WriteLine("Check the connection string values in cds/App.config.");
                        throw new Exception(service.LastCrmError);
                    }
                    else
                    {
                        throw service.LastCrmException;
                    }
                }
            }
            catch (Exception ex)
            {
                CrmSdkHelper.HandleException(ex);
            }
            finally
            {
                if (service != null && !doNotDispose)
                    service.Dispose();
            }
        }

        public static void FetchLegislationData(string legFetchXml, CrmServiceClient existingService = null, string outputPath = "legislation.integration.js")
        {
            CrmServiceClient service = null;

            try
            {
                service = existingService == null ? CrmSdkHelper.Connect() : existingService;

                if (service != null)
                {
                    Console.BackgroundColor = ConsoleColor.DarkGreen;

                    Console.WriteLine("Connected to the organization server for " + service?.CrmConnectOrgUriActual?.AbsoluteUri ?? service?.ConnectedOrgFriendlyName);

                    if (service.IsReady)
                    {
                        Console.WriteLine(Environment.NewLine + "-----FETCHING LEGISLATION DATA-----" + Environment.NewLine + ":)");

                        var result = CrmSdkHelper.ExecuteLegislationFetchXml(legFetchXml);

                        JToken jsonFormatted = JToken.Parse(result);
                        var beautified = jsonFormatted.ToString(Formatting.Indented);

                        string before = $"/* eslint-disable indent */{Environment.NewLine}export default {{{Environment.NewLine}  data: ";
                        string after = $"{Environment.NewLine}}}{Environment.NewLine}";

                        beautified = beautified.Replace("\"", "'");

                        using (StreamWriter file = File.CreateText(outputPath))
                        {
                            file.Write(before);
                            file.Write(beautified);
                            file.Write(after);
                        }

                        Console.WriteLine(outputPath);

                        Console.WriteLine("opening legislation fetch results");

                        Process myProcess = new Process();
                        Process.Start("notepad++.exe", outputPath);
                        myProcess.Dispose();

                    }
                    else
                    {
                        const string UNABLE_TO_LOGIN_ERROR = "Unable to Login to Common Data Service";
                        if (service.LastCrmError.Equals(UNABLE_TO_LOGIN_ERROR))
                        {
                            Console.WriteLine("Check the connection string values in cds/App.config.");
                            throw new Exception(service.LastCrmError);
                        }
                        else
                        {
                            throw service.LastCrmException;
                        }
                    }
                }
            }

            catch (Exception ex)
            {
                CrmSdkHelper.HandleException(ex);
            }


            finally
            {
                if (service != null)
                    service.Dispose();
            }
        }

        public static void ETLLegislationData(Regulation legData, CrmServiceClient existingService = null)
        {
            CrmServiceClient service = null;

            try
            {
                service = existingService == null ? CrmSdkHelper.Connect() : existingService;

                if (service != null)
                {
                    Console.BackgroundColor = ConsoleColor.DarkGreen;

                    Console.WriteLine("Connected to the organization server for " + service?.CrmConnectOrgUriActual?.AbsoluteUri ?? service?.ConnectedOrgFriendlyName);

                    if (service.IsReady)
                    {
                        Console.WriteLine(Environment.NewLine + "-----UPDATING LEGISLATION DATA-----" + Environment.NewLine + ":)");
                        CrmSdkHelper.CreateOrUpdateLegislations(service, legData);
                    }
                    else
                    {
                        const string UNABLE_TO_LOGIN_ERROR = "Unable to Login to Common Data Service";
                        if (service.LastCrmError.Equals(UNABLE_TO_LOGIN_ERROR))
                        {
                            Console.WriteLine("Check the connection string values in cds/App.config.");
                            throw new Exception(service.LastCrmError);
                        }
                        else
                        {
                            throw service.LastCrmException;
                        }
                    }
                }
            }

            catch (Exception ex)
            {
                CrmSdkHelper.HandleException(ex);
            }


            finally
            {
                if (service != null)
                    service.Dispose();
            }
        }
    }
}
