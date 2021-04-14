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
FROM [dbo].[01_IIS_DATA_CONSOLIDATION]
WHERE [REGULATED_ENTITY_ID] IN 
(
	--Only bring in sites for regulated entities that have been converted
	SELECT REGULATED_ENTITY_ID_SOURCE FROM DBO.[02_REGULATED_ENTITIES]
)


--get the uniqueindentifiers for regulated entities and update the site table
UPDATE SITES
SET 
    SITES.REGULATED_ENTITY_ID = REGENT.REGULATED_ENTITY_ID
FROM 
    DBO.[03_SITES] as SITES
    INNER JOIN DBO.[02_REGULATED_ENTITIES] as REGENT ON SITES.REGULATED_ENTITY_ID_SOURCE = REGENT.REGULATED_ENTITY_ID_SOURCE;