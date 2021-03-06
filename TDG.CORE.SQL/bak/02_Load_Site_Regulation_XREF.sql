TRUNCATE TABLE DBO.[03_SITES];


INSERT INTO [dbo].[03_SITES]
           ([SITE_ID]
           ,[IIS_ID]
           ,[REGULATED_ENTITY_ID]
           ,[REGULATED_ENTITY_ID_SOURCE]
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
NULL [MATCHING_ID],
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
    SITES.[REGULATED_ENTITY_ID_SOURCE] = REGENT.REGULATED_ENTITY_ID
FROM 
    [dbo].[03_SITES] as SITES
    INNER JOIN DBO.[02_REGULATED_ENTITIES] as REGENT ON SITES.[REGULATED_ENTITY_ID_SOURCE] = REGENT.[REGULATED_ENTITY_ID_SOURCE];



SELECT [SITE_ID]
      ,[IIS_ID]
      ,[REGULATED_ENTITY_ID]
      ,[REGULATED_ENTITY_ID_SOURCE]
      ,[COMPANY_NAME_FORMATTED]
      ,[COMPANY_NAME]
      ,[COUNTRY_SUBDIVISION_CD]
      ,[CITY_TOWN_NAME_NM]
      ,[ADDRESS]
      ,[POSTAL_CODE_TXT]
      ,[COMPLETED]
      ,[PLANNED2021]
  FROM [dbo].[03_SITES]

GO
