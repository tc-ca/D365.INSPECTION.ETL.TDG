--DEFAULT MASTER DATA
BEGIN
	DECLARE @CONST_WORKORDERTYPE_INSPECTION           VARCHAR(50) = 'b1ee680a-7cf7-ea11-a815-000d3af3a7a7';
	DECLARE @CONST_OVERSIGHTTYPE_GCTARGETED           VARCHAR(50) = '50D0BDF1-269E-EB11-B1AC-000D3AE924D1';
	DECLARE @CONST_OVERSIGHTTYPE_MOCTARGETED          VARCHAR(50) = '864BAA27-279E-EB11-B1AC-000D3AE924D1';
	DECLARE @CONST_OVERSIGHTTYPE_GCCONSIGNMENT        VARCHAR(50) = '460B6C2A-5F9C-EB11-B1AC-000D3AE92708';
	DECLARE @CONST_OVERSIGHTTYPE_MOCOPPORTUNITY       VARCHAR(50) = 'F6A0B96E-5F9C-EB11-B1AC-000D3AE92708';
	DECLARE @CONST_OVERSIGHTTYPE_CIVDOCREVIEW         VARCHAR(50) = 'A4965081-5F9C-EB11-B1AC-000D3AE92708';
	DECLARE @CONST_OVERSIGHTTYPE_RATIONALE_PLANNED    VARCHAR(50) = '994c3ec1-c104-eb11-a813-000d3af3a7a7';
	DECLARE @CONST_OVERSIGHTTYPE_RATIONALE_UNPLANNED  VARCHAR(50) = '47f438c7-c104-eb11-a813-000d3af3a7a7';
	DECLARE @CONST_TDGCORE_BOOKABLE_RESOURCE_ID       VARCHAR(50) = '2cfc9150-d6a3-eb11-b1ac-000d3ae8bee7';
	DECLARE @CONST_PRICELISTID                        VARCHAR(50) = 'B92B6A16-7CF7-EA11-A815-000D3AF3A7A7'; 
	DECLARE @CONST_RATIONALE_PLANNED                  VARCHAR(50) = '994C3EC1-C104-EB11-A813-000D3AF3A7A7';
	DECLARE @CONST_RATIONALE_UNPLANNED                VARCHAR(50) = '47F438C7-C104-EB11-A813-000D3AF3A7A7';

	--these variables can change with the environment, so double check these match the environment you're syncing to
	DECLARE @CONST_TDGCORE_USERID                     VARCHAR(50) = 'ae39bb8b-4b92-eb11-b1ac-000d3ae85ba1';
	DECLARE @CONST_TDGCORE_DOMAINNAME                 VARCHAR(50) = 'tdg.core@034gc.onmicrosoft.com';
	DECLARE @CONST_TDG_TEAMID                         VARCHAR(50) = 'ed81d4e5-55b7-eb11-8236-0022483bc30f';
	DECLARE @CONST_TDG_TEAMNAME                       VARCHAR(50) = 'TDG / TMD';
	DECLARE @CONST_TDG_BUSINESSUNITID                 VARCHAR(50) = '4E122E0C-73F3-EA11-A815-000D3AF3AC0D';

END


--PRE-MIGRATION SANTIY CHECKS
--===================================================================================================
--===================================================================================================
--staging tables should be empty before conversion
SELECT COUNT(*) [02_REGULATED_ENTITIES]              FROM [dbo].[02_REGULATED_ENTITIES];
SELECT COUNT(*) [03_SITES]                           FROM [dbo].[03_SITES];
SELECT COUNT(*) [04_ACCOUNT]                         FROM [dbo].[04_ACCOUNT];
SELECT COUNT(*) [06_WORK_ORDERS]                     FROM [dbo].[06_WORK_ORDERS];
SELECT COUNT(*) [07_VIOLATIONS]                      FROM [dbo].[07_VIOLATIONS];
SELECT COUNT(*) [11_CONTACT]                         FROM [dbo].[11_CONTACT];
SELECT COUNT(*) [18_BOOKABLE_RESOURCE_CATEGORY_ASSN] FROM [dbo].[18_BOOKABLE_RESOURCE_CATEGORY_ASSN]; --staging tables for master lookup data should have values
SELECT COUNT(*) [12_BOOKABLE_RESOURCE]               FROM [dbo].[12_BOOKABLE_RESOURCE];
SELECT COUNT(*) [17_BOOKABLE_RESOURCE_CATEGORIES]    FROM [dbo].[17_BOOKABLE_RESOURCE_CATEGORIES];
SELECT COUNT(*) [21_TYRATIONAL]                      FROM [dbo].[21_TYRATIONAL];
SELECT COUNT(*) [22_OVERSIGHTTYPE]                   FROM [dbo].[22_OVERSIGHTTYPE];
SELECT COUNT(*) [23_TERRITORY]                       FROM [dbo].[23_TERRITORY];
SELECT COUNT(*) [24_WORKORDERTYPE]                   FROM [dbo].[24_WORKORDERTYPE];

--try to match up the staging records with records in CRM by id and make sure they exist in CRM with the same ID
SELECT 
(SELECT COUNT(*) bookableresources FROM [dbo].tdgdata__bookableresource) bookableresources,
(SELECT COUNT(*) bookableresources FROM [dbo].[12_BOOKABLE_RESOURCE]) stagingbookableresources,
(
	SELECT COUNT(*) FROM
	(
		SELECT t1.bookableresourceid, t1.name FROM dbo.tdgdata__bookableresource T1 
		JOIN dbo.[12_BOOKABLE_RESOURCE] T2 
		ON T2.bookableresourceid = T1.bookableresourceid
	) T
) book_rsrces_with_matching_ids

--verify hardcoded values inserted in scripts have been loaded and exist in crm database before running conversion
SELECT [msdyn_name] msdyn_workordertype FROM tdgdata__msdyn_workordertype    WHERE msdyn_workordertypeid = @CONST_WORKORDERTYPE_INSPECTION;
SELECT [ovs_name] gc_targeted           FROM tdgdata__ovs_oversighttype		where ovs_oversighttypeid   = @CONST_OVERSIGHTTYPE_GCTARGETED;
SELECT [ovs_name] moc_targeted          FROM tdgdata__ovs_oversighttype		where ovs_oversighttypeid   = @CONST_OVERSIGHTTYPE_MOCTARGETED;
SELECT [ovs_name] gc_consignment        FROM tdgdata__ovs_oversighttype		where ovs_oversighttypeid   = @CONST_OVERSIGHTTYPE_GCCONSIGNMENT;
SELECT [ovs_name] moc_opportunity       FROM tdgdata__ovs_oversighttype		where ovs_oversighttypeid   = @CONST_OVERSIGHTTYPE_MOCOPPORTUNITY;
SELECT [ovs_name] civ_doc_review        FROM tdgdata__ovs_oversighttype		where ovs_oversighttypeid   = @CONST_OVERSIGHTTYPE_CIVDOCREVIEW ;
SELECT [ovs_name] ovs_tyrational        FROM tdgdata__ovs_tyrational         WHERE ovs_tyrationalid      = @CONST_OVERSIGHTTYPE_RATIONALE_PLANNED;
SELECT [ovs_name] ovs_tyrational        FROM tdgdata__ovs_tyrational         WHERE ovs_tyrationalid      = @CONST_OVERSIGHTTYPE_RATIONALE_UNPLANNED
SELECT [name] tdgcore_bookable_resource FROM tdgdata__bookableresource		WHERE bookableresourceid    = @CONST_TDGCORE_BOOKABLE_RESOURCE_ID;
SELECT systemuserid tdgcore_systemuser	FROM tdgdata__systemuser             WHERE systemuserid          = @CONST_TDGCORE_USERID;
SELECT [fullname] tdgcore_fullname		FROM tdgdata__systemuser             WHERE domainname            = @CONST_TDGCORE_DOMAINNAME;
SELECT [name] tdgteam                   FROM tdgdata__team                   WHERE teamid                = @CONST_TDG_TEAMID;
SELECT [name] tdgteamname				FROM tdgdata__team                   WHERE [name]                = @CONST_TDG_TEAMNAME;
SELECT [name] defaultpricelevel			FROM tdgdata__pricelevel             WHERE pricelevelid          = @CONST_PRICELISTID;
SELECT [name] tdgbusinessunit           FROM tdgdata__businessunit           WHERE businessunitid        = @CONST_TDG_BUSINESSUNITID;

select [name] territories    FROM tdgdata__territory t1 JOIN [05_TERRITORY_TRANSLATION] t2 on t1.territoryid = t2.msdyn_serviceterritory;
--===================================================================================================
--===================================================================================================
