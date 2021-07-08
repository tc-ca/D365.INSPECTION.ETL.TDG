TRUNCATE TABLE DBO.[03_SITES];

INSERT INTO DBO.[03_SITES]
(
	[SITE_ID],
	[IIS_ID],
	[REGULATED_ENTITY_ID_SOURCE],
	[COMPANY_NAME_FORMATTED],
	[COMPANY_NAME],
	[COUNTRY_SUBDIVISION_CD],
	[CITY_TOWN_NAME_NM],
	[ADDRESS],
	[POSTAL_CODE_TXT],
	[COMPLETED],
	[PLANNED2021]
)


SELECT
NEWID(),
[IIS_ID],
[REGULATED_ENTITY_ID],
[COMPANY_NAME_FORMATTED],
[COMPANY_NAME],
[COUNTRY_SUBDIVISION_CD],
[CITY_TOWN_NAME_NM],
[ADDRESS],
[POSTAL_CODE_TXT],
[COMPLETED],
[PLANNED2021]
FROM [dbo].[01_IIS_DATA_CONSOLIDATION];


--get the uniqueindentifiers for regulated entities and update the site table
UPDATE SITES
SET 
    SITES.REGULATED_ENTITY_ID = REGENT.REGULATED_ENTITY_ID
FROM 
    DBO.[03_SITES] as SITES
    INNER JOIN DBO.[02_REGULATED_ENTITIES] as REGENT ON SITES.REGULATED_ENTITY_ID_SOURCE = REGENT.REGULATED_ENTITY_ID_SOURCE;


------------------------------------------------
--CONVERT SITE ENTITY RECORDS TO ACCOUNTS--
------------------------------------------------
INSERT INTO [dbo].[04_ACCOUNT]
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
[IIS_ID]																[accountnumber],
CONCAT('Converted from IIS.', CHAR(13)+CHAR(10), 'IIS ID: ', [IIS_ID])	[description],
[SITE_ID]																id,
[IIS_ID]																[ovs_iisid],
[COMPANY_NAME_FORMATTED]												[ovs_legalname],
[COMPANY_NAME_FORMATTED]												[name],
[COMPANY_NAME]															[ovs_accountnameenglish],
SITES.[COUNTRY_SUBDIVISION_CD]											[address1_stateorprovince],
[CITY_TOWN_NAME_NM]														[address1_city],
[ADDRESS]																[address1_line1],
[POSTAL_CODE_TXT]														[address1_postalcode],
'd0483132-b964-eb11-a812-000d3af38846'									[owningteam],
'4E122E0C-73F3-EA11-A815-000D3AF3AC0D'									[owningbusinessunit],
'team'																	[owneridtype],
'd0483132-b964-eb11-a812-000d3af38846'									[ownerid],
948010001																[customertypecode],
T.[msdyn_serviceterritory]												[msdyn_serviceterritory],
T.[msdyn_serviceterritory]												[territoryid],
[REGULATED_ENTITY_ID]													[parentaccountid]
FROM [dbo].[03_SITES] SITES
LEFT JOIN [dbo].[05_TERRITORY_TRANSLATION] T ON SITES.[COUNTRY_SUBDIVISION_CD] = T.[COUNTRY_SUBDIVISION_CD];