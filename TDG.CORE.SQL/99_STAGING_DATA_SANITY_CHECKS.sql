﻿--DECLARE CONSTANTS
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

	SELECT @CONST_TDGCORE_DOMAINNAME TDGCORE_DOMAINNAME, @CONST_TDGCORE_USERID TDGCORE_USERID, @CONST_TEAM_TDG_ID TEAM_TDG_NAME, @CONST_BUSINESSUNIT_TDG_ID BUSINESSUNIT_TDG_ID, @CONST_PRICELISTID PRICELISTID;

	--===================================================================================================


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



--SCRIPTS TO CHECK DATA INTEGRITY BEFORE LOADING INTO CRM
--===================================================================================================
--===================================================================================================

DECLARE @crm_workorders_w_invalid_bookable_resources int = 0;
DECLARE @crm_bookableresource_count int = 0;
DECLARE @stage_inspections_count int = 0;
DECLARE @stage_bookableresource_count int = 0;
DECLARE @WO_OWNED_BY_WRONG_PEOPLE INT = 0;
DECLARE @WO_WITH_INVALID_ACCOUNTS INT = 0;
DECLARE @CONTACTS_WITH_INVALID_ACCOUNTS INT = 0;

--no workorders with non-existing bookableresources
SELECT @crm_workorders_w_invalid_bookable_resources = COUNT(*)
FROM CRM__SYSTEMUSER
JOIN STAGING__BOOKABLE_RESOURCE T1 ON CRM__SYSTEMUSER.systemuserid = T1.userid
WHERE systemuserid IN
(
	SELECT T1.ownerid 
	FROM STAGING__WORK_ORDERS T1
	where T1.ovs_primaryinspector not in 
	(
		SELECT bookableresourceid FROM STAGING__BOOKABLE_RESOURCE
	)
);

--records should only be owned by the tdg team or the primary inspector
SELECT @WO_OWNED_BY_WRONG_PEOPLE = COUNT(*) 
FROM STAGING__WORK_ORDERS T1
where T1.[ownerid] not in 
(
	SELECT userid FROM STAGING__BOOKABLE_RESOURCE
)
AND T1.ownerid <> @CONST_TEAM_TDG_ID;


SELECT @stage_bookableresource_count = COUNT(*) FROM STAGING__BOOKABLE_RESOURCE;
SELECT @stage_inspections_count = COUNT(*) FROM dbo.STAGING__WORK_ORDERS;


--no inspections for sites that dont exists
SELECT @WO_WITH_INVALID_ACCOUNTS = COUNT(*)
FROM STAGING__WORK_ORDERS T1
where T1.msdyn_serviceaccount not in 
(
	SELECT accountid FROM dbo.STAGING__ACCOUNT
)

--no contacts linked to sites that dont exists
SELECT @CONTACTS_WITH_INVALID_ACCOUNTS = COUNT(*) 
FROM dbo.STAGING__CONTACT T1
where T1.company not in 
(
	SELECT accountid FROM dbo.STAGING__ACCOUNT
)


select @crm_workorders_w_invalid_bookable_resources crm_workorders_w_invalid_bookable_resources, @stage_bookableresource_count stage_bookableresource_count, @stage_inspections_count stage_inspections_count,
@WO_OWNED_BY_WRONG_PEOPLE WO_OWNED_BY_WRONG_PEOPLE, @WO_WITH_INVALID_ACCOUNTS WO_WITH_INVALID_ACCOUNTS, @CONTACTS_WITH_INVALID_ACCOUNTS CONTACTS_WITH_INVALID_ACCOUNTS


--staging data check; tables should no longer be empty

SELECT 
(SELECT COUNT(*) FROM [dbo].SOURCE__REGULATED_ENTITIES) CONSOLIDATION_SHEET_REGULATED_ENTITIES,
(SELECT COUNT(*) FROM [dbo].SOURCE__SITES) CONSOLIDATION_SHEET_SITES,
(SELECT COUNT(*) FROM [dbo].STAGING__ACCOUNT WHERE ovs_iisid NOT IN (SELECT IIS_ID FROM SOURCE__DATA_CONSOLIDATION)) IIS_SITES_NOT_IN_CONSOLIDATION,
(SELECT COUNT(*) FROM [dbo].STAGING__ACCOUNT) REGENT_SITES_FROM_CONSOLIDATION_PLUS_IIS_SITES,
(SELECT COUNT(*) FROM [dbo].STAGING__WORK_ORDERS) [WORK_ORDERS],
(SELECT COUNT(*) FROM [dbo].STAGING__VIOLATIONS) [VIOLATIONS],
(SELECT COUNT(*) FROM [dbo].STAGING__CONTACT) [CONTACT],
(SELECT COUNT(*) FROM [dbo].STAGING__BOOKABLE_RESOURCE) [BOOKABLE_RESOURCE],
(SELECT COUNT(*) FROM [dbo].STAGING__BOOKABLE_RESOURCE_CATEGORY_ASSN) [BOOKABLE_RESOURCE_CATEGORY_ASSN] 


select * from STAGING__ACCOUNT where name is null and ovs_legalname is null;


SELECT 
(SELECT COUNT(*) FROM STAGING__WORK_ORDERS WHERE ovs_fiscalyearname = '2021-2022') INSPECTIONS_2021_2022,
(SELECT COUNT(*) FROM STAGING__WORK_ORDERS WHERE ovs_fiscalyearname = '2020-2021') INSPECTIONS_2020_2021,
(SELECT COUNT(*) FROM STAGING__WORK_ORDERS WHERE ovs_iisactivityid IS NULL) INSPECTIONS_NO_IIS_ACTIVITYID,
(SELECT COUNT(*) FROM SOURCE__WORKPLAN_IMPORT WHERE fiscal_year = '2021-2022' AND CURRENTLY_PLANNED = '1') WORKPLAN_2021_2022_PLANNED



SELECT * FROM 
SOURCE__WORKPLAN_IMPORT T1 
LEFT JOIN STAGING__WORK_ORDERS T2 ON T1.fiscal_year = T2.ovs_fiscalyearname AND T1.IIS_ID = T2.ovs_iisid
WHERE T1.fiscal_year = '2021-2022' AND T1.CURRENTLY_PLANNED = 1
AND T2.Id IS NULL;


--VIOLATION CHECKS
--===================================================================================================
--THERE ARE NO VIOLATIONS LINKED TO LEGISLATION THAT DONT EXIST
DECLARE @STAGED_LEGISLATION_COUNT INT = 0;
DECLARE @STAGED_VIOLATION_COUNT INT = 0;
DECLARE @VIOLATIONS_MATCHED_TO_LEGISLATION_COUNT INT = 0;

SELECT @STAGED_LEGISLATION_COUNT = COUNT(*) FROM STAGING__tylegislation;
SELECT @STAGED_VIOLATION_COUNT = COUNT(*) FROM STAGING__VIOLATIONS;

SELECT @VIOLATIONS_MATCHED_TO_LEGISLATION_COUNT = COUNT(*) FROM STAGING__VIOLATIONS T1
JOIN STAGING__tylegislation T2 ON T1.qm_rclegislationid = T2.qm_rclegislationid;

SELECT @STAGED_LEGISLATION_COUNT STAGED_LEGISLATION_COUNT, @STAGED_VIOLATION_COUNT STAGED_VIOLATION_COUNT, @VIOLATIONS_MATCHED_TO_LEGISLATION_COUNT VIOLATIONS_MATCHED_TO_LEGISLATION_COUNT;
--===================================================================================================


--===================================================================================================
--===================================================================================================



--DATA INTEGRITY CHECKS FOR AFTER DATA HAS BEEN LOADED TO CRM
--===================================================================================================
--===================================================================================================

--how many accounts were migrated
SELECT COUNT(*) crm_accounts_joined_to_staged_accounts FROM 
[dbo].tdgdata__account T1
JOIN [dbo].STAGING__ACCOUNT T2 ON T1.accountid = T2.id

--how many contacts were assigned to sites
SELECT COUNT(*) crm_accounts_linked_to_staged_contacts FROM 
[dbo].tdgdata__account T1 
JOIN [dbo].STAGING__CONTACT T2 ON T1.accountid = T2.accountid
WHERE T1.customertypecode <> 948010000;   

--how many contacts were migrated
SELECT COUNT(*) crm_contacts_linked_to_staged_contacts FROM 
[dbo].STAGING__CONTACT T1
JOIN [dbo].tdgdata__contact T2 ON T1.accountid = T2.parentcustomerid;

--match work order staging table to replicated crm work order table to see how many work order were created in crm
SELECT COUNT(*) crm_workorders_linked_to_staged_workorders FROM  
[dbo].STAGING__WORK_ORDERS T1
JOIN [dbo].tdgdata__msdyn_workorder T2 ON T1.msdyn_workorderid = T2.msdyn_workorderid;

--no workorders in staging table with a null rational or oversight type
SELECT COUNT(*) workorders_w_no_oversight_type_or_rationale FROM 
[dbo].STAGING__WORK_ORDERS T1
WHERE T1.ovs_rational IS NULL OR T1.ovs_oversighttype IS NULL;

--match violation staging table to replicated crm violation table to see how many violations were created in crm
SELECT COUNT(*) crm_violations_linked_to_staged_violations FROM 
[dbo].STAGING__VIOLATIONS T1
JOIN [dbo].tdgdata__qm_syresult T2 ON T1.qm_syresultid = T2.qm_syresultid;
--=========================================================================================================
--=========================================================================================================

