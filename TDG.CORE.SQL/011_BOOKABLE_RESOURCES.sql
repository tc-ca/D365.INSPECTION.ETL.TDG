--two bad records in rom user list
delete from SOURCE__ROM_USER_LIST
where (Email = 'maitri.shah@tc.gc.ca' and Email_hyperlink is null) or email = 'venessa.talbot@tc.gc.ca';

TRUNCATE TABLE STAGING__BOOKABLE_RESOURCE;
TRUNCATE TABLE STAGING__BOOKABLE_RESOURCE_CATEGORY_ASSN;


--98 inspectors only in the work plan?
----========================================================================================
SELECT distinct CURRENT_INSPECTOR, CURRENT_INSPECTOR_EMAIL, CURRENT_INSPECTOR_FAMILY_NAME, CURRENT_INSPECTOR_FIRST_NAME, CURRENT_INSPECTOR_ID
FROM CURRENT_WORKPLAN2021
where CURRENT_INSPECTOR is not null and CURRENT_INSPECTOR <> '';

SELECT @@ROWCOUNT COUNT_OF_INSPECTORS_IN_WORKPLAN;
-----========================================================================================


--GET INSPECTOR LIST FROM IIS
--GET ONLY USERS WITH VALID CERTIFICATE, ASSUMING THESE ARE THE REAL INSPECTORS
--========================================================================================
DROP TABLE IF EXISTS #TEMP__IIS_INSPECTORS;
GO 

SELECT
T1.[STAKEHOLDER_ID]
,T2.STAKEHOLDER_NAME_FIRST_NM
,T2.STAKEHOLDER_NAME_FAMILY_NM
,T1.[INSPECTOR_CERT_NUM]
,T1.[INSPECTOR_BADGE_NUM]
,T1.[DATE_CREATED_DTE]
,T1.[DATE_LAST_UPDATE_DTE]
, TC008.DATE_STOP_DTE
, TC008.EMAIL_TXT
, TC008.USER_ID
,TC008.USER_STAKEHOLDER_ID

INTO #TEMP__IIS_INSPECTORS
FROM [dbo].[YD074_INSPECTOR] T1
JOIN [dbo].[YD083_INDIVIDUAL_INFORMATION] T2 ON T1.STAKEHOLDER_ID = T2.STAKEHOLDER_ID
JOIN [dbo].[YD070_STAKEHOLDER] T3 ON T2.STAKEHOLDER_ID = T3.STAKEHOLDER_ID
JOIN TC008_USER TC008 ON T1.STAKEHOLDER_ID = TC008.USER_STAKEHOLDER_ID
WHERE T3.DATE_STOP_DTE IS NULL
AND T1.DATE_DELETED_DTE IS NULL AND T2.DATE_DELETED_DTE IS NULL 
AND INSPECTOR_CERT_NUM like '99%' OR INSPECTOR_CERT_NUM like '98%' 
order by STAKEHOLDER_NAME_FAMILY_NM;

SELECT @@ROWCOUNT COUNT_IIS_INSPECTORS;
--========================================================================================

--144 LEGIT INSPECTORS TO BRING OVER FROM IIS


--MATCH INSPECTOR DATA FROM IIS TO AZURE AD USER DATA STORED IN DYNAMICS
--========================================================================================
DROP TABLE IF EXISTS #TEMP__IIS_USER_MATCHES;
GO

SELECT
	newid() bookableresourceid,
	SYSUSER.systemuserid,
	CONCAT(SYSUSER.firstname, ' ', SYSUSER.lastname) name,
	domainname,
	insp.STAKEHOLDER_ID,
	INSP.INSPECTOR_CERT_NUM,
	INSP.INSPECTOR_BADGE_NUM,
	insp.STAKEHOLDER_NAME_FAMILY_NM,
	INSP.STAKEHOLDER_NAME_FIRST_NM,
	INSP.EMAIL_TXT,
	SYSUSER.isdisabled, 
	SYSUSER.islicensed, 
	SYSUSER.issyncwithdirectory, 
	SYSUSER.territoryid
INTO #TEMP__IIS_USER_MATCHES
FROM
	[dbo].#TEMP__IIS_INSPECTORS INSP 
    LEFT JOIN CRM__SYSTEMUSER SYSUSER ON DBO.ReplaceASCII(LOWER(SYSUSER.domainname)) = DBO.ReplaceASCII(LOWER(INSP.EMAIL_TXT))


SELECT @@ROWCOUNT COUNT_IIS_INSPECTORS
--========================================================================================


DROP TABLE IF EXISTS #TEMP__ROM_USER_MATCHES;
--try to match users by the ROM USER LIST Excel sheet
SELECT 
	newid() bookableresourceid,
	SYSUSER.systemuserid,
	ROM.Fullname name,
	domainname,
	ROM.[RIN Number],
	ROM.[Badge Number],
	ROM.[CRM Region],
	ROM.[Manager Email],
	ROM.Role,
	SYSUSER.isdisabled, 
	SYSUSER.islicensed, 
	SYSUSER.issyncwithdirectory, 
	SYSUSER.territoryid
INTO #TEMP__ROM_USER_MATCHES
FROM
[dbo].CRM__SYSTEMUSER SYSUSER
JOIN SOURCE__ROM_USER_LIST ROM ON 

(LOWER(TRIM(ROM.Email)) = lower(TRIM(SYSUSER.domainname)) --MATCH ON EMAIL

OR 

LOWER(TRIM(ROM.Fullname)) = LOWER(TRIM(SYSUSER.fullname))) --MATCH ON FULLNAME 

AND 

UPPER(Role) LIKE '%TDG INSPECTOR%'; --AT LEAST THEY MUST HAVE INSPECTOR ROLE...


--AND [Badge Number] IS NOT NULL AND [RIN Number] IS NOT NULL; -- FOR MATCHING PURPOSES, GOING TO NOT EXCLUDE BASED ON BADGE OR RIN
SELECT @@ROWCOUNT ROM_USER_LIST_COUNT


--TDG INSPECTOR
DROP TABLE IF EXISTS #TEMP__IIS_USERS_TO_ROM_USERS;
GO
SELECT T1.systemuserid, T1.name, T1.domainname, T1.INSPECTOR_CERT_NUM, T1.INSPECTOR_BADGE_NUM, T1.territoryid, T1.STAKEHOLDER_ID, T1.STAKEHOLDER_NAME_FAMILY_NM, T1.STAKEHOLDER_NAME_FIRST_NM
INTO #TEMP__IIS_USERS_TO_ROM_USERS
FROM #TEMP__IIS_USER_MATCHES T1
LEFT JOIN #TEMP__ROM_USER_MATCHES T2 ON T1.systemuserid = T2.systemuserid

DROP TABLE IF EXISTS #TEMP__ROM_USERS_TO_IIS_USERS;
GO
SELECT T1.systemuserid, T1.name, T1.domainname, T1.[RIN Number], T1.[Badge Number], T1.[CRM Region]
INTO #TEMP__ROM_USERS_TO_IIS_USERS
FROM #TEMP__ROM_USER_MATCHES  T1
LEFT JOIN #TEMP__IIS_USER_MATCHES T2 ON T1.systemuserid = T2.systemuserid;
 



----INSERT 
--DROP TABLE IF EXISTS #TEMP__ALL_MATCHED_USERS;
--SELECT * 
--INTO #TEMP__ALL_MATCHED_USERS
--FROM #TEMP__IIS_USERS_TO_ROM_USERS
--UNION 
--SELECT * FROM #TEMP__ROM_USERS_TO_IIS_USERS WHERE domainname NOT IN 
--(
--	SELECT domainname FROM #TEMP__IIS_USERS_TO_ROM_USERS
--)



--BOOKABLE RESOURCES
INSERT INTO
	[dbo].[STAGING__BOOKABLE_RESOURCE] (
		bookableresourceid,
		[userid],
		[name],
		[msdyn_primaryemail],
		[ovs_registeredinspectornumberrin],
		[ovs_badgenumber],
		accountidname
	)
SELECT
	NEWID() bookableresourceid,
	systemuserid,
	[name],
	domainname,
	INSPECTOR_CERT_NUM,
	INSPECTOR_BADGE_NUM,
	STAKEHOLDER_ID
FROM
#TEMP__IIS_USERS_TO_ROM_USERS
order by name;




--FILL IN THE INSPECTOR GAPS USING THE ROM USER LIST EXCEL SHEET 
--ZERO MISSING
--==============================================================
INSERT INTO
	[dbo].[STAGING__BOOKABLE_RESOURCE] (
		bookableresourceid,
		[userid],
		[name],
		[msdyn_primaryemail],
		[ovs_registeredinspectornumberrin],
		[ovs_badgenumber],
		accountidname
	)
SELECT
	NEWID() bookableresourceid,
	systemuserid,
	[name],
	domainname,
	[RIN Number],
	[Badge Number],
	NULL
FROM
#TEMP__ROM_USERS_TO_IIS_USERS
WHERE domainname NOT IN 
(
	SELECT domainname FROM #TEMP__IIS_USERS_TO_ROM_USERS
)
AND [RIN Number] NOT IN 
(
	SELECT #TEMP__IIS_USERS_TO_ROM_USERS.INSPECTOR_CERT_NUM FROM #TEMP__IIS_USERS_TO_ROM_USERS
)
order by name;
--==============================================================





----SET OWNERSHIP OF BOOKABLE RESOURCE RECORDS
---do we want inspectors to edit their inspector information such as badge and rin and name, or no?
----=======================================
DECLARE @CONST_TDGCORE_DOMAINNAME  VARCHAR(50)  = 'tdg.core@034gc.onmicrosoft.com';
DECLARE @CONST_TDGCORE_USERID      VARCHAR(50)  = (SELECT systemuserid FROM CRM__SYSTEMUSER  where domainname = 'tdg.core@034gc.onmicrosoft.com');
DECLARE @CONST_TEAM_TDG_ID          VARCHAR(500) = (SELECT teamid FROM CRM__TEAM WHERE name = 'Transportation of Dangerous Goods');
DECLARE @CONST_BUSINESSUNIT_TDG_ID VARCHAR(50)  = (SELECT businessunitid FROM CRM__BUSINESSUNIT WHERE name = 'Transportation of Dangerous Goods');
DECLARE @CONST_PRICELISTID         VARCHAR(50)  = (SELECT pricelevelid FROM CRM__pricelevel  WHERE NAME = 'Base Prices');
DECLARE @CONST_TDGCORE_BOOKABLE_RESOURCE_ID VARCHAR(50) = (SELECT bookableresourceid FROM CRM__BOOKABLERESOURCE WHERE msdyn_primaryemail = @CONST_TDGCORE_DOMAINNAME);
DECLARE @CONST_OWNERIDTYPE_TEAM VARCHAR(50)			= 'team';
DECLARE @CONST_OWNERIDTYPE_SYSTEMUSER VARCHAR(50)	= 'systemuser';
DECLARE @CONST_CATEGORY_INSPECTOR                    VARCHAR(50) = '06DB6E56-01F9-EA11-A815-000D3AF3AC0D';

UPDATE
	[dbo].[STAGING__BOOKABLE_RESOURCE]
SET
	owningbusinessunit                 = @CONST_BUSINESSUNIT_TDG_ID,
	owneridtype                        = @CONST_OWNERIDTYPE_SYSTEMUSER,
	ownerid                            = @CONST_TDGCORE_USERID,
	owninguser                         = @CONST_TDGCORE_USERID,
	resourcetype                       = 3,
	statecode                          = 0,
	statuscode                         = 1,
	msdyn_derivecapacity               = 0,
	msdyn_displayonscheduleassistant   = 1,
	msdyn_displayonscheduleboard       = 1,
	msdyn_enabledforfieldservicemobile = 1,
	msdyn_enabledripscheduling         = 0,
	msdyn_endlocation                  = 690970002,
	--location agnostic
	msdyn_startlocation                = 690970002,
	--location agnostic
	msdyn_timeoffapprovalrequired      = 0;
----=======================================


INSERT INTO
	[STAGING__BOOKABLE_RESOURCE_CATEGORY_ASSN] (
		resource,
		resourcecategory,
		statecode,
		statuscode,
		owningbusinessunit,
		owneridtype,
		ownerid,
		owninguser
	)
SELECT
	bookableresourceid,
	resourcecategory   = @CONST_CATEGORY_INSPECTOR,
	--INSPECTOR
	statecode          = 0,
	statuscode         = 1,
	owningbusinessunit = @CONST_BUSINESSUNIT_TDG_ID,
	owneridtype        = @CONST_OWNERIDTYPE_SYSTEMUSER,
	ownerid            = @CONST_TDGCORE_USERID,
	owninguser         = @CONST_TDGCORE_USERID
FROM
	[dbo].[STAGING__BOOKABLE_RESOURCE];



--UPDATE USER REGIONS
UPDATE CRM__SYSTEMUSER
set territoryid = t2.territoryid
FROM 
(
	SELECT 
	bookableresourceid,
	systemuserid,
	CASE 
		WHEN [CRM Region] = 'Transportation of Dangerous Goods' THEN 'HQ-CR'
		ELSE [CRM Region]
	END [CRM Region]
	FROM #TEMP__ROM_USER_MATCHES
) T1
JOIN STAGING__TERRITORY T2 ON T1.[CRM Region] = T2.ovs_territorynameenglish
JOIN CRM__SYSTEMUSER T3 ON T1.systemuserid = T3.systemuserid;

SELECT @@ROWCOUNT TC_USERS_REGIONS_UPDATED


--SELECT
--bookableresourceid ,
--msdyn_derivecapacity ,
--msdyn_displayonscheduleassistant ,
--msdyn_displayonscheduleboard ,
--1 msdyn_enableappointments ,
--msdyn_enabledforfieldservicemobile ,
--msdyn_enabledripscheduling ,
--msdyn_endlocation ,
--msdyn_primaryemail ,
--msdyn_startlocation ,
--msdyn_timeoffapprovalrequired ,
--name ,
--ovs_badgenumber ,
--ovs_registeredinspectornumberrin ,
--ownerid ,
--owneridtype ,
--owningbusinessunit ,
--owninguser ,
--resourcetype ,
--statecode ,
--statecodename ,
--statuscode ,
--statuscodename ,
--userid
--FROM [STAGING__BOOKABLE_RESOURCE]
--ORDER BY NAME;