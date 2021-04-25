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
	NEWID()								[REGULATED_ENTITY_ID],
	REGENT.REGULATED_ENTITY_ID			[REGULATED_ENTITY_ID_SOURCE],
	REGENT.MATCHING_ID,
	TRIM(REGENT.REGULATED_ENTITY_NAME),
	TRIM(REGENT.REGULATED_ENTITY_NAME),
	TRIM(REGENT.REGULATED_ENTITY_NAME)
FROM 
(

	SELECT REGULATED_ENTITY_ID, REGULATED_ENTITY_NAME, MATCHING_ID, COUNT(REGULATED_ENTITY_ID) COUNT_OF
	FROM (
		SELECT REGULATED_ENTITY_ID,  
		REGULATED_ENTITY_NAME,
		MATCHING_ID
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
CONCAT('Converted from IIS.', CHAR(13)+CHAR(10), 'IIS ID: ', [IIS_ID], 
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
NEWID() [SITE_ID],
SITES.IIS_ID,
NULL [REGULATED_ENTITY_ID],
SITES.REGULATED_ENTITY_ID [REGULATED_ENTITY_ID_SOURCE],
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


--link SITES to regulated entities
UPDATE SITES
SET 
    SITES.REGULATED_ENTITY_ID = REGENT.REGULATED_ENTITY_ID 
FROM 
    [dbo].[03_SITES] as SITES
    INNER JOIN DBO.[02_REGULATED_ENTITIES] as REGENT ON SITES.[REGULATED_ENTITY_ID_SOURCE] = REGENT.[REGULATED_ENTITY_ID_SOURCE];


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





--===============================LOGIC FOR IIS DATA===


UPDATE [04_ACCOUNT]
SET 
--,name = T2.OPERATING_NAME,
ovs_legalname = T2.LEGAL_NAME,
ovs_accountnameenglish = T2.OPERATING_NAME,
address1_primarycontactname = T2.USER_CONTACT,
address1_telephone1 = T2.CONTACT_TFH,
address1_latitude = CASE WHEN ISNUMERIC(T2.LATITUDE_DEGREE_NBR) = 1 THEN CAST(T2.LATITUDE_DEGREE_NBR AS DECIMAL(38, 5)) ELSE NULL END,
address1_longitude = CASE WHEN ISNUMERIC(T2.LONGITUDE_DEGREE_NBR) = 1 THEN CAST(T2.LONGITUDE_DEGREE_NBR AS DECIMAL(38, 5)) ELSE NULL END,
address1_city  = TRIM(T2.CITY_TOWN_NAME_NM),
address1_country = TRIM(T2.COUNTRY),
address1_postalcode = TRIM(T2.POSTAL_CODE_TXT),
address1_stateorprovince = TRIM(T2.COUNTRY_SUBDIVISION_CD),
address1_line3 = TRIM(POBOX),
address1_postofficebox = TRIM(POBOX),

address1_line1 = 
CASE
	WHEN TRIM(T2.STREET) IS NULL OR TRIM(T2.STREET) = '' THEN
		address1_line1
	ELSE
		TRIM(T2.STREET)
END

FROM [04_ACCOUNT] T1
JOIN 
(
		SELECT 
		--IIS Number
		IIS.STAKEHOLDER_ID,

		--Legal Name
		--DATA MIGRATION RULES:
		--If Legal name doesn't exist in IIS, then include make the Legal Name "Legal Name was not on file in IIS, please confirm Legal Name".
		--BUSINESS REASON: This is what is used on the Inspection Report and Tickets and other official documents
		CASE 
		WHEN IIS.LEGAL_NAME_ENM IS NULL THEN 'Legal Name was not on file in IIS, please confirm Legal Name'
		ELSE TRIM(IIS.LEGAL_NAME_ENM)
		END LEGAL_NAME,

		--Operating Name
		--DATA MIGRATION RULES:
		--If Operating Name doesn't exist in IIS, then use the Legal Name in IIS for the Operating Name.
		--BUSINESS REASON: This is required so that you know the name of the company you are looking for by name.
		CASE 
		WHEN IIS.OPERATING_NAME_ENM IS NULL THEN IIS.LEGAL_NAME_ENM
		ELSE TRIM(IIS.OPERATING_NAME_ENM)
		END OPERATING_NAME,

		--Address 1 - Out of the box fields in ROM; Concept of "Civic General Address" in IIS
		--DATA MIGRATION RULE FOR ALL ADDRESS FIELDS
		--If the "Civic General Address" within the address from Address Type = "Civic" is blank, then use the Address Type = "Physical" to then fill in all the fields for the address

		--Street 1
		--DATA MIGRATION RULES:
		--Use the "Civic General Address" from IIS for this field for Address Type Civic. into this field.
		--If this field is blank in IIS, leave this field blank in ROM.
		IIS.PHYS_STREET_NUMBER_NUM,
		IIS.PHYS_STREET_NAME_NM,
		IIS.STREET_NUMBER_NUM,
		IIS.STREET_NAME_NM,

		CASE
			WHEN STREET_NAME_NM IS NULL AND (PHYS_STREET_NAME_NM IS NULL OR TRIM(PHYS_STREET_NAME_NM) = '') THEN 
				NULL
			WHEN (STREET_NAME_NM IS NULL OR TRIM(STREET_NAME_NM) = '0') AND PHYS_STREET_NAME_NM IS NOT NULL THEN
				CONCAT(IIS.PHYS_STREET_NUMBER_NUM, ' ', IIS.PHYS_STREET_NAME_NM)
			ELSE 
				CONCAT(IIS.STREET_NUMBER_NUM, ' ', STREET_NAME_NM)
		END STREET,

		--City
		--DATA MIGRATION RULES:
		--Migrate the IIS "City Town Name" for Address Type Civic. into this field
		CASE
			WHEN ADDRESS_TYPE.[TYPE] = 'PHYSICAL' THEN IIS.PHYS_CITY_TOWN_NAME_NM
			ELSE IIS.CITY_TOWN_NAME_NM
		END CITY_TOWN_NAME_NM,

		--Province
		--DATA MIGRATION RULES:
		--Migrate the IIS "Country Sub Divsiion Code" for Address Type Civic. into this field
		CASE
			WHEN ADDRESS_TYPE.[TYPE] = 'PHYSICAL' THEN IIS.PHYS_COUNTRY_SUBDIVISION_CD
			ELSE IIS.COUNTRY_SUBDIVISION_CD
		END COUNTRY_SUBDIVISION_CD,

		--Postal Code
		--DATA MIGRATION RULES:
		--Migrate the IIS "Postal Code" for Address Type Civic. into this field
		CASE
			WHEN ADDRESS_TYPE.[TYPE] = 'PHYSICAL' THEN IIS.PHYS_POSTAL_CODE_TXT
			ELSE IIS.POSTAL_CODE_TXT
		END POSTAL_CODE_TXT,

		--Country
		--DATA MIGRATION RULES:
		--Migrate the IIS "Country" for Address Type Civic. into this field
		CASE
			WHEN ADDRESS_TYPE.[TYPE] = 'CIVIC' THEN 'Canada'
			WHEN IIS.[PHYS_COUNTRY_CD] IS NULL THEN 'Canada'
			ELSE IIS.[PHYS_COUNTRY_ENM]
		END COUNTRY,

		--Lat / Long
		--DATA MIGRATION RULES:
		--Migrate the IIS "Lat Long" for Address Type Civic. into this field
		--If this field is currently blank in IIS, leave it blank in ROM.
		CASE
			WHEN ADDRESS_TYPE.[TYPE] = 'CIVIC' THEN IIS.[LATITUDE_DEGREE_NBR]
			ELSE IIS.[PHYS_LATITUDE_DEGREE_NBR]
		END LATITUDE_DEGREE_NBR,

		CASE
			WHEN ADDRESS_TYPE.[TYPE] = 'CIVIC' THEN IIS.LATITUDE_MINUTE_NBR
			ELSE IIS.[PHYS_LATITUDE_MINUTE_NBR]
		END LATITUDE_MINUTE_NBR,
		
		CASE
			WHEN ADDRESS_TYPE.[TYPE] = 'CIVIC' THEN IIS.LONGITUDE_DEGREE_NBR
			ELSE IIS.[PHYS_LONGITUDE_DEGREE_NBR]
		END LONGITUDE_DEGREE_NBR,

		CASE
			WHEN ADDRESS_TYPE.[TYPE] = 'CIVIC' THEN IIS.LONGITUDE_MINUTE_NBR
			ELSE IIS.[PHYS_LONGITUDE_MINUTE_NBR]
		END LONGITUDE_MINUTE_NBR,

		--Street 3
		--DATA MIGRATION RULES:
		--Use the "PO Box" field from IIS for this field.
		--If this field is blank in IIS, leave this field blank in ROM.
		CASE
			WHEN IIS.UNIT_SUITE_NUM = 'P.O. Box' OR IIS.UNIT_SUITE_NUM = 'PO' THEN
				CONCAT('P.O. Box', ' ', STREET_NUMBER_NUM)
			WHEN IIS.UNIT_SUITE_NUM = 'RR' OR IIS.UNIT_SUITE_NUM = 'SS' THEN 
				CONCAT(IIS.UNIT_SUITE_NUM, ' ', STREET_NUMBER_NUM)
			ELSE 
				NULL
		END POBOX,

		--Phone
		--Out of the box field.
		--DATA MIGRATION RULES:
		--There is no field that needs to be migrated from IIS.
		IIS.CONTACT_PHONE,
		IIS.CONTACT_BUSINESS_PHONE,
		IIS.CONTACT_EMAIL,
		IIS.CONTACT_TFH,
		IIS.USER_CONTACT
		--Fax
		--Out of the box field.
		--DATA MIGRATION RULES:
		--There is no field that needs to be migrated from IIS.

		, ADDRESS_TYPE.[TYPE]
		FROM [03_SITES] SITES
		JOIN [10_IIS_EXPORT] IIS ON SITES.IIS_ID = IIS.STAKEHOLDER_ID
		JOIN (
			SELECT
			STAKEHOLDER_ID,
			CASE
				WHEN	(STREET_NUMBER_NUM IS NULL		OR TRIM(STREET_NUMBER_NUM) = '')		AND 
						(STREET_NAME_NM IS NULL			OR TRIM (STREET_NAME_NM) = '')			AND 
						(CITY_TOWN_NAME_NM IS NULL		OR TRIM(CITY_TOWN_NAME_NM) = '')		AND 
						(COUNTRY_SUBDIVISION_CD IS NULL OR TRIM(COUNTRY_SUBDIVISION_CD) = '')	AND 
						(POSTAL_CODE_TXT IS NULL		OR TRIM(POSTAL_CODE_TXT) = '') THEN
						'PHYSICAL'
				ELSE
					'CIVIC'
			END [TYPE]
			FROM [10_IIS_EXPORT]
		) ADDRESS_TYPE ON IIS.STAKEHOLDER_ID = ADDRESS_TYPE.STAKEHOLDER_ID
) T2

ON T1.ovs_iisid = T2.STAKEHOLDER_ID;



--MOC Registration Number
--Required to be migrated from IIS.  This field will be required for linking to FDR.
--get this field from the workplan uploads
UPDATE [04_ACCOUNT]
SET 
	ovs_mocid = T2.MOC_ID
FROM [04_ACCOUNT] T1
JOIN 
(
	SELECT DISTINCT SITES.IIS_ID, WORKPLANS.MOC_ID
	FROM [03_SITES] SITES
	JOIN [dbo].[09_WORKPLAN_IMPORT] WORKPLANS ON CAST(SITES.IIS_ID as varchar(10)) = WORKPLANS.IIS_ID
	WHERE MOC_ID IS NOT NULL and MOC_ID <> ''
) T2 
ON T1.ovs_iisid = T2.IIS_ID;


--View accounts linked to Sites
--SELECT *  
--FROM [04_ACCOUNT] T1
--JOIN [03_SITES] T2 ON T1.ovs_iisid = T2.IIS_ID;


--SITE OPERATING PROFILE TAGS:
--The following are all characteristics of a site that will be used to build / filter the questionnaire.
--During Data Migration the expectation is that these tags will be extracted / translated from the existing data in IIS and imported into ROM.

--Means of Containment
--DATA MIGRATION RULES:
--Migrate the 
--Means of Containment Facility Type
--DATA MIGRATION RULES:

--Mode
--DATA MIGRATION RULES:
--This field is in IIS as "Mode".  It is check boxes in IIS.
--Migrate the value from IIS to Mode.
--This is a Mandatory field.
--Valid Values
--Rail 
--Road
--Air
--Marine
--The field name remains as "Mode".
--This is a tag that will be associated with a site.  It will need to be in the Site Operating Profile section; these values are used to build / filter the questionnaire.
--Multiple values for Mode can be selected


--Try to sanitize some bad data from IIS
UPDATE [dbo].[04_ACCOUNT]
SET address1_postalcode = REPLACE(address1_postalcode, ' ', ''),
	address1_country = 'Canada',
	address1_line1 = TRIM(address1_line1),
	address1_latitude  = CASE WHEN address1_latitude IS NULL OR address1_latitude = 0.00000 THEN NULL ELSE address1_latitude END,
	address1_longitude = CASE WHEN address1_longitude IS NULL OR address1_longitude = 0.00000 THEN NULL ELSE address1_longitude END;


----=============================END IIS LOGIC====


---checkpoint
TRUNCATE TABLE [21_TYRATIONAL];

INSERT INTO [dbo].[21_TYRATIONAL]
           ([Id]
		   ,[ovs_tyrationalid]
           ,[ovs_name]
           ,[ovs_rationalelbl]
           ,[ovs_rationalflbl]
           ,[ownerid]
           ,[owneridtype]
           ,[owningbusinessunit]
           ,[owningteam]
			)
SELECT	'994c3ec1-c104-eb11-a813-000d3af3a7a7'	[Id],	'994c3ec1-c104-eb11-a813-000d3af3a7a7'  [ovs_tyrationalid],	'Planned'	[ovs_name],	'Planned'	[ovs_rationalelbl], 'FR Planned'	[ovs_rationalflbl], 
		'd0483132-b964-eb11-a812-000d3af38846'	[ownerid], 'team'	[owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d'	[owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846'	[owningteam]

UNION

SELECT	'47f438c7-c104-eb11-a813-000d3af3a7a7'	[Id],	'47f438c7-c104-eb11-a813-000d3af3a7a7'  [ovs_tyrationalid],	'Unplanned'	[ovs_name],	'Unplanned'	[ovs_rationalelbl],	'FR Unplanned'	[ovs_rationalflbl], 
		'd0483132-b964-eb11-a812-000d3af38846'	[ownerid],	'team'	[owneridtype],	'4e122e0c-73f3-ea11-a815-000d3af3ac0d'	[owningbusinessunit],	'd0483132-b964-eb11-a812-000d3af38846'	[owningteam];   



TRUNCATE TABLE [23_TERRITORY];

INSERT INTO [dbo].[23_TERRITORY]
           ([Id]
           ,[territoryid]
           ,[name]
           ,[ovs_territorynameenglish]
           ,[ovs_territorynamefrench]
           ,[transactioncurrencyid])

SELECT 'fab76e9e-1707-eb11-a813-000d3af3a0d7', 'fab76e9e-1707-eb11-a813-000d3af3a0d7', 'Atlantic', 'Atlantic', 'Atlantic', '5A3BA338-C95D-EB11-89F5-000D3AE8E48A'
UNION
SELECT 'fcb76e9e-1707-eb11-a813-000d3af3a0d7', 'fcb76e9e-1707-eb11-a813-000d3af3a0d7', 'Quebec', 'Quebec', 'Quebec', '5A3BA338-C95D-EB11-89F5-000D3AE8E48A'
UNION
SELECT 'feb76e9e-1707-eb11-a813-000d3af3a0d7', 'feb76e9e-1707-eb11-a813-000d3af3a0d7', 'Pacific', 'Pacific', 'Pacific', '5A3BA338-C95D-EB11-89F5-000D3AE8E48A'
UNION
SELECT '02b86e9e-1707-eb11-a813-000d3af3a0d7', '02b86e9e-1707-eb11-a813-000d3af3a0d7', 'Prairie and Northern', 'Prairie and Northern', 'Prairie and Northern', '5A3BA338-C95D-EB11-89F5-000D3AE8E48A'
UNION
SELECT '04b86e9e-1707-eb11-a813-000d3af3a0d7', '04b86e9e-1707-eb11-a813-000d3af3a0d7', 'National Capital', 'National Capital', 'National Capital', '5A3BA338-C95D-EB11-89F5-000D3AE8E48A'
UNION
SELECT '50b21a84-db04-eb11-a813-000d3af3ac0d', '50b21a84-db04-eb11-a813-000d3af3ac0d', 'Ontario', 'Ontario', 'Ontario', '5A3BA338-C95D-EB11-89F5-000D3AE8E48A';
   

TRUNCATE TABLE [22_OVERSIGHTTYPE];

INSERT INTO [dbo].[22_OVERSIGHTTYPE]
           ([Id]
           ,[ovs_oversighttypeid]
           ,[ovs_name]
           ,[ovs_oversighttypenameenglish]
           ,[ovs_oversighttypenamefrench]
           ,[ownerid]
           ,[owneridtype]
           ,[owningbusinessunit]
           ,[owningteam])

SELECT '72afccd3-269e-eb11-b1ac-000d3ae924d1', '72afccd3-269e-eb11-b1ac-000d3ae924d1', 'GC IPT', 'GC IPT', 'GC IPT (FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT 'abf3c4d9-269e-eb11-b1ac-000d3ae924d1', 'abf3c4d9-269e-eb11-b1ac-000d3ae924d1', 'GC CEP', 'GC IPT', 'GC IPT (FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT '50d0bdf1-269e-eb11-b1ac-000d3ae924d1', '50d0bdf1-269e-eb11-b1ac-000d3ae924d1', 'GC Targeted', 'GC Targeted', 'GC Targeted (FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT '1cd7bd09-279e-eb11-b1ac-000d3ae924d1', '1cd7bd09-279e-eb11-b1ac-000d3ae924d1', 'GC Follow-up', 'GC Follow-up', 'GC Follow-up (FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT 'e99ab21b-279e-eb11-b1ac-000d3ae924d1', 'e99ab21b-279e-eb11-b1ac-000d3ae924d1', 'MOC Facility IPT', 'MOC Facility IPT', 'MOC Facility IPT (FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT '864baa27-279e-eb11-b1ac-000d3ae924d1', '864baa27-279e-eb11-b1ac-000d3ae924d1', 'MOC Facility Targeted', 'MOC Facility Targeted', 'MOC Facility Targeted (FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT 'c1e09a33-279e-eb11-b1ac-000d3ae924d1', 'c1e09a33-279e-eb11-b1ac-000d3ae924d1', 'MOC Facility Follow-up', 'MOC Facility Follow-up', 'MOC Facility Follow-up (FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT '9dee7316-5f9c-eb11-b1ac-000d3ae92708', '9dee7316-5f9c-eb11-b1ac-000d3ae92708', 'GC Triggered', 'GC Triggered', 'GC Triggered(FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT '07966e1c-5f9c-eb11-b1ac-000d3ae92708', '07966e1c-5f9c-eb11-b1ac-000d3ae92708', 'GC Opportunity', 'GC Opportunity', 'GC Opportunity(FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT '460b6c2a-5f9c-eb11-b1ac-000d3ae92708', '460b6c2a-5f9c-eb11-b1ac-000d3ae92708', 'GC Consignment', 'GC Consignment', 'GC Consignment(FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT '1cc06b3f-5f9c-eb11-b1ac-000d3ae92708', '1cc06b3f-5f9c-eb11-b1ac-000d3ae92708', 'GC Undeclared/ Misdeclared', 'GC Undeclared/ Misdeclared', 'GC Undeclared/ Misdeclared(FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT 'ea95bc68-5f9c-eb11-b1ac-000d3ae92708', 'ea95bc68-5f9c-eb11-b1ac-000d3ae92708', 'MOC Facility Triggered', 'MOC Facility Triggered', 'MOC Facility Triggered(FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT 'f6a0b96e-5f9c-eb11-b1ac-000d3ae92708', 'f6a0b96e-5f9c-eb11-b1ac-000d3ae92708', 'MOC Facility Opportunity', 'MOC Facility Opportunity', 'MOC Facility Opportunity(FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT 'a4965081-5f9c-eb11-b1ac-000d3ae92708', 'a4965081-5f9c-eb11-b1ac-000d3ae92708', 'Civil Aviation Document Review', 'Civil Aviation Document Review', 'Civil Aviation Document Review(FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam];

      
TRUNCATE TABLE [24_WORKORDERTYPE];

INSERT INTO [dbo].[24_WORKORDERTYPE]
           ([Id]
           ,[msdyn_workordertypeid]
           ,[msdyn_name]
           ,[msdyn_pricelist]
           ,[ovs_workordertypenameenglish]
           ,[ovs_workordertypenamefrench]
           ,[ownerid]
           ,[owneridtype]
           ,[owningbusinessunit]
           ,[owningteam])

SELECT 'b1ee680a-7cf7-ea11-a815-000d3af3a7a7', 'b1ee680a-7cf7-ea11-a815-000d3af3a7a7', 'Inspection', 'b92b6a16-7cf7-ea11-a815-000d3af3a7a7', 'Inspection', 'FR Inspection', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT '46706c0a-ad60-eb11-a812-000d3ae9471c', '46706c0a-ad60-eb11-a812-000d3ae9471c', 'Regulatory Authorization', 'b92b6a16-7cf7-ea11-a815-000d3af3a7a7', 'Regulatory Authorization', 'FR Regulatory Authorization', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam];

	

--=============BOOKABLE RESOURCES===

TRUNCATE TABLE [dbo].[bookableresource];

INSERT INTO [dbo].[bookableresource]
           (
		   bookableresourceid
		   ,[userid]
           ,[name]
           ,[msdyn_primaryemail]
           ,[id]
           ,[ovs_registeredinspectornumberrin]
           ,[ovs_badgenumber])

SELECT bookableresourceid, * 
FROM
(
	SELECT SYSUSER.systemuserid, CONCAT(SYSUSER.firstname, ' ', SYSUSER.lastname) name, domainname, newid() bookableresourceid, RIN, BADGE FROM [dbo].systemuser SYSUSER 
	JOIN [16_IIS_INSPECTORS] INSP ON lower(INSP.Account_name) = lower(SYSUSER.domainname)
) T


INSERT INTO [dbo].[bookableresource]
           (
		   bookableresourceid
		   ,[userid]
           ,[name]
           ,[msdyn_primaryemail]
           ,[id]
           ,[ovs_registeredinspectornumberrin]
           ,[ovs_badgenumber])

SELECT 
'2cfc9150-d6a3-eb11-b1ac-000d3ae8bee7' [bookableresourceid], --tdg core bookable resource id
'53275569-d460-eb11-a812-000d3ae947a6' [userid], -- tdg core system user id
'TDG Core'							   [name],
'tdg.core@034gc.onmicrosoft.com'       [msdyn_primaryemail],
'2cfc9150-d6a3-eb11-b1ac-000d3ae8bee7' [id], --tdg core bookable resource id
'1337' [ovs_registeredinspectornumberrin],
'1337' [ovs_badgenumber]


UPDATE [dbo].[bookableresource]
SET 
owningbusinessunit = '4e122e0c-73f3-ea11-a815-000d3af3ac0d',
owneridtype = 'team',
ownerid = 'd0483132-b964-eb11-a812-000d3af38846',
owningteam = 'd0483132-b964-eb11-a812-000d3af38846',
resourcetype = 3,
statecode = 0,
statuscode = 1,
msdyn_derivecapacity = 0,
msdyn_displayonscheduleassistant = 1,
msdyn_displayonscheduleboard = 1,
msdyn_enabledforfieldservicemobile = 1,
msdyn_enabledripscheduling = 0,
msdyn_endlocation = 690970002, --location agnostic
msdyn_startlocation = 690970002, --location agnostic
msdyn_timeoffapprovalrequired = 0;


TRUNCATE TABLE [17_BOOKABLE_RESOURCE_CATEGORIES];

INSERT INTO [dbo].[17_BOOKABLE_RESOURCE_CATEGORIES]
           ([bookableresourcecategoryid]
           ,[description]
           ,[name]
           ,[ownerid]
           ,[owneridtype]
           ,[owningbusinessunit]
           ,[owningteam])

SELECT 
'06DB6E56-01F9-EA11-A815-000D3AF3AC0D', --INSPECTOR 
'Category to indicate a Bookable Resource is an Inspector',
'Inspector',
ownerid = 'd0483132-b964-eb11-a812-000d3af38846',
owneridtype = 'team',
owningbusinessunit = '4e122e0c-73f3-ea11-a815-000d3af3ac0d',
owningteam = 'd0483132-b964-eb11-a812-000d3af38846';   

GO




---ADD "INSPECTOR" category to all inspectors
TRUNCATE TABLE [18_BOOKABLE_RESOURCE_CATEGORY_ASSN];

INSERT INTO [18_BOOKABLE_RESOURCE_CATEGORY_ASSN]
(resource, resourcecategory, statecode, statuscode, owningbusinessunit, owneridtype, ownerid , owningteam)

SELECT 
bookableresourceid, 
resourcecategory = '06DB6E56-01F9-EA11-A815-000D3AF3AC0D', --INSPECTOR 
statecode = 0, 
statuscode = 1, 
owningbusinessunit = '4e122e0c-73f3-ea11-a815-000d3af3ac0d',
owneridtype = 'team',
ownerid = 'd0483132-b964-eb11-a812-000d3af38846',
owningteam = 'd0483132-b964-eb11-a812-000d3af38846' FROM [dbo].[bookableresource]; 

--=====END BOOKABLE RESOURCES



--============WORK ORDERS

DROP TABLE IF EXISTS [19_IIS_INSPECTIONS];

CREATE TABLE [19_IIS_INSPECTIONS]
(
	[MONTH] int
	,[YEAR]	int	
	,FILE_NUMBER_NUM nvarchar (200)
	,FILE_STATUS_ETXT	varchar	(50)
	,FILE_STATUS_FTXT	varchar	(50)
	,ACTIVITY_TYPE_ENM	varchar	(250)
	,ACTIVITY_TYPE_FNM	varchar	(250)
	,ACTIVITY_DATE_DTE	datetime	
	,ACTIVITY_ID	numeric	
	,STAKEHOLDER_ID	numeric	
	,id	uniqueidentifier	
	,ovs_iisid	nvarchar	(50)
	,ACTIVITY_TYPE_CD	varchar	(20)
	,INSPECTION_REASON_ETXT	varchar	(250)
	,INSPECTION_REASON_FTXT	varchar	(250)
	,PRIMARY_INSPECTOR	nvarchar	(200)
	,PRIMARY_INSPECTOR_ID	numeric	
	,PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID	uniqueidentifier	
	,SECONDARY_INSPECTOR	nvarchar (200)
	,SECONDARY_INSPECTOR_ID	numeric	
	,SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID	uniqueidentifier
);

INSERT INTO [19_IIS_INSPECTIONS]

SELECT
MONTH(ACTIVITY_DATE_DTE) [MONTH],
YEAR(ACTIVITY_DATE_DTE) [YEAR],
*
FROM 
(
	SELECT 
	YD095.FILE_NUMBER_NUM, 
	TD001.FILE_STATUS_ETXT, 
	TD001.FILE_STATUS_FTXT, 
	TD045.ACTIVITY_TYPE_ENM, 
	TD045.ACTIVITY_TYPE_FNM,
	CONVERT(datetime, YD040.ACTIVITY_DATE_DTE) ACTIVITY_DATE_DTE,
	YD040.ACTIVITY_ID, 
	YD040.STAKEHOLDER_ID, 
	null id,--ACCOUNTS.id,
	null ovs_iisid,--ACCOUNTS.[ovs_iisid],
	TD045.ACTIVITY_TYPE_CD, 
	TD038.INSPECTION_REASON_ETXT, 
	TD038.INSPECTION_REASON_FTXT,
	PRIMARY_INSPECTOR.name PRIMARY_INSPECTOR,
	PRIMARY_INSPECTOR.STAKEHOLDER_ID PRIMARY_INSPECTOR_ID, 
	PRIMARY_INSPECTOR.id PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
	SECONDARY_INSPECTOR.name SECONDARY_INSPECTOR,
	SECONDARY_INSPECTOR.STAKEHOLDER_ID SECONDARY_INSPECTOR_ID,
	SECONDARY_INSPECTOR.id SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID
	FROM YD040_ACTIVITY YD040
	INNER JOIN YD095_STAKEHOLDER_FILE YD095 ON  YD040.FILE_NUMBER_NUM = YD095.FILE_NUMBER_NUM  
	INNER JOIN YD101_FILE_ACTIVITY_TYPE YD101 ON YD101.FILE_NUMBER_NUM = YD095.FILE_NUMBER_NUM AND YD101.DATE_DELETED_DTE IS NULL
	INNER JOIN TD045_ACTIVITY_TYPE TD045 ON YD101.ACTIVITY_TYPE_CD = TD045.ACTIVITY_TYPE_CD 
	INNER JOIN TD001_FILE_STATUS TD001 ON YD095.FILE_STATUS_CD = TD001.FILE_STATUS_CD
	LEFT JOIN YD041_INSPECTION YD041 ON YD040.ACTIVITY_ID = YD041.ACTIVITY_ID 
	LEFT JOIN TD038_INSPECTION_REASON TD038 ON YD041.INSPECTION_REASON_CD = TD038.INSPECTION_REASON_CD 
    
	LEFT JOIN
	(
		SELECT YD048.ACTIVITY_ID,
		YD048.STAKEHOLDER_ID
		,name
		,BR.id
		FROM YD048_ACTIVITY_ASSIGNMENT YD048 
		JOIN YD083_INDIVIDUAL_INFORMATION YD083 ON  YD048.STAKEHOLDER_ID = YD083.STAKEHOLDER_ID 
		JOIN [dbo].[bookableresource] BR ON UPPER(TRIM(CONCAT(CONCAT(YD083.STAKEHOLDER_NAME_FIRST_NM, ' '), YD083.STAKEHOLDER_NAME_FAMILY_NM))) = UPPER([dbo].[ReplaceASCII](name))
		WHERE YD083.DATE_DELETED_DTE IS NULL AND YD048.DATE_DELETED_DTE IS NULL AND ASSIGN_ROLE_CD = '1'
	) PRIMARY_INSPECTOR ON PRIMARY_INSPECTOR.ACTIVITY_ID = YD040.ACTIVITY_ID
    
	LEFT JOIN
	(
		SELECT YD048.ACTIVITY_ID,
		YD048.STAKEHOLDER_ID
		,name
		,BR.id
		FROM YD048_ACTIVITY_ASSIGNMENT YD048 
		JOIN YD083_INDIVIDUAL_INFORMATION YD083 ON  YD048.STAKEHOLDER_ID = YD083.STAKEHOLDER_ID 
		JOIN [dbo].[bookableresource] BR ON UPPER(TRIM(CONCAT(CONCAT(YD083.STAKEHOLDER_NAME_FIRST_NM, ' '), YD083.STAKEHOLDER_NAME_FAMILY_NM))) = UPPER([dbo].[ReplaceASCII](name))
		WHERE YD083.DATE_DELETED_DTE IS NULL AND YD048.DATE_DELETED_DTE IS NULL AND ASSIGN_ROLE_CD = '2'
	) SECONDARY_INSPECTOR ON SECONDARY_INSPECTOR.ACTIVITY_ID = YD040.ACTIVITY_ID
    
	--JOIN [dbo].[04_ACCOUNT] ACCOUNTS ON ACCOUNTS.ovs_iisid = YD040.STAKEHOLDER_ID

	WHERE 
	YD040.DATE_DELETED_DTE IS NULL AND 
	YD095.DATE_DELETED_DTE IS NULL AND 
	YD041.DATE_DELETED_DTE IS NULL AND 
	YD101.DATE_DELETED_DTE IS NULL 
	AND TD045.ACTIVITY_TYPE_PARENT_CD IS NULL AND TD045.DATE_DELETED_DTE IS NULL
	GROUP BY 
	YD095.FILE_NUMBER_NUM, 
	TD001.FILE_STATUS_ETXT, 
	TD001.FILE_STATUS_FTXT, 
	TD045.ACTIVITY_TYPE_ENM, 
	TD045.ACTIVITY_TYPE_FNM, 
	YD040.INSPECTION_DATE_DTE, 
	YD040.ACTIVITY_ID, 
	YD040.STAKEHOLDER_ID, 
	--ACCOUNTS.id,
	--ACCOUNTS.ovs_iisid,
	TD045.ACTIVITY_TYPE_CD, 
	TD038.INSPECTION_REASON_ETXT, 
	TD038.INSPECTION_REASON_FTXT,
	YD040.ACTIVITY_DATE_DTE,
	PRIMARY_INSPECTOR.name,
	PRIMARY_INSPECTOR.STAKEHOLDER_ID, 
	PRIMARY_INSPECTOR.id,
	SECONDARY_INSPECTOR.name,
	SECONDARY_INSPECTOR.STAKEHOLDER_ID,
	SECONDARY_INSPECTOR.id
			
) T;


--connect the IIS Inspections to the Accounts in ROM
UPDATE [19_IIS_INSPECTIONS]
SET 
id = ACCOUNTS.Id
,ovs_iisid = STAKEHOLDER_ID
FROM [19_IIS_INSPECTIONS]
JOIN [dbo].[04_ACCOUNT] ACCOUNTS ON ACCOUNTS.ovs_iisid = STAKEHOLDER_ID



----====================CREATE WORK ORDER RECORDS
----====================----====================----====================
----====================----====================----====================

TRUNCATE TABLE [06_WORK_ORDERS];

INSERT INTO [dbo].[06_WORK_ORDERS]
(
	 [msdyn_workorderid]
	,[msdyn_workordertype]
	,[msdyn_name]
	,[msdyn_pricelist]
	,[msdyn_serviceaccount]
	,[ovs_iisid]
	,[msdyn_systemstatus]
	,[ovs_primaryinspector]
	,[ovs_secondaryinspector]
	,[ownerid]
	,[owneridtype]
	,[owningbusinessunit]
	,owninguser
	,[msdyn_workordersummary]
	,[ovs_fiscalquarter]
	,[ovs_fiscalyear]
	,[ovs_oversighttype]
	,[ovs_rational]

	--,[qm_reportcontactid]
	--,[statecode]
	--,[statuscode]
)

SELECT ID, WORK_ORDER_TYPE, WORK_ORDER_NUMBER, PRICE_LIST, accountid, ovs_iisid, WORK_ORDER_STATUS, PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID, SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID,[OWNER],
	   OWNER_TYPE, OWNING_BUSINESS_UNIT, owning_user, WORK_ORDER_SUMMARY, FQ.tc_tcfiscalquarterid, FY.tc_tcfiscalyearid, OVERSIGHT_TYPE, RATIONALE FROM
(

	SELECT
		newid() ID,																				--WORK ORDER ID
		'B1EE680A-7CF7-EA11-A815-000D3AF3A7A7' WORK_ORDER_TYPE,									--work order type "Inspection"
		REPLACE(STR(ROW_NUMBER() OVER (ORDER BY ACTIVITY_ID),6),' ','0') WORK_ORDER_NUMBER,		--WO name, auto incremented number 1...x
		'B92B6A16-7CF7-EA11-A815-000D3AF3A7A7' PRICE_LIST,										--default price list
		id accountid,																			--account id for service account linked by the iis id
		[ovs_iisid],																			--IIS STAKEHOLDER_ID
		'690970004' WORK_ORDER_STATUS,															--"Closed - Posted"
		FILE_STATUS_ETXT,
		PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,													--PRIMARY INSPECTOR
		SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID												--SECONDARY INSPECTOR
		,PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID owner											--'D0483132-B964-EB11-A812-000D3AF38846' [OWNER]	--OWNER = primary inspector
		,'systemuser' [OWNER_TYPE]																--OWNER TYPE = systemuser
		,'4E122E0C-73F3-EA11-A815-000D3AF3AC0D' [OWNING_BUSINESS_UNIT]							--TDG Business Unit
		,PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID [owning_user]
		--,'D0483132-B964-EB11-A812-000D3AF38846' [OWNING_TEAM]									--OWNING TEAM = TDG Team
		,CAST(ACTIVITY_ID as nvarchar(500))	[WORK_ORDER_SUMMARY],	--WORK ORDER SUMMARY

		CASE 
			WHEN ([MONTH] >= 1 AND [MONTH] <=3)   THEN 'Q4'
			WHEN ([MONTH] >= 4 AND [MONTH] <=6)   THEN 'Q1'
			WHEN ([MONTH] >= 7 AND [MONTH] <=9)   THEN 'Q2'
			WHEN ([MONTH] >= 10 AND [MONTH] <=12) THEN 'Q3'
		END FISCAL_QUARTER,

		CASE 
			WHEN ([MONTH] >= 1 AND [MONTH] <=3) THEN 
				CONCAT(CONVERT(NVARCHAR(4), [YEAR] - 1),'-', CONVERT(NVARCHAR(4), [YEAR]))
			ELSE
				CONCAT(CONVERT(NVARCHAR(4), [YEAR]),'-', CONVERT(NVARCHAR(4), [YEAR] + 1))
		END FISCAL_YEAR,

--'07966E1C-5F9C-EB11-B1AC-000D3AE92708',	'GC Opportunity'
--'1CC06B3F-5F9C-EB11-B1AC-000D3AE92708',	'GC Undeclared / Misdeclared'
--'1CD7BD09-279E-EB11-B1AC-000D3AE924D1',	'GC Follow-up'
--'460B6C2A-5F9C-EB11-B1AC-000D3AE92708',	'GC Consignment'
--'50D0BDF1-269E-EB11-B1AC-000D3AE924D1',	'GC Targeted'
--'72AFCCD3-269E-EB11-B1AC-000D3AE924D1',	'GC IPT'
--'864BAA27-279E-EB11-B1AC-000D3AE924D1',	'MOC Facility Targeted'
--'9DEE7316-5F9C-EB11-B1AC-000D3AE92708',	'GC Triggered'
--'A4965081-5F9C-EB11-B1AC-000D3AE92708',	'Civil Aviation Document Review'
--'ABF3C4D9-269E-EB11-B1AC-000D3AE924D1',	'GC IPT'
--'C1E09A33-279E-EB11-B1AC-000D3AE924D1',	'MOC Facility Follow-up'
--'E99AB21B-279E-EB11-B1AC-000D3AE924D1',	'MOC Facility IPT'
--'EA95BC68-5F9C-EB11-B1AC-000D3AE92708',	'MOC Facility Triggered'
--'F6A0B96E-5F9C-EB11-B1AC-000D3AE92708',	'MOC Facility Opportunity'

		CASE 
			WHEN ACTIVITY_TYPE_ENM = 'Site Visit'							 THEN '50D0BDF1-269E-EB11-B1AC-000D3AE924D1'
			WHEN ACTIVITY_TYPE_ENM = 'MOC Facility Inspection (Planned)'	 THEN '864BAA27-279E-EB11-B1AC-000D3AE924D1'
			WHEN ACTIVITY_TYPE_ENM = 'General Compliance Inspection'		 THEN '50D0BDF1-269E-EB11-B1AC-000D3AE924D1'
			WHEN ACTIVITY_TYPE_ENM = 'Consignment'							 THEN '460B6C2A-5F9C-EB11-B1AC-000D3AE92708'
			WHEN ACTIVITY_TYPE_ENM = 'MOC Facility Inspection - (Unplanned)' THEN 'F6A0B96E-5F9C-EB11-B1AC-000D3AE92708'
			WHEN ACTIVITY_TYPE_ENM = 'Document Review'						 THEN 'A4965081-5F9C-EB11-B1AC-000D3AE92708'
		END OVERSIGHT_TYPE,

--994C3EC1-C104-EB11-A813-000D3AF3A7A7	Planned
--47F438C7-C104-EB11-A813-000D3AF3A7A7	Unplanned

		CASE 
			WHEN ACTIVITY_TYPE_ENM = 'Site Visit'							 THEN '994C3EC1-C104-EB11-A813-000D3AF3A7A7' --PLANNED
			WHEN ACTIVITY_TYPE_ENM = 'MOC Facility Inspection (Planned)'	 THEN '994C3EC1-C104-EB11-A813-000D3AF3A7A7' --PLANNED
			WHEN ACTIVITY_TYPE_ENM = 'General Compliance Inspection'		 THEN '994C3EC1-C104-EB11-A813-000D3AF3A7A7' --PLANNED
			WHEN ACTIVITY_TYPE_ENM = 'Consignment'							 THEN '47F438C7-C104-EB11-A813-000D3AF3A7A7' --UNPLANNED
			WHEN ACTIVITY_TYPE_ENM = 'MOC Facility Inspection - (Unplanned)' THEN '47F438C7-C104-EB11-A813-000D3AF3A7A7' --UNPLANNED
			WHEN ACTIVITY_TYPE_ENM = 'Document Review'						 THEN '47F438C7-C104-EB11-A813-000D3AF3A7A7' --UNPLANNED
		END RATIONALE
	
	FROM [19_IIS_INSPECTIONS]

	WHERE id IS NOT NULL

) T3
JOIN [dbo].[13_FISCAL_YEAR] FY ON FY.TC_NAME = T3.FISCAL_YEAR
JOIN [dbo].[14_FISCAL_QUARTER] FQ ON FQ.TC_NAME = T3.FISCAL_QUARTER AND FY.tc_tcfiscalyearid = FQ.tc_tcfiscalyearid;


--load the fiscal year, quarter and inspector names into the staging table, easier to look at the data
update [06_WORK_ORDERS] 
SET
	 [ovs_primaryinspectorname]		= BR.name
	,[ovs_secondaryinspectorname]	= BR2.name
	,[ovs_fiscalquartername]		= FQ.tc_name
	,[ovs_fiscalyearname]			= FY.tc_name
--SELECT 
--BR.name
--,BR2.name
--,FQ.tc_name
--,FY.tc_name
FROM 
[06_WORK_ORDERS] T1
JOIN [dbo].[13_FISCAL_YEAR] FY on T1.ovs_fiscalyear = FY.tc_tcfiscalyearid
JOIN [dbo].[14_FISCAL_QUARTER] FQ on T1.ovs_fiscalquarter = FQ.tc_tcfiscalquarterid
JOIN [dbo].[bookableresource] BR ON T1.ovs_primaryinspector = BR.bookableresourceid
LEFT JOIN [dbo].[bookableresource] BR2 ON T1.ovs_secondaryinspector = BR2.bookableresourceid


--UPDATE WORK ORDER ADDRESSES WITH ACCOUNT ADDRESSES 
UPDATE [06_WORK_ORDERS] 
SET 
msdyn_serviceterritory = A.territoryid, 
msdyn_address1 = A.address1_line1, 
msdyn_address2 = A.address1_line2, 
msdyn_address3 = A.address1_line3, 
msdyn_city = A.address1_city, 
msdyn_country = A.address1_country, 
msdyn_postalcode = A.address1_postalcode, 
msdyn_stateorprovince = A.address1_stateorprovince
FROM [06_WORK_ORDERS] WO
JOIN [04_ACCOUNT] A on WO.msdyn_serviceaccount = A.id;




--WHERE THE PRIMARY HASNT BEEN SET BECAUSE THE INSPECTOR DOES NOT HAVE AN ACCOUNT YET, THEN SET IT TO THE "TDG.CORE" user so we can at least get them in
UPDATE [06_WORK_ORDERS] 
SET 
[ovs_primaryinspector] = '2cfc9150-d6a3-eb11-b1ac-000d3ae8bee7' --TDG CORE BOOKABLE RESOURCE ID
,ownerid			   = '53275569-d460-eb11-a812-000d3ae947a6' -- tdg core system user
,owninguser			   = '53275569-d460-eb11-a812-000d3ae947a6' -- tdg core system user
FROM [06_WORK_ORDERS] WO
WHERE WO.ovs_primaryinspector IS NULL;

--==========================================


--==========================INSERT WORKORDERS FROM CURRENT WORKPLAN====


--SELECT * FROM [06_WORK_ORDERS] WHERE ovs_fiscalyearname = '2021-2022'

--Open - Unscheduled	690970000
--Open - Scheduled		690970001
--Open - In Progress	690970002
--Open - Completed		690970003
--Closed - Posted		690970004
--Closed - Canceled		690970005

--ANY Inspections from this years workplan that exist in IIS lets set to Open-Completed, hard to know if they're fully done or not
UPDATE [06_WORK_ORDERS]
SET [msdyn_systemstatus] = '690970003' --Open-Completed
WHERE ovs_fiscalyearname = '2021-2022';

--INSERT planned inspections for this fiscal year that havnt been started in IIS
INSERT INTO [dbo].[06_WORK_ORDERS]
(
	 [msdyn_workorderid]
	,[msdyn_workordertype]
	,[msdyn_name]
	,[msdyn_pricelist]
	,[msdyn_serviceaccount]
	,[ovs_iisid]
	,[msdyn_systemstatus]
	--,[ovs_primaryinspector]
	--,[ovs_secondaryinspector]
	,[ownerid]
	,[owneridtype]
	,[owningbusinessunit]
	--,owninguser
	,owningteam
	,[msdyn_workordersummary]

	,[ovs_fiscalquarter]
	,[ovs_fiscalquartername]
	,[ovs_fiscalyear]
	,[ovs_fiscalyearname]

	,[ovs_oversighttype]
	,[ovs_rational]
)

SELECT
	newid()																				[msdyn_workorderid],	--WORK ORDER ID
	'B1EE680A-7CF7-EA11-A815-000D3AF3A7A7'												WORK_ORDER_TYPE,		--work order type "Inspection"
	CONCAT([YEAR], REPLACE(STR(ROW_NUMBER() OVER (ORDER BY import_number),6),' ','0') )	WORK_ORDER_NUMBER,		--WO name, 2021 + auto incremented number 1...x
	'B92B6A16-7CF7-EA11-A815-000D3AF3A7A7'												PRICE_LIST,				--default price list
	accountid																			accountid,				--account id for service account linked by the iis id
	IIS_ID																				IIS_ID,					--IIS STAKEHOLDER_ID
	'690970000'																			WORK_ORDER_STATUS,		--"Unscheduled"
	--PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,											--PRIMARY INSPECTOR		--SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID																
	'D0483132-B964-EB11-A812-000D3AF38846'												[OWNER]					--OWNER = primary inspector
	--,PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID											[owner]					--'D0483132-B964-EB11-A812-000D3AF38846' [OWNER]
	,'systemuser'																		[OWNER_TYPE]			--OWNER TYPE = systemuser
	,'4E122E0C-73F3-EA11-A815-000D3AF3AC0D'												[OWNING_BUSINESS_UNIT]	--TDG Business Unit
	--,PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID											[owning_user]			--owning user is the primary inspector
	,'D0483132-B964-EB11-A812-000D3AF38846'												[OWNING_TEAM]			--OWNING TEAM = TDG Team
	,CONCAT('Work Order converted from 2021/2022 Workplan for IIS_ID = ', IIS_ID)		[WORK_ORDER_SUMMARY],	--WORK ORDER SUMMARY
	[tc_tcfiscalquarterid],
	[ovs_fiscalquartername],
	[tc_tcfiscalyearid],
	[ovs_fiscalyearname],

	CASE 
		WHEN [TYPE] = 'MOC'		THEN '864BAA27-279E-EB11-B1AC-000D3AE924D1'
		WHEN [TYPE] = 'GC'		THEN '50D0BDF1-269E-EB11-B1AC-000D3AE924D1'
		WHEN [TYPE] = 'HUBS'	THEN '50D0BDF1-269E-EB11-B1AC-000D3AE924D1'
	END																					OVERSIGHT_TYPE,

	'994C3EC1-C104-EB11-A813-000D3AF3A7A7'												RATIONALE --ALL WORK PLAN INSPECTIONS ARE PLANNED

FROM
(
	SELECT 
		WP.*, 
		ACCOUNTS.ID accountid,
		FQ.[tc_tcfiscalquarterid],
		FQ.[tc_name] [ovs_fiscalquartername],
		FY.[tc_tcfiscalyearid],
		FY.[tc_name] [ovs_fiscalyearname]
	FROM 
	(
		Select 
		
		CASE
			WHEN QUARTER_1 = '1' THEN 'Q1'
			WHEN QUARTER_2 = '1' THEN 'Q2'
			WHEN QUARTER_3 = '1' THEN 'Q3'
			WHEN QUARTER_4 = '1' THEN 'Q4'
		END [QUARTER],
		
		CASE
			WHEN QUARTER_1 = '1' OR QUARTER_2 = '1' OR QUARTER_3 = '1' THEN '2021'
			WHEN QUARTER_4 = '1' THEN '2022'
		END [YEAR]

		,CASE 
			WHEN Charindex(',', CURRENT_INSPECTOR) = 0 THEN 'TDG'
			ELSE Substring(CURRENT_INSPECTOR, 1,Charindex(',', CURRENT_INSPECTOR)-1)
		END [InspectorFirstName],
		
		CASE 
			WHEN Charindex(',', CURRENT_INSPECTOR) = 0 THEN 'CORE'
			ELSE Substring(CURRENT_INSPECTOR, Charindex(',', CURRENT_INSPECTOR)+1, LEN(CURRENT_INSPECTOR))
		END [InspectorLastName]
		
		,*	
		
		from [09_WORKPLAN_IMPORT] WP
		WHERE 
		CURRENTLY_PLANNED = '1' and fiscal_year = '2021-2022' AND
		CURRENT_INSPECTOR <> '' and CURRENT_INSPECTOR IS NOT NULL
	) WP
	--[dbo].[bookableresource] BR ON UPPER(TRIM(CONCAT(CONCAT(YD083.STAKEHOLDER_NAME_FIRST_NM, ' '), YD083.STAKEHOLDER_NAME_FAMILY_NM))) = UPPER([dbo].[ReplaceASCII](name))
	JOIN [04_ACCOUNT] ACCOUNTS ON WP.IIS_ID = ACCOUNTS.ovs_iisid
	JOIN [dbo].[13_FISCAL_YEAR] FY on WP.[YEAR] = FY.tc_fiscalyearnum
	JOIN [dbo].[14_FISCAL_QUARTER] FQ on FQ.tc_name = WP.[QUARTER] AND FQ.tc_tcfiscalyearidname = WP.fiscal_year
	AND import_number NOT IN
	(
		--WORKPLAN INSPECTIONS CREATED IN IIS ALREADY
		--IGNORE TO PREVENT DOUBLES
		SELECT import_number
		FROM
		(
			SELECT *, 

			CASE
				WHEN QUARTER_1 = '1' THEN 'Q1'
				WHEN QUARTER_2 = '1' THEN 'Q2'
				WHEN QUARTER_3 = '1' THEN 'Q3'
				WHEN QUARTER_4 = '1' THEN 'Q4'
			END [QUARTER]

			FROM [dbo].[09_WORKPLAN_IMPORT] 
		) WP
		JOIN [06_WORK_ORDERS] WO ON WP.IIS_ID = WO.ovs_iisid AND WP.fiscal_year = WO.ovs_fiscalyearname AND WP.QUARTER = WO.ovs_fiscalquartername
		where WP.fiscal_year = '2021-2022'
	)

) CURRENT_WORKPLAN;


--TODO: BOOKABLE RESOURCE BOOKINGS



--SELECT 
--     *
--  FROM [dbo].[06_WORK_ORDERS]
--  where ovs_fiscalyearname = '2021-2022'

--=================END WORKPLAN



--=====================CONTACTS

/****** Script for SelectTopNRows command from SSMS  ******/

TRUNCATE TABLE [11_CONTACT];
INSERT INTO [dbo].[11_CONTACT]
	   (
	   --id
	   [Id]
      ,[contactid]
      ,[accountid]
	  
	  --owner
	  ,[owningbusinessunit]
      ,[owningteam]
      ,[ownerid]
      ,[owneridtype]

      ,[emailaddress1]
      
	  --contact
      ,[telephone1]
      ,[telephone2]
      ,[telephone3]

	  --account
      ,[company]
	  ,[parentcustomeridtype]

	  --identifiaction
	  ,[firstname]
      ,[lastname]
      ,[fullname]
      --,[jobtitle]
)
SELECT 
	
	--id
	contactid id, contactid, id accountid, 
	
	--owner
	'4E122E0C-73F3-EA11-A815-000D3AF3AC0D'												[OWNING_BUSINESS_UNIT]	--TDG Business Unit
	--,PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID											[owning_user]			--owning user is the primary inspector
	,'D0483132-B964-EB11-A812-000D3AF38846'												[OWNING_TEAM]			--OWNING TEAM = TDG Team
	,'D0483132-B964-EB11-A812-000D3AF38846'												[OWNER]					--OWNER = primary inspector
	,'team'																				[OWNER_TYPE]			--OWNER TYPE = systemuser
	
	--contact
	,CONTACT_EMAIL
	
	--phones
	,CONTACT_BUSINESS_PHONE
	,CONTACT_TFH
	,CONTACT_PHONE

	--account
	,id accountname
	,'account' parentcustomeridtype
	
	--identification
	,CONTACT_FIRST_NAME, 
	LEFT(CONTACT_LAST_NAME, 50) CONTACT_LAST_NAME,  
	USER_CONTACT [fullname]
FROM
(
	SELECT NEWID() contactid, ACCOUNTS.id, ACCOUNTS.name, IIS.CONTACT_BUSINESS_PHONE, IIS.CONTACT_EMAIL, IIS.CONTACT_PHONE, IIS.CONTACT_TFH, IIS.USER_CONTACT

	,CASE 
		WHEN Charindex(' ', USER_CONTACT) = 0 THEN 'TDG'
		ELSE TRIM(Substring(USER_CONTACT, 1,Charindex(' ', USER_CONTACT)-1))
	END CONTACT_FIRST_NAME,
		
	CASE 
		WHEN Charindex(' ', USER_CONTACT) = 0 THEN 'CORE'
		ELSE TRIM(Substring(USER_CONTACT, Charindex(' ', USER_CONTACT)+1, LEN(USER_CONTACT)))
	END CONTACT_LAST_NAME


	FROM [dbo].[04_ACCOUNT] ACCOUNTS
	JOIN [dbo].[10_IIS_EXPORT] IIS ON ACCOUNTS.ovs_iisid = IIS.STAKEHOLDER_ID
	WHERE IIS.USER_CONTACT <> '' and IIS.USER_CONTACT IS NOT NULL
) T;


UPDATE [11_CONTACT] 
SET parentcustomeridtype = 'account';


--Set contacts to primary contact of the account
update [04_ACCOUNT]
SET 
primarycontactid = t1.Id, 
ovs_primarycontactemail = t1.emailaddress1, 
ovs_primarycontactphone = t1.telephone1
FROM [11_CONTACT] t1
JOIN [04_ACCOUNT] t2 on t1.accountid = t2.id and t1.accountid = T2.Id


update [11_CONTACT]
SET
accountid = T1.Id, 
company = t1.Id
FROM [04_ACCOUNT] t1
JOIN [11_CONTACT] t2 on t1.Id = t2.accountid and t1.Id = T2.accountid


-----===END CONTACTS