TRUNCATE TABLE DBO.[02_REGULATED_ENTITIES];

INSERT INTO DBO.[02_REGULATED_ENTITIES]

SELECT
NEWID(),
REGENT.REGULATED_ENTITY_ID,
SITES.IIS_ID,
REGENT.REGULATED_ENTITY_NAME,
REGENT.REGULATED_ENTITY_NAME,
REGENT.REGULATED_ENTITY_NAME,
SITES.COUNTRY_SUBDIVISION_CD,
SITES.CITY_TOWN_NAME_NM,
SITES.ADDRESS,
SITES.POSTAL_CODE_TXT,
SITES.COMPLETED,
SITES.NOTES
FROM 
(

	SELECT 
	[MATCHING_ID],
	REGULATED_ENTITY_ID,
	REGULATED_ENTITY_NAME,
	IIS_ID
	FROM [dbo].[01_IIS_DATA_CONSOLIDATION]

	--give us only the regulated entities that have unique entries
	--WHERE REGULATED_ENTITY_ID IN (
	
	--	--get regulated entities that are currently matching multiple sites
	--	--there should only be one unique entry for regulated entities.
	--	SELECT REGULATED_ENTITY_ID FROM (
	--		SELECT REGULATED_ENTITY_ID, COUNT (REGULATED_ENTITY_ID) COUNT_OF FROM (
	--			SELECT [REGULATED_ENTITY_ID], [MATCHING_ID] FROM [dbo].[01_IIS_DATA_CONSOLIDATION] 
	--			GROUP BY REGULATED_ENTITY_ID, [MATCHING_ID]
	--		) BAD_DATA
	--		GROUP BY REGULATED_ENTITY_ID
	--	) BAD_DATA_IDS
	--	WHERE COUNT_OF = 1

	--)

	GROUP BY 
	[FILE_STATUS_CD],
	[MATCHING_ID],
	[REGULATED_ENTITY_ID],
	[REGULATED_ENTITY_NAME],
	[CONSOLIDATED_COMMON_ENGLISH_NAME],
	[CONSOLIDATED_COMMON_FRENCH_NAME],
	[IIS_ID]

) REGENT,

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


WHERE 
REGENT.MATCHING_ID = SITES.IIS_ID;
--AND COMPLETED = 'Y'



SELECT [REGULATED_ENTITY_ID]
      ,[REGULATED_ENTITY_ID_SOURCE]
      ,[IIS_ID]
      ,[REGULATED_ENTITY_NAME]
      ,[CONSOLIDATED_COMMON_ENGLISH_NAME]
      ,[CONSOLIDATED_COMMON_FRENCH_NAME]
      ,[COUNTRY_SUBDIVISION_CD]
      ,[CITY_TOWN_NAME_NM]
      ,[ADDRESS]
      ,[POSTAL_CODE_TXT]
      ,[COMPLETED]
      ,[NOTES]
  FROM [dbo].[02_REGULATED_ENTITIES]

GO




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
FROM [dbo].account
WHERE customertypecode = 948010000