------------------------------------------------
--CONVERT EXCEL DATA TO UNIQUE RECORDS WITH ADDRESS FROM "MATCHING_ID"
------------------------------------------------
/****** Object:  Table [dbo].[02_REGULATED_ENTITIES]    Script Date: 4/22/2021 12:41:24 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[02_REGULATED_ENTITIES]') AND type in (N'U'))
DROP TABLE [dbo].[02_REGULATED_ENTITIES]
GO

CREATE TABLE [dbo].[02_REGULATED_ENTITIES](
	[REGULATED_ENTITY_ID] [uniqueidentifier] NULL,
	[REGULATED_ENTITY_ID_SOURCE] [nvarchar](50) NULL,
	[IIS_ID] [numeric](18, 0) NULL,
	[REGULATED_ENTITY_NAME] [nvarchar](500) NULL,
	[CONSOLIDATED_COMMON_ENGLISH_NAME] [nvarchar](500) NULL,
	[CONSOLIDATED_COMMON_FRENCH_NAME] [nvarchar](500) NULL,
	[COUNTRY_SUBDIVISION_CD] [nvarchar](10) NULL,
	[CITY_TOWN_NAME_NM] [nvarchar](250) NULL,
	[ADDRESS] [nvarchar](1000) NULL,
	[POSTAL_CODE_TXT] [nvarchar](10) NULL,
	[COMPLETED] [nvarchar](10) NULL,
	[NOTES] [nvarchar](500) NULL,
	[TYPE] [nvarchar](25) NULL
) ON [PRIMARY]
GO


INSERT INTO DBO.[02_REGULATED_ENTITIES]
(
	[REGULATED_ENTITY_ID],
	[REGULATED_ENTITY_ID_SOURCE],
	IIS_ID,
	[REGULATED_ENTITY_NAME],
	[CONSOLIDATED_COMMON_ENGLISH_NAME],
	[CONSOLIDATED_COMMON_FRENCH_NAME]
)
SELECT
	NEWID()									[REGULATED_ENTITY_ID],
	[REGULATED_ENTITY_ID]					[REGULATED_ENTITY_ID_SOURCE],
	REGENT.[MATCHING_ID]					[IIS_ID],
	TRIM(REGENT.REGULATED_ENTITY_NAME),
	TRIM(REGENT.REGULATED_ENTITY_NAME),
	TRIM(REGENT.REGULATED_ENTITY_NAME)
FROM 
(

	--USE CONSOLIDATED COMMON NAME TO IDENTIFY SITES
	SELECT REGULATED_ENTITY_ID, REGULATED_ENTITY_NAME, [MATCHING_ID], COUNT(REGULATED_ENTITY_ID) COUNT_OF
	FROM (
		SELECT REGULATED_ENTITY_ID,  
		REGULATED_ENTITY_NAME,
		[MATCHING_ID]
		FROM [dbo].[01_IIS_DATA_CONSOLIDATION]
	) REGENT_NAMES WHERE REGULATED_ENTITY_NAME IS NOT NULL
	GROUP BY REGULATED_ENTITY_ID, REGULATED_ENTITY_NAME, MATCHING_ID
	HAVING COUNT(REGULATED_ENTITY_ID) > 1

) REGENT


------------------------------------------------
--CONVERT REGULATED ENTITY RECORDS TO ACCOUNTS--
------------------------------------------------

TRUNCATE TABLE [dbo].[04_ACCOUNT];

INSERT INTO [dbo].[04_ACCOUNT]
(
[accountnumber],
[description],
id,
accountid,
[ovs_legalname],
[name],
[ovs_accountnameenglish],
[ovs_accountnamefrench],
[owningteam],
[owningbusinessunit],
[owneridtype],
[ownerid],
[customertypecode]
)
SELECT
[REGULATED_ENTITY_ID_SOURCE]										   [accountnumber],
CONCAT('Converted from IIS.', CHAR(13)+CHAR(10), 'Consolidation ID: ', [IIS_ID], 
							  CHAR(13)+CHAR(10), 'Data Consolidation Matching ID: ', [REGULATED_ENTITY_ID_SOURCE]) [description], 
[REGULATED_ENTITY_ID]													id,
[REGULATED_ENTITY_ID]													[accountid],
[REGULATED_ENTITY_NAME]													[ovs_legalname],
[REGULATED_ENTITY_NAME]													[name],
[CONSOLIDATED_COMMON_ENGLISH_NAME]										[ovs_accountnameenglish],
[CONSOLIDATED_COMMON_FRENCH_NAME]										[ovs_accountnamefrench],
'd0483132-b964-eb11-a812-000d3af38846'									[owningteam],
'4e122e0c-73f3-ea11-a815-000d3af3ac0d'									[owningbusinessunit],
'team'																	[owneridtype],
'd0483132-b964-eb11-a812-000d3af38846'									[ownerid],
948010000																[customertypecode]
FROM [dbo].[02_REGULATED_ENTITIES] REGENT;



/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
[Id]
,customertypecode
,[accountid]
,[accountnumber]
,[address1_city]
,[address1_country]
,[address1_latitude]
,[address1_line1]
,[address1_line2]
,[address1_line3]
,[address1_longitude]
,[address1_name]
,[address1_postalcode]
,[address1_postofficebox]
,[address1_primarycontactname]
,[address1_stateorprovince]
,[address1_telephone2]
,[address1_telephone3]
,[description]
,[emailaddress1]
,[emailaddress2]
,[emailaddress3]
,[fax]
,[msdyn_serviceterritory]
,[name]
,[ovs_accountnameenglish]
,[ovs_accountnamefrench]
,[ovs_iisid]
,[ovs_legalname]
,[ovs_naicscode]
,[ovs_primarycontactemail]
,[ovs_primarycontactphone]
,[ownerid]
,[owneridtype]
,[owningbusinessunit]
,[owningteam]
,[parentaccountid]
,[primarycontactid]
,[telephone1]
,[telephone2]
,[telephone3]
,[territoryid]
,[websiteurl]
FROM [dbo].[04_ACCOUNT]
WHERE customertypecode = 948010000;



--=======================================SITES==========

TRUNCATE TABLE DBO.[03_SITES];

INSERT INTO [dbo].[03_SITES]
           ([SITE_ID]
           ,[IIS_ID]
           ,[REGULATED_ENTITY_ID]
           ,[REGULATED_ENTITY_ID_SOURCE]
		   ,[REGULATED_ENTITY_NAME]
           ,[COMPANY_NAME_FORMATTED]
           ,[COMPANY_NAME]
           ,[COUNTRY_SUBDIVISION_CD]
           ,[CITY_TOWN_NAME_NM]
           ,[ADDRESS]
           ,[POSTAL_CODE_TXT]
           ,[COMPLETED]
           ,[PLANNED2021])
SELECT
NEWID(),
SITES.IIS_ID,
NULL [REGULATED_ENTITY_ID],
SITES.REGULATED_ENTITY_ID [MATCHING_ID],
SITES.[REGULATED_ENTITY_NAME],
SITES.COMPANY_NAME_FORMATTED,
SITES.COMPANY_NAME,
SITES.COUNTRY_SUBDIVISION_CD,
SITES.CITY_TOWN_NAME_NM,
SITES.ADDRESS,
SITES.POSTAL_CODE_TXT,
SITES.COMPLETED,
SITES.[PLANNED2021]
FROM 
(
	SELECT
	[COMPLETED],
	[ASSIGNED_TO],
	[IIS_ID],
	[COMPANY_NAME_FORMATTED],
	[PLANNED2021],
	[COMPANY_NAME],
	[COUNTRY_SUBDIVISION_CD],
	[CITY_TOWN_NAME_NM],
	[ADDRESS],
	[POSTAL_CODE_TXT],
	[FILE_STATUS_CD],
	[SOUNDEX_NAME],
	[MATCHING_ID],
	[FUZZY_MATCH],
	[REGULATED_ENTITY_ID],
	[REGULATED_ENTITY_NAME],
	[CONSOLIDATED_COMMON_ENGLISH_NAME],
	[CONSOLIDATED_COMMON_FRENCH_NAME],
	[NOTES]
	FROM [dbo].[01_IIS_DATA_CONSOLIDATION]
) SITES
--WHERE AND COMPLETED = 'Y'



--link to regulated entities that have the exact match of company name
UPDATE SITES
SET 
    SITES.REGULATED_ENTITY_ID = REGENT.REGULATED_ENTITY_ID
FROM 
    [dbo].[03_SITES] as SITES
    INNER JOIN DBO.[02_REGULATED_ENTITIES] as REGENT ON SITES.[REGULATED_ENTITY_ID_SOURCE] = REGENT.[REGULATED_ENTITY_ID_SOURCE];


--link to regulated entities that have the exact match of company name
UPDATE SITES
SET 
    SITES.REGULATED_ENTITY_ID = REGENT.REGULATED_ENTITY_ID
FROM 
    [dbo].[03_SITES] as SITES
    INNER JOIN DBO.[02_REGULATED_ENTITIES] as REGENT ON SITES.IIS_ID = REGENT.IIS_ID;


--link to regulated entities that have the exact match of company name
UPDATE SITES
SET 
    SITES.REGULATED_ENTITY_ID = REGENT.REGULATED_ENTITY_ID
FROM 
    [dbo].[03_SITES] as SITES
    INNER JOIN DBO.[02_REGULATED_ENTITIES] as REGENT ON UPPER(SITES.REGULATED_ENTITY_NAME) = UPPER(REGENT.REGULATED_ENTITY_NAME);



DROP TABLE IF EXISTS #TEMP_ACCOUNTS;
GO

CREATE TABLE #TEMP_ACCOUNTS (
	[accountnumber] [nvarchar](20) NULL,
	[description] [nvarchar](max) NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[ovs_iisid] [nvarchar](25) NULL,
	[ovs_legalname] [nvarchar](250) NULL,
	[name] [nvarchar](160) NULL,
	[ovs_accountnameenglish] [nvarchar](4000) NULL,
	[address1_stateorprovince] [nvarchar](50) NULL,
	[address1_city] [nvarchar](80) NULL,
	[address1_line1] [nvarchar](250) NULL,
	[address1_postalcode] [nvarchar](20) NULL,
	[owningteam] [uniqueidentifier] NULL,
	[owningbusinessunit] [uniqueidentifier] NULL,
	[owneridtype] [nvarchar](4000) NULL,
	[ownerid] [uniqueidentifier] NULL,
	[customertypecode] int,
	[msdyn_serviceterritory] [uniqueidentifier] NULL,
	[territoryid] [uniqueidentifier] NULL,
	[parentaccountid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

------------------------------------------------
--CONVERT SITE ENTITY RECORDS TO ACCOUNTS--
------------------------------------------------
INSERT INTO #TEMP_ACCOUNTS
([accountnumber],
[description],
[ID],
[ovs_iisid],
[ovs_legalname],
[name],
[ovs_accountnameenglish],
[address1_stateorprovince],
[address1_city],
[address1_line1],
[address1_postalcode],
[owningteam],
[owningbusinessunit],
[owneridtype],
[ownerid],
[customertypecode],
[msdyn_serviceterritory],
[territoryid],
[parentaccountid])

SELECT

IIS_ID																			[accountnumber],
CONCAT('Converted from IIS.', CHAR(13)+CHAR(10), 'IIS ID: ', IIS_ID)			[description],
NEWID()																			[ID],
IIS_ID																			[ovs_iisid],
LEGAL_NAME_ENM																	[ovs_legalname],
COMPANY_NAME																	[name],
OPERATING_NAME_ENM																[ovs_accountnameenglish],
T1.[COUNTRY_SUBDIVISION_CD]														[address1_stateorprovince],
[CITY_TOWN_NAME_NM]																[address1_city],
[ADDRESS]																		[address1_line1],
[POSTAL_CODE_TXT]																[address1_postalcode],
'd0483132-b964-eb11-a812-000d3af38846'											[owningteam],
'4E122E0C-73F3-EA11-A815-000D3AF3AC0D'											[owningbusinessunit],
'team'																			[owneridtype],
'd0483132-b964-eb11-a812-000d3af38846'											[ownerid],
948010001																		[customertypecode],
[msdyn_serviceterritory]														[msdyn_serviceterritory],
[msdyn_serviceterritory]														[territoryid],
T1.REGULATED_ENTITY_ID															[parentaccountid]

FROM 

(
	SELECT
	T1.*,
	CASE
		WHEN T2.LEGAL_NAME_ENM IS NULL OR T2.LEGAL_NAME_ENM = '' THEN NULL
		ELSE T2.LEGAL_NAME_ENM
	END LEGAL_NAME_ENM,
	[T2].OPERATING_NAME_ENM,
	T3.[msdyn_serviceterritory],
	NULL [parentaccountid]

	FROM
	[03_SITES] T1
	LEFT JOIN [10_IIS_EXPORT] T2 ON T1.IIS_ID = T2.STAKEHOLDER_ID
	LEFT JOIN [dbo].[05_TERRITORY_TRANSLATION] T3 ON UPPER(TRIM(T1.[COUNTRY_SUBDIVISION_CD])) = UPPER(TRIM(T3.[COUNTRY_SUBDIVISION_CD]))

	--Make sure that no regulated entity ids do not go into the system as sites
	--AND STAKEHOLDER_ID NOT IN
	--(
	--	SELECT
	--	IIS_ID
	--	FROM 
	--	[02_REGULATED_ENTITIES]
	--)
) T1



INSERT INTO [04_ACCOUNT]
(
	[accountnumber],
	[description],
	id,
	[ovs_iisid],
	[ovs_legalname],
	[name],
	[ovs_accountnameenglish],
	[address1_stateorprovince],
	[address1_city],
	[address1_line1],
	[address1_postalcode],
	[owningteam],
	[owningbusinessunit],
	[owneridtype],
	[ownerid],
	[customertypecode],
	[msdyn_serviceterritory],
	[territoryid],
	[parentaccountid]
)
SELECT 
[accountnumber], 
[description], 
[id],
[ovs_iisid],
[ovs_legalname],
[name],
[ovs_accountnameenglish],
[address1_stateorprovince],
[address1_city],
[address1_line1],
[address1_postalcode],
[owningteam],
[owningbusinessunit],
[owneridtype],
[ownerid],
[customertypecode],
[msdyn_serviceterritory], 
[territoryid],
[parentaccountid]
FROM #TEMP_ACCOUNTS;




/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
[Id]
,customertypecode
,[accountid]
,[accountnumber]
,[address1_city]
,[address1_country]
,[address1_latitude]
,[address1_line1]
,[address1_line2]
,[address1_line3]
,[address1_longitude]
,[address1_name]
,[address1_postalcode]
,[address1_postofficebox]
,[address1_primarycontactname]
,[address1_stateorprovince]
,[address1_telephone2]
,[address1_telephone3]
,[description]
,[emailaddress1]
,[emailaddress2]
,[emailaddress3]
,[fax]
,[msdyn_serviceterritory]
,[name]
,[ovs_accountnameenglish]
,[ovs_accountnamefrench]
,[ovs_iisid]
,[ovs_legalname]
,[ovs_naicscode]
,[ovs_primarycontactemail]
,[ovs_primarycontactphone]
,[ownerid]
,[owneridtype]
,[owningbusinessunit]
,[owningteam]
,[parentaccountid]
,[primarycontactid]
,[telephone1]
,[telephone2]
,[telephone3]
,[territoryid]
,[websiteurl]
FROM [dbo].[04_ACCOUNT]


