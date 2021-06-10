--TABLE DEFINITIONS
--===================================================================================================
	/****** Object:  Table [dbo].[tdgdata__msdyn_workorder]    Script Date: 6/6/2021 11:21:47 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STAGING__WORK_ORDERS]') AND type in (N'U'))
DROP TABLE [dbo].[STAGING__WORK_ORDERS]

/****** Object:  Table [dbo].[STAGING__WORK_ORDERS]    Script Date: 6/6/2021 11:21:47 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

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
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

--===================================================================================================
GO


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

--TDG CORE BOOKABLE RESOURCE
--used as a default value in case inspectors are not able to be loaded or are not licensed in dynamics yet 
DECLARE @CONST_TDGCORE_BOOKABLE_RESOURCE_ID          VARCHAR(50) = '2cfc9150-d6a3-eb11-b1ac-000d3ae8bee7';

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
--these variables can change with the environment, so double check these match the environment you're syncing to

--DECLARE @CONST_TDGCORE_DOMAINNAME  VARCHAR(50)  = 'tdg.core@034gc.onmicrosoft.com';
--DECLARE @CONST_TDGCORE_USERID      VARCHAR(50)  = (SELECT ID FROM tdgdata__systemuser  where domainname = 'tdg.core@034gc.onmicrosoft.com');
--DECLARE @CONST_TEAM_QUEBEC_ID      VARCHAR(50)  = (SELECT teamid FROM tdgdata__team    WHERE name = 'Quebec');
--DECLARE @CONST_TEAM_TDG_NAME       VARCHAR(500) = (SELECT teamid FROM tdgdata__team    WHERE name = 'Transportation of Dangerous Goods');
--DECLARE @CONST_BUSINESSUNIT_TDG_ID VARCHAR(50)  = (SELECT ID FROM TDGDATA__BUSINESSUNIT WHERE name = 'Transportation of Dangerous Goods');
--DECLARE @CONST_PRICELISTID         VARCHAR(50)  = (SELECT ID FROM tdgdata__pricelevel  WHERE NAME = 'Base Prices');

	--PREPROD, QA, ACC VALUES
	DECLARE @CONST_TDGCORE_DOMAINNAME  VARCHAR(50)  = 'tdg.core@034gc.onmicrosoft.com';
	DECLARE @CONST_TDGCORE_USERID      VARCHAR(50)  = '15abdd9e-8edd-ea11-a814-000d3af3afe0';
	DECLARE @CONST_TEAM_TDG_NAME       VARCHAR(500) = '53122e0c-73f3-ea11-a815-000d3af3ac0d';
	DECLARE @CONST_BUSINESSUNIT_TDG_ID VARCHAR(50)  = '4e122e0c-73f3-ea11-a815-000d3af3ac0d';
	DECLARE @CONST_PRICELISTID         VARCHAR(50)  = 'b92b6a16-7cf7-ea11-a815-000d3af3a7a7';

	--CRM CONSTANTS
	DECLARE @CONST_OWNERIDTYPE_TEAM VARCHAR(50)			= 'team';
	DECLARE @CONST_OWNERIDTYPE_SYSTEMUSER VARCHAR(50)	= 'systemuser';

	SELECT @CONST_TDGCORE_DOMAINNAME TDGCORE_DOMAINNAME, @CONST_TDGCORE_USERID TDGCORE_USERID, @CONST_TEAM_TDG_NAME TEAM_TDG_NAME, @CONST_BUSINESSUNIT_TDG_ID BUSINESSUNIT_TDG_ID, @CONST_PRICELISTID PRICELISTID;

--===================================================================================================

--IIS ACTIVITY TYPE TO ROM ACTIVITY MAPPING EXCEL SHEET VALUES
--===================================================================================================
DROP TABLE IF EXISTS ACTIVITY_TYPE_MAPPINGS;
SELECT
	* INTO ACTIVITY_TYPE_MAPPINGS
FROM
	(
	SELECT
		20                       IIS_ACTIVITY_TYPE_ID,
		'Site visit'             IIS_ACTIVITY_TYPE_ENM,
		NULL                     IIS_ACTIVITY_SUB_TYPE_ID,
		'n/a'                    IIS_ACTIVITY_SUB_TYPE_ENM,
		'SITE_VISIT'             ROM_OVERSIGHT_TYPE_ID,
		'SITE_VISIT'             ROM_OVERSIGHT_TYPE_ENM,
		@CONST_RATIONALE_PLANNED ROM_RATIONALE_ID,
		'Planned'                ROM_RATIONALE_ENM
	UNION
	SELECT
		21,
		'General Compliance Inspection',
		26,
		'Compliance Estimation Program (CEP)',
		@CONST_OVERSIGHTTYPE_GCTARGETED,
		'GC Targeted',
		@CONST_RATIONALE_PLANNED,
		'Planned'
	UNION
	SELECT
		21,
		'General Compliance Inspection',
		28,
		'Follow-up Inspection (Discretionary)',
		@CONST_OVERSIGHTTYPE_GCTARGETED,
		'GC Targeted',
		@CONST_RATIONALE_PLANNED,
		'Planned'
	UNION
	SELECT
		21,
		'General Compliance Inspection',
		27,
		'Follow-up Inspection (Indicated)',
		@CONST_OVERSIGHTTYPE_GCTARGETED,
		'GC Targeted',
		@CONST_RATIONALE_PLANNED,
		'Planned'
	UNION
	SELECT
		21,
		'General Compliance Inspection',
		33,
		'Opportunity',
		@CONST_OVERSIGHTTYPE_GC_OPPORTUNITY,
		'GC Opportunity',
		@CONST_RATIONALE_UNPLANNED,
		'Unplanned'
	UNION
	SELECT
		21,
		'General Compliance Inspection',
		25,
		'Scheduled (Workplan / Risk Based - excluding others)',
		@CONST_OVERSIGHTTYPE_GCIPT,
		'GC IPT',
		@CONST_RATIONALE_PLANNED,
		'Planned'
	UNION
	SELECT
		21,
		'General Compliance Inspection',
		32,
		'Triggered',
		@CONST_OVERSIGHTTYPE_GC_TRIGGERED,
		'GC Triggered',
		@CONST_RATIONALE_UNPLANNED,
		'Unplanned'
	UNION
	SELECT
		22,
		'MOC Facility Inspection (Planned)',
		NULL,
		'all subcategory types',
		@CONST_OVERSIGHTTYPE_MOC_FACILITY_IPT,
		'MOC Facility IPT',
		@CONST_RATIONALE_PLANNED,
		'Planned'
	UNION
	SELECT
		23,
		'Consignment',
		NULL,
		'all subcategory types',
		@CONST_OVERSIGHTTYPE_GCCONSIGNMENT,
		'GC Consignment',
		@CONST_RATIONALE_UNPLANNED,
		'Unplanned'
	UNION
	SELECT
		24,
		'Document Review',
		NULL,
		'n/a',
		@CONST_OVERSIGHTTYPE_CIVDOCREVIEW,
		'Civil Aviation Document Review',
		@CONST_RATIONALE_UNPLANNED,
		'Unplanned'
	UNION
	SELECT
		59,
		'MOC Facility Inspection - (Unplanned)',
		NULL,
		'all subcategory types',
		@CONST_OVERSIGHTTYPE_MOCOPPORTUNITY,
		'MOC Facility Opportunity',
		@CONST_RATIONALE_UNPLANNED,
		'Unplanned'
	UNION
	SELECT
		NULL,
		'NULL',
		NULL,
		'NULL',
		@CONST_OVERSIGHTTYPE_GC_UNDECLARED,
		'GC Undeclared / Misdeclared',
		@CONST_RATIONALE_UNPLANNED,
		'Unplanned'
	UNION
	SELECT
		NULL,
		'NULL',
		NULL,
		'NULL',
		@CONST_OVERSIGHTTYPE_MOC_FACILITY_FOLLOWUP,
		'MOC Facility Follow-up',
		@CONST_RATIONALE_UNPLANNED,
		'Unplanned'
	UNION
	SELECT
		NULL,
		'NULL',
		NULL,
		'NULL',
		@CONST_OVERSIGHTTYPE_MOCTARGETED,
		'MOC Facility Targeted',
		@CONST_RATIONALE_PLANNED,
		'Planned'
	UNION
	SELECT
		NULL,
		'NULL',
		NULL,
		'NULL',
		@CONST_OVERSIGHTTYPE_MOC_FACILITY_TRIGGERED,
		'MOC Facility Triggered',
		@CONST_RATIONALE_UNPLANNED,
		'Unplanned'
	) T;
--===================================================================================================

--GET TEMPORARY LIST OF INTERNAL EMPLOYEE FULL NAMES FROM IIS, USED TO JOIN TO BOOKABLE RESOURCES
--===================================================================================================
DROP TABLE IF EXISTS #TEMP_IIS_CONTACT_FULL_NAMES;
SELECT REPLACE(UPPER(
TRIM(
	CONCAT(
	CONCAT(STAKEHOLDER_NAME_FIRST_NM, ' '),
			STAKEHOLDER_NAME_FAMILY_NM
	)
)
), '  ', ' ') IIS_CONTACT_FULL_NAME, T1.STAKEHOLDER_ID, T2.LANGUAGE_CD, T1.USER_STAKEHOLDER_ID, T3.DATE_CURRENT_DTE, T3.DATE_DELETED_DTE, T3.FILE_STATUS_CD, T3.DATE_STOP_DTE, T3.ORIGIN_KEY_TXT, T3.STAKEHOLDER_TYPE_CD
INTO #TEMP_IIS_CONTACT_FULL_NAMES
FROM YD083_INDIVIDUAL_INFORMATION T1
JOIN YD075_INDIVIDUAL T2 ON T1.STAKEHOLDER_ID = T2.STAKEHOLDER_ID
JOIN YD070_STAKEHOLDER T3 ON T2.STAKEHOLDER_ID = T3.STAKEHOLDER_ID
WHERE STAKEHOLDER_TYPE_CD = 1; --AND (T3.DATE_DELETED_DTE IS NOT NULL OR T3.DATE_STOP_DTE IS NOT NULL)
--===================================================================================================

--CONVERT IIS INSPECTIONS INTO WORKORDERS
--===================================================================================================
--WORK ORDERS
INSERT INTO
	[dbo].SOURCE__IIS_INSPECTIONS (
	[MONTH],
	[YEAR],
	FILE_NUMBER_NUM,
	FILE_STATUS_ETXT,
	FILE_STATUS_FTXT,
	ACTIVITY_DATE_DTE,
	ACTIVITY_ID,
	STAKEHOLDER_ID,
	id,
	ovs_iisid,
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
		TD001.FILE_STATUS_ETXT,
		TD001.FILE_STATUS_FTXT,
		CONVERT(datetime, YD040.ACTIVITY_DATE_DTE) ACTIVITY_DATE_DTE,
		YD040.ACTIVITY_ID,
		YD040.STAKEHOLDER_ID,
		NULL id,
		--ACCOUNTS.id,
		NULL ovs_iisid,
		--ACCOUNTS.[ovs_iisid],
		TD038.INSPECTION_REASON_ETXT,
		TD038.INSPECTION_REASON_FTXT,
		CATEGORIES.ACTIVITY_TYPE_CD,
		CATEGORIES.ACTIVITY_TYPE_ENM,
		CATEGORIES.SUBACTIVITY_TYPE_CDS,
		CATEGORIES.SUBACTIVITY_TYPE_ENMS,
		PRIMARY_INSPECTOR.name PRIMARY_INSPECTOR,
		PRIMARY_INSPECTOR.STAKEHOLDER_ID PRIMARY_INSPECTOR_ID,
		PRIMARY_INSPECTOR.bookableresourceid PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
		PRIMARY_INSPECTOR.userid PRIMARY_INSPECTOR_USER_ID,
		SECONDARY_INSPECTOR.name SECONDARY_INSPECTOR,
		SECONDARY_INSPECTOR.STAKEHOLDER_ID SECONDARY_INSPECTOR_ID,
		SECONDARY_INSPECTOR.bookableresourceid SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
		SECONDARY_INSPECTOR.userid SECONDARY_INSPECTOR_USER_ID,
		YD040.VERIFICATION_IND,
		YD040.MANAGER_COMMENT_TXT
	FROM
		YD040_ACTIVITY YD040
		JOIN YD095_STAKEHOLDER_FILE YD095 ON YD040.FILE_NUMBER_NUM = YD095.FILE_NUMBER_NUM
		JOIN TD001_FILE_STATUS TD001 ON YD095.FILE_STATUS_CD = TD001.FILE_STATUS_CD
		LEFT JOIN (

		--GET CATEGORIES AND SUBCATEGORIES OF ACTIVIES FROM IIS
		SELECT
			CAT.FILE_NUMBER_NUM,
			CAT.ACTIVITY_TYPE_CD,
			CAT.ACTIVITY_TYPE_ENM,
			ISNULL(SUBCAT.SUBACTIVITY_TYPE_CDS, 'N/A') SUBACTIVITY_TYPE_CDS,
			ISNULL(SUBCAT.SUBACTIVITY_TYPE_ENMS, 'N/A') SUBACTIVITY_TYPE_ENMS
		FROM
			(
			SELECT
				YD101.FILE_NUMBER_NUM,
				TD045.ACTIVITY_TYPE_CD,
				TD045.ACTIVITY_TYPE_ENM
			FROM
				YD101_FILE_ACTIVITY_TYPE YD101
				JOIN TD045_ACTIVITY_TYPE TD045 ON YD101.ACTIVITY_TYPE_CD = TD045.ACTIVITY_TYPE_CD
				AND YD101.DATE_DELETED_DTE IS NULL
			GROUP BY
				YD101.FILE_NUMBER_NUM,
				TD045.ACTIVITY_TYPE_CD,
				TD045.ACTIVITY_TYPE_ENM
			) CAT
			LEFT JOIN (
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


		) CATEGORIES ON CATEGORIES.FILE_NUMBER_NUM = YD095.FILE_NUMBER_NUM
		LEFT JOIN YD041_INSPECTION YD041 ON YD040.ACTIVITY_ID = YD041.ACTIVITY_ID
		LEFT JOIN TD038_INSPECTION_REASON TD038 ON YD041.INSPECTION_REASON_CD = TD038.INSPECTION_REASON_CD
		LEFT JOIN (
		SELECT
			YD048.ACTIVITY_ID,
			YD048.STAKEHOLDER_ID,
			name,
			BR.bookableresourceid,
			BR.userid
		FROM
			YD048_ACTIVITY_ASSIGNMENT YD048
			JOIN YD083_INDIVIDUAL_INFORMATION YD083 ON YD048.STAKEHOLDER_ID = YD083.STAKEHOLDER_ID
			JOIN #TEMP_IIS_CONTACT_FULL_NAMES IIS_NAMES ON YD083.STAKEHOLDER_ID = IIS_NAMES.STAKEHOLDER_ID 
			JOIN [dbo].STAGING__BOOKABLE_RESOURCE BR ON IIS_NAMES.IIS_CONTACT_FULL_NAME = UPPER([dbo].[ReplaceASCII](name))
		WHERE
			YD083.DATE_DELETED_DTE IS NULL
			AND YD048.DATE_DELETED_DTE IS NULL
			AND ASSIGN_ROLE_CD = '1'
		) PRIMARY_INSPECTOR ON PRIMARY_INSPECTOR.ACTIVITY_ID = YD040.ACTIVITY_ID
		LEFT JOIN (
		SELECT
			YD048.ACTIVITY_ID,
			YD048.STAKEHOLDER_ID,
			name,
			BR.bookableresourceid,
			BR.userid
		FROM
			YD048_ACTIVITY_ASSIGNMENT YD048
			JOIN YD083_INDIVIDUAL_INFORMATION YD083 ON YD048.STAKEHOLDER_ID = YD083.STAKEHOLDER_ID
			JOIN #TEMP_IIS_CONTACT_FULL_NAMES IIS_NAMES ON YD083.STAKEHOLDER_ID = IIS_NAMES.STAKEHOLDER_ID 
			JOIN [dbo].STAGING__BOOKABLE_RESOURCE BR ON IIS_NAMES.IIS_CONTACT_FULL_NAME = UPPER([dbo].[ReplaceASCII](name))
		WHERE
			YD083.DATE_DELETED_DTE IS NULL
			AND YD048.DATE_DELETED_DTE IS NULL
			AND ASSIGN_ROLE_CD = '2'
		) SECONDARY_INSPECTOR ON SECONDARY_INSPECTOR.ACTIVITY_ID = YD040.ACTIVITY_ID 
	GROUP BY
		YD095.FILE_NUMBER_NUM,
		TD001.FILE_STATUS_ETXT,
		TD001.FILE_STATUS_FTXT,
		YD040.INSPECTION_DATE_DTE,
		YD040.ACTIVITY_ID,
		YD040.STAKEHOLDER_ID,
		CATEGORIES.FILE_NUMBER_NUM,
		CATEGORIES.ACTIVITY_TYPE_CD,
		CATEGORIES.ACTIVITY_TYPE_ENM,
		CATEGORIES.SUBACTIVITY_TYPE_CDS,
		CATEGORIES.SUBACTIVITY_TYPE_ENMS,
		TD038.INSPECTION_REASON_ETXT,
		TD038.INSPECTION_REASON_FTXT,
		YD040.ACTIVITY_DATE_DTE,
		PRIMARY_INSPECTOR.name,
		PRIMARY_INSPECTOR.STAKEHOLDER_ID,
		PRIMARY_INSPECTOR.bookableresourceid,
		PRIMARY_INSPECTOR.userid,
		SECONDARY_INSPECTOR.name,
		SECONDARY_INSPECTOR.STAKEHOLDER_ID,
		SECONDARY_INSPECTOR.bookableresourceid,
		SECONDARY_INSPECTOR.userid,
		YD040.VERIFICATION_IND,
		YD040.MANAGER_COMMENT_TXT
	) T;


--connect the IIS Inspections to the Accounts in ROM
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


--only convert activities that have a mapping defined
DELETE FROM ACTIVITY_TYPE_MAPPINGS WHERE IIS_ACTIVITY_TYPE_ID IS NULL;


--create values for fiscal data
DROP TABLE IF EXISTS #TEMP_TRANSFORMED_SOURCE_DATA;
SELECT
	T.*,
	FY.tc_tcfiscalyearid,
	FQ.tc_tcfiscalquarterid 
INTO #TEMP_TRANSFORMED_SOURCE_DATA
FROM
	(
	SELECT
		newid() ID,
		CONVERT(uniqueidentifier, @CONST_WORKORDERTYPE_INSPECTION) WORK_ORDER_TYPE,
		CONCAT('WO-', [YEAR], '-', REPLACE(STR(ROW_NUMBER() OVER (ORDER BY ID), 8), ' ', '0')) [WORK_ORDER_NUMBER], --WO name, 2021 + auto incremented number 1...X
		CONVERT(uniqueidentifier, @CONST_PRICELISTID) PRICE_LIST,                     --default price list
		id accountid,                                                                 --account id for service account linked by the iis id
		[ovs_iisid],                                                                  --IIS STAKEHOLDER_ID
		@CONST_WORKORDER_SYSTEM_STATUS_CLOSED_POSTED WORK_ORDER_STATUS,                --"Closed - Posted"
		@CONST_WORK_ORDER_STATUSCODE_INACTIVE WORK_ORDER_STATUSCODE,
		FILE_STATUS_ETXT,
		PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,                                       --PRIMARY INSPECTOR
		SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID,                                     --SECONDARY INSPECTOR
		PRIMARY_INSPECTOR_USER_ID owner,                                              --@CONST_TDGCORE_USERID [OWNER] --OWNER = primary inspector
		@CONST_OWNERIDTYPE_SYSTEMUSER [OWNER_TYPE],                                   --OWNER TYPE = systemuser
		CONVERT(uniqueidentifier, @CONST_BUSINESSUNIT_TDG_ID) [OWNING_BUSINESS_UNIT],  --TDG Business Unit
		PRIMARY_INSPECTOR_USER_ID [owning_user],                                      --,@CONST_TDGCORE_USERID [OWNING_TEAM]         --OWNING TEAM = TDG Team
		CAST(ACTIVITY_ID AS nvarchar(500)) [WORK_ORDER_SUMMARY],
		ACTIVITY_ID IIS_ACTIVITY_ID,
		  
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

		T1.ACTIVITY_TYPE_CD,
		T2.IIS_ACTIVITY_TYPE_ID,
		T2.IIS_ACTIVITY_SUB_TYPE_ID,
		T1.ACTIVITY_TYPE_ENM,
		IIS_ACTIVITY_TYPE_ENM,
		ROM_OVERSIGHT_TYPE_ID,
		ROM_RATIONALE_ID,
		SUBACTIVITY_TYPE_CDS SUBACTIVITY_TYPE_CDS,
		T1.QC_REVIEW_IND,
		T1.QC_REVIEW_MANAGERS_COMMENTS
	FROM
		SOURCE__IIS_INSPECTIONS T1,
		ACTIVITY_TYPE_MAPPINGS T2
	WHERE
		ROM_OVERSIGHT_TYPE_ID <> 'SITE_VISIT'
		AND (T1.ACTIVITY_TYPE_CD = t2.IIS_ACTIVITY_TYPE_ID AND IIS_ACTIVITY_SUB_TYPE_ID IS NULL) AND id IS NOT NULL
		OR (T1.ACTIVITY_TYPE_CD = t2.IIS_ACTIVITY_TYPE_ID AND T1.SUBACTIVITY_TYPE_CDS = CAST(T2.IIS_ACTIVITY_SUB_TYPE_ID AS varchar(10)))
		OR (T1.ACTIVITY_TYPE_CD = t2.IIS_ACTIVITY_TYPE_ID AND CAST(T2.IIS_ACTIVITY_SUB_TYPE_ID AS varchar(10)) IS NULL)
		OR (T1.ACTIVITY_TYPE_CD = t2.IIS_ACTIVITY_TYPE_ID AND CHARINDEX(CAST(T2.IIS_ACTIVITY_SUB_TYPE_ID AS varchar(10)), T1.SUBACTIVITY_TYPE_CDS) > 0)
	) T
	JOIN [dbo].SOURCE__FISCAL_YEAR FY ON FY.TC_NAME = T.FISCAL_YEAR
	JOIN [dbo].SOURCE__FISCAL_QUARTER FQ ON FQ.TC_NAME = T.FISCAL_QUARTER
	AND FY.tc_tcfiscalyearid = FQ.tc_tcfiscalyearid
WHERE
	accountid IS NOT NULL;



--create staging values
INSERT INTO
	[dbo].STAGING__WORK_ORDERS (
	Id,
	[msdyn_workordertype],
	[msdyn_name],
	[msdyn_pricelist],
	[msdyn_serviceaccount],
	[ovs_iisid],
	[msdyn_systemstatus],
	[statuscode],
	[ovs_primaryinspector],
	[ovs_secondaryinspector],
	[ownerid],
	[owneridtype],
	[owningbusinessunit],
	owninguser,
	[msdyn_workordersummary],
	ovs_iisactivityid,
	[ovs_fiscalquarter],
	[ovs_fiscalyear],
	[ovs_oversighttype],
	[ovs_rational],
	ovs_qcreviewcompletedind,
	ovs_qcreviewcomments
	)
SELECT
	ID,
	WORK_ORDER_TYPE,
	WORK_ORDER_NUMBER,
	PRICE_LIST,
	accountid,
	ovs_iisid,
	WORK_ORDER_STATUS,
	WORK_ORDER_STATUSCODE,
	PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
	SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
	owner,
	OWNER_TYPE,
	OWNING_BUSINESS_UNIT,
	owning_user,
	WORK_ORDER_SUMMARY,
	IIS_ACTIVITY_ID,
	tc_tcfiscalquarterid,
	tc_tcfiscalyearid,
	CONVERT(uniqueidentifier, ROM_OVERSIGHT_TYPE_ID) ROM_OVERSIGHT_TYPE_ID,
	CONVERT(uniqueidentifier, ROM_RATIONALE_ID) ROM_RATIONALE_ID,
	QC_REVIEW_IND,
	QC_REVIEW_MANAGERS_COMMENTS
FROM
	(
	SELECT
		*
	FROM
		#TEMP_TRANSFORMED_SOURCE_DATA
	WHERE
		ROM_OVERSIGHT_TYPE_ID <> 'SITE_VISIT'
	) T;

UPDATE STAGING__WORK_ORDERS SET msdyn_workorderid = Id; 


--load the fiscal year, quarter and inspector names into the staging table, easier to look at the data
UPDATE
	STAGING__WORK_ORDERS
SET
	[ovs_primaryinspectorname] = BR.name,
	[ovs_secondaryinspectorname] = BR2.name,
	[ovs_fiscalquartername] = FQ.tc_name,
	[ovs_fiscalyearname] = FY.tc_name --SELECT
	--BR.name
	--,BR2.name
	--,FQ.tc_name
	--,FY.tc_name
FROM
	STAGING__WORK_ORDERS T1
	JOIN [dbo].SOURCE__FISCAL_YEAR FY ON T1.ovs_fiscalyear = FY.tc_tcfiscalyearid
	JOIN [dbo].SOURCE__FISCAL_QUARTER FQ ON T1.ovs_fiscalquarter = FQ.tc_tcfiscalquarterid
	JOIN [dbo].STAGING__BOOKABLE_RESOURCE BR ON T1.ovs_primaryinspector = BR.bookableresourceid
	LEFT JOIN [dbo].STAGING__BOOKABLE_RESOURCE BR2 ON T1.ovs_secondaryinspector = BR2.bookableresourceid;
  

--WHERE THE PRIMARY HASNT BEEN SET BECAUSE THE INSPECTOR DOES NOT HAVE AN ACCOUNT YET, THEN SET IT TO THE "TDG.CORE" user so we can at least get them in
UPDATE
	STAGING__WORK_ORDERS
SET
	[ovs_primaryinspector] = @CONST_TDGCORE_BOOKABLE_RESOURCE_ID, --TDG CORE BOOKABLE RESOURCE ID
	ownerid = @CONST_TDGCORE_USERID,                              -- tdg core system user
	owninguser = @CONST_TDGCORE_USERID                            -- tdg core system user
FROM
	STAGING__WORK_ORDERS WO
WHERE
	WO.ovs_primaryinspector IS NULL;


--set the status of inspections from this years workplan that have already been started in IIS to Open-Completed====
--SELECT * FROM STAGING__WORK_ORDERS WHERE ovs_fiscalyearname = '2021-2022'
--Open - Unscheduled 690970000
--Open - Scheduled  690970001
--Open - In Progress 690970002
--Open - Completed  690970003
--Closed - Posted  690970004
--Closed - Canceled  690970005
--ANY Inspections from this years workplan that exist in IIS lets set to Open-Completed, hard to know if they're fully done or not
UPDATE
	STAGING__WORK_ORDERS
SET
	[msdyn_systemstatus] = '690970003' --Open-Completed
WHERE
	ovs_fiscalyearname = '2021-2022';
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
ACCOUNTS.ID accountid,
FQ.[tc_tcfiscalquarterid],
FQ.[tc_name] [ovs_fiscalquartername],
FY.[tc_tcfiscalyearid],
FY.[tc_name] [ovs_fiscalyearname]
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

		TYPE, IIS_ID, import_number, fiscal_year

	FROM
		SOURCE__WORKPLAN_IMPORT WP
	WHERE
		CURRENTLY_PLANNED = '1'
		AND fiscal_year = '2021-2022'

) WP
JOIN STAGING__ACCOUNT ACCOUNTS ON WP.IIS_ID = ACCOUNTS.ovs_iisid
JOIN [dbo].SOURCE__FISCAL_YEAR FY ON WP.[YEAR] = FY.tc_fiscalyearnum
JOIN [dbo].SOURCE__FISCAL_QUARTER FQ ON FQ.tc_name = WP.[QUARTER] AND FQ.tc_tcfiscalyearidname = WP.fiscal_year;
--==============================================================================


--GET A TEMPORARY TABLE OF BOOKABLE RESOURCES WITH TRANSFORMED VALUES FROM OUR STAGED DATA
--==============================================================================
DROP TABLE IF EXISTS #TEMP_BOOKABLE_RESOURCES;
SELECT 
[name],

CASE
	WHEN BR.userid IS NULL THEN @CONST_TDGCORE_USERID
	ELSE BR.userid
END OWNER_ID,

CASE
	WHEN BR.bookableresourceid IS NULL THEN @CONST_TDGCORE_BOOKABLE_RESOURCE_ID
	ELSE BR.bookableresourceid
END BOOKABLE_RESOURCE_ID,

CASE
	WHEN BR.userid IS NULL THEN @CONST_OWNERIDTYPE_SYSTEMUSER
	ELSE @CONST_OWNERIDTYPE_SYSTEMUSER
END OWNER_TYPE,

CASE
	WHEN BR.userid IS NULL THEN NULL
	ELSE BR.userid
END OWNING_USER

INTO #TEMP_BOOKABLE_RESOURCES
FROM STAGING__BOOKABLE_RESOURCE BR; 
--==============================================================================


--MATCH BOOKABLE RESOURCES FROM ROM TO INSPECTORS IN THE WORKPLAN BY NAME, AND PUT MATCHES IN A TEMP TABLE
--==============================================================================
DROP TABLE IF EXISTS #TEMP_WORKPLAN_MATCHED_BOOKABLE_RESOURCES;
SELECT * 
INTO #TEMP_WORKPLAN_MATCHED_BOOKABLE_RESOURCES
FROM #TEMP_BOOKABLE_RESOURCES T1
JOIN #TEMP_WORKPLAN T2 ON UPPER(TRIM(CONCAT(T2.InspectorFirstName, ' ', T2.InspectorLastName))) = UPPER([dbo].[ReplaceASCII](T1.name)); 
--==============================================================================


--CREATE A LIST OF INSPECTIONS FROM THE WORKPLAN THAT EXCLUDE INSPECTIONS 
--THAT HAVE ALREADY BEEN ENTERED IN IIS AS WE'VE ALREADY CONVERTED AND DON'T WANT DUPLICATES
--==============================================================================
DROP TABLE IF EXISTS #TEMP_WORKPLAN_EXCLUDING_INSPECTIONS_ALREADY_IN_IIS;
SELECT WP.*, BR.BOOKABLE_RESOURCE_ID, BR.name
INTO #TEMP_WORKPLAN_EXCLUDING_INSPECTIONS_ALREADY_IN_IIS
FROM #TEMP_WORKPLAN WP
LEFT JOIN #TEMP_WORKPLAN_MATCHED_BOOKABLE_RESOURCES BR ON WP.IIS_ID = BR.IIS_ID
AND BR.import_number 
NOT IN (
	--WORKPLAN INSPECTIONS CREATED IN IIS ALREADY
	--IGNORE TO PREVENT DOUBLES
	SELECT
		import_number
	FROM #TEMP_WORKPLAN WP
		JOIN STAGING__WORK_ORDERS WO ON WP.IIS_ID = WO.ovs_iisid
		AND WP.fiscal_year = WO.ovs_fiscalyearname
		AND WP.QUARTER = WO.ovs_fiscalquartername
	WHERE
		WP.fiscal_year = '2021-2022'
);
--==============================================================================


--TRANSFORM AND INSERT VALUES FOR OUR FINAL DATA SET OF WORKORDERS
--==============================================================================
INSERT INTO
  [dbo].STAGING__WORK_ORDERS (
	Id,
    [msdyn_workordertype],
    [msdyn_pricelist],
    [msdyn_serviceaccount],
    [ovs_iisid],
    [msdyn_systemstatus],
    [owningbusinessunit],
    [ovs_fiscalquarter],
    [ovs_fiscalquartername],      
	[ovs_fiscalyear],
    [ovs_fiscalyearname],
    [msdyn_name],
    [msdyn_workordersummary],
    [ovs_oversighttype],
    [ovs_rational],
    [ovs_primaryinspector], --,[ovs_secondaryinspector]
    [ownerid],
    [owneridtype],
    owninguser
    
  )
SELECT
	newid()									 [msdyn_workorderid], 
	@CONST_WORKORDERTYPE_INSPECTION			 [WORK_ORDER_TYPE], 
	@CONST_PRICELISTID						 [PRICE_LIST], 
	WP.accountid, 
	IIS_ID, 
	@CONST_WORKORDER_SYSTEM_STATUS_UNSCHEDULED [WORK_ORDER_STATUS],  
	@CONST_BUSINESSUNIT_TDG_ID				 [OWNING_BUSINESS_UNIT], 
	[tc_tcfiscalquarterid],
	[ovs_fiscalquartername],
	[tc_tcfiscalyearid],
	[ovs_fiscalyearname],

	CONCAT('WO-', [YEAR], '-', REPLACE(STR(ROW_NUMBER() OVER (ORDER BY import_number), 8), ' ', '0')) [WORK_ORDER_NUMBER],  --WO + 2021 + auto incremented number 1...x
    
	CONCAT(
	'Work Order converted from 2021/2022 Workplan for IIS_ID = ',
	IIS_ID
	) [WORK_ORDER_SUMMARY],                           
 
	CASE
	WHEN [TYPE] = 'MOC' THEN @CONST_OVERSIGHTTYPE_MOCTARGETED
	WHEN [TYPE] = 'GC' THEN @CONST_OVERSIGHTTYPE_GCTARGETED
	WHEN [TYPE] = 'HUBS' THEN @CONST_OVERSIGHTTYPE_GCTARGETED
	END OVERSIGHT_TYPE,
  
	@CONST_RATIONALE_PLANNED RATIONALE,                --ALL WORK PLAN INSPECTIONS ARE PLANNED
	BOOKABLE_RESOURCE_ID,
	BR.userid,
	@CONST_OWNERIDTYPE_SYSTEMUSER,
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


/****** Script for SelectTopNRows command from SSMS  ******/
--SELECT 
--      [msdyn_address1]
--      ,[msdyn_address2]
--      ,[msdyn_address3]
--      ,[msdyn_city]
--      ,[msdyn_country]
--      ,[msdyn_name]
--      ,[msdyn_postalcode]
--      ,[msdyn_pricelist]
--      ,[msdyn_serviceaccount]
--      ,[msdyn_serviceterritory]
--      ,[msdyn_stateorprovince]
--      ,[msdyn_systemstatus]
--      ,[msdyn_workorderid]
--      ,[msdyn_workordersummary]
--      ,[msdyn_workordertype]
--      ,[ovs_fiscalquarter]
--      ,[ovs_fiscalyear]
--      ,[ovs_iisid]
--      ,[ovs_mocid]
--      ,[ovs_oversighttype]
--      ,[ovs_primaryinspector]
--      ,[ovs_rational]
--      ,[ovs_secondaryinspector]
--      ,[ovs_tyrational]
--      ,[ownerid]
--      ,[owneridtype]
--      ,[owningbusinessunit]
--      ,[owninguser]
--	  ,ovs_qcreviewcomments
--	  ,ovs_qcreviewcompletedind
--  FROM [dbo].STAGING__WORK_ORDERS