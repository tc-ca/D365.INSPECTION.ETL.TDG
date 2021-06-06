--TABLE DEFINITIONS
--===================================================================================================
--===================================================================================================
BEGIN 

	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID( '[dbo].[SOURCE__REGULATED_ENTITIES]')
			AND TYPE IN ('U')
	) DROP TABLE [dbo].[SOURCE__REGULATED_ENTITIES];


	CREATE TABLE [dbo].[SOURCE__REGULATED_ENTITIES] (
		[REGULATED_ENTITY_ID] [uniqueidentifier],
		[REGULATED_ENTITY_ID_SOURCE] [nvarchar](50) NULL,
		[IIS_ID] [numeric](18, 0) NULL,
		[REGULATED_ENTITY_NAME] [nvarchar](500) NULL,
		[CONSOLIDATED_COMMON_ENGLISH_NAME] [nvarchar](500) NULL,
		[CONSOLIDATED_COMMON_FRENCH_NAME] [nvarchar](500) NULL,
		[COUNTRY_SUBDIVISION_CD] [nvarchar](10) NULL,
		[CITY_TOWN_NAME_NM] [nvarchar](250) NULL,
		[ADDRESS] [nvarchar](1000) NULL,
		[POSTAL_CODE_TXT] [nvarchar](10) NULL,
		[COMPLETED] [nvarchar](10) NULL,
		[NOTES] [nvarchar](500) NULL
	) ON [PRIMARY];


	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID('[dbo].[SOURCE__SITES]')
			AND TYPE IN ('U')
	) DROP TABLE [dbo].[SOURCE__SITES];


	CREATE TABLE [dbo].[SOURCE__SITES] (
		[SITE_ID] [uniqueidentifier],
		[IIS_ID] [numeric](18, 0) NULL,
		[REGULATED_ENTITY_ID] [uniqueidentifier],
		[REGULATED_ENTITY_NAME] [nvarchar](500) NULL,
		[REGULATED_ENTITY_ID_SOURCE] [nvarchar](50) NULL,
		[COMPANY_NAME_FORMATTED] [nvarchar](500) NULL,
		[COMPANY_NAME] [nvarchar](500) NULL,
		[COUNTRY_SUBDIVISION_CD] [nvarchar](10) NULL,
		[CITY_TOWN_NAME_NM] [nvarchar](250) NULL,
		[ADDRESS] [nvarchar](1000) NULL,
		[POSTAL_CODE_TXT] [nvarchar](10) NULL,
		[COMPLETED] [nvarchar](10) NULL,
		[PLANNED2021] [nvarchar](10) NULL,
	) ON [PRIMARY];

		
	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID( '[dbo].[STAGING__CONTACT]')
			AND TYPE IN ('U')
	) DROP TABLE [dbo].[STAGING__CONTACT];


	CREATE TABLE [dbo].[STAGING__CONTACT](
		[accountid] [uniqueidentifier] NULL,
		[accountrolecode] [int] NULL,
		[address1_addresstypecode] [int] NULL,
		[address1_city] [nvarchar](80) NULL,
		[address1_country] [nvarchar](80) NULL,
		[address1_latitude] [decimal](38, 5) NULL,
		[address1_line1] [nvarchar](250) NULL,
		[address1_line2] [nvarchar](250) NULL,
		[address1_line3] [nvarchar](250) NULL,
		[address1_postalcode] [nvarchar](20) NULL,
		[address1_postofficebox] [nvarchar](20) NULL,
		[address1_primarycontactname] [nvarchar](100) NULL,
		[address1_stateorprovince] [nvarchar](50) NULL,
		[address1_telephone1] [nvarchar](50) NULL,
		[company] [nvarchar](50) NULL,
		[contactid] [uniqueidentifier] NULL,
		[customertypecode] [int] NULL,
		[emailaddress1] [nvarchar](100) NULL,
		[firstname] [nvarchar](50) NULL,
		[fullname] [nvarchar](160) NULL,
		[Id] [uniqueidentifier] NOT NULL,
		[jobtitle] [nvarchar](100) NULL,
		[lastname] [nvarchar](50) NULL,
		[mobilephone] [nvarchar](50) NULL,
		[ownerid] [uniqueidentifier] NULL,
		[owneridtype] [nvarchar](4000) NULL,
		[owningbusinessunit] [uniqueidentifier] NULL,
		[owningteam] [uniqueidentifier] NULL,
		[owninguser] [uniqueidentifier] NULL,
		parentcustomeridtype nvarchar(4000) NULL,
		[statecode] [int] NULL,
		[statuscode] [int] NULL,
		[telephone1] [nvarchar](50) NULL,
		[telephone2] [nvarchar](50) NULL,
		[telephone3] [nvarchar](50) NULL
	) ON [PRIMARY];


	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID( '[dbo].[STAGING__BOOKABLE_RESOURCE]')
			AND TYPE IN ('U')
	) DROP TABLE [dbo].[STAGING__BOOKABLE_RESOURCE];


	CREATE TABLE [STAGING__BOOKABLE_RESOURCE] (
		[accountid] UNIQUEIDENTIFIER,
		[accountidname] VARCHAR(160),
		[accountidyominame] VARCHAR(160),
		[bookableresourceid] UNIQUEIDENTIFIER,
		[calendarid] UNIQUEIDENTIFIER,
		[calendaridname] VARCHAR(160),
		[contactid] UNIQUEIDENTIFIER,
		[contactidname] VARCHAR(160),
		[contactidyominame] VARCHAR(160),
		[createdby] UNIQUEIDENTIFIER,
		[createdbyname] VARCHAR(200),
		[createdbyyominame] VARCHAR(200),
		[createdon] DATETIME,
		[createdonbehalfby] UNIQUEIDENTIFIER,
		[createdonbehalfbyname] VARCHAR(200),
		[createdonbehalfbyyominame] VARCHAR(200),
		[exchangerate] NUMERIC(38, 10),
		[importsequencenumber] INT,
		[modifiedby] UNIQUEIDENTIFIER,
		[modifiedbyname] VARCHAR(200),
		[modifiedbyyominame] VARCHAR(200),
		[modifiedon] DATETIME,
		[modifiedonbehalfby] UNIQUEIDENTIFIER,
		[modifiedonbehalfbyname] VARCHAR(200),
		[modifiedonbehalfbyyominame] VARCHAR(200),
		[msdyn_bookingstodrip] INT,
		[msdyn_crewstrategy] INT,
		[msdyn_crewstrategyname] VARCHAR(255),
		[msdyn_derivecapacity] BIT,
		[msdyn_derivecapacityname] VARCHAR(255),
		[msdyn_displayonscheduleassistant] BIT,
		[msdyn_displayonscheduleassistantname] VARCHAR(255),
		[msdyn_displayonscheduleboard] BIT,
		[msdyn_displayonscheduleboardname] VARCHAR(255),
		[msdyn_enableappointments] INT,
		[msdyn_enableappointmentsname] VARCHAR(255),
		[msdyn_enabledforfieldservicemobile] BIT,
		[msdyn_enabledforfieldservicemobilename] VARCHAR(255),
		[msdyn_enabledripscheduling] BIT,
		[msdyn_enabledripschedulingname] VARCHAR(255),
		[msdyn_endlocation] INT,
		[msdyn_endlocationname] VARCHAR(255),
		[msdyn_facilityequipmentid] UNIQUEIDENTIFIER,
		[msdyn_facilityequipmentidname] VARCHAR(160),
		[msdyn_generictype] INT,
		[msdyn_generictypename] VARCHAR(255),
		[msdyn_hourlyrate] NUMERIC(38, 2),
		[msdyn_hourlyrate_base] NUMERIC(38, 2),
		[msdyn_internalflags] NTEXT,
		[msdyn_latitude] FLOAT,
		[msdyn_locationtimestamp] DATETIME,
		[msdyn_longitude] FLOAT,
		[msdyn_organizationalunit] UNIQUEIDENTIFIER,
		[msdyn_organizationalunitname] VARCHAR(100),
		[msdyn_pooltype] VARCHAR(4000),
		[msdyn_pooltypename] VARCHAR(255),
		[msdyn_primaryemail] VARCHAR(100),
		[msdyn_startlocation] INT,
		[msdyn_startlocationname] VARCHAR(255),
		[msdyn_targetutilization] INT,
		[msdyn_timeoffapprovalrequired] BIT,
		[msdyn_timeoffapprovalrequiredname] VARCHAR(255),
		[msdyn_warehouse] UNIQUEIDENTIFIER,
		[msdyn_warehousename] VARCHAR(100),
		[name] VARCHAR(100),
		[overriddencreatedon] DATETIME,
		[ovs_badgenumber] VARCHAR(100),
		[ovs_registeredinspectornumberrin] VARCHAR(100),
		[ownerid] UNIQUEIDENTIFIER,
		[owneridname] VARCHAR(200),
		[owneridtype] VARCHAR(64),
		[owneridyominame] VARCHAR(200),
		[owningbusinessunit] UNIQUEIDENTIFIER,
		[owningteam] UNIQUEIDENTIFIER,
		[owninguser] UNIQUEIDENTIFIER,
		[processid] UNIQUEIDENTIFIER,
		[resourcetype] INT,
		[resourcetypename] VARCHAR(255),
		[stageid] UNIQUEIDENTIFIER,
		[statecode] INT,
		[statecodename] VARCHAR(255),
		[statuscode] INT,
		[statuscodename] VARCHAR(255),
		[timezone] INT,
		[timezoneruleversionnumber] INT,
		[transactioncurrencyid] UNIQUEIDENTIFIER,
		[transactioncurrencyidname] VARCHAR(100),
		[traversedpath] VARCHAR(1250),
		[userid] UNIQUEIDENTIFIER,
		[useridname] VARCHAR(200),
		[useridyominame] VARCHAR(200),
		[utcconversiontimezonecode] INT,
		[versionnumber] BIGINT
	) ON [PRIMARY];


	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID(
				 '[dbo].[STAGING__BOOKABLE_RESOURCE_CATEGORIES]'
			)
			AND TYPE IN ('U')
	) DROP TABLE [dbo].[STAGING__BOOKABLE_RESOURCE_CATEGORIES];


	CREATE TABLE [STAGING__BOOKABLE_RESOURCE_CATEGORIES] (
		[bookableresourcecategoryid] UNIQUEIDENTIFIER,
		[createdby] UNIQUEIDENTIFIER,
		[createdbyname] VARCHAR(200),
		[createdbyyominame] VARCHAR(200),
		[createdon] DATETIME,
		[createdonbehalfby] UNIQUEIDENTIFIER,
		[createdonbehalfbyname] VARCHAR(200),
		[createdonbehalfbyyominame] VARCHAR(200),
		[description] VARCHAR(100),
		[exchangerate] NUMERIC(38, 10),
		[importsequencenumber] INT,
		[modifiedby] UNIQUEIDENTIFIER,
		[modifiedbyname] VARCHAR(200),
		[modifiedbyyominame] VARCHAR(200),
		[modifiedon] DATETIME,
		[modifiedonbehalfby] UNIQUEIDENTIFIER,
		[modifiedonbehalfbyname] VARCHAR(200),
		[modifiedonbehalfbyyominame] VARCHAR(200),
		[name] VARCHAR(100),
		[overriddencreatedon] DATETIME,
		[ownerid] UNIQUEIDENTIFIER,
		[owneridname] VARCHAR(200),
		[owneridtype] VARCHAR(64),
		[owneridyominame] VARCHAR(200),
		[owningbusinessunit] UNIQUEIDENTIFIER,
		[owningteam] UNIQUEIDENTIFIER,
		[owninguser] UNIQUEIDENTIFIER,
		[statecode] INT,
		[statecodename] VARCHAR(255),
		[statuscode] INT,
		[statuscodename] VARCHAR(255),
		[timezoneruleversionnumber] INT,
		[transactioncurrencyid] UNIQUEIDENTIFIER,
		[transactioncurrencyidname] VARCHAR(100),
		[utcconversiontimezonecode] INT,
		[versionnumber] BIGINT
	) ON [PRIMARY];


	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID(
				 '[dbo].[STAGING__BOOKABLE_RESOURCE_CATEGORY_ASSN]'
			)
			AND TYPE IN ('U')
	) DROP TABLE [dbo].[STAGING__BOOKABLE_RESOURCE_CATEGORY_ASSN];


	CREATE TABLE [STAGING__BOOKABLE_RESOURCE_CATEGORY_ASSN] (
		[bookableresourcecategoryassnid] UNIQUEIDENTIFIER,
		[createdby] UNIQUEIDENTIFIER,
		[createdbyname] VARCHAR(200),
		[createdbyyominame] VARCHAR(200),
		[createdon] DATETIME,
		[createdonbehalfby] UNIQUEIDENTIFIER,
		[createdonbehalfbyname] VARCHAR(200),
		[createdonbehalfbyyominame] VARCHAR(200),
		[exchangerate] NUMERIC(38, 10),
		[importsequencenumber] INT,
		[modifiedby] UNIQUEIDENTIFIER,
		[modifiedbyname] VARCHAR(200),
		[modifiedbyyominame] VARCHAR(200),
		[modifiedon] DATETIME,
		[modifiedonbehalfby] UNIQUEIDENTIFIER,
		[modifiedonbehalfbyname] VARCHAR(200),
		[modifiedonbehalfbyyominame] VARCHAR(200),
		[name] VARCHAR(100),
		[overriddencreatedon] DATETIME,
		[ownerid] UNIQUEIDENTIFIER,
		[owneridname] VARCHAR(200),
		[owneridtype] VARCHAR(64),
		[owneridyominame] VARCHAR(200),
		[owningbusinessunit] UNIQUEIDENTIFIER,
		[owningteam] UNIQUEIDENTIFIER,
		[owninguser] UNIQUEIDENTIFIER,
		[resource] UNIQUEIDENTIFIER,
		[resourcecategory] UNIQUEIDENTIFIER,
		[resourcecategoryname] VARCHAR(100),
		[resourcename] VARCHAR(100),
		[statecode] INT,
		[statecodename] VARCHAR(255),
		[statuscode] INT,
		[statuscodename] VARCHAR(255),
		[timezoneruleversionnumber] INT,
		[transactioncurrencyid] UNIQUEIDENTIFIER,
		[transactioncurrencyidname] VARCHAR(100),
		[utcconversiontimezonecode] INT,
		[versionnumber] BIGINT
	);


	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID( '[dbo].[SOURCE__IIS_INSPECTIONS]')
			AND TYPE IN ('U')
	) DROP TABLE [dbo].[SOURCE__IIS_INSPECTIONS];


	CREATE TABLE [SOURCE__IIS_INSPECTIONS] (
		[MONTH] int,
		[YEAR] int,
		FILE_NUMBER_NUM nvarchar (200),
		FILE_STATUS_ETXT varchar (50),
		FILE_STATUS_FTXT varchar (50),
		ACTIVITY_DATE_DTE datetime,
		ACTIVITY_ID numeric,
		STAKEHOLDER_ID numeric,
		id uniqueidentifier,
		ovs_iisid nvarchar (50),
		INSPECTION_REASON_ETXT varchar (250),
		INSPECTION_REASON_FTXT varchar (250),
		ACTIVITY_TYPE_CD varchar (250),
		ACTIVITY_TYPE_ENM varchar (500),
		SUBACTIVITY_TYPE_CDS varchar (250),
		SUBACTIVITY_TYPE_ENMS varchar (500),
		PRIMARY_INSPECTOR nvarchar (200),
		PRIMARY_INSPECTOR_ID numeric,
		PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID uniqueidentifier,
		PRIMARY_INSPECTOR_USER_ID uniqueidentifier,
		SECONDARY_INSPECTOR nvarchar (200),
		SECONDARY_INSPECTOR_ID numeric,
		SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID uniqueidentifier,
		SECONDARY_INSPECTOR_USER_ID uniqueidentifier
	);


	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID( '[dbo].[STAGING__TYRATIONAL]')
			AND TYPE IN ('U')
	) DROP TABLE [dbo].[STAGING__TYRATIONAL];


	CREATE TABLE [dbo].[STAGING__TYRATIONAL] (
		[Id] [uniqueidentifier] NOT NULL,
		[ovs_name] [nvarchar](100) NULL,
		[ovs_rationalelbl] [nvarchar](100) NULL,
		[ovs_rationalflbl] [nvarchar](100) NULL,
		[ovs_tyrationalid] [uniqueidentifier] NULL,
		[ownerid] [uniqueidentifier] NULL,
		[ownerid_entitytype] [nvarchar](128) NULL,
		[owneridname] [nvarchar](100) NULL,
		[owneridtype] [nvarchar](4000) NULL,
		[owningbusinessunit] [uniqueidentifier] NULL,
		[owningbusinessunit_entitytype] [nvarchar](128) NULL,
		[owningteam] [uniqueidentifier] NULL,
		[owningteam_entitytype] [nvarchar](128) NULL,
		[owninguser] [uniqueidentifier] NULL,
		[owninguser_entitytype] [nvarchar](128) NULL,
		[statecode] [int] NULL,
		[statuscode] [int] NULL
	);


	/****** Object:  Table [dbo].[STAGING__TYRATIONAL]    Script Date: 4/23/2021 12:20:19 PM ******/
	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID( '[dbo].[STAGING__OVERSIGHTTYPE]')
			AND TYPE IN ('U')
	) DROP TABLE [dbo].[STAGING__OVERSIGHTTYPE];


	CREATE TABLE [dbo].[STAGING__OVERSIGHTTYPE](
		[Id] [uniqueidentifier] NOT NULL,
		[ovs_name] [nvarchar](100) NULL,
		[ovs_oversighttypeid] [uniqueidentifier] NULL,
		[ovs_oversighttypenameenglish] [nvarchar](100) NULL,
		[ovs_oversighttypenamefrench] [nvarchar](100) NULL,
		[ownerid] [uniqueidentifier] NULL,
		[owneridtype] [nvarchar](4000) NULL,
		[owningbusinessunit] [uniqueidentifier] NULL,
		[owningteam] [uniqueidentifier] NULL,
		[owninguser] [uniqueidentifier] NULL
	);


	/****** Object:  Table [dbo].[STAGING__TERRITORY]    Script Date: 4/23/2021 12:39:57 PM ******/
	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID( '[dbo].[STAGING__TERRITORY]')
			AND TYPE IN ('U')
	) DROP TABLE [dbo].[STAGING__TERRITORY];


	CREATE TABLE [dbo].[STAGING__TERRITORY] (
		[Id] [uniqueidentifier] NOT NULL,
		[territoryid] [uniqueidentifier] NULL,
		[parentterritoryid] [uniqueidentifier] NULL,
		[description] [nvarchar](max) NULL,
		[managerid] [uniqueidentifier] NULL,
		[managerid_entitytype] [nvarchar](128) NULL,
		[name] [nvarchar](200) NULL,
		[ovs_territorynameenglish] [nvarchar](100) NULL,
		[ovs_territorynamefrench] [nvarchar](100) NULL,
		[transactioncurrencyid] [uniqueidentifier] NULL,
		[transactioncurrencyid_entitytype] [nvarchar](128) NULL
	);


	/****** Object:  Table [dbo].[STAGING__WORKORDERTYPE]    Script Date: 4/23/2021 1:43:19 PM ******/
	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID( '[dbo].[STAGING__WORKORDERTYPE]')
			AND TYPE IN ('U')
	) DROP TABLE [dbo].[STAGING__WORKORDERTYPE];


	CREATE TABLE [dbo].[STAGING__WORKORDERTYPE](
		[Id] [uniqueidentifier] NOT NULL,
		[msdyn_name] [nvarchar](100) NULL,
		[msdyn_pricelist] [uniqueidentifier] NULL,
		[msdyn_workordertypeid] [uniqueidentifier] NULL,
		[ovs_workordertypenameenglish] [nvarchar](100) NULL,
		[ovs_workordertypenamefrench] [nvarchar](100) NULL,
		[ownerid] [uniqueidentifier] NULL,
		[owneridtype] [nvarchar](4000) NULL,
		[owningbusinessunit] [uniqueidentifier] NULL,
		[owningteam] [uniqueidentifier] NULL,
		[owninguser] [uniqueidentifier] NULL
	)
END 


--DELETE REPLICATED CRM DATA AS A PRECAUTION IN CASE IT INTERFERES WITH OUR ETL
--===================================================================================================
--===================================================================================================
BEGIN 

	TRUNCATE TABLE dbo.tdgdata__bookableresource;
	TRUNCATE TABLE dbo.tdgdata__account;
	TRUNCATE TABLE dbo.tdgdata__msdyn_workorder;
	TRUNCATE TABLE dbo.tdgdata__qm_syresult;

END 



--DECLARE CONSTANTS
--===================================================================================================
--===================================================================================================
BEGIN 

	--=============================================DYNAMIC VALUES===========================================
	--these variables can change with the environment, so double check these match the environment you're syncing to

	DECLARE @CONST_TDGCORE_DOMAINNAME  VARCHAR(50)  = 'tdg.core@034gc.onmicrosoft.com';
	DECLARE @CONST_TDGCORE_USERID      VARCHAR(50)  = (SELECT ID FROM tdgdata__systemuser  where domainname = 'tdg.core@034gc.onmicrosoft.com');
	DECLARE @CONST_TEAM_QUEBEC_ID      VARCHAR(50)  = (SELECT teamid FROM tdgdata__team    WHERE name = 'Quebec');
	DECLARE @CONST_TEAM_TDG_NAME       VARCHAR(500) = (SELECT teamid FROM tdgdata__team    WHERE name = 'Transportation of Dangerous Goods');
	DECLARE @CONST_BUSINESSUNIT_TDG_ID VARCHAR(50)  = (SELECT ID FROM TDGDATA__BUSINESSUNIT WHERE name = 'Transportation of Dangerous Goods');
	DECLARE @CONST_PRICELISTID         VARCHAR(50)  = (SELECT ID FROM tdgdata__pricelevel  WHERE NAME = 'Base Prices');

	SELECT @CONST_TDGCORE_DOMAINNAME TDGCORE_DOMAINNAME, @CONST_TDGCORE_USERID TDGCORE_USERID, @CONST_TEAM_QUEBEC_ID TEAM_QUEBEC_ID, @CONST_TEAM_TDG_NAME TEAM_TDG_NAME, @CONST_BUSINESSUNIT_TDG_ID BUSINESSUNIT_TDG_ID, @CONST_PRICELISTID PRICELISTID;

	--CRM CONSTANTS
	DECLARE @CONST_OWNERIDTYPE_TEAM VARCHAR(50)			= 'team';
	DECLARE @CONST_OWNERIDTYPE_SYSTEMUSER VARCHAR(50)	= 'systemuser';
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
	

END
--===================================================================================================
--===================================================================================================


--CREATE MASTER DATA
--===================================================================================================
--===================================================================================================
BEGIN
	--===================================================================================================
	--RATIONALS
	INSERT INTO
		[dbo].[STAGING__TYRATIONAL] (
			[Id],
			[ovs_tyrationalid],
			[ovs_name],
			[ovs_rationalelbl],
			[ovs_rationalflbl],
			[ownerid],
			[owneridtype],
			[owningbusinessunit],
			[owninguser]
		)
	SELECT
		@CONST_RATIONALE_PLANNED   [Id],
		@CONST_RATIONALE_PLANNED   [ovs_tyrationalid],
		'Planned::Planifié'        [ovs_name],
		'Planned'                  [ovs_rationalelbl],
		'Planifié'                 [ovs_rationalflbl],
		@CONST_TDGCORE_USERID          [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER    [owneridtype],
		@CONST_BUSINESSUNIT_TDG_ID  [owningbusinessunit],
		@CONST_TDGCORE_USERID          [owninguser]
	UNION
	SELECT
		@CONST_RATIONALE_UNPLANNED [Id],
		@CONST_RATIONALE_UNPLANNED [ovs_tyrationalid],
		'Unplanned::Non planifié'  [ovs_name],
		'Unplanned'                [ovs_rationalelbl],
		'Non planifié'             [ovs_rationalflbl],
		@CONST_TDGCORE_USERID          [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER    [owneridtype],
		@CONST_BUSINESSUNIT_TDG_ID  [owningbusinessunit],
		@CONST_TDGCORE_USERID          [owninguser];


	--===================================================================================================
	--===================================================================================================
	--OVERSIGHT TYPES
	INSERT INTO
		[dbo].[STAGING__OVERSIGHTTYPE] (
			[Id],
			[ovs_oversighttypeid],
			[ovs_name],
			[ovs_oversighttypenameenglish],
			[ovs_oversighttypenamefrench],
			[ownerid],
			[owneridtype],
			[owningbusinessunit],
			[owninguser]
		)
	SELECT
		@CONST_OVERSIGHTTYPE_GCIPT,
		@CONST_OVERSIGHTTYPE_GCIPT,
		'GC IPT::GC IPT (FR)',
		'GC IPT',
		'GC IPT (FR)',
		@CONST_TDGCORE_USERID         [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER   [owneridtype],
		@CONST_BUSINESSUNIT_TDG_ID [owningbusinessunit],
		@CONST_TDGCORE_USERID         [owninguser]
	UNION
	SELECT
		@CONST_OVERSIGHTTYPE_GCTARGETED,
		@CONST_OVERSIGHTTYPE_GCTARGETED,
		'GC Targeted::GC Targeted (FR)',
		'GC Targeted',
		'GC ciblé',
		@CONST_TDGCORE_USERID         [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER   [owneridtype],
		@CONST_BUSINESSUNIT_TDG_ID [owningbusinessunit],
		@CONST_TDGCORE_USERID         [owninguser]
	UNION
	SELECT
		@CONST_OVERSIGHTTYPE_GC_FOLLOWUP,
		@CONST_OVERSIGHTTYPE_GC_FOLLOWUP,
		'GC Follow-up',
		'GC Follow-up',
		'Suivi GC',
		@CONST_TDGCORE_USERID         [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER   [owneridtype],
		@CONST_BUSINESSUNIT_TDG_ID [owningbusinessunit],
		@CONST_TDGCORE_USERID         [owninguser]
	UNION
	SELECT
		@CONST_OVERSIGHTTYPE_MOC_FACILITY_IPT,
		@CONST_OVERSIGHTTYPE_MOC_FACILITY_IPT,
		'MOC Facility IPT',
		'MOC Facility IPT',
		'Installation MOC IPT',
		@CONST_TDGCORE_USERID         [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER   [owneridtype],
		@CONST_BUSINESSUNIT_TDG_ID [owningbusinessunit],
		@CONST_TDGCORE_USERID         [owninguser]
	UNION
	SELECT
		@CONST_OVERSIGHTTYPE_MOCTARGETED,
		@CONST_OVERSIGHTTYPE_MOCTARGETED,
		'MOC Facility Targeted',
		'MOC Facility Targeted',
		'Facilité MOC ciblée',
		@CONST_TDGCORE_USERID         [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER   [owneridtype],
		@CONST_BUSINESSUNIT_TDG_ID [owningbusinessunit],
		@CONST_TDGCORE_USERID         [owninguser]
	UNION
	SELECT
		@CONST_OVERSIGHTTYPE_MOC_FACILITY_FOLLOWUP,
		@CONST_OVERSIGHTTYPE_MOC_FACILITY_FOLLOWUP,
		'MOC Facility Follow-up',
		'MOC Facility Follow-up',
		'Suivi des installations de MOC',
		@CONST_TDGCORE_USERID         [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER   [owneridtype],
		@CONST_BUSINESSUNIT_TDG_ID [owningbusinessunit],
		@CONST_TDGCORE_USERID         [owninguser]
	UNION
	SELECT
		@CONST_OVERSIGHTTYPE_GC_TRIGGERED,
		@CONST_OVERSIGHTTYPE_GC_TRIGGERED,
		'GC Triggered',
		'GC Triggered',
		'GC déclenché',
		@CONST_TDGCORE_USERID         [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER   [owneridtype],
		@CONST_BUSINESSUNIT_TDG_ID [owningbusinessunit],
		@CONST_TDGCORE_USERID         [owninguser]
	UNION
	SELECT
		@CONST_OVERSIGHTTYPE_GC_OPPORTUNITY,
		@CONST_OVERSIGHTTYPE_GC_OPPORTUNITY,
		'GC Opportunity',
		'GC Opportunity',
		'Opportunité GC',
		@CONST_TDGCORE_USERID         [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER   [owneridtype],
		@CONST_BUSINESSUNIT_TDG_ID [owningbusinessunit],
		@CONST_TDGCORE_USERID         [owninguser]
	UNION
	SELECT
		@CONST_OVERSIGHTTYPE_GCCONSIGNMENT,
		@CONST_OVERSIGHTTYPE_GCCONSIGNMENT,
		'GC Consignment',
		'GC Consignment',
		'Envoi GC',
		@CONST_TDGCORE_USERID         [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER   [owneridtype],
		@CONST_BUSINESSUNIT_TDG_ID [owningbusinessunit],
		@CONST_TDGCORE_USERID         [owninguser]
	UNION
	SELECT
		@CONST_OVERSIGHTTYPE_GC_UNDECLARED,
		@CONST_OVERSIGHTTYPE_GC_UNDECLARED,
		'GC Undeclared/ Misdeclared',
		'GC Undeclared/ Misdeclared',
		'GC non déclaré / mal déclaré',
		@CONST_TDGCORE_USERID         [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER   [owneridtype],
		@CONST_BUSINESSUNIT_TDG_ID [owningbusinessunit],
		@CONST_TDGCORE_USERID         [owninguser]
	UNION
	SELECT
		@CONST_OVERSIGHTTYPE_MOC_FACILITY_TRIGGERED,
		@CONST_OVERSIGHTTYPE_MOC_FACILITY_TRIGGERED,
		'MOC Facility Triggered',
		'MOC Facility Triggered',
		'Installation MOC déclenchée',
		@CONST_TDGCORE_USERID         [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER   [owneridtype],
		@CONST_BUSINESSUNIT_TDG_ID [owningbusinessunit],
		@CONST_TDGCORE_USERID         [owninguser]
	UNION
	SELECT
		@CONST_OVERSIGHTTYPE_MOCOPPORTUNITY,
		@CONST_OVERSIGHTTYPE_MOCOPPORTUNITY,
		'MOC Facility Opportunity',
		'MOC Facility Opportunity',
		'Opportunité d''installation MOC',
		@CONST_TDGCORE_USERID         [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER   [owneridtype],
		@CONST_BUSINESSUNIT_TDG_ID [owningbusinessunit],
		@CONST_TDGCORE_USERID         [owninguser]
	UNION
	SELECT
		@CONST_OVERSIGHTTYPE_CIVDOCREVIEW,
		@CONST_OVERSIGHTTYPE_CIVDOCREVIEW,
		'Civil Aviation Document Review',
		'Civil Aviation Document Review',
		'Examen des documents de l''aviation civile',
		@CONST_TDGCORE_USERID         [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER   [owneridtype],
		@CONST_BUSINESSUNIT_TDG_ID [owningbusinessunit],
		@CONST_TDGCORE_USERID         [owninguser];


	--===================================================================================================
	--===================================================================================================
	--WORKORDER TYPES
	INSERT INTO
		[dbo].[STAGING__WORKORDERTYPE] (
			[Id],
			[msdyn_workordertypeid],
			[msdyn_name],
			[msdyn_pricelist],
			[ovs_workordertypenameenglish],
			[ovs_workordertypenamefrench],
			[ownerid],
			[owneridtype],
			[owningbusinessunit],
			[owninguser]
		)
	SELECT
		@CONST_WORKORDERTYPE_INSPECTION,
		@CONST_WORKORDERTYPE_INSPECTION,
		'Inspection::Inspection',
		@CONST_PRICELISTID,
		'Inspection',
		'Inspection',
		@CONST_TDGCORE_USERID         [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER   [owneridtype],
		@CONST_BUSINESSUNIT_TDG_ID [owningbusinessunit],
		@CONST_TDGCORE_USERID         [owninguser]
	UNION
	SELECT
		@CONST_WORKORDERTYPE_REGULATORYAUTHORIZATION,
		@CONST_WORKORDERTYPE_REGULATORYAUTHORIZATION,
		'Regulatory Authorization',
		@CONST_PRICELISTID,
		'Regulatory Authorization',
		'Autorisation réglementaire',
		@CONST_TDGCORE_USERID         [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER   [owneridtype],
		@CONST_BUSINESSUNIT_TDG_ID [owningbusinessunit],
		@CONST_TDGCORE_USERID         [owninguser];


	--===================================================================================================
	--===================================================================================================
	--BOOKABLE RESOURCE CATEGORIES
	INSERT INTO
		[dbo].[STAGING__BOOKABLE_RESOURCE_CATEGORIES] (
			[bookableresourcecategoryid],
			[description],
			[name],
			[ownerid],
			[owneridtype],
			[owningbusinessunit],
			[owninguser]
		)
	SELECT
		@CONST_CATEGORY_INSPECTOR,
		--INSPECTOR 
		'Mark a Bookable Resource as an Inspector',
		'Inspector::Inspecteur',
		ownerid            = @CONST_TDGCORE_USERID,
		owneridtype        = @CONST_OWNERIDTYPE_SYSTEMUSER,
		owningbusinessunit = @CONST_BUSINESSUNIT_TDG_ID,
		owninguser         = @CONST_TDGCORE_USERID;


	--===================================================================================================
	--===================================================================================================
	--BOOKABLE RESOURCES / INSPECTORS
	INSERT INTO
		[dbo].[STAGING__BOOKABLE_RESOURCE] (
			bookableresourceid,
			[userid],
			[name],
			[msdyn_primaryemail],
			[ovs_registeredinspectornumberrin],
			[ovs_badgenumber]
		)
	SELECT
		@CONST_TDGCORE_BOOKABLE_RESOURCE_ID [bookableresourceid],
		--tdg core bookable resource id
		@CONST_TDGCORE_USERID               [userid],
		-- tdg core system user id
		'TDG Core'                          [name],
		@CONST_TDGCORE_DOMAINNAME           [msdyn_primaryemail],
		'1337'                              [ovs_registeredinspectornumberrin],
		'1337'                              [ovs_badgenumber];


	--===================================================================================================
	--===================================================================================================
	--TERRITORIES / REGIONS
	INSERT
		[dbo].[STAGING__TERRITORY] (
			[Id],
			[territoryid],
			[name],
			[ovs_territorynameenglish],
			[ovs_territorynamefrench]
		)
	SELECT
		@CONST_TERRITORY_HQ_ES,
		@CONST_TERRITORY_HQ_ES,
		'HQ-ES::FR HQ-ES',
		'HQ-ES',
		'HQ-ES'
	UNION
	SELECT
		@CONST_TERRITORY_HQ_CR,
		@CONST_TERRITORY_HQ_CR,
		'HQ-CR::FR HQ-CR',
		'HQ-CR',
		'HQ-CR'
	UNION
	SELECT
		@CONST_TERRITORY_ATLANTIC,
		@CONST_TERRITORY_ATLANTIC,
		'Atlantic::Atlantique',
		'Atlantic',
		'Atlantique'
	UNION
	SELECT
		@CONST_TERRITORY_QUEBEC,
		@CONST_TERRITORY_QUEBEC,
		'Quebec::Québec',
		'Quebec',
		'Québec'
	UNION
	SELECT
		@CONST_TERRITORY_PACIFIQUE,
		@CONST_TERRITORY_PACIFIQUE,
		'Pacific::Pacifique',
		'Pacific',
		'Pacifique'
	UNION
	SELECT
		@CONST_TERRITORY_PNR,
		@CONST_TERRITORY_PNR,
		 'Prairie and Northern::Prairies et du Nord',
		 'Prairie and Northern',
		 'Prairies et du Nord'
	UNION
	SELECT
		@CONST_TERRITORY_ONTARIO,
		@CONST_TERRITORY_ONTARIO,
		'Ontario::Ontario',
		'Ontario',
		'Ontario';


	--===================================================================================================
	--===================================================================================================
	--LOCALIZATION PLUGIN SUPPORT
	UPDATE
		[STAGING__TERRITORY]
	SET
		[name] = CONCAT(
			ovs_territorynameenglish,
			'::',
			ovs_territorynamefrench
		);


	UPDATE
		[STAGING__WORKORDERTYPE]
	SET
		[msdyn_name] = CONCAT(
			ovs_workordertypenameenglish,
			'::',
			ovs_workordertypenamefrench
		);


	UPDATE
		[STAGING__OVERSIGHTTYPE]
	SET
		[ovs_name] = CONCAT(
			ovs_oversighttypenameenglish,
			'::',
			ovs_oversighttypenamefrench
		);


	UPDATE
		[STAGING__TYRATIONAL]
	SET
		[ovs_name] = CONCAT(ovs_rationalelbl, '::', ovs_rationalflbl);


	--===================================================================================================
	--BOOKABLE RESOURCES
	INSERT INTO
		[dbo].[STAGING__BOOKABLE_RESOURCE] (
			bookableresourceid,
			[userid],
			[name],
			[msdyn_primaryemail],
			[ovs_registeredinspectornumberrin],
			[ovs_badgenumber]
		)
	SELECT
		*
	FROM
		(
			SELECT
				newid() bookableresourceid,
				SYSUSER.systemuserid,
				CONCAT(SYSUSER.firstname, ' ', SYSUSER.lastname) name,
				domainname,
				RIN,
				BADGE --,
				--SYSUSER.isdisabled, 
				--SYSUSER.islicensed, 
				--SYSUSER.issyncwithdirectory, 
				--SYSUSER.territoryid
			FROM
				[dbo].tdgdata__systemuser SYSUSER
				JOIN SOURCE__IIS_INSPECTORS INSP ON lower(TRIM(INSP.Account_name)) = lower(TRIM(SYSUSER.domainname))
		) T;


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


END