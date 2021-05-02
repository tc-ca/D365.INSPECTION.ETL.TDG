/****** Object:  Table [dbo].[04_ACCOUNT]    Script Date: 4/18/2021 11:46:23 PM ******/
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
NULL																			[parentaccountid]

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


--link to regulated entities that have the exact match of company name
UPDATE SITES
SET 
    SITES.[parentaccountid] = REGENT.REGULATED_ENTITY_ID
FROM 
    #TEMP_ACCOUNTS as SITES
    INNER JOIN DBO.[02_REGULATED_ENTITIES] as REGENT ON UPPER(dbo.fn_StripCharacters(SITES.[REGULATED_ENTITY_ID_SOURCE], '^a-z0-9')) = UPPER(dbo.fn_StripCharacters(REGENT.[REGULATED_ENTITY_ID_SOURCE], '^a-z0-9'));


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




