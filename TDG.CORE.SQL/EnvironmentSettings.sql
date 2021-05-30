/****** Object:  Table [dbo].[25_ENVIRONMENT_SETTINGS]    Script Date: 2021-05-10 4:43:24 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[25_ENVIRONMENT_SETTINGS]') AND type in (N'U'))
DROP TABLE [dbo].[25_ENVIRONMENT_SETTINGS]
GO

/****** Object:  Table [dbo].[25_ENVIRONMENT_SETTINGS]    Script Date: 2021-05-10 4:43:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[25_ENVIRONMENT_SETTINGS](
	[qm_environmentsettingid] [uniqueidentifier] NOT NULL,
	[qm_name] [varchar](1000) NOT NULL,
	[qm_value] [varchar](1000) NOT NULL,
	[qm_environment] [varchar](50) NOT NULL
) ON [PRIMARY]
GO


INSERT INTO [dbo].[25_ENVIRONMENT_SETTINGS]
           ([qm_environmentsettingid]
           ,[qm_name]
           ,[qm_value]
           ,[qm_environment])

SELECT NEWID() [qm_environmentsettingid], 'CustomerSupportTeam'									[qm_name], 'Michael.Kalinovich@tc.gc.ca;sebastien.belanger@tc.gc.ca;aaron.leblanc@tc.gc.ca;Desmond.Yelland@tc.gc.ca'	[qm_value],	'DEV' [qm_environment] UNION
SELECT NEWID() [qm_environmentsettingid], 'DesignatedPersonName'								[qm_name], 'Luc Belaire'																								[qm_value],	'DEV' [qm_environment] UNION
SELECT NEWID() [qm_environmentsettingid], 'DesignatedPersonTitle'								[qm_name], 'Chief Of Enforcement'																						[qm_value],	'DEV' [qm_environment] UNION
SELECT NEWID() [qm_environmentsettingid], 'Detention Notice - HTTP'								[qm_name], 'No longer triggered by HTTP'																				[qm_value],	'DEV' [qm_environment] UNION
SELECT NEWID() [qm_environmentsettingid], 'Notice Of Direction To Remedy Non-Compliance - HTTP' [qm_name], 'No longer triggered by HTTP'																				[qm_value],	'DEV' [qm_environment] UNION
SELECT NEWID() [qm_environmentsettingid], 'ovs_confirmationofcompliance'						[qm_name], 'socialactivity'																								[qm_value],	'DEV' [qm_environment] UNION
SELECT NEWID() [qm_environmentsettingid], 'ovs_cyaction'										[qm_name], 'socialactivity'																								[qm_value],	'DEV' [qm_environment] UNION
SELECT NEWID() [qm_environmentsettingid], 'qm_BlobAccount'										[qm_name], 'romstorageaccounttdg'																						[qm_value],	'DEV' [qm_environment] UNION
SELECT NEWID() [qm_environmentsettingid], 'qm_InspectionReports'								[qm_name], 'InspectionReports'																							[qm_value],	'DEV' [qm_environment] UNION
SELECT NEWID() [qm_environmentsettingid], 'qm_QuestionnaireResult'								[qm_name], 'qmsyresult'																									[qm_value],	'DEV' [qm_environment] UNION
SELECT NEWID() [qm_environmentsettingid], 'qm_ServiceTaskResults'								[qm_name], 'servicetaskresults'																							[qm_value],	'DEV' [qm_environment] UNION
SELECT NEWID() [qm_environmentsettingid], 'qm_workorder_blob_container'							[qm_name], 'msdynworkorder'																								[qm_value],	'DEV' [qm_environment] UNION
SELECT NEWID() [qm_environmentsettingid], 'qm_woservicetask_blob_container'						[qm_name], 'msdynworkorderservicetask'																					[qm_value],	'DEV' [qm_environment] UNION

--flows
SELECT NEWID() [qm_environmentsettingid], 'CustomerSupportUrl'									[qm_name], 'https://prod-31.canadacentral.logic.azure.com:443/workflows/50b2639a78f9458f8ddb5584a1dd25a2/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=rV9punoqrzzCBRy3C92PsTV2m76FiCs6sDqeq349f-Y' [qm_value], 'DEV' [qm_environment] UNION
SELECT NEWID() [qm_environmentsettingid], 'InspectionReportUrl'									[qm_name], 'https://prod-14.canadacentral.logic.azure.com:443/workflows/53004795e9ac4aaaa50f8cc2ecf5f52b/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=GbS7Zj7gKLTuqCdLv3JtlV84vcg8Bc3SRDdYIiV1EcU' [qm_value], 'DEV' [qm_environment] UNION
SELECT NEWID() [qm_environmentsettingid], 'qm_BlobSAS'											[qm_name], '?sv=2019-12-12&ss=bfqt&srt=sco&sp=rwdlacupx&se=2099-02-12T11:34:16Z&st=2021-02-12T03:34:16Z&spr=https&sig=' [qm_value], 'DEV' [qm_environment];
GO

--use the above as defaults for other environments
INSERT INTO [dbo].[25_ENVIRONMENT_SETTINGS]
           ([qm_environmentsettingid]
           ,[qm_name]
           ,[qm_value]
           ,[qm_environment])

SELECT [qm_environmentsettingid], [qm_name], [qm_value], environment
FROM [25_ENVIRONMENT_SETTINGS]
CROSS JOIN (
	SELECT 'QA' environment UNION
	SELECT 'ACC' environment
) T;

UPDATE [25_ENVIRONMENT_SETTINGS] 
SET
[qm_value] = 'https://prod-31.canadacentral.logic.azure.com:443/workflows/50b2639a78f9458f8ddb5584a1dd25a2/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=rV9punoqrzzCBRy3C92PsTV2m76FiCs6sDqeq349f-Y'
WHERE [qm_name] = 'CustomerSupportUrl' AND [qm_environment] = 'QA';

--TODO, no flow defined yet in ACC, not published
UPDATE [25_ENVIRONMENT_SETTINGS] 
SET
[qm_value] = 'https://prod-31.canadacentral.logic.azure.com:443/workflows/50b2639a78f9458f8ddb5584a1dd25a2/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=rV9punoqrzzCBRy3C92PsTV2m76FiCs6sDqeq349f-Y'
WHERE [qm_name] = 'CustomerSupportUrl' AND [qm_environment] = 'ACC';

UPDATE [25_ENVIRONMENT_SETTINGS] 
SET
[qm_value] = 'https://prod-14.canadacentral.logic.azure.com:443/workflows/53004795e9ac4aaaa50f8cc2ecf5f52b/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=GbS7Zj7gKLTuqCdLv3JtlV84vcg8Bc3SRDdYIiV1EcU'
WHERE [qm_name] = 'InspectionReportUrl' AND [qm_environment] = 'QA';

UPDATE [25_ENVIRONMENT_SETTINGS] 
SET
[qm_value] = 'https://prod-14.canadacentral.logic.azure.com:443/workflows/53004795e9ac4aaaa50f8cc2ecf5f52b/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=GbS7Zj7gKLTuqCdLv3JtlV84vcg8Bc3SRDdYIiV1EcU'
WHERE [qm_name] = 'InspectionReportUrl' AND [qm_environment] = 'ACC';

--check for dups
SELECT qm_name, qm_environment, COUNT(*) [count] FROM [25_ENVIRONMENT_SETTINGS]
GROUP BY qm_name, qm_environment
HAVING COUNT(*) > 1
ORDER BY qm_environment, qm_name;

SELECT * FROM [25_ENVIRONMENT_SETTINGS];