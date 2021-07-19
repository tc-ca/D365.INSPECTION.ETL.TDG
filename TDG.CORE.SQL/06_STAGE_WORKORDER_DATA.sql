
--INITIALIZE WORK ORDER STAGING TABLE
--====================================================================================================================
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STAGING__WORK_ORDERS]') AND type in (N'U'))
DROP TABLE [dbo].[STAGING__WORK_ORDERS];
GO

CREATE TABLE [dbo].[STAGING__WORK_ORDERS](
	[Id] [uniqueidentifier] NOT NULL,
	[SinkCreatedOn] [datetime] NULL,
	[SinkModifiedOn] [datetime] NULL,
	[statecode] [int] NULL,
	[statuscode] [int] NULL,
	[msdyn_worklocation] [int] NULL,
	[msdyn_systemstatus] [int] NULL,
	[msdyn_taxable] [bit] NULL,
	[msdyn_isfollowup] [bit] NULL,
	[qm_remote] [bit] NULL,
	[msdyn_ismobile] [bit] NULL,
	[msdyn_followuprequired] [bit] NULL,
	[ovs_qcreviewcompletedind] [bit] NULL,
	[ovs_secondaryinspector] [uniqueidentifier] NULL,
	[ovs_secondaryinspector_entitytype] [nvarchar](128) NULL,
	[msdyn_iotalert] [uniqueidentifier] NULL,
	[msdyn_iotalert_entitytype] [nvarchar](128) NULL,
	[ovs_rational] [uniqueidentifier] NULL,
	[ovs_rational_entitytype] [nvarchar](128) NULL,
	[msdyn_timegroupdetailselected] [uniqueidentifier] NULL,
	[msdyn_timegroupdetailselected_entitytype] [nvarchar](128) NULL,
	[ovs_assetcategory] [uniqueidentifier] NULL,
	[ovs_assetcategory_entitytype] [nvarchar](128) NULL,
	[ovs_operationtypeid] [uniqueidentifier] NULL,
	[ovs_operationtypeid_entitytype] [nvarchar](128) NULL,
	[owningbusinessunit] [uniqueidentifier] NULL,
	[owningbusinessunit_entitytype] [nvarchar](128) NULL,
	[ovs_asset] [uniqueidentifier] NULL,
	[ovs_asset_entitytype] [nvarchar](128) NULL,
	[msdyn_pricelist] [uniqueidentifier] NULL,
	[msdyn_pricelist_entitytype] [nvarchar](128) NULL,
	[msdyn_taxcode] [uniqueidentifier] NULL,
	[msdyn_taxcode_entitytype] [nvarchar](128) NULL,
	[msdyn_primaryresolution] [uniqueidentifier] NULL,
	[msdyn_primaryresolution_entitytype] [nvarchar](128) NULL,
	[ovs_tyrational] [uniqueidentifier] NULL,
	[ovs_tyrational_entitytype] [nvarchar](128) NULL,
	[msdyn_timegroup] [uniqueidentifier] NULL,
	[msdyn_timegroup_entitytype] [nvarchar](128) NULL,
	[msdyn_billingaccount] [uniqueidentifier] NULL,
	[msdyn_billingaccount_entitytype] [nvarchar](128) NULL,
	[msdyn_servicerequest] [uniqueidentifier] NULL,
	[msdyn_servicerequest_entitytype] [nvarchar](128) NULL,
	[msdyn_workordertype] [uniqueidentifier] NULL,
	[msdyn_workordertype_entitytype] [nvarchar](128) NULL,
	[msdyn_customerasset] [uniqueidentifier] NULL,
	[msdyn_customerasset_entitytype] [nvarchar](128) NULL,
	[ovs_siteofviolation] [uniqueidentifier] NULL,
	[ovs_siteofviolation_entitytype] [nvarchar](128) NULL,
	[ovs_regulatedentity] [uniqueidentifier] NULL,
	[ovs_regulatedentity_entitytype] [nvarchar](128) NULL,
	[msdyn_serviceaccount] [uniqueidentifier] NULL,
	[msdyn_serviceaccount_entitytype] [nvarchar](128) NULL,
	[msdyn_workorderarrivaltimekpiid] [uniqueidentifier] NULL,
	[msdyn_workorderarrivaltimekpiid_entitytype] [nvarchar](128) NULL,
	[modifiedby] [uniqueidentifier] NULL,
	[modifiedby_entitytype] [nvarchar](128) NULL,
	[msdyn_serviceterritory] [uniqueidentifier] NULL,
	[msdyn_serviceterritory_entitytype] [nvarchar](128) NULL,
	[modifiedonbehalfby] [uniqueidentifier] NULL,
	[modifiedonbehalfby_entitytype] [nvarchar](128) NULL,
	[msdyn_priority] [uniqueidentifier] NULL,
	[msdyn_priority_entitytype] [nvarchar](128) NULL,
	[ovs_revisedquarterid] [uniqueidentifier] NULL,
	[ovs_revisedquarterid_entitytype] [nvarchar](128) NULL,
	[owninguser] [uniqueidentifier] NULL,
	[owninguser_entitytype] [nvarchar](128) NULL,
	[msdyn_functionallocation] [uniqueidentifier] NULL,
	[msdyn_functionallocation_entitytype] [nvarchar](128) NULL,
	[owningteam] [uniqueidentifier] NULL,
	[owningteam_entitytype] [nvarchar](128) NULL,
	[ovs_currentfiscalquarter] [uniqueidentifier] NULL,
	[ovs_currentfiscalquarter_entitytype] [nvarchar](128) NULL,
	[msdyn_agreement] [uniqueidentifier] NULL,
	[msdyn_agreement_entitytype] [nvarchar](128) NULL,
	[createdonbehalfby] [uniqueidentifier] NULL,
	[createdonbehalfby_entitytype] [nvarchar](128) NULL,
	[transactioncurrencyid] [uniqueidentifier] NULL,
	[transactioncurrencyid_entitytype] [nvarchar](128) NULL,
	[msdyn_primaryincidenttype] [uniqueidentifier] NULL,
	[msdyn_primaryincidenttype_entitytype] [nvarchar](128) NULL,
	[msdyn_workorderresolutionkpiid] [uniqueidentifier] NULL,
	[msdyn_workorderresolutionkpiid_entitytype] [nvarchar](128) NULL,
	[ovs_fiscalquarter] [uniqueidentifier] NULL,
	[ovs_fiscalquarter_entitytype] [nvarchar](128) NULL,
	[ovs_fiscalyear] [uniqueidentifier] NULL,
	[ovs_fiscalyear_entitytype] [nvarchar](128) NULL,
	[ovs_primaryinspector] [uniqueidentifier] NULL,
	[ovs_primaryinspector_entitytype] [nvarchar](128) NULL,
	[msdyn_substatus] [uniqueidentifier] NULL,
	[msdyn_substatus_entitytype] [nvarchar](128) NULL,
	[createdby] [uniqueidentifier] NULL,
	[createdby_entitytype] [nvarchar](128) NULL,
	[msdyn_preferredresource] [uniqueidentifier] NULL,
	[msdyn_preferredresource_entitytype] [nvarchar](128) NULL,
	[ovs_oversighttype] [uniqueidentifier] NULL,
	[ovs_oversighttype_entitytype] [nvarchar](128) NULL,
	[msdyn_parentworkorder] [uniqueidentifier] NULL,
	[msdyn_parentworkorder_entitytype] [nvarchar](128) NULL,
	[msdyn_supportcontact] [uniqueidentifier] NULL,
	[msdyn_supportcontact_entitytype] [nvarchar](128) NULL,
	[msdyn_reportedbycontact] [uniqueidentifier] NULL,
	[msdyn_reportedbycontact_entitytype] [nvarchar](128) NULL,
	[msdyn_closedby] [uniqueidentifier] NULL,
	[msdyn_closedby_entitytype] [nvarchar](128) NULL,
	[msdyn_opportunityid] [uniqueidentifier] NULL,
	[msdyn_opportunityid_entitytype] [nvarchar](128) NULL,
	[msdyn_workhourtemplate] [uniqueidentifier] NULL,
	[msdyn_workhourtemplate_entitytype] [nvarchar](128) NULL,
	[ovs_operationid] [uniqueidentifier] NULL,
	[ovs_operationid_entitytype] [nvarchar](128) NULL,
	[ownerid] [uniqueidentifier] NULL,
	[ownerid_entitytype] [nvarchar](128) NULL,
	[msdyn_estimatesubtotalamount] [decimal](38, 2) NULL,
	[msdyn_subtotalamount] [decimal](38, 2) NULL,
	[msdyn_totalamount] [decimal](38, 2) NULL,
	[msdyn_totalsalestax] [decimal](38, 2) NULL,
	[msdyn_totalamount_base] [decimal](38, 2) NULL,
	[msdyn_totalsalestax_base] [decimal](38, 2) NULL,
	[msdyn_subtotalamount_base] [decimal](38, 2) NULL,
	[msdyn_estimatesubtotalamount_base] [decimal](38, 2) NULL,
	[msdyn_servicerequestname] [nvarchar](200) NULL,
	[msdyn_instructions] [nvarchar](max) NULL,
	[msdyn_primaryresolutionname] [nvarchar](100) NULL,
	[ovs_regulatedentityyominame] [nvarchar](160) NULL,
	[ovs_regulatedentityname] [nvarchar](160) NULL,
	[msdyn_customerassetname] [nvarchar](100) NULL,
	[modifiedon] [datetime] NULL,
	[msdyn_city] [nvarchar](80) NULL,
	[msdyn_reportedbycontactyominame] [nvarchar](450) NULL,
	[msdyn_datewindowend] [datetime] NULL,
	[msdyn_followupnote] [nvarchar](max) NULL,
	[msdyn_address1] [nvarchar](250) NULL,
	[msdyn_reportedbycontactname] [nvarchar](160) NULL,
	[msdyn_address3] [nvarchar](250) NULL,
	[msdyn_opportunityidname] [nvarchar](300) NULL,
	[msdyn_workorderresolutionkpiidname] [nvarchar](100) NULL,
	[ovs_siteofviolationname] [nvarchar](160) NULL,
	[msdyn_address2] [nvarchar](250) NULL,
	[ovs_tyrationalname] [nvarchar](100) NULL,
	[ovs_mocid] [nvarchar](100) NULL,
	[msdyn_totalestimatedduration] [int] NULL,
	[msdyn_serviceterritoryname] [nvarchar](200) NULL,
	[msdyn_primaryincidentdescription] [nvarchar](max) NULL,
	[msdyn_preferredresourcename] [nvarchar](100) NULL,
	[msdyn_longitude] [decimal](38, 5) NULL,
	[msdyn_pricelistname] [nvarchar](100) NULL,
	[ovs_rolluptestdeletemeafter_state] [int] NULL,
	[ovs_assetname] [nvarchar](100) NULL,
	[msdyn_closedbyname] [nvarchar](200) NULL,
	[msdyn_workordertypename] [nvarchar](100) NULL,
	[versionnumber] [bigint] NULL,
	[ovs_operationidname] [nvarchar](200) NULL,
	[exchangerate] [decimal](38, 10) NULL,
	[msdyn_timegroupdetailselectedname] [nvarchar](100) NULL,
	[msdyn_primaryincidenttypename] [nvarchar](100) NULL,
	[msdyn_substatusname] [nvarchar](100) NULL,
	[ovs_revisedquarteridname] [nvarchar](100) NULL,
	[createdon] [datetime] NULL,
	[ovs_qcreviewcomments] [nvarchar](max) NULL,
	[msdyn_autonumbering] [nvarchar](100) NULL,
	[msdyn_workorderid] [uniqueidentifier] NULL,
	[ovs_fiscalyearname] [nvarchar](100) NULL,
	[msdyn_stateorprovince] [nvarchar](50) NULL,
	[msdyn_workorderarrivaltimekpiidname] [nvarchar](100) NULL,
	[msdyn_bookingsummary] [nvarchar](max) NULL,
	[owneridyominame] [nvarchar](100) NULL,
	[timezoneruleversionnumber] [int] NULL,
	[msdyn_workhourtemplatename] [nvarchar](100) NULL,
	[ovs_assetcategoryname] [nvarchar](100) NULL,
	[msdyn_parentworkordername] [nvarchar](100) NULL,
	[msdyn_addressname] [nvarchar](250) NULL,
	[traversedpath] [nvarchar](1250) NULL,
	[overriddencreatedon] [datetime] NULL,
	[msdyn_timeclosed] [datetime] NULL,
	[createdonbehalfbyname] [nvarchar](100) NULL,
	[owneridtype] [nvarchar](4000) NULL,
	[msdyn_postalcode] [nvarchar](20) NULL,
	[msdyn_priorityname] [nvarchar](100) NULL,
	[owneridname] [nvarchar](100) NULL,
	[msdyn_functionallocationname] [nvarchar](60) NULL,
	[modifiedonbehalfbyname] [nvarchar](100) NULL,
	[createdonbehalfbyyominame] [nvarchar](100) NULL,
	[msdyn_country] [nvarchar](80) NULL,
	[ovs_rolluptestdeletemeafter] [datetime] NULL,
	[transactioncurrencyidname] [nvarchar](100) NULL,
	[msdyn_mapcontrol] [nvarchar](100) NULL,
	[msdyn_timefrompromised] [datetime] NULL,
	[processid] [uniqueidentifier] NULL,
	[msdyn_primaryincidentestimatedduration] [int] NULL,
	[msdyn_serviceaccountyominame] [nvarchar](160) NULL,
	[msdyn_billingaccountyominame] [nvarchar](160) NULL,
	[msdyn_internalflags] [nvarchar](max) NULL,
	[msdyn_timetopromised] [datetime] NULL,
	[ovs_fiscalquartername] [nvarchar](100) NULL,
	[msdyn_latitude] [decimal](38, 5) NULL,
	[msdyn_serviceaccountname] [nvarchar](160) NULL,
	[ovs_oversighttypename] [nvarchar](100) NULL,
	[msdyn_workordersummary] [nvarchar](max) NULL,
	[createdbyname] [nvarchar](100) NULL,
	[ovs_currentfiscalquartername] [nvarchar](100) NULL,
	[modifiedbyyominame] [nvarchar](100) NULL,
	[modifiedonbehalfbyyominame] [nvarchar](100) NULL,
	[ovs_rationalname] [nvarchar](100) NULL,
	[msdyn_completedon] [datetime] NULL,
	[ovs_operationtypeidname] [nvarchar](100) NULL,
	[msdyn_timewindowstart] [datetime] NULL,
	[msdyn_closedbyyominame] [nvarchar](200) NULL,
	[msdyn_timewindowend] [datetime] NULL,
	[ovs_siteofviolationyominame] [nvarchar](160) NULL,
	[stageid] [uniqueidentifier] NULL,
	[utcconversiontimezonecode] [int] NULL,
	[ovs_iisid] [nvarchar](100) NULL,
	ovs_iisactivityid numeric(18, 0),
	[ovs_primaryinspectorname] [nvarchar](100) NULL,
	[msdyn_firstarrivedon] [datetime] NULL,
	[msdyn_billingaccountname] [nvarchar](160) NULL,
	[importsequencenumber] [int] NULL,
	[msdyn_timegroupname] [nvarchar](100) NULL,
	[msdyn_childindex] [int] NULL,
	[ovs_rolluptestdeletemeafter_date] [datetime] NULL,
	[msdyn_agreementname] [nvarchar](100) NULL,
	[ovs_secondaryinspectorname] [nvarchar](100) NULL,
	[qm_blobpath] [nvarchar](200) NULL,
	[modifiedbyname] [nvarchar](100) NULL,
	[createdbyyominame] [nvarchar](100) NULL,
	[msdyn_name] [nvarchar](100) NULL,
	[msdyn_datewindowstart] [datetime] NULL,
	[msdyn_supportcontactname] [nvarchar](100) NULL,
	[msdyn_taxcodename] [nvarchar](100) NULL,
	[msdyn_iotalertname] [nvarchar](100) NULL,
	CONSTRAINT [EPK[dbo]].[STAGING__WORK_ORDERS]]] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
GO
--===================================================================================================



----WHATS IN IIS?
--============================================================================================
--this fiscal
SELECT MAX(activity_date_dte) latest, MIN(activity_date_dte) oldest, COUNT(*) IIS_ACTIVITIES_THIS_FISCAL FROM yd040_activity WHERE YEAR(activity_date_dte) = 2021 AND MONTH(activity_date_dte) > 3  AND DATE_DELETED_DTE IS NULL;

--pre this fiscal
SELECT MAX(activity_date_dte) latest, MIN(activity_date_dte) oldest, count(*) IIS_ACTIVITIES_BEFORE_THIS_FISCAL FROM yd040_activity WHERE activity_date_dte < CAST('2021-04-01' as date) AND DATE_DELETED_DTE IS NULL;

SELECT count(*) ALL_IIS_ACTIVITIES FROM yd040_activity WHERE DATE_DELETED_DTE IS NULL;
--============================================================================================



-----RETRIEVE THE INSPECTOR LIST DIRECTLY FROM IIS TABLE
--============================================================================================
DROP TABLE IF EXISTS #TEMP__IIS_INSPECTORS;
SELECT 
USER_ID,
STAKEHOLDER_NAME_FIRST_NM "First Name",
STAKEHOLDER_NAME_FAMILY_NM "Last Name",
CONCAT(STAKEHOLDER_NAME_FIRST_NM, ' ', STAKEHOLDER_NAME_FAMILY_NM) "Fullname",
EMAIL_TXT "Account_name", 
YD074.INSPECTOR_BADGE_NUM BADGE, 
YD074.INSPECTOR_CERT_NUM RIN,
'' "RegionCrmId",

CASE 

	WHEN YD093.STAKEHOLDER_ENM = 'TDG ASDA' THEN 'HQ-ES'
	WHEN YD093.STAKEHOLDER_ENM = 'TDG ASDB' THEN 'HQ-CR'
	WHEN YD093.STAKEHOLDER_ENM = 'TDG ASDE' THEN 'HQ-CR'
	WHEN YD093.STAKEHOLDER_ENM = 'TDG PRAIRIE AND NORTHERN REGION' THEN 'PNR'
	WHEN YD093.STAKEHOLDER_ENM = 'TDG PACIFIC REGION' THEN 'PAC'
	WHEN YD093.STAKEHOLDER_ENM = 'TDG ATLANTIC REGION' THEN 'ATL'
	WHEN YD093.STAKEHOLDER_ENM = 'TDG QUEBEC REGION' THEN 'PQ'
	WHEN YD093.STAKEHOLDER_ENM = 'TDG ONTARIO REGION' THEN 'ONT'
	WHEN YD093.STAKEHOLDER_ENM = 'TDG HQ' THEN 'HQ-CR'

END "Region",

YD093.STAKEHOLDER_ENM "RegionEnm", 
YD093.STAKEHOLDER_FNM "RegionFnm"

INTO #TEMP__IIS_INSPECTORS
FROM TC008_USER TC008
JOIN YD083_INDIVIDUAL_INFORMATION YD083 ON TC008.USER_STAKEHOLDER_ID = YD083.STAKEHOLDER_ID
JOIN YD074_INSPECTOR YD074 ON TC008.USER_STAKEHOLDER_ID = YD074.STAKEHOLDER_ID
JOIN YD092_STAKEHOLDER_ORG_PERS YD092 ON TC008.USER_STAKEHOLDER_ID = YD092.STAKEHOLDER_CONTACT_ID
JOIN YD093_STAKEHOLDER_ORG_NAME YD093 ON YD092.STAKEHOLDER_ID = YD093.STAKEHOLDER_ID
WHERE YD083.DATE_DELETED_DTE IS NULL and TC008.DATE_DELETED_DTE IS NULL AND TC008.DATE_STOP_DTE IS NULL
--AND 
--INSPECTOR_CERT_NUM like '99%' 
--OR 
--INSPECTOR_CERT_NUM like '98%';

SELECT @@ROWCOUNT INSPECTORS_FROM_IIS;
--============================================================================================




--SESSION VARIABLES 
--===================================================================================================
--inspection work order type
DECLARE @WO_TYPE_INSPECTION      VARCHAR(50) = (SELECT Id 					FROM STAGING__WORKORDERTYPE WHERE UPPER(ovs_workordertypenameenglish) = 'INSPECTION');
DECLARE @PRICE_LIST_BASE_PRICES  VARCHAR(50) = (SELECT pricelevelid 		FROM CRM__pricelevel  		WHERE NAME = 'Base Prices');
DECLARE @BU_TDG					 VARCHAR(50) = (SELECT businessunitid 		FROM CRM__BUSINESSUNIT 		WHERE name = 'Transportation of Dangerous Goods');
DECLARE @BR_TDGCORE				 VARCHAR(50) = (SELECT bookableresourceid	FROM CRM__BOOKABLERESOURCE	WHERE msdyn_primaryemail = 'tdg.core@034gc.onmicrosoft.com');
DECLARE @USER_TDGCORE           VARCHAR(50) = (SELECT systemuserid			FROM CRM__SYSTEMUSER		where domainname = 'tdg.core@034gc.onmicrosoft.com');
DECLARE @WO_STATUS_CLOSED_POSTED VARCHAR(50) =  '690970004';
DECLARE @WO_STATUS_INACTIVE      VARCHAR(50) =  '2';
DECLARE @WO_STATE_INACTIVE       VARCHAR(50) =  '1';
DECLARE @CONST_OWNERIDTYPE_TEAM             VARCHAR(50)  = 'team';
DECLARE @CONST_OWNERIDTYPE_SYSTEMUSER       VARCHAR(50)  = 'systemuser';


EXEC [sys].[sp_set_session_context] @key = 'WO_TYPE_INSPECTION',      @value = @WO_TYPE_INSPECTION     ;  
EXEC [sys].[sp_set_session_context] @key = 'PRICE_LIST_BASE_PRICES',  @value = @PRICE_LIST_BASE_PRICES ;  
EXEC [sys].[sp_set_session_context] @key = 'BU_TDG',				  @value = @BU_TDG;  
EXEC [sys].[sp_set_session_context] @key = 'CLOSED',				  @value = @WO_STATUS_CLOSED_POSTED;  
EXEC [sys].[sp_set_session_context] @key = 'STATUS_INACTIVE',         @value = @WO_STATUS_INACTIVE ;  
EXEC [sys].[sp_set_session_context] @key = 'STATE_INACTIVE',          @value = @WO_STATE_INACTIVE      ;  
EXEC [sys].[sp_set_session_context] @key = 'BR_TDGCORE',			  @value = @BR_TDGCORE		;  
EXEC [sys].[sp_set_session_context] @key = 'USERS_TDGCORE',			  @value = @USER_TDGCORE			;  
--===================================================================================================



--GET INSPECTION FILE NUMBERS AND THEIR ASSOCIATED CATEGORIES TO DETERMINE OVERSIGHT TYPE IN ROM
--==========================================================================================
DROP TABLE IF EXISTS #IIS__FILE_NUMBERS;
SELECT
CAT.FILE_NUMBER_NUM,
CAT.ACTIVITY_TYPE_CD,
CAT.ACTIVITY_TYPE_ENM,
ISNULL(SUBCAT.SUBACTIVITY_TYPE_CDS, 'N/A') SUBACTIVITY_TYPE_CDS,
ISNULL(SUBCAT.SUBACTIVITY_TYPE_ENMS, 'N/A') SUBACTIVITY_TYPE_ENMS
INTO #IIS__FILE_NUMBERS
FROM
(
	--INSPECTION FILE NUMBERS AND THEIR ASSOCIATED CATEGORIES
	SELECT
		YD101.FILE_NUMBER_NUM,
		TD045.ACTIVITY_TYPE_CD,
		TD045.ACTIVITY_TYPE_ENM
	FROM
		YD101_FILE_ACTIVITY_TYPE YD101
		JOIN TD045_ACTIVITY_TYPE TD045 ON YD101.ACTIVITY_TYPE_CD = TD045.ACTIVITY_TYPE_CD
	WHERE
		ACTIVITY_TYPE_PARENT_CD IS NULL
		--AND TD045.DATE_DELETED_DTE IS NULL
		AND YD101.DATE_DELETED_DTE IS NULL
	GROUP BY
		YD101.FILE_NUMBER_NUM,
		TD045.ACTIVITY_TYPE_CD,
		TD045.ACTIVITY_TYPE_ENM
) CAT

LEFT JOIN (
	--INSPECTION SUBCATEGORIES
	SELECT
		YD101.FILE_NUMBER_NUM,
		STRING_AGG (ISNULL(TD045.ACTIVITY_TYPE_CD, 'N/A'), ',') AS SUBACTIVITY_TYPE_CDS,
		STRING_AGG (ISNULL(TD045.ACTIVITY_TYPE_ENM, 'N/A'), ',') AS SUBACTIVITY_TYPE_ENMS
	FROM
		[dbo].[YD101_FILE_ACTIVITY_TYPE] YD101
		JOIN TD045_ACTIVITY_TYPE TD045 ON YD101.ACTIVITY_TYPE_CD = TD045.ACTIVITY_TYPE_CD
	WHERE
		ACTIVITY_TYPE_PARENT_CD IS NOT NULL
		--AND TD045.DATE_DELETED_DTE IS NULL 
		AND YD101.DATE_DELETED_DTE IS NULL
	GROUP BY 
	YD101.FILE_NUMBER_NUM
) SUBCAT ON CAT.FILE_NUMBER_NUM = SUBCAT.FILE_NUMBER_NUM


--STORE ROW COUNT REPORT
DECLARE @IIS__FILE_NUMBERS INT = 0;
SELECT @IIS__FILE_NUMBERS = COUNT(*) FROM #IIS__FILE_NUMBERS;
PRINT 'IIS__FILE_NUMBERS = ' + CAST(@IIS__FILE_NUMBERS AS NVARCHAR(50))
EXEC [sys].[sp_set_session_context] @key = 'IIS__FILE_NUMBERS',	@value = @IIS__FILE_NUMBERS;  

--CHECK FOR DUPLICATES
DECLARE @IIS__FILE_NUMBER_DUPLICATES INT = 0;
SELECT @IIS__FILE_NUMBER_DUPLICATES = COUNT(*) FROM #IIS__FILE_NUMBERS
GROUP  BY FILE_NUMBER_NUM
HAVING COUNT(FILE_NUMBER_NUM) > 1;
PRINT 'IIS__FILE_NUMBER_DUPLICATES = ' + CAST(@IIS__FILE_NUMBER_DUPLICATES AS NVARCHAR(50))
EXEC [sys].[sp_set_session_context] @key = 'IIS__FILE_NUMBER_DUPLICATES',	@value = @IIS__FILE_NUMBER_DUPLICATES;  

--==========================================================================================
--40757



--GET INSPECTION ASSIGNMENTS FROM IIS
--we can match on stakeholderid now in the accountidname field
--==========================================================================================
DROP TABLE IF EXISTS #TEMP__PRIMARY_INSPECTOR_ASSIGNMENTS;
SELECT
DISTINCT
	YD048.ACTIVITY_ID,
	YD048.STAKEHOLDER_ID
	,YD048.ASSIGN_ROLE_CD
	,name
	,BR.bookableresourceid
	,BR.accountidname
	,BR.userid
	,br.msdyn_primaryemail
INTO #TEMP__PRIMARY_INSPECTOR_ASSIGNMENTS
FROM
	YD048_ACTIVITY_ASSIGNMENT YD048
	JOIN [dbo].STAGING__BOOKABLE_RESOURCE BR ON BR.accountidname = YD048.STAKEHOLDER_ID 
WHERE
	 YD048.DATE_DELETED_DTE IS NULL AND YD048.ASSIGN_ROLE_CD ='1';


DROP TABLE IF EXISTS #TEMP__SECONDARY_INSPECTOR_ASSIGNMENTS;
SELECT
DISTINCT
	YD048.ACTIVITY_ID,
	YD048.STAKEHOLDER_ID
	,YD048.ASSIGN_ROLE_CD
	,name
	,BR.bookableresourceid
	,BR.accountidname
	,BR.userid
	,br.msdyn_primaryemail
INTO #TEMP__SECONDARY_INSPECTOR_ASSIGNMENTS
FROM
	YD048_ACTIVITY_ASSIGNMENT YD048
	JOIN [dbo].STAGING__BOOKABLE_RESOURCE BR ON BR.accountidname = YD048.STAKEHOLDER_ID 
WHERE
	 YD048.DATE_DELETED_DTE IS NULL AND YD048.ASSIGN_ROLE_CD ='2';
--==========================================================================================



--36944
--GET INSPECTOR ASSIGNMENTS BY YD048
--==========================================================================================
DROP TABLE IF EXISTS #TEMP__INSPECTION_ASSIGNMENTS;
SELECT 
T1.FILE_NUMBER_NUM, 
T1.ACTIVITY_TYPE_CD,
T1.ACTIVITY_TYPE_ENM, 
T1.SUBACTIVITY_TYPE_CDS,
T1.SUBACTIVITY_TYPE_ENMS,
T2.ACTIVITY_DATE_DTE, 
T2.INSPECTION_DATE_DTE,
T2.ACTIVITY_ID, 
T2.STAKEHOLDER_ID COMPANY_STAKEHOLDER_ID,
T2.MANAGER_COMMENT_TXT, 
T2.MANAGER_USER_ID,
T2.VERIFICATION_IND,
T3.msdyn_primaryemail primary_inspector_email, 
T3.bookableresourceid primary_inspector_bookable_resource_id, 
T3.name primary_inspector_name, 
T3.STAKEHOLDER_ID primary_inspector_STAKEHOLDER_ID,
T4.bookableresourceid secondary_inspector_bookable_resource_id, 
T4.name secondary_inspector_name, 
T4.STAKEHOLDER_ID secondary_inspector_STAKEHOLDER_ID,

MONTH(ACTIVITY_DATE_DTE) [MONTH],
YEAR(ACTIVITY_DATE_DTE) [YEAR]

INTO #TEMP__INSPECTION_ASSIGNMENTS
FROM #TEMP__INSPECTION_CATEGORIES T1
JOIN YD040_ACTIVITY T2 ON T1.FILE_NUMBER_NUM = T2.FILE_NUMBER_NUM
JOIN #TEMP__PRIMARY_INSPECTOR_ASSIGNMENTS T3 ON T2.ACTIVITY_ID = T3.ACTIVITY_ID
LEFT JOIN #TEMP__SECONDARY_INSPECTOR_ASSIGNMENTS T4 ON T2.ACTIVITY_ID = T4.ACTIVITY_ID AND T2.ACTIVITY_ID = T3.ACTIVITY_ID
--==========================================================================================



--duplicates
--===================================================================================================
SELECT COUNT(ACTIVITY_ID) DUPLICATION_INSPECTIONS
FROM #TEMP__INSPECTION_ASSIGNMENTS
GROUP BY ACTIVITY_ID
HAVING COUNT(ACTIVITY_ID) > 1;
--===================================================================================================




----GET COMPLETE LIST OF INSPECTIONS
----==========================================================================================
--SELECT
--	YD095.FILE_NUMBER_NUM,
--	CONVERT(datetime, YD040.ACTIVITY_DATE_DTE) ACTIVITY_DATE_DTE,
--	TD001.FILE_STATUS_ETXT,
--	TD001.FILE_STATUS_FTXT,
--	YD040.ACTIVITY_ID,
--	YD040.STAKEHOLDER_ID,		
--	TD038.INSPECTION_REASON_ETXT,
--	TD038.INSPECTION_REASON_FTXT,
--	CATEGORIES.ACTIVITY_TYPE_CD,
--	CATEGORIES.ACTIVITY_TYPE_ENM,
--	CATEGORIES.SUBACTIVITY_TYPE_CDS,
--	CATEGORIES.SUBACTIVITY_TYPE_ENMS,
--	PA.name PRIMARY_INSPECTOR,
--	PA.STAKEHOLDER_ID PRIMARY_INSPECTOR_ID,
--	PA.bookableresourceid PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
--	PA.userid PRIMARY_INSPECTOR_USER_ID,
--	SA.name SECONDARY_INSPECTOR,
--	SA.STAKEHOLDER_ID SECONDARY_INSPECTOR_ID,
--	SA.bookableresourceid SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
--	SA.userid SECONDARY_INSPECTOR_USER_ID,
--	YD040.VERIFICATION_IND,
--	YD040.MANAGER_COMMENT_TXT
--FROM
--	YD040_ACTIVITY YD040
--	JOIN YD095_STAKEHOLDER_FILE YD095 ON YD040.FILE_NUMBER_NUM = YD095.FILE_NUMBER_NUM
--	JOIN TD001_FILE_STATUS TD001 ON YD095.FILE_STATUS_CD = TD001.FILE_STATUS_CD
--	LEFT JOIN YD041_INSPECTION YD041 ON YD040.ACTIVITY_ID = YD041.ACTIVITY_ID
--	LEFT JOIN TD038_INSPECTION_REASON TD038 ON YD041.INSPECTION_REASON_CD = TD038.INSPECTION_REASON_CD
--	LEFT JOIN #TEMP__INSPECTION_CATEGORIES CATEGORIES ON CATEGORIES.FILE_NUMBER_NUM = YD095.FILE_NUMBER_NUM
--	LEFT JOIN #TEMP__PRIMARY_INSPECTOR_ASSIGNMENTS PA ON YD040.ACTIVITY_ID = PA.ACTIVITY_ID
--	LEFT JOIN #TEMP__SECONDARY_INSPECTOR_ASSIGNMENTS SA ON YD040.ACTIVITY_ID = SA.ACTIVITY_ID AND SA.ACTIVITY_ID = PA.ACTIVITY_ID  

--	WHERE TD001.DATE_DELETED_DTE IS NULL AND YD095.DATE_DELETED_DTE IS NULL AND YD040.DATE_DELETED_DTE IS NULL AND YD
--GROUP BY
--	YD095.FILE_NUMBER_NUM,
--	TD001.FILE_STATUS_ETXT,
--	TD001.FILE_STATUS_FTXT,
--	CONVERT(datetime, YD040.ACTIVITY_DATE_DTE) ,
--	YD040.ACTIVITY_ID,
--	YD040.STAKEHOLDER_ID,
--	TD038.INSPECTION_REASON_ETXT,
--	TD038.INSPECTION_REASON_FTXT,
--	CATEGORIES.ACTIVITY_TYPE_CD,
--	CATEGORIES.ACTIVITY_TYPE_ENM,
--	CATEGORIES.SUBACTIVITY_TYPE_CDS,
--	CATEGORIES.SUBACTIVITY_TYPE_ENMS,
--	PA.name ,
--	PA.STAKEHOLDER_ID ,
--	PA.bookableresourceid ,
--	PA.userid ,
--	SA.name ,
--	SA.STAKEHOLDER_ID ,
--	SA.bookableresourceid ,
--	SA.userid ,
--	YD040.VERIFICATION_IND,
--	YD040.MANAGER_COMMENT_TXT
----==========================================================================================


 
--GET A LIST OF INSPECTIONS FROM IIS INTO A SOURCE TABLE
--===================================================================================================
TRUNCATE TABLE SOURCE__IIS_INSPECTIONS;
--WORK ORDERS
INSERT INTO
	[dbo].SOURCE__IIS_INSPECTIONS (
	[MONTH],
	[YEAR],
	FILE_NUMBER_NUM,
	ACTIVITY_DATE_DTE,
	FILE_STATUS_ETXT,
	FILE_STATUS_FTXT,
	ACTIVITY_ID,
	STAKEHOLDER_ID,
	INSPECTION_REASON_ETXT,
	INSPECTION_REASON_FTXT,
	ACTIVITY_TYPE_CD,
	ACTIVITY_TYPE_ENM,
	SUBACTIVITY_TYPE_CDS,
	SUBACTIVITY_TYPE_ENMS,
	PRIMARY_INSPECTOR,
	PRIMARY_INSPECTOR_ID,
	PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
	PRIMARY_INSPECTOR_USER_ID,
	SECONDARY_INSPECTOR,
	SECONDARY_INSPECTOR_ID,
	SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
	SECONDARY_INSPECTOR_USER_ID,
	QC_REVIEW_IND,
	QC_REVIEW_MANAGERS_COMMENTS
	)
SELECT
	MONTH(ACTIVITY_DATE_DTE) [MONTH],
	YEAR(ACTIVITY_DATE_DTE) [YEAR],
	*
FROM
	(
	SELECT
		YD095.FILE_NUMBER_NUM,
		CONVERT(datetime, YD040.ACTIVITY_DATE_DTE) ACTIVITY_DATE_DTE,
		TD001.FILE_STATUS_ETXT,
		TD001.FILE_STATUS_FTXT,
		YD040.ACTIVITY_ID,
		YD040.STAKEHOLDER_ID,		
		TD038.INSPECTION_REASON_ETXT,
		TD038.INSPECTION_REASON_FTXT,
		CATEGORIES.ACTIVITY_TYPE_CD,
		CATEGORIES.ACTIVITY_TYPE_ENM,
		CATEGORIES.SUBACTIVITY_TYPE_CDS,
		CATEGORIES.SUBACTIVITY_TYPE_ENMS,
		PA.name PRIMARY_INSPECTOR,
		PA.STAKEHOLDER_ID PRIMARY_INSPECTOR_ID,
		PA.bookableresourceid PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
		PA.userid PRIMARY_INSPECTOR_USER_ID,
		SA.name SECONDARY_INSPECTOR,
		SA.STAKEHOLDER_ID SECONDARY_INSPECTOR_ID,
		SA.bookableresourceid SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
		SA.userid SECONDARY_INSPECTOR_USER_ID,
		YD040.VERIFICATION_IND,
		YD040.MANAGER_COMMENT_TXT
	FROM
		YD040_ACTIVITY YD040
		JOIN YD095_STAKEHOLDER_FILE YD095 ON YD040.FILE_NUMBER_NUM = YD095.FILE_NUMBER_NUM
		JOIN TD001_FILE_STATUS TD001 ON YD095.FILE_STATUS_CD = TD001.FILE_STATUS_CD
		LEFT JOIN YD041_INSPECTION YD041 ON YD040.ACTIVITY_ID = YD041.ACTIVITY_ID
		LEFT JOIN TD038_INSPECTION_REASON TD038 ON YD041.INSPECTION_REASON_CD = TD038.INSPECTION_REASON_CD
		LEFT JOIN #TEMP__INSPECTION_CATEGORIES CATEGORIES ON CATEGORIES.FILE_NUMBER_NUM = YD095.FILE_NUMBER_NUM
		LEFT JOIN #TEMP__PRIMARY_INSPECTOR_ASSIGNMENTS PA ON YD040.ACTIVITY_ID = PA.ACTIVITY_ID
		LEFT JOIN #TEMP__SECONDARY_INSPECTOR_ASSIGNMENTS SA ON YD040.ACTIVITY_ID = SA.ACTIVITY_ID AND SA.ACTIVITY_ID = PA.ACTIVITY_ID  
		WHERE TD001.DATE_DELETED_DTE IS NULL AND YD095.DATE_DELETED_DTE IS NULL AND YD040.DATE_DELETED_DTE IS NULL
	GROUP BY
		YD095.FILE_NUMBER_NUM,
		TD001.FILE_STATUS_ETXT,
		TD001.FILE_STATUS_FTXT,
		CONVERT(datetime, YD040.ACTIVITY_DATE_DTE) ,
		YD040.ACTIVITY_ID,
		YD040.STAKEHOLDER_ID,
		TD038.INSPECTION_REASON_ETXT,
		TD038.INSPECTION_REASON_FTXT,
		CATEGORIES.ACTIVITY_TYPE_CD,
		CATEGORIES.ACTIVITY_TYPE_ENM,
		CATEGORIES.SUBACTIVITY_TYPE_CDS,
		CATEGORIES.SUBACTIVITY_TYPE_ENMS,
		PA.name ,
		PA.STAKEHOLDER_ID ,
		PA.bookableresourceid ,
		PA.userid ,
		SA.name ,
		SA.STAKEHOLDER_ID ,
		SA.bookableresourceid ,
		SA.userid ,
		YD040.VERIFICATION_IND,
		YD040.MANAGER_COMMENT_TXT
	) T;

select * from SOURCE__IIS_INSPECTIONS
where PRIMARY_INSPECTOR is null

SELECT FILE_NUMBER_NUM FROM SOURCE__IIS_INSPECTIONS
GROUP BY FILE_NUMBER_NUM
HAVING COUNT (FILE_NUMBER_NUM) > 1;

SELECT @@ROWCOUNT SOURCE__IIS_INSPECTIONS_QUERY, COUNT(ACTIVITY_ID) COUNT__IIS_INSPECTIONS 
from YD040_ACTIVITY;
--===================================================================================================


--duplicates
--===================================================================================================
SELECT COUNT(ACTIVITY_ID) DUPLICATION_INSPECTIONS
FROM SOURCE__IIS_INSPECTIONS
GROUP BY ACTIVITY_ID
HAVING COUNT(ACTIVITY_ID) > 1;
--===================================================================================================


--CONNECT THE IIS INSPECTIONS TO THE ACCOUNTS IN ROM
--===================================================================================================
UPDATE
	SOURCE__IIS_INSPECTIONS
SET
	id = ACCOUNTS.Id,
	ovs_iisid = STAKEHOLDER_ID
FROM
	SOURCE__IIS_INSPECTIONS
	JOIN [dbo].STAGING__ACCOUNT ACCOUNTS ON ACCOUNTS.ovs_iisid = STAKEHOLDER_ID
WHERE
	ACCOUNTS.customertypecode <> 948010000;

select @@ROWCOUNT INSPECTION_ACCOUNT_MATCHUP;
--===================================================================================================


----REMOVE OVERSIGHT TYPES THAT DONT HAVE ACTIVITY TYPE MAPPINGS
----==================================================================================
DELETE FROM ACTIVITY_TYPE_MAPPINGS WHERE IIS_ACTIVITY_TYPE_ID IS NULL;
----SELECT * FROM ACTIVITY_TYPE_MAPPINGS WHERE IIS_ACTIVITY_TYPE_ID IS NULL;

----UNMAPPED VALUES
----GC Undeclared / Misdeclared	47F438C7-C104-EB11-A813-000D3AF3A7A7	Unplanned
----MOC Facility Targeted			994C3EC1-C104-EB11-A813-000D3AF3A7A7	Planned
----MOC Facility Follow-up		47F438C7-C104-EB11-A813-000D3AF3A7A7	Unplanned
----MOC Facility Triggered		47F438C7-C104-EB11-A813-000D3AF3A7A7	Unplanned
--select @@ROWCOUNT ACTIVITY_TYPES_WITH_NO_MAPPING;
----==================================================================================



--DETERMINE ROM ACTIVITY TYPES USING ACTIVITY MAPPING SHEET
--==================================================================================
DROP TABLE IF EXISTS #TEMP__INSPECTION_ACTIVITY_MAPPINGS;
SELECT *
INTO #TEMP__INSPECTION_ACTIVITY_MAPPINGS
FROM
	SOURCE__IIS_INSPECTIONS T1,
	ACTIVITY_TYPE_MAPPINGS T2
WHERE
	ROM_OVERSIGHT_TYPE_ID <> 'SITE_VISIT'
	AND (T1.ACTIVITY_TYPE_CD = t2.IIS_ACTIVITY_TYPE_ID AND IIS_ACTIVITY_SUB_TYPE_ID IS NULL) AND T1.ACTIVITY_ID IS NOT NULL
	OR (T1.ACTIVITY_TYPE_CD = t2.IIS_ACTIVITY_TYPE_ID AND T1.SUBACTIVITY_TYPE_CDS = CAST(T2.IIS_ACTIVITY_SUB_TYPE_ID AS varchar(10)))
	OR (T1.ACTIVITY_TYPE_CD = t2.IIS_ACTIVITY_TYPE_ID AND CAST(T2.IIS_ACTIVITY_SUB_TYPE_ID AS varchar(10)) IS NULL)
	OR (T1.ACTIVITY_TYPE_CD = t2.IIS_ACTIVITY_TYPE_ID AND CHARINDEX(CAST(T2.IIS_ACTIVITY_SUB_TYPE_ID AS varchar(10)), T1.SUBACTIVITY_TYPE_CDS) > 0);

select @@ROWCOUNT INSPECTIONS_ACTIVITIES_MAPPED;
--==================================================================================
--BEFORE 40405, AFTER 35682 - REVIEW MAPPINGS



--LOGIC FOR FISCAL YEAR AND QUARTER AND WO NUMBERS
--==================================================================================
DECLARE @INS 			 NVARCHAR(50) = CONVERT(NVARCHAR(50),SESSION_CONTEXT(N'WO_TYPE_INSPECTION'));
DECLARE @PL  			 NVARCHAR(50) = CONVERT(NVARCHAR(50),SESSION_CONTEXT(N'PRICE_LIST_BASE_PRICES'));
DECLARE @CLOSED          NVARCHAR(50) = CONVERT(NVARCHAR(50),SESSION_CONTEXT(N'CLOSED'));
DECLARE @STATUS_INACTIVE NVARCHAR(50) = CONVERT(NVARCHAR(50),SESSION_CONTEXT(N'STATUS_INACTIVE'));
DECLARE @STATE_INACTIVE  NVARCHAR(50) = CONVERT(NVARCHAR(50),SESSION_CONTEXT(N'STATE_INACTIVE'));
DECLARE @TDG			 NVARCHAR(50) = CONVERT(NVARCHAR(50),SESSION_CONTEXT(N'BU_TDG'));

DROP TABLE IF EXISTS #TEMP__IIS_TO_ROM;
SELECT
	newid() ID,
	CONVERT(uniqueidentifier, @INS) WORK_ORDER_TYPE,
	CONCAT('WO-', [YEAR], '-', REPLACE(STR(ROW_NUMBER() OVER (ORDER BY ACTIVITY_ID), 8), ' ', '0')) [WORK_ORDER_NUMBER], --WO name, 2021 + auto incremented number 1...X
	CONVERT(uniqueidentifier, @PL) PRICE_LIST,                    
	#TEMP__INSPECTION_ACTIVITY_MAPPINGS.ID ACCOUNTID, 
	MONTH,
	YEAR,
	ovs_iisid,                                                                 
	@CLOSED workorder_status,                
	@STATUS_INACTIVE [status],
	@STATE_INACTIVE [state],
	FILE_STATUS_ETXT,
	PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,                                       
	SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID,                                     
	PRIMARY_INSPECTOR_USER_ID owner,                                              
	'systemuser' [OWNER_TYPE],                                  
	CONVERT(uniqueidentifier, @TDG) [OWNING_BUSINESS_UNIT],  
	PRIMARY_INSPECTOR_USER_ID [owning_user],                                      
	CAST(ACTIVITY_ID AS nvarchar(500)) [description],
	ACTIVITY_ID,
		  
CASE
	WHEN ([MONTH] >= 1 AND [MONTH] <= 3) THEN 'Q4'
	WHEN ([MONTH] >= 4 AND [MONTH] <= 6) THEN 'Q1'
	WHEN ([MONTH] >= 7 AND [MONTH] <= 9) THEN 'Q2'
	WHEN ([MONTH] >= 10 AND [MONTH] <= 12) THEN 'Q3'
END FISCAL_QUARTER,
		  
CASE
	WHEN ([MONTH] >= 1 AND [MONTH] <= 3) THEN CONCAT(CONVERT(NVARCHAR(4), [YEAR] - 1), '-', CONVERT(NVARCHAR(4), [YEAR]))
	ELSE CONCAT(CONVERT(NVARCHAR(4), [YEAR]),'-',CONVERT(NVARCHAR(4), [YEAR] + 1))
END FISCAL_YEAR,

ACTIVITY_TYPE_CD,
IIS_ACTIVITY_TYPE_ID,
IIS_ACTIVITY_SUB_TYPE_ID,
ACTIVITY_TYPE_ENM,
IIS_ACTIVITY_TYPE_ENM,
ROM_OVERSIGHT_TYPE_ID,
ROM_RATIONALE_ID,
SUBACTIVITY_TYPE_CDS SUBACTIVITY_TYPE_CDS,
QC_REVIEW_IND,
QC_REVIEW_MANAGERS_COMMENTS

INTO #TEMP__IIS_TO_ROM
FROM #TEMP__INSPECTION_ACTIVITY_MAPPINGS

ORDER BY YEAR DESC


SELECT * FROM #TEMP__IIS_TO_ROM ORDER BY YEAR DESC

SELECT COUNT(*) IIS_INSPECTION_THIS_FISCAL FROM #TEMP__IIS_TO_ROM WHERE FISCAL_YEAR = '2021-2022'
--==================================================================================



--LINK WORK ORDERS TO ROMS FISCAL DATA
--==================================================================================
DROP TABLE IF EXISTS #PRE_STAGING;
SELECT T.*, FY.TC_TCFISCALYEARID, FQ.TC_TCFISCALQUARTERID, FQ.tc_name FISCALQUARTERNAME  , FY.tc_name FISCALYEARNAME
INTO #PRE_STAGING
FROM #TEMP__IIS_TO_ROM T
	JOIN [DBO].SOURCE__FISCAL_YEAR FY    ON FY.TC_NAME = T.FISCAL_YEAR
	JOIN [DBO].SOURCE__FISCAL_QUARTER FQ ON FQ.TC_NAME = T.FISCAL_QUARTER
	AND FY.TC_TCFISCALYEARID = FQ.TC_TCFISCALYEARID

SELECT @@ROWCOUNT PRE_STAGING_COUNT
--==================================================================================
--BEFORE 35682, AFTER 35674



--WHERE THE PRIMARY HASNT BEEN SET BECAUSE THE INSPECTOR DOES NOT HAVE AN ACCOUNT YET, THEN SET IT TO THE "TDG.CORE" user so we can at least get them in
--I DID THIS SO OLD INSPECTIONS DONT SHOW AS UNASSIGNED, BUT IF WE PREFER BLANKS I CAN BULK UPDATE IN CRM 
--==================================================================================
DECLARE @TDGBU   NVARCHAR(50) = CONVERT(NVARCHAR(50),SESSION_CONTEXT(N'BU_TDG'));
DECLARE @TDGUSER NVARCHAR(50) = CONVERT(NVARCHAR(50),SESSION_CONTEXT(N'USER_TDGCORE'));	

UPDATE
	#PRE_STAGING
SET
	PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID  = @TDGBU, 
	[owner] = @TDGUSER       
FROM
	#PRE_STAGING WO
WHERE
	WO.PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID IS NULL;

SELECT @@ROWCOUNT PRE_STAGING_INSPECTIONS_OWNERS_SET;
--==================================================================================




--HOW MANY SITE VISITS ARE WE SAVING FOR LATER 
--==================================================================================
SELECT COUNT(*) SITE_VISITS_IN_STAGING FROM #PRE_STAGING
WHERE ACTIVITY_TYPE_ENM = 'Site Visit';
--==================================================================================



--INSERT DATA INTO STAGING TABLE FOR KINGSWAY
--==================================================================================
INSERT INTO
	[dbo].STAGING__WORK_ORDERS (
	Id,
	msdyn_workorderid,
	[msdyn_workordertype],
	[msdyn_name],
	[msdyn_pricelist],
	[msdyn_serviceaccount],
	[ovs_iisid],
	[msdyn_systemstatus],
	[statuscode],
	statecode,
	[ovs_primaryinspector],
	[ovs_secondaryinspector],
	[ownerid],
	[owneridtype],
	[owningbusinessunit],
	owninguser,
	[msdyn_workordersummary],
	ovs_iisactivityid,
	[ovs_fiscalquarter],
	ovs_currentfiscalquartername,
	[ovs_fiscalyear],
	ovs_fiscalyearname,
	[ovs_oversighttype],
	[ovs_rational],
	ovs_qcreviewcompletedind,
	ovs_qcreviewcomments
	)
SELECT
	ID,
	ID,
	WORK_ORDER_TYPE,
	WORK_ORDER_NUMBER,
	PRICE_LIST,
	accountid,
	ovs_iisid,
	workorder_status,
	[status],
	[state],
	PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
	SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
	owner,
	OWNER_TYPE,
	OWNING_BUSINESS_UNIT,
	owning_user,
	[DESCRIPTION],
	ACTIVITY_ID,
	tc_tcfiscalquarterid,
	FISCALQUARTERNAME,
	tc_tcfiscalyearid,
	FISCALYEARNAME,
	CONVERT(uniqueidentifier, ROM_OVERSIGHT_TYPE_ID) ROM_OVERSIGHT_TYPE_ID,
	CONVERT(uniqueidentifier, ROM_RATIONALE_ID) ROM_RATIONALE_ID,
	QC_REVIEW_IND,
	QC_REVIEW_MANAGERS_COMMENTS
FROM #PRE_STAGING
WHERE ROM_OVERSIGHT_TYPE_ID <> 'SITE_VISIT';


SELECT @@ROWCOUNT PRE_STAGING_INSPECTIONS;
--==================================================================================


--TODO MATCH SITE VISITS TO SEANS EXCEL SHEET WITH MATCHES
--==================================================================================
--SQL
--==================================================================================






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
ACCOUNTS.ID accountid,
CURRENT_INSPECTOR_ID
,FQ.[tc_tcfiscalquarterid],
FQ.[tc_name] [ovs_fiscalquartername],
FY.[tc_tcfiscalyearid],
FY.[tc_name] [ovs_fiscalyearname]
INTO #TEMP_WORKPLAN
FROM (

--3745
	SELECT
		CASE
			WHEN QUARTER_1 = '1' THEN 'Q1'
			WHEN QUARTER_2 = '1' THEN 'Q2'
			WHEN QUARTER_3 = '1' THEN 'Q3'
			WHEN QUARTER_4 = '1' THEN 'Q4'
		END [QUARTER],

		CASE
			WHEN QUARTER_1 = '1' OR QUARTER_2 = '1' OR QUARTER_3 = '1' THEN '2021'
			WHEN QUARTER_4 = '1' THEN '2022'
		END [YEAR],
	
		CASE
			WHEN Charindex(',', CURRENT_INSPECTOR) = 0 THEN 'TDG'
			ELSE Substring(CURRENT_INSPECTOR, 1, Charindex(',', CURRENT_INSPECTOR) -1)
		END [InspectorLastName],

		CASE
			WHEN Charindex(',', CURRENT_INSPECTOR) = 0 THEN 'CORE'
			ELSE Substring(CURRENT_INSPECTOR, Charindex(',', CURRENT_INSPECTOR) + 1, LEN(CURRENT_INSPECTOR))
		END [InspectorFirstName],

		wp.CURRENT_INSPECTOR_ID,

		TYPE, IIS_ID, import_number, fiscal_year

	FROM
		CURRENT_WORKPLAN2021 WP
	WHERE
		CURRENTLY_PLANNED = '1'
		AND fiscal_year = '2021-2022'

) WP
JOIN STAGING__ACCOUNT ACCOUNTS ON WP.IIS_ID = ACCOUNTS.ovs_iisid --3733
JOIN [dbo].SOURCE__FISCAL_YEAR FY ON WP.[YEAR] = FY.tc_fiscalyearnum
JOIN [dbo].SOURCE__FISCAL_QUARTER FQ ON FQ.tc_name = WP.[QUARTER] AND FQ.tc_tcfiscalyearidname = WP.fiscal_year; --3725
--==============================================================================

--3745 nop vs 3725 coverted = acceptable


--GET A TEMPORARY TABLE OF BOOKABLE RESOURCES WITH TRANSFORMED VALUES FROM OUR STAGED DATA
--==============================================================================
DECLARE @BR NVARCHAR(50) = CONVERT(NVARCHAR(50),SESSION_CONTEXT(N'BR_TDGCORE'));
DECLARE @TDGU NVARCHAR(50) = CONVERT(NVARCHAR(50),SESSION_CONTEXT(N'USERS_TDGCORE'));

DROP TABLE IF EXISTS #TEMP_BOOKABLE_RESOURCES;
SELECT 
[name],

CASE
	WHEN BR.userid IS NULL THEN @TDGU
	ELSE BR.userid
END OWNER_ID,

CASE
	WHEN BR.bookableresourceid IS NULL THEN @BR
	ELSE BR.bookableresourceid
END BOOKABLE_RESOURCE_ID,

'systemuser' OWNER_TYPE,

CASE
	WHEN BR.userid IS NULL THEN NULL
	ELSE BR.userid
END OWNING_USER,

REPLACE(UPPER([dbo].[ReplaceASCII](BR.name)), ' ', '') NOASCII_OR_SPACE ,

BR.accountidname STAKEHOLDER_ID
--UPPER(TRIM(CONCAT(BR.FIRST, ' ', T2.InspectorLastName))) = UPPER([dbo].[ReplaceASCII](T1.name)) BR.useridname

INTO #TEMP_BOOKABLE_RESOURCES
FROM STAGING__BOOKABLE_RESOURCE BR; 

SELECT COUNT(*) STAGING__BOOKABLE_RESOURCE FROM #TEMP_BOOKABLE_RESOURCES;
--==============================================================================


--MATCH BOOKABLE RESOURCES FROM ROM TO INSPECTORS IN THE WORKPLAN BY ID, AND PUT MATCHES IN A TEMP TABLE
--==============================================================================
DROP TABLE IF EXISTS #TEMP__MATCHED_WP_INSPECTORS;
SELECT * 
INTO #TEMP__MATCHED_WP_INSPECTORS                
FROM #TEMP_BOOKABLE_RESOURCES T1
JOIN #TEMP_WORKPLAN T2 
ON T1.STAKEHOLDER_ID = T2.CURRENT_INSPECTOR_ID;
--==============================================================================
SELECT * FROM #TEMP__MATCHED_WP_INSPECTORS

--CREATE A LIST OF INSPECTIONS FROM THE WORKPLAN THAT EXCLUDE INSPECTIONS 
--THAT HAVE ALREADY BEEN ENTERED IN IIS AS WE'VE ALREADY CONVERTED AND DON'T WANT DUPLICATES
--==============================================================================
DROP TABLE IF EXISTS #TEMP_WORKPLAN_EXCLUDING_INSPECTIONS_ALREADY_IN_IIS; 
SELECT WP.*, BR.BOOKABLE_RESOURCE_ID, BR.name
INTO #TEMP_WORKPLAN_EXCLUDING_INSPECTIONS_ALREADY_IN_IIS
FROM #TEMP_WORKPLAN WP
LEFT JOIN #TEMP__MATCHED_WP_INSPECTORS BR ON WP.IIS_ID = BR.IIS_ID
WHERE CONCAT(BR.IIS_ID, BR.fiscal_year)
NOT IN (
	--WORKPLAN INSPECTIONS CREATED IN IIS ALREADY
	--IGNORE TO PREVENT DOUBLES
	SELECT
		CONCAT(IIS_ID, WP.fiscal_year)
	FROM #TEMP_WORKPLAN WP
		JOIN STAGING__WORK_ORDERS WO ON WP.IIS_ID = WO.ovs_iisid
		AND WP.fiscal_year = WO.ovs_fiscalyearname
		AND WP.QUARTER = WO.ovs_currentfiscalquartername
	WHERE
		WP.fiscal_year = '2021-2022'
);
--==============================================================================


--TRANSFORM AND INSERT VALUES FOR OUR FINAL DATA SET OF WORKORDERS
--==============================================================================	
DECLARE @CONST_WORKORDERTYPE_INSPECTION              VARCHAR(50) = 'b1ee680a-7cf7-ea11-a815-000d3af3a7a7';
DECLARE @BASEPRICE  			 NVARCHAR(50) = CONVERT(NVARCHAR(50),SESSION_CONTEXT(N'PRICE_LIST_BASE_PRICES'));


 SELECT
	newid()									 [msdyn_workorderid], 
	'b1ee680a-7cf7-ea11-a815-000d3af3a7a7'			 [WORK_ORDER_TYPE], 
	@BASEPRICE								 [PRICE_LIST], 
	WP.accountid, 
	IIS_ID, 
	'690970000' [WORK_ORDER_STATUS],  
	(SELECT businessunitid FROM CRM__BUSINESSUNIT WHERE name = 'Transportation of Dangerous Goods')				 [OWNING_BUSINESS_UNIT], 
	[tc_tcfiscalquarterid],
	[ovs_fiscalquartername],
	[tc_tcfiscalyearid],
	WP.fiscal_year,

	CONCAT('WO-', [YEAR], '-', REPLACE(STR(ROW_NUMBER() OVER (ORDER BY import_number), 8), ' ', '0')) [WORK_ORDER_NUMBER],  --WO + 2021 + auto incremented number 1...x
    
	CONCAT(
	'Work Order converted from 2021/2022 Workplan for IIS_ID = ',
	IIS_ID
	) [WORK_ORDER_SUMMARY],                           
 
	CASE
	WHEN [TYPE] = 'MOC' THEN '864BAA27-279E-EB11-B1AC-000D3AE924D1'
	WHEN [TYPE] = 'GC' THEN '72afccd3-269e-eb11-b1ac-000d3ae924d1'
	WHEN [TYPE] = 'HUBS' THEN '72afccd3-269e-eb11-b1ac-000d3ae924d1'
	END OVERSIGHT_TYPE,
  
	'994C3EC1-C104-EB11-A813-000D3AF3A7A7' RATIONALE,                --ALL WORK PLAN INSPECTIONS ARE PLANNED
	BOOKABLE_RESOURCE_ID,
	BR.userid,
	'systemuser',
	BR.userid
FROM #TEMP_WORKPLAN_EXCLUDING_INSPECTIONS_ALREADY_IN_IIS WP
JOIN [dbo].STAGING__BOOKABLE_RESOURCE BR ON WP.BOOKABLE_RESOURCE_ID = BR.bookableresourceid;


UPDATE STAGING__WORK_ORDERS 
SET 
[msdyn_workorderid] = ID,
ovs_currentfiscalquarter = ovs_fiscalquarter;
--==============================================================================


--PULL SITE ADDRESS INTO WORK ORDER
--==============================================================================
UPDATE STAGING__WORK_ORDERS
SET 
--SELECT
msdyn_address1 = T2.address1_line1,
msdyn_address2 = T2.address1_line2,
msdyn_address3 = T2.address1_line3,
msdyn_postalcode = T2.address1_postalcode,
msdyn_city = T2.address1_city,
msdyn_stateorprovince = T2.address1_stateorprovince,
msdyn_country = T2.address1_country,
msdyn_serviceterritory = T2.territoryid
FROM STAGING__WORK_ORDERS T1
JOIN STAGING__ACCOUNT T2 ON T1.msdyn_serviceaccount = T2.accountid;
--==============================================================================


--SET THE WORK ORDER STATUSES FOR OLD AND CURRENT INSPECTIONS
--===================================================================================================
--SELECT * FROM STAGING__WORK_ORDERS WHERE ovs_fiscalyearname = '2021-2022'
--Open   - Unscheduled 690970000
--Open   - Scheduled   690970001
--Open   - In Progress 690970002
--Open   - Completed   690970003
--Closed - Posted      690970004
--Closed - Canceled    690970005

--ANY Inspections from this years workplan that already exist in IIS lets set to UNSCHEDULED, hard to know if they're fully done or not
--better to not assume closed
UPDATE
	STAGING__WORK_ORDERS
SET
	[msdyn_systemstatus] = '690970000' --Open-Completed
WHERE
	ovs_fiscalyearname = '2021-2022';
--TODO AL: IF OLD INSPECTION AND NO OPEN COCS OR ENFORCEMENT ACTIONS = CLOSED - POSTED
--REQUIRES COCS AND ENFORCEMENT ACTIONS TO BE CREATED FIRST, THEN CAN UPDATE STATUS OF WO'S
--===================================================================================================



select count(*) from STAGING__WORK_ORDERS

--/****** Script for SelectTopNRows command from SSMS  ******/
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




select * from STAGING__WORK_ORDERS
WHERE ovs_fiscalyearname = '2021-2022'
