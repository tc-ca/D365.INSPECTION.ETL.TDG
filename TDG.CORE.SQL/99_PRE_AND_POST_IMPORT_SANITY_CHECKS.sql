--DEFAULT MASTER DATA
	--============================================STATIC VALUES==========================================
	--OVERSIGHT TYPES
	DECLARE @CONST_OVERSIGHTTYPE_GCTARGETED              VARCHAR(50) = '72afccd3-269e-eb11-b1ac-000d3ae924d1';
	DECLARE @CONST_OVERSIGHTTYPE_GCIPT                   VARCHAR(50) = '50D0BDF1-269E-EB11-B1AC-000D3AE924D1';
	DECLARE @CONST_OVERSIGHTTYPE_MOCTARGETED             VARCHAR(50) = '864BAA27-279E-EB11-B1AC-000D3AE924D1';
	DECLARE @CONST_OVERSIGHTTYPE_GCCONSIGNMENT           VARCHAR(50) = '460B6C2A-5F9C-EB11-B1AC-000D3AE92708';
	DECLARE @CONST_OVERSIGHTTYPE_MOCOPPORTUNITY          VARCHAR(50) = 'F6A0B96E-5F9C-EB11-B1AC-000D3AE92708';
	DECLARE @CONST_OVERSIGHTTYPE_CIVDOCREVIEW            VARCHAR(50) = 'A4965081-5F9C-EB11-B1AC-000D3AE92708';
	DECLARE @CONST_OVERSIGHTTYPE_GC_CEP                  VARCHAR(50) = 'abf3c4d9-269e-eb11-b1ac-000d3ae924d1';
	DECLARE @CONST_OVERSIGHTTYPE_GC_FOLLOWUP             VARCHAR(50) = '1cd7bd09-279e-eb11-b1ac-000d3ae924d1';
	DECLARE @CONST_OVERSIGHTTYPE_GC_TRIGGERED            VARCHAR(50) = '9dee7316-5f9c-eb11-b1ac-000d3ae92708';
	DECLARE @CONST_OVERSIGHTTYPE_GC_OPPORTUNITY          VARCHAR(50) = '07966e1c-5f9c-eb11-b1ac-000d3ae92708';
	DECLARE @CONST_OVERSIGHTTYPE_GC_UNDECLARED           VARCHAR(50) = '1cc06b3f-5f9c-eb11-b1ac-000d3ae92708';
	DECLARE @CONST_OVERSIGHTTYPE_MOC_FACILITY_IPT        VARCHAR(50) = 'e99ab21b-279e-eb11-b1ac-000d3ae924d1';
	DECLARE @CONST_OVERSIGHTTYPE_MOC_FACILITY_FOLLOWUP   VARCHAR(50) = 'c1e09a33-279e-eb11-b1ac-000d3ae924d1';
	DECLARE @CONST_OVERSIGHTTYPE_MOC_FACILITY_TRIGGERED  VARCHAR(50) = 'ea95bc68-5f9c-eb11-b1ac-000d3ae92708';

	--WORK ORDER TYPES
	DECLARE @CONST_WORKORDERTYPE_INSPECTION              VARCHAR(50) = 'b1ee680a-7cf7-ea11-a815-000d3af3a7a7';
	DECLARE @CONST_WORKORDERTYPE_REGULATORYAUTHORIZATION VARCHAR(50) = '46706c0a-ad60-eb11-a812-000d3ae9471c';

	--RATIONALS
	DECLARE @CONST_RATIONALE_PLANNED                     VARCHAR(50) = '994C3EC1-C104-EB11-A813-000D3AF3A7A7';
	DECLARE @CONST_RATIONALE_UNPLANNED                   VARCHAR(50) = '47F438C7-C104-EB11-A813-000D3AF3A7A7';

	--BOOKABLE RESOURCE CATEGORY
	DECLARE @CONST_CATEGORY_INSPECTOR                    VARCHAR(50) = '06DB6E56-01F9-EA11-A815-000D3AF3AC0D';

	--TERRITORIES / REGIONS
	DECLARE @CONST_TERRITORY_HQ_ES                       VARCHAR(50) = '2e7b2f75-989c-eb11-b1ac-000d3ae92708';
	DECLARE @CONST_TERRITORY_HQ_CR                       VARCHAR(50) = '52c72783-989c-eb11-b1ac-000d3ae92708';
	DECLARE @CONST_TERRITORY_ATLANTIC                    VARCHAR(50) = 'FAB76E9E-1707-EB11-A813-000D3AF3A0D7';
	DECLARE @CONST_TERRITORY_QUEBEC                      VARCHAR(50) = 'FCB76E9E-1707-EB11-A813-000D3AF3A0D7';
	DECLARE @CONST_TERRITORY_PACIFIQUE                   VARCHAR(50) = 'FEB76E9E-1707-EB11-A813-000D3AF3A0D7';
	DECLARE @CONST_TERRITORY_PNR                         VARCHAR(50) = '02B86E9E-1707-EB11-A813-000D3AF3A0D7';
	DECLARE @CONST_TERRITORY_ONTARIO                     VARCHAR(50) = '50B21A84-DB04-EB11-A813-000D3AF3AC0D';
	--===================================================================================================

	--=============================================DYNAMIC VALUES===========================================
	DECLARE @CONST_TDGCORE_DOMAINNAME  VARCHAR(50)  = 'tdg.core@034gc.onmicrosoft.com';
	DECLARE @CONST_TDGCORE_USERID      VARCHAR(50)  = (SELECT systemuserid FROM CRM__SYSTEMUSER  where domainname = 'tdg.core@034gc.onmicrosoft.com');
	DECLARE @CONST_TEAM_TDG_ID          VARCHAR(500) = (SELECT teamid FROM CRM__TEAM WHERE name = 'Transportation of Dangerous Goods');
	DECLARE @CONST_BUSINESSUNIT_TDG_ID VARCHAR(50)  = (SELECT businessunitid FROM CRM__BUSINESSUNIT WHERE name = 'Transportation of Dangerous Goods');
	DECLARE @CONST_PRICELISTID         VARCHAR(50)  = (SELECT pricelevelid FROM CRM__pricelevel  WHERE NAME = 'Base Prices');
	DECLARE @CONST_TDGCORE_BOOKABLE_RESOURCE_ID VARCHAR(50) = (SELECT bookableresourceid FROM STAGING__BOOKABLE_RESOURCE WHERE msdyn_primaryemail = @CONST_TDGCORE_DOMAINNAME);
	

	--CRM CONSTANTS
	DECLARE @CONST_OWNERIDTYPE_TEAM VARCHAR(50)			= 'team';
	DECLARE @CONST_OWNERIDTYPE_SYSTEMUSER VARCHAR(50)	= 'systemuser';
	--===================================================================================================
	

--PRE-MIGRATION SANTIY CHECKS
--===================================================================================================
--===================================================================================================
--staging tables should be empty before conversion
SELECT COUNT(*) [CRM__BOOKABLERESOURCE]	FROM [dbo].[CRM__BOOKABLERESOURCE] 											  ;
SELECT COUNT(*) [CRM__BUSINESSUNIT]		FROM [dbo].[CRM__BUSINESSUNIT] 												  ;
SELECT COUNT(*) [CRM__PRICELEVEL]			FROM [dbo].[CRM__PRICELEVEL] 											  ;
SELECT COUNT(*) [CRM__SYSTEMUSER]			FROM [dbo].[CRM__SYSTEMUSER] 											  ;
SELECT COUNT(*) [CRM__TEAM]				FROM [dbo].[CRM__TEAM] 														  ;
SELECT COUNT(*) [CrmCountHistory]			FROM [dbo].[CrmCountHistory] 											  ;
SELECT COUNT(*) [ERRORS__ACCOUNT_UNNUMBER] FROM [dbo].[ERRORS__ACCOUNT_UNNUMBER] 									  ;
SELECT COUNT(*) [ERRORS__BUSINESSUNIT]	 FROM [dbo].[ERRORS__BUSINESSUNIT] 											  ;
SELECT COUNT(*) [ERRORS__COC]				 FROM [dbo].[ERRORS__COC] 												  ;
SELECT COUNT(*) [SSIS_RegulatedEntityErrors]	FROM [dbo].[SSIS_RegulatedEntityErrors] 							  ;
SELECT COUNT(*) [SSIS_SiteErrors]					FROM [dbo].[SSIS_SiteErrors] 									  ;
SELECT COUNT(*) [SSIS_WorkOrderErrors]			FROM [dbo].[SSIS_WorkOrderErrors] 									  ;
SELECT COUNT(*) [STAGING__ACCOUNT]				FROM [dbo].[STAGING__ACCOUNT] 										  ;
SELECT COUNT(*) [STAGING__accountclass]			FROM [dbo].[STAGING__accountclass] 									  ;
SELECT COUNT(*) [STAGING__ACCOUNTUN]				FROM [dbo].[STAGING__ACCOUNTUN] 								  ;
SELECT COUNT(*) [STAGING__AIR_OPERATOR_FUNCTION]	FROM [dbo].[STAGING__AIR_OPERATOR_FUNCTION] 					  ;
SELECT COUNT(*) [STAGING__AIR_OPERATOR_TYPE]		FROM [dbo].[STAGING__AIR_OPERATOR_TYPE] 						  ;
SELECT COUNT(*) [STAGING__AIRCRAFT_TYPE]			FROM [dbo].[STAGING__AIRCRAFT_TYPE] 							  ;
SELECT COUNT(*) [STAGING__BOOKABLE_RESOURCE]					FROM [dbo].[STAGING__BOOKABLE_RESOURCE] 			  ;
SELECT COUNT(*) [STAGING__BOOKABLE_RESOURCE_CATEGORIES]	 FROM [dbo].[STAGING__BOOKABLE_RESOURCE_CATEGORIES] 		  ;
SELECT COUNT(*) [STAGING__BOOKABLE_RESOURCE_CATEGORY_ASSN] FROM [dbo].[STAGING__BOOKABLE_RESOURCE_CATEGORY_ASSN] 	  ;
SELECT COUNT(*) [STAGING__COC] FROM [dbo].[STAGING__COC] 															  ;
SELECT COUNT(*) [STAGING__CONTACT] FROM [dbo].[STAGING__CONTACT] 													  ;
SELECT COUNT(*) [STAGING__ENVIRONMENT_SETTINGS] FROM [dbo].[STAGING__ENVIRONMENT_SETTINGS] 							  ;
SELECT COUNT(*) [STAGING__EQUIPMENT_TYPE] FROM [dbo].[STAGING__EQUIPMENT_TYPE] 										  ;
SELECT COUNT(*) [STAGING__MOC_FACILITY_TYPE] FROM [dbo].[STAGING__MOC_FACILITY_TYPE] 								  ;
SELECT COUNT(*) [STAGING__MOC_TYPE] FROM [dbo].[STAGING__MOC_TYPE] 													  ;
SELECT COUNT(*) [STAGING__MODES] FROM [dbo].[STAGING__MODES] 														  ;
SELECT COUNT(*) [STAGING__OVERSIGHTTYPE] FROM [dbo].[STAGING__OVERSIGHTTYPE] 										  ;
SELECT COUNT(*) [STAGING__TERRITORY] FROM [dbo].[STAGING__TERRITORY] 												  ;
SELECT COUNT(*) [STAGING__tylegislation] FROM [dbo].[STAGING__tylegislation] 										  ;
SELECT COUNT(*) [STAGING__tylegislationsource] FROM [dbo].[STAGING__tylegislationsource] 							  ;
SELECT COUNT(*) [STAGING__tylegislationtype] FROM [dbo].[STAGING__tylegislationtype] 								  ;
SELECT COUNT(*) [STAGING__TYRATIONAL] FROM [dbo].[STAGING__TYRATIONAL] 												  ;
SELECT COUNT(*) [STAGING__UNPLANNED_FORECAST] FROM [dbo].[STAGING__UNPLANNED_FORECAST] 								  ;
SELECT COUNT(*) [STAGING__VIOLATIONS] FROM [dbo].[STAGING__VIOLATIONS] 												  ;
SELECT COUNT(*) [STAGING__WORK_ORDERS] FROM [dbo].[STAGING__WORK_ORDERS] 											  ;
SELECT COUNT(*) [STAGING__WORKORDERTYPE] FROM [dbo].[STAGING__WORKORDERTYPE] 										  ;
SELECT COUNT(*) [STAGING_UN_NUMBERS]	FROM [dbo].[STAGING_UN_NUMBERS]												  ;

--try to match up the staging records with records in CRM by id and make sure they exist in CRM with the same ID
SELECT 
(SELECT COUNT(*) bookableresources FROM [dbo].tdgdata__bookableresource) bookableresources,
(SELECT COUNT(*) bookableresources FROM [dbo].STAGING__BOOKABLE_RESOURCE) stagingbookableresources,
(
	SELECT COUNT(*) FROM
	(
		SELECT t1.bookableresourceid, t1.name FROM dbo.tdgdata__bookableresource T1 
		JOIN dbo.STAGING__BOOKABLE_RESOURCE T2 
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
SELECT [ovs_name] ovs_tyrational        FROM tdgdata__ovs_tyrational         WHERE ovs_tyrationalid      = @CONST_RATIONALE_PLANNED;
SELECT [ovs_name] ovs_tyrational        FROM tdgdata__ovs_tyrational         WHERE ovs_tyrationalid      = @CONST_RATIONALE_UNPLANNED
SELECT [name] tdgcore_bookable_resource FROM tdgdata__bookableresource		WHERE bookableresourceid     = @CONST_TDGCORE_BOOKABLE_RESOURCE_ID;
SELECT systemuserid tdgcore_systemuser	FROM tdgdata__systemuser             WHERE systemuserid          = @CONST_TDGCORE_USERID;
SELECT [fullname] tdgcore_fullname		FROM tdgdata__systemuser             WHERE domainname            = @CONST_TDGCORE_DOMAINNAME;
SELECT [name] tdgteam                   FROM tdgdata__team                   WHERE teamid                = @CONST_TEAM_TDG_ID;
SELECT [name] defaultpricelevel			FROM tdgdata__pricelevel             WHERE pricelevelid          = @CONST_PRICELISTID;
SELECT [name] tdgbusinessunit           FROM tdgdata__businessunit           WHERE businessunitid        = @CONST_BUSINESSUNIT_TDG_ID;

select [name] territories    FROM tdgdata__territory t1 JOIN SOURCE__TERRITORY_TRANSLATION t2 on t1.territoryid = t2.msdyn_serviceterritory;



--LEGISLATION CHECKS
--SANITY CHECKS
--how many match from replicated data to staging data
DECLARE @stagingCount int           = 0;
DECLARE @crmCount     int           = 0;
DECLARE @matchCount   int           = 0;
DECLARE @legislationSourceCount INT = 0;
DECLARE @legislationTypeSourceCount INT   = 0;
DECLARE @legTypeMatchCount INT      = 0;
DECLARE @legSourceMatchCount INT      = 0;

SELECT @stagingCount = COUNT(*) 
FROM [STAGING__tylegislation];

SELECT @legislationSourceCount = COUNT(*) 
FROM [STAGING__tylegislationsource];

SELECT @legislationTypeSourceCount = COUNT(*) 
FROM [STAGING__tylegislationtype];

SELECT @crmCount = COUNT(*) 
FROM tdgdata__qm_rclegislation;

SELECT @matchCount = COUNT(*) 
FROM [dbo].[tdgdata__qm_rclegislation] T1
JOIN [STAGING__tylegislation] T2 ON T1.qm_name = T2.qm_name;

SELECT @legTypeMatchCount = COUNT(*) 
FROM [dbo].tdgdata__qm_tylegislationtype T1
JOIN [STAGING__tylegislationtype] T2 ON T1.qm_name = T2.qm_name;

SELECT @legSourceMatchCount = COUNT(*) 
FROM [dbo].tdgdata__qm_tylegislationsource T1
JOIN STAGING__tylegislationsource T2 ON T1.qm_name = T2.qm_name;

SELECT @stagingCount staged_record_count, @crmCount crm_record_count, @matchCount records_matched_by_name, @legislationSourceCount legislation_Source_Count, @legislationTypeSourceCount legislation_Type_Source_Count, @legTypeMatchCount legType_Match_Count, @legSourceMatchCount legSource_Match_Count
--===================================================================================================
--===================================================================================================
