--Number of active sites (by regions)
--12386
--==========================================================================
select COUNT(*) [STAGING__ACCOUNT] FROM [STAGING__ACCOUNT]
WHERE customertypecode = 948010001;
--==========================================================================

--number of rows in the data consolidation excel file
--==========================================================================
SELECT COUNT(*) DATA_CONSOLIDATION from [dbo].[SOURCE__DATA_CONSOLIDATION];
--==========================================================================


--GET LIST OF COMPANIES FROM IIS, EXCLUDING NON-COMPANY TYPES
--STAKEHOLDER TYPES
--1		TC Individual
--2		External Individual
--3		TC Organization
--4		External Organization
--5		Special Interest Group
--6		Branch Office
--7		Division
--8		Headquarter
--9		Owner
--10	Regional Office
--11	SIG Member
--12	Subsidiary
--13	Company Contact
--14	Inspection Contact
--TOTAL 19661
--==========================================================================
SELECT COUNT(*) YD070_STAKEHOLDER FROM YD070_STAKEHOLDER
where STAKEHOLDER_TYPE_CD
NOT IN (
	1,	--TC Individual
	2,	--External Individual
	3,	--TC Organization
	13, --Company Contact
	14  --Inspection Contact
)
AND date_deleted_dte is null and FILE_STATUS_CD = 'ACTIVE';
--==========================================================================

--ENSURE THERE ARE 0 COMPANIES MISSING FROM ROM 
--==========================================================================
SELECT STAKEHOLDER_ID
INTO #TEMP_IIS_IDS
FROM YD070_STAKEHOLDER
where STAKEHOLDER_TYPE_CD
NOT IN (
	1,	--TC Individual
	2,	--External Individual
	3,	--TC Organization
	13, --Company Contact
	14  --Inspection Contact
)
AND date_deleted_dte is null and FILE_STATUS_CD = 'ACTIVE';


SELECT COUNT(*) missingSites 
FROM #TEMP_IIS_IDS
WHERE 
STAKEHOLDER_ID
not in
(
	SELECT ovs_iisid FROM [STAGING__ACCOUNT]
	WHERE customertypecode = 948010001
);
--==========================================================================


--COUNTS OF WORKORDERS BY OVERSIGHT TYPE
--==========================================================================
SELECT * FROM
(
	SELECT t2.ovs_name, count(t2.ovs_name) RecordCount
	FROM STAGING__WORK_ORDERS T1
	JOIN STAGING__OVERSIGHTTYPE T2 ON T2.Id = T1.ovs_oversighttype
	GROUP BY t1.ovs_oversighttype, t2.ovs_name
) T
ORDER BY RecordCount DESC;

SELECT COUNT(*) TOTAL_WORKORDERS FROM STAGING__WORK_ORDERS;
--==========================================================================



--19616

--numbers from seans email
--Atlantic	2258
--CR		68
--Ontario	5076
--Pacific	3251
--PNR		4828
--Quebec	2474
--Unknown	2

--Grand Total	17957


--exclude US - based on provided code by Roger
--include MOC - nothing special here
--Identify Alberta sites based on business category 
----Set region = PNR, Inspector Type = Alberta


--Number of active sites (by regions)

--Number of inspections completed (by region - YTD, 2021-2022)

--Number of inspections completed (by type - YTD, 2021-2022)

--Number of civil aviation document reviews (YTD, 2021-2022)

--Number of non-compliances (YTD, 2021-2022)
 
--Number of inspection report reviews (by region, 2021-2022)


--Get Enforcement Actions Done
--Send email to everyone at Jeffs Group and Sebastien 
--Heres the mapping used to convert from the excel sheet







SELECT 
SYSUSER.systemuserid, 
CONCAT(SYSUSER.firstname, ' ', SYSUSER.lastname) name, domainname, 
RIN, 
BADGE, 
SYSUSER.isdisabled, 
SYSUSER.islicensed, 
SYSUSER.issyncwithdirectory, 
RegionCrmId
FROM [dbo].CRM__SYSTEMUSER SYSUSER 
JOIN dbo.SOURCE__IIS_INSPECTORS INSP ON 
lower(TRIM(INSP.Account_name)) = lower(TRIM(SYSUSER.domainname))



select * from SOURCE__IIS_EXPORT where STAKEHOLDER_ID = 10463;

select 
 t3.name inspector
,t1.[msdyn_name]
,t1.[msdyn_address1]
,t1.[msdyn_city]
,t1.[msdyn_stateorprovince]
,t1.[msdyn_postalcode]
,t4.name
,t2.name operatingname
,t2.ovs_legalname
from STAGING__WORK_ORDERS t1
join STAGING__ACCOUNT t2 on t1.msdyn_serviceaccount = t2.Id
left join STAGING__BOOKABLE_RESOURCE t3 on t1.ovs_primaryinspector = t3.bookableresourceid
left join STAGING__TERRITORY t4 on t1.msdyn_serviceterritory = t4.territoryid
where t2.ovs_iisid in
(18853, 10119, 10139, 9290, 3033180, 10033)
AND (ovs_fiscalyearname = '2020-2021' OR ovs_fiscalyearname = '2021-2022');


CARGILL AGHORIZONS
NAPA Auto Parts - Wolseley Ag & Auto Ltld

SELECT * 
INTO #TEMP_WORKPLAN_MATCHED_BOOKABLE_RESOURCES
FROM #TEMP_BOOKABLE_RESOURCES T1
JOIN #TEMP_WORKPLAN T2 ON UPPER(TRIM(CONCAT(T2.InspectorFirstName, ' ', T2.InspectorLastName))) = UPPER([dbo].[ReplaceASCII](T1.name));


select name, ovs_legalname, address1_city, address1_line1, address1_line3, address1_postalcode, address1_postofficebox, address1_stateorprovince, accountnumber, ovs_iisid, address1_primarycontactname, description  from STAGING__ACCOUNT
where 
ovs_iisid IN
(18853, 10119, 10139, 9290, 3033180, 10033);


SELECT * FROM STAGING__WORK_ORDERS



--Duplicate sites by IISID? why would these exists

select 
name, ovs_legalname, address1_city, address1_line1, address1_line3, address1_postalcode, address1_postofficebox, address1_stateorprovince, accountnumber, ovs_iisid, address1_primarycontactname, description 
from STAGING__ACCOUNT where ovs_iisid in 
(
	select ovs_iisid from 
	STAGING__ACCOUNT
	group by ovs_iisid
	having count(ovs_iisid) > 1
)


--SELECT 
--[Id]
--,[msdyn_address1]
--,[msdyn_address2]
--,[msdyn_address3]
--,[msdyn_city]
--,[msdyn_completedon]
--,[msdyn_country]
--,[msdyn_latitude]
--,[msdyn_longitude]
--,[msdyn_name]
--,[msdyn_postalcode]
--,[msdyn_pricelist]
--,[msdyn_serviceaccount]
--,[msdyn_serviceterritory]
--,[msdyn_stateorprovince]
--,[msdyn_substatus]
--,[msdyn_systemstatus]
--,[msdyn_workorderid]
--,[msdyn_workordersummary]
--,[msdyn_workordertype]
--,[ovs_currentfiscalquarter]
--,[ovs_fiscalquarter]
--,[ovs_fiscalyear]
--,[ovs_iisactivityid]
--,[ovs_iisid]
--,[ovs_mocid]
--,[ovs_oversighttype]
--,[ovs_primaryinspector]
--,[ovs_qcreviewcomments]
--,[ovs_qcreviewcompletedind]
--,[ovs_rational]
--,[ovs_secondaryinspector]
--,[ownerid]
--,[owneridtype]
--,[owningbusinessunit]
--,[owningteam]
--,[owninguser]
--,[qm_remote]
--,[statecode]
--,[statuscode]
--FROM [dbo].[STAGING__WORK_ORDERS]











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
DECLARE 
VARCHAR(50) = '994C3EC1-C104-EB11-A813-000D3AF3A7A7';
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

DECLARE @CONST_WORKORDER_SYSTEM_STATUS_CLOSED_POSTED  VARCHAR(50) = '690970004';
DECLARE @CONST_WORK_ORDER_STATUSCODE_INACTIVE		  VARCHAR(50) = '2';
DECLARE @CONST_WORK_ORDER_STATECODE_INACTIVE		  VARCHAR(50) = '1';
DECLARE @CONST_WORKORDER_SYSTEM_STATUS_UNSCHEDULED    VARCHAR(50) = '690970000';

--msdyn_systemstatus	
--Name	Value
--Open - Unscheduled	690970000
--Open - Scheduled	690970001
--Open - In Progress	690970002
--Open - Completed	690970003
--Closed - Posted	690970004
--Closed - Canceled	690970005

--statuscode	
--Name	Value
--Active	1
--Inactive	2
--Closed	918640000
--===================================================================================================

--=============================================DYNAMIC VALUES===========================================
DECLARE @CONST_TDGCORE_DOMAINNAME  VARCHAR(50)  = 'tdg.core@034gc.onmicrosoft.com';
DECLARE @CONST_TDGCORE_USERID      VARCHAR(50)  = (SELECT systemuserid FROM CRM__SYSTEMUSER  where domainname = 'tdg.core@034gc.onmicrosoft.com');
DECLARE @CONST_TEAM_TDG_ID          VARCHAR(500) = (SELECT teamid FROM CRM__TEAM WHERE name = 'Transportation of Dangerous Goods');
DECLARE @CONST_BUSINESSUNIT_TDG_ID VARCHAR(50)  = (SELECT businessunitid FROM CRM__BUSINESSUNIT WHERE name = 'Transportation of Dangerous Goods');
DECLARE @CONST_PRICELISTID         VARCHAR(50)  = (SELECT pricelevelid FROM CRM__pricelevel  WHERE NAME = 'Base Prices');
DECLARE @CONST_TDGCORE_BOOKABLE_RESOURCE_ID VARCHAR(50) = (SELECT bookableresourceid FROM CRM__BOOKABLERESOURCE WHERE msdyn_primaryemail = @CONST_TDGCORE_DOMAINNAME);
	

--CRM CONSTANTS
DECLARE @CONST_OWNERIDTYPE_TEAM VARCHAR(50)			= 'team';
DECLARE @CONST_OWNERIDTYPE_SYSTEMUSER VARCHAR(50)	= 'systemuser';
--===================================================================================================




--INSERT planned inspections for this fiscal year FROM THE WORKPLAN that havnt been started in IIS 
--==============================================================================

--GET A TEMPORARY TABLE OF THE WORKPLAN WITH SOME TRANSFORMED VALUES AND JOINED TO FISCAL TABLES
--==============================================================================
DROP TABLE IF EXISTS #TEMP_WORKPLAN;
SELECT 
QUARTER,
YEAR,
InspectorLastName,
InspectorFirstName,
TYPE, 
IIS_ID, 
import_number, 
fiscal_year,
ACCOUNTS.ID accountid
--,FQ.[tc_tcfiscalquarterid],
--FQ.[tc_name] [ovs_fiscalquartername],
--FY.[tc_tcfiscalyearid],
--FY.[tc_name] [ovs_fiscalyearname]
INTO #TEMP_WORKPLAN
FROM (

	SELECT
		CASE
			WHEN QUARTER_1 = '1' THEN 'Q1'
			WHEN QUARTER_2 = '1' THEN 'Q2'
			WHEN QUARTER_3 = '1' THEN 'Q3'
			WHEN QUARTER_4 = '1' THEN 'Q4'
		END [QUARTER],

		CASE
			WHEN QUARTER_1 = '1' OR QUARTER_2 = '1' OR QUARTER_3 = '1' THEN '2021'
			WHEN QUARTER_4 = '1' THEN '2021'
		END [YEAR],
	
		CASE
			WHEN Charindex(',', CURRENT_INSPECTOR) = 0 THEN 'TDG'
			ELSE Substring(CURRENT_INSPECTOR, 1, Charindex(',', CURRENT_INSPECTOR) -1)
		END [InspectorLastName],

		CASE
			WHEN Charindex(',', CURRENT_INSPECTOR) = 0 THEN 'CORE'
			ELSE Substring(CURRENT_INSPECTOR, Charindex(',', CURRENT_INSPECTOR) + 1, LEN(CURRENT_INSPECTOR))
		END [InspectorFirstName],

		TYPE, IIS_ID, import_number, fiscal_year

	FROM
		SOURCE__WORKPLAN_IMPORT WP
	WHERE
		CURRENTLY_PLANNED = '1'
		AND fiscal_year = '2021-2022'

) WP
JOIN STAGING__ACCOUNT ACCOUNTS ON TRIM(WP.IIS_ID) = TRIM(ACCOUNTS.ovs_iisid)
JOIN [dbo].SOURCE__FISCAL_YEAR FY ON WP.[YEAR] = FY.tc_fiscalyearnum
JOIN [dbo].SOURCE__FISCAL_QUARTER FQ ON FQ.tc_name = WP.[QUARTER] AND FQ.tc_tcfiscalyearidname = WP.fiscal_year;
--==============================================================================



--SELECT 
--COMPANY_NAME, fiscal_year, CURRENT_INSPECTOR, QUARTER_1, QUARTER_2, QUARTER_3, QUARTER_4
--FROM SOURCE__WORKPLAN_IMPORT
--WHERE
--CURRENTLY_PLANNED = '1'
--AND fiscal_year = '2021-2022'



--select * from YD070_STAKEHOLDER
--where STAKEHOLDER_ID in (
--27534337
--)
--order by STAKEHOLDER_ID

----GET A TEMPORARY TABLE OF BOOKABLE RESOURCES WITH TRANSFORMED VALUES FROM OUR STAGED DATA
----==============================================================================
--SELECT 
--[name],

--CASE
--	WHEN BR.userid IS NULL THEN @CONST_TDGCORE_USERID
--	ELSE BR.userid
--END OWNER_ID,

--CASE
--	WHEN BR.bookableresourceid IS NULL THEN @CONST_TDGCORE_BOOKABLE_RESOURCE_ID
--	ELSE BR.bookableresourceid
--END BOOKABLE_RESOURCE_ID,

--CASE
--	WHEN BR.userid IS NULL THEN @CONST_OWNERIDTYPE_SYSTEMUSER
--	ELSE @CONST_OWNERIDTYPE_SYSTEMUSER
--END OWNER_TYPE,

--CASE
--	WHEN BR.userid IS NULL THEN NULL
--	ELSE BR.userid
--END OWNING_USER

--INTO #TEMP_BOOKABLE_RESOURCES
--FROM STAGING__BOOKABLE_RESOURCE BR; 
----==============================================================================


----MATCH BOOKABLE RESOURCES FROM ROM TO INSPECTORS IN THE WORKPLAN BY NAME, AND PUT MATCHES IN A TEMP TABLE
----==============================================================================
--SELECT * 
--INTO #TEMP_WORKPLAN_MATCHED_BOOKABLE_RESOURCES
--FROM #TEMP_BOOKABLE_RESOURCES T1
--JOIN #TEMP_WORKPLAN T2 ON UPPER(TRIM(CONCAT(T2.InspectorFirstName, ' ', T2.InspectorLastName))) = UPPER([dbo].[ReplaceASCII](T1.name)); 
----==============================================================================


----CREATE A LIST OF INSPECTIONS FROM THE WORKPLAN THAT EXCLUDE INSPECTIONS 
----THAT HAVE ALREADY BEEN ENTERED IN IIS AS WE'VE ALREADY CONVERTED AND DON'T WANT DUPLICATES
----==============================================================================
--SELECT WP.*, BR.BOOKABLE_RESOURCE_ID, BR.name
--INTO #TEMP_WORKPLAN_EXCLUDING_INSPECTIONS_ALREADY_IN_IIS
--FROM #TEMP_WORKPLAN WP
--LEFT JOIN #TEMP_WORKPLAN_MATCHED_BOOKABLE_RESOURCES BR ON WP.IIS_ID = BR.IIS_ID
--AND BR.import_number 
--NOT IN (
--	--WORKPLAN INSPECTIONS CREATED IN IIS ALREADY
--	--IGNORE TO PREVENT DOUBLES
--	SELECT
--		import_number
--	FROM #TEMP_WORKPLAN WP
--		JOIN STAGING__WORK_ORDERS WO ON WP.IIS_ID = WO.ovs_iisid
--		AND WP.fiscal_year = WO.ovs_fiscalyearname
--		AND WP.QUARTER = WO.ovs_fiscalquartername
--	WHERE
--		WP.fiscal_year = '2021-2022'
--);
----==============================================================================
