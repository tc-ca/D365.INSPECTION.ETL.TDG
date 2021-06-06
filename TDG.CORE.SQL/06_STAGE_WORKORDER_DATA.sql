--DEFAULT MASTER DATA
BEGIN

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

END


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
			object_id = OBJECT_ID( '[dbo].[STAGING__WORK_ORDERS]')
			AND TYPE IN ('U')
	) DROP TABLE [dbo].[STAGING__WORK_ORDERS];


	CREATE TABLE [dbo].[STAGING__WORK_ORDERS] (
		createdby UNIQUEIDENTIFIER NULL,
		createdbyname VARCHAR (200) NULL,
		createdbyyominame VARCHAR (200) NULL,
		createdon DATETIME NULL,
		createdonbehalfby UNIQUEIDENTIFIER NULL,
		createdonbehalfbyname VARCHAR (200) NULL,
		createdonbehalfbyyominame VARCHAR (200) NULL,
		exchangerate NUMERIC (38, 10) NULL,
		importsequencenumber INT NULL,
		modifiedby UNIQUEIDENTIFIER NULL,
		modifiedbyname VARCHAR (200) NULL,
		modifiedbyyominame VARCHAR (200) NULL,
		modifiedon DATETIME NULL,
		modifiedonbehalfby UNIQUEIDENTIFIER NULL,
		modifiedonbehalfbyname VARCHAR (200) NULL,
		modifiedonbehalfbyyominame VARCHAR (200) NULL,
		msdyn_address1 VARCHAR (250) NULL,
		msdyn_address2 VARCHAR (250) NULL,
		msdyn_address3 VARCHAR (250) NULL,
		msdyn_addressname VARCHAR (250) NULL,
		msdyn_agreement UNIQUEIDENTIFIER NULL,
		msdyn_agreementname VARCHAR (100) NULL,
		msdyn_autonumbering VARCHAR (100) NULL,
		msdyn_billingaccount UNIQUEIDENTIFIER NULL,
		msdyn_billingaccountname VARCHAR (160) NULL,
		msdyn_billingaccountyominame VARCHAR (160) NULL,
		msdyn_bookingsummary ntext NULL,
		msdyn_childindex INT NULL,
		msdyn_city VARCHAR (80) NULL,
		msdyn_closedby UNIQUEIDENTIFIER NULL,
		msdyn_closedbyname VARCHAR (200) NULL,
		msdyn_closedbyyominame VARCHAR (200) NULL,
		msdyn_completedon DATETIME NULL,
		msdyn_country VARCHAR (80) NULL,
		msdyn_customerasset UNIQUEIDENTIFIER NULL,
		msdyn_customerassetname VARCHAR (100) NULL,
		msdyn_datewindowend DATETIME NULL,
		msdyn_datewindowstart DATETIME NULL,
		msdyn_estimatesubtotalamount NUMERIC (38, 2) NULL,
		msdyn_estimatesubtotalamount_base NUMERIC (38, 2) NULL,
		msdyn_firstarrivedon DATETIME NULL,
		msdyn_followupnote ntext NULL,
		msdyn_followuprequired bit NULL,
		msdyn_followuprequiredname VARCHAR (255) NULL,
		msdyn_functionallocation UNIQUEIDENTIFIER NULL,
		msdyn_functionallocationname VARCHAR (60) NULL,
		msdyn_instructions ntext NULL,
		msdyn_internalflags ntext NULL,
		msdyn_iotalert UNIQUEIDENTIFIER NULL,
		msdyn_iotalertname VARCHAR (100) NULL,
		msdyn_isfollowup bit NULL,
		msdyn_isfollowupname VARCHAR (255) NULL,
		msdyn_ismobile bit NULL,
		msdyn_ismobilename VARCHAR (255) NULL,
		msdyn_latitude FLOAT NULL,
		msdyn_longitude FLOAT NULL,
		msdyn_mapcontrol VARCHAR (100) NULL,
		msdyn_name VARCHAR (100) NULL,
		msdyn_opportunityid UNIQUEIDENTIFIER NULL,
		msdyn_opportunityidname VARCHAR (300) NULL,
		msdyn_parentworkorder UNIQUEIDENTIFIER NULL,
		msdyn_parentworkordername VARCHAR (100) NULL,
		msdyn_postalcode VARCHAR (20) NULL,
		msdyn_preferredresource UNIQUEIDENTIFIER NULL,
		msdyn_preferredresourcename VARCHAR (100) NULL,
		msdyn_pricelist UNIQUEIDENTIFIER NULL,
		msdyn_pricelistname VARCHAR (100) NULL,
		msdyn_primaryincidentdescription ntext NULL,
		msdyn_primaryincidentestimatedduration INT NULL,
		msdyn_primaryincidenttype UNIQUEIDENTIFIER NULL,
		msdyn_primaryincidenttypename VARCHAR (100) NULL,
		msdyn_priority UNIQUEIDENTIFIER NULL,
		msdyn_priorityname VARCHAR (100) NULL,
		msdyn_reportedbycontact UNIQUEIDENTIFIER NULL,
		msdyn_reportedbycontactname VARCHAR (160) NULL,
		msdyn_reportedbycontactyominame VARCHAR (450) NULL,
		msdyn_serviceaccount UNIQUEIDENTIFIER NULL,
		msdyn_serviceaccountname VARCHAR (160) NULL,
		msdyn_serviceaccountyominame VARCHAR (160) NULL,
		msdyn_servicerequest UNIQUEIDENTIFIER NULL,
		msdyn_servicerequestname VARCHAR (200) NULL,
		msdyn_serviceterritory UNIQUEIDENTIFIER NULL,
		msdyn_serviceterritoryname VARCHAR (200) NULL,
		msdyn_stateorprovince VARCHAR (50) NULL,
		msdyn_substatus UNIQUEIDENTIFIER NULL,
		msdyn_substatusname VARCHAR (100) NULL,
		msdyn_subtotalamount NUMERIC (38, 2) NULL,
		msdyn_subtotalamount_base NUMERIC (38, 2) NULL,
		msdyn_supportcontact UNIQUEIDENTIFIER NULL,
		msdyn_supportcontactname VARCHAR (100) NULL,
		msdyn_systemstatus INT NULL,
		msdyn_systemstatusname VARCHAR (255) NULL,
		msdyn_taxable bit NULL,
		msdyn_taxablename VARCHAR (255) NULL,
		msdyn_taxcode UNIQUEIDENTIFIER NULL,
		msdyn_taxcodename VARCHAR (100) NULL,
		msdyn_timeclosed DATETIME NULL,
		msdyn_timefrompromised DATETIME NULL,
		msdyn_timegroup UNIQUEIDENTIFIER NULL,
		msdyn_timegroupdetailselected UNIQUEIDENTIFIER NULL,
		msdyn_timegroupdetailselectedname VARCHAR (100) NULL,
		msdyn_timegroupname VARCHAR (100) NULL,
		msdyn_timetopromised DATETIME NULL,
		msdyn_timewindowend DATETIME NULL,
		msdyn_timewindowstart DATETIME NULL,
		msdyn_totalamount NUMERIC (38, 2) NULL,
		msdyn_totalamount_base NUMERIC (38, 2) NULL,
		msdyn_totalestimatedduration INT NULL,
		msdyn_totalsalestax NUMERIC (38, 2) NULL,
		msdyn_totalsalestax_base NUMERIC (38, 2) NULL,
		msdyn_workhourtemplate UNIQUEIDENTIFIER NULL,
		msdyn_workhourtemplatename VARCHAR (100) NULL,
		msdyn_worklocation INT NULL,
		msdyn_worklocationname VARCHAR (255) NULL,
		msdyn_workorderarrivaltimekpiid UNIQUEIDENTIFIER NULL,
		msdyn_workorderarrivaltimekpiidname VARCHAR (100) NULL,
		msdyn_workorderid UNIQUEIDENTIFIER NULL,
		msdyn_workorderresolutionkpiid UNIQUEIDENTIFIER NULL,
		msdyn_workorderresolutionkpiidname VARCHAR (100) NULL,
		msdyn_workordersummary ntext NULL,
		msdyn_workordertype UNIQUEIDENTIFIER NULL,
		msdyn_workordertypename VARCHAR (100) NULL,
		overriddencreatedon DATETIME NULL,
		ovs_asset UNIQUEIDENTIFIER NULL,
		ovs_assetcategory UNIQUEIDENTIFIER NULL,
		ovs_assetcategoryname VARCHAR (100) NULL,
		ovs_assetname VARCHAR (100) NULL,
		ovs_currentfiscalquarter UNIQUEIDENTIFIER NULL,
		ovs_currentfiscalquartername VARCHAR (100) NULL,
		ovs_fiscalquarter UNIQUEIDENTIFIER NULL,
		ovs_fiscalquartername VARCHAR (100) NULL,
		ovs_fiscalyear UNIQUEIDENTIFIER NULL,
		ovs_fiscalyearname VARCHAR (100) NULL,
		ovs_iisid VARCHAR (100) NULL,
		ovs_iisactivityid numeric(18, 0),
		ovs_mocid VARCHAR (100) NULL,
		ovs_operationid UNIQUEIDENTIFIER NULL,
		ovs_operationidname VARCHAR (200) NULL,
		ovs_operationtypeid UNIQUEIDENTIFIER NULL,
		ovs_operationtypeidname VARCHAR (100) NULL,
		ovs_oversighttype UNIQUEIDENTIFIER NULL,
		ovs_oversighttypename VARCHAR (100) NULL,
		ovs_ovscountry UNIQUEIDENTIFIER NULL,
		ovs_ovscountryname VARCHAR (100) NULL,
		ovs_primaryinspector UNIQUEIDENTIFIER NULL,
		ovs_primaryinspectorname VARCHAR (100) NULL,
		ovs_rational UNIQUEIDENTIFIER NULL,
		ovs_rationalname VARCHAR (100) NULL,
		ovs_regulatedentity UNIQUEIDENTIFIER NULL,
		ovs_regulatedentityname VARCHAR (160) NULL,
		ovs_regulatedentityyominame VARCHAR (160) NULL,
		ovs_revisedquarterid UNIQUEIDENTIFIER NULL,
		ovs_revisedquarteridname VARCHAR (100) NULL,
		ovs_rolluptestdeletemeafter DATETIME NULL,
		ovs_rolluptestdeletemeafter_date DATETIME NULL,
		ovs_rolluptestdeletemeafter_state INT NULL,
		ovs_secondaryinspector UNIQUEIDENTIFIER NULL,
		ovs_secondaryinspectorname VARCHAR (100) NULL,
		ovs_siteofviolation UNIQUEIDENTIFIER NULL,
		ovs_siteofviolationname VARCHAR (160) NULL,
		ovs_siteofviolationyominame VARCHAR (160) NULL,
		ovs_tyrational UNIQUEIDENTIFIER NULL,
		ovs_tyrationalname VARCHAR (100) NULL,
		ownerid UNIQUEIDENTIFIER NULL,
		owneridname VARCHAR (200) NULL,
		owneridtype VARCHAR (64) NULL,
		owneridyominame VARCHAR (200) NULL,
		owningbusinessunit UNIQUEIDENTIFIER NULL,
		owningteam UNIQUEIDENTIFIER NULL,
		owninguser UNIQUEIDENTIFIER NULL,
		processid UNIQUEIDENTIFIER NULL,
		qm_blobpath VARCHAR (200) NULL,
		qm_remote bit NULL,
		qm_remotename VARCHAR (255) NULL,
		qm_reportcontactid UNIQUEIDENTIFIER NULL,
		qm_reportcontactidname VARCHAR (160) NULL,
		qm_reportcontactidyominame VARCHAR (450) NULL,
		stageid UNIQUEIDENTIFIER NULL,
		statecode INT NULL,
		statecodename VARCHAR (255) NULL,
		statuscode INT NULL,
		statuscodename VARCHAR (255) NULL,
		timezoneruleversionnumber INT NULL,
		transactioncurrencyid UNIQUEIDENTIFIER NULL,
		transactioncurrencyidname VARCHAR (100) NULL,
		traversedpath VARCHAR (1250) NULL,
		utcconversiontimezonecode INT NULL,
		versionnumber bigint NULL
	) ON [PRIMARY];

END
--===================================================================================================
--===================================================================================================


--IIS ACTIVITY TYPE TO ROM ACTIVITY MAPPING EXCEL SHEET VALUES
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
    SECONDARY_INSPECTOR_USER_ID
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
      SECONDARY_INSPECTOR.userid SECONDARY_INSPECTOR_USER_ID
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
          JOIN [dbo].STAGING__BOOKABLE_RESOURCE BR ON UPPER(
            TRIM(
              CONCAT(
                CONCAT(YD083.STAKEHOLDER_NAME_FIRST_NM, ' '),
                YD083.STAKEHOLDER_NAME_FAMILY_NM
              )
            )
          ) = UPPER([dbo].[ReplaceASCII](name))
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
          JOIN [dbo].STAGING__BOOKABLE_RESOURCE BR ON UPPER(
            TRIM(
              CONCAT(
                CONCAT(YD083.STAKEHOLDER_NAME_FIRST_NM, ' '),
                YD083.STAKEHOLDER_NAME_FAMILY_NM
              )
            )
          ) = UPPER([dbo].[ReplaceASCII](name))
        WHERE
          YD083.DATE_DELETED_DTE IS NULL
          AND YD048.DATE_DELETED_DTE IS NULL
          AND ASSIGN_ROLE_CD = '2'
      ) SECONDARY_INSPECTOR ON SECONDARY_INSPECTOR.ACTIVITY_ID = YD040.ACTIVITY_ID --JOIN [dbo].STAGING__ACCOUNT ACCOUNTS ON ACCOUNTS.ovs_iisid = YD040.STAKEHOLDER_ID
      --WHERE
      --YD040.DATE_DELETED_DTE IS NULL AND
      --YD095.DATE_DELETED_DTE IS NULL AND
      --YD041.DATE_DELETED_DTE IS NULL AND
      -- TD045.ACTIVITY_TYPE_CD,
      --TD045.ACTIVITY_TYPE_ENM,
      --TD045.ACTIVITY_TYPE_FNM,
      --YD101.DATE_DELETED_DTE IS NULL
      --AND TD045.ACTIVITY_TYPE_PARENT_CD IS NULL AND TD045.DATE_DELETED_DTE IS NULL
    GROUP BY
      YD095.FILE_NUMBER_NUM,
      TD001.FILE_STATUS_ETXT,
      TD001.FILE_STATUS_FTXT,
      YD040.INSPECTION_DATE_DTE,
      YD040.ACTIVITY_ID,
      YD040.STAKEHOLDER_ID,
      --ACCOUNTS.id,
      --ACCOUNTS.ovs_iisid,
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
      SECONDARY_INSPECTOR.userid
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
      --WORK ORDER ID
      CONVERT(
        uniqueidentifier,
        @CONST_WORKORDERTYPE_INSPECTION
      ) WORK_ORDER_TYPE,
      --work order type "Inspection"
	  CONCAT('WO-',
		[YEAR], '-',
		REPLACE(
		  STR(
			ROW_NUMBER() OVER (
			  ORDER BY
				ID
			),
			8
		  ),
		  ' ',
		  '0'
		)
	  )	[WORK_ORDER_NUMBER],														--WO name, 2021 + auto incremented number 1...x                                                         --WO name, auto incremented number 1...x
      CONVERT(uniqueidentifier, @CONST_PRICELISTID) PRICE_LIST,                     --default price list
      id accountid,                                                                 --account id for service account linked by the iis id
      [ovs_iisid],                                                                  --IIS STAKEHOLDER_ID
      @CONST_WORKORDER_SYSTEM_STATUS_CLOSED_POSTED WORK_ORDER_STATUS,                      --"Closed - Posted"
	  @CONST_WORK_ORDER_STATUSCODE_INACTIVE WORK_ORDER_STATUSCODE,
      FILE_STATUS_ETXT,
      PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,                                       --PRIMARY INSPECTOR
      SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID,                                     --SECONDARY INSPECTOR
      PRIMARY_INSPECTOR_USER_ID owner,                                              --@CONST_TDGCORE_USERID [OWNER] --OWNER = primary inspector
      @CONST_OWNERIDTYPE_SYSTEMUSER [OWNER_TYPE],                                                    --OWNER TYPE = systemuser
      CONVERT(uniqueidentifier, @CONST_BUSINESSUNIT_TDG_ID) [OWNING_BUSINESS_UNIT],  --TDG Business Unit
      PRIMARY_INSPECTOR_USER_ID [owning_user],                                      --,@CONST_TDGCORE_USERID [OWNING_TEAM]         --OWNING TEAM = TDG Team
      CAST(ACTIVITY_ID AS nvarchar(500)) [WORK_ORDER_SUMMARY],
      ACTIVITY_ID IIS_ACTIVITY_ID,
      --WORK ORDER SUMMARY
      CASE
        WHEN (
          [MONTH] >= 1
          AND [MONTH] <= 3
        ) THEN 'Q4'
        WHEN (
          [MONTH] >= 4
          AND [MONTH] <= 6
        ) THEN 'Q1'
        WHEN (
          [MONTH] >= 7
          AND [MONTH] <= 9
        ) THEN 'Q2'
        WHEN (
          [MONTH] >= 10
          AND [MONTH] <= 12
        ) THEN 'Q3'
      END FISCAL_QUARTER,
      CASE
        WHEN (
          [MONTH] >= 1
          AND [MONTH] <= 3
        ) THEN CONCAT(
          CONVERT(NVARCHAR(4), [YEAR] - 1),
          '-',
          CONVERT(NVARCHAR(4), [YEAR])
        )
        ELSE CONCAT(
          CONVERT(NVARCHAR(4), [YEAR]),
          '-',
          CONVERT(NVARCHAR(4), [YEAR] + 1)
        )
      END FISCAL_YEAR,
      T1.ACTIVITY_TYPE_CD,
      T2.IIS_ACTIVITY_TYPE_ID,
      T2.IIS_ACTIVITY_SUB_TYPE_ID,
      T1.ACTIVITY_TYPE_ENM,
      IIS_ACTIVITY_TYPE_ENM,
      ROM_OVERSIGHT_TYPE_ID,
      ROM_RATIONALE_ID,
      SUBACTIVITY_TYPE_CDS SUBACTIVITY_TYPE_CDS
    FROM
      SOURCE__IIS_INSPECTIONS T1,
      ACTIVITY_TYPE_MAPPINGS T2
      --JOIN #ACTIVITY_TYPE_MAPPINGS T2 ON  (T1.ACTIVITY_TYPE_CD  = CAST(T2.IIS_ACTIVITY_TYPE_ID as varchar(10))) AND
      --(T1.SUBACTIVITY_TYPE_CDS = CAST(T2.IIS_ACTIVITY_SUB_TYPE_ID as varchar(10)))
    WHERE
      ROM_OVERSIGHT_TYPE_ID <> 'SITE_VISIT'
      AND (
        (T1.ACTIVITY_TYPE_CD = t2.IIS_ACTIVITY_TYPE_ID)
        AND IIS_ACTIVITY_SUB_TYPE_ID IS NULL
      )
      OR (
        T1.ACTIVITY_TYPE_CD = t2.IIS_ACTIVITY_TYPE_ID
        AND T1.SUBACTIVITY_TYPE_CDS = CAST(T2.IIS_ACTIVITY_SUB_TYPE_ID AS varchar(10))
      )
      OR (
        T1.ACTIVITY_TYPE_CD = t2.IIS_ACTIVITY_TYPE_ID
        AND CAST(T2.IIS_ACTIVITY_SUB_TYPE_ID AS varchar(10)) IS NULL
      )
      OR (
        T1.ACTIVITY_TYPE_CD = t2.IIS_ACTIVITY_TYPE_ID
        AND CHARINDEX(
          CAST(T2.IIS_ACTIVITY_SUB_TYPE_ID AS varchar(10)),
          T1.SUBACTIVITY_TYPE_CDS
        ) > 0
      )
      AND id IS NOT NULL
  ) T
  JOIN [dbo].SOURCE__FISCAL_YEAR FY ON FY.TC_NAME = T.FISCAL_YEAR
  JOIN [dbo].SOURCE__FISCAL_QUARTER FQ ON FQ.TC_NAME = T.FISCAL_QUARTER
  AND FY.tc_tcfiscalyearid = FQ.tc_tcfiscalyearid
WHERE
  accountid IS NOT NULL;



--create staging values
INSERT INTO
  [dbo].STAGING__WORK_ORDERS (
    [msdyn_workorderid],
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
    [ovs_rational] --,[qm_reportcontactid]
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
  tc_tcfiscalyearid --,ACTIVITY_TYPE_CD
  --,IIS_ACTIVITY_TYPE_ID
  --,IIS_ACTIVITY_SUB_TYPE_ID
  --,ACTIVITY_TYPE_ENM
  --,IIS_ACTIVITY_TYPE_ENM
  --,SUBACTIVITY_TYPE_CDS
,
  CONVERT(uniqueidentifier, ROM_OVERSIGHT_TYPE_ID) ROM_OVERSIGHT_TYPE_ID,
  CONVERT(uniqueidentifier, ROM_RATIONALE_ID) ROM_RATIONALE_ID
FROM
  (
    SELECT
      *
    FROM
      #TEMP_TRANSFORMED_SOURCE_DATA
    WHERE
      ROM_OVERSIGHT_TYPE_ID <> 'SITE_VISIT'
  ) T;


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
  
  --UPDATE WORK ORDER ADDRESSES WITH ACCOUNT ADDRESSES
UPDATE
  STAGING__WORK_ORDERS
SET
  msdyn_serviceterritory = A.territoryid,
  msdyn_address1 = A.address1_line1,
  msdyn_address2 = A.address1_line2,
  msdyn_address3 = A.address1_line3,
  msdyn_city = A.address1_city,
  msdyn_country = A.address1_country,
  msdyn_postalcode = A.address1_postalcode,
  msdyn_stateorprovince = A.address1_stateorprovince
FROM
  STAGING__WORK_ORDERS WO
  JOIN STAGING__ACCOUNT A ON WO.msdyn_serviceaccount = A.id;


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


--INSERT planned inspections for this fiscal year that havnt been started in IIS
INSERT INTO
  [dbo].STAGING__WORK_ORDERS (
    [msdyn_workorderid],
    [msdyn_workordertype],
    [msdyn_name],
    [msdyn_pricelist],
    [msdyn_serviceaccount],
    [ovs_iisid],
    [msdyn_systemstatus],
    [ovs_primaryinspector], --,[ovs_secondaryinspector]
    [ownerid],
    [owneridtype],
    [owningbusinessunit],
    owninguser,
    [msdyn_workordersummary],
    [ovs_fiscalquarter],
    [ovs_fiscalquartername],      
    [ovs_fiscalyear],
    [ovs_fiscalyearname],
    [ovs_oversighttype],
    [ovs_rational]
  )
SELECT
  newid()                         [msdyn_workorderid],    --WORK ORDER ID
  @CONST_WORKORDERTYPE_INSPECTION [WORK_ORDER_TYPE],      --work order type "Inspection"
  CONCAT('WO-',
    [YEAR], '-',
    REPLACE(
      STR(
        ROW_NUMBER() OVER (
          ORDER BY
            import_number
        ),
        8
      ),
      ' ',
      '0'
    )
  )                               [WORK_ORDER_NUMBER],    --WO name, 2021 + auto incremented number 1...x
  @CONST_PRICELISTID              [PRICE_LIST],           --default price list
  accountid                       [accountid],            --account id for service account linked by the iis id
  IIS_ID                          [IIS_ID],               --IIS STAKEHOLDER_ID
  '690970000'                     [WORK_ORDER_STATUS],    --"Unscheduled"
  BOOKABLE_RESOURCE_ID            [PRIMARY INSPECTOR],    --PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID
  OWNER_ID                        [OWNER],                --OWNER = primary inspector
  OWNER_TYPE                      [OWNER_TYPE],           --OWNER TYPE = systemuser
  @CONST_BUSINESSUNIT_TDG_ID       [OWNING_BUSINESS_UNIT], --TDG Business Unit
  OWNING_USER                     [owning_user],          --owning user is the primary inspector
  CONCAT(
    'Work Order converted from 2021/2022 Workplan for IIS_ID = ',
    IIS_ID
  ) [WORK_ORDER_SUMMARY],                           --WORK ORDER SUMMARY
  [tc_tcfiscalquarterid],
  [ovs_fiscalquartername],
  [tc_tcfiscalyearid],
  [ovs_fiscalyearname],
  CASE
    WHEN [TYPE] = 'MOC' THEN @CONST_OVERSIGHTTYPE_MOCTARGETED
    WHEN [TYPE] = 'GC' THEN @CONST_OVERSIGHTTYPE_GCTARGETED
    WHEN [TYPE] = 'HUBS' THEN @CONST_OVERSIGHTTYPE_GCTARGETED
  END OVERSIGHT_TYPE,
  @CONST_RATIONALE_PLANNED RATIONALE                --ALL WORK PLAN INSPECTIONS ARE PLANNED
FROM
  (
    SELECT
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
      END OWNING_USER,
      WP.*,
      ACCOUNTS.ID accountid,
      FQ.[tc_tcfiscalquarterid],
      FQ.[tc_name] [ovs_fiscalquartername],
      FY.[tc_tcfiscalyearid],
      FY.[tc_name] [ovs_fiscalyearname]
    FROM
      (
        SELECT
          CASE
            WHEN QUARTER_1 = '1' THEN 'Q1'
            WHEN QUARTER_2 = '1' THEN 'Q2'
            WHEN QUARTER_3 = '1' THEN 'Q3'
            WHEN QUARTER_4 = '1' THEN 'Q4'
          END [QUARTER],
          CASE
            WHEN QUARTER_1 = '1'
            OR QUARTER_2 = '1'
            OR QUARTER_3 = '1' THEN '2021'
            WHEN QUARTER_4 = '1' THEN '2022'
          END [YEAR],
		  CASE
            WHEN Charindex(',', CURRENT_INSPECTOR) = 0 THEN 'TDG'
            ELSE Substring(
              CURRENT_INSPECTOR,
              1,
              Charindex(',', CURRENT_INSPECTOR) -1
            )
          END [InspectorLastName],
          CASE
            WHEN Charindex(',', CURRENT_INSPECTOR) = 0 THEN 'CORE'
            ELSE Substring(
              CURRENT_INSPECTOR,
              Charindex(',', CURRENT_INSPECTOR) + 1,
              LEN(CURRENT_INSPECTOR)
            )
          END [InspectorFirstName],
          *
        FROM
          SOURCE__WORKPLAN_IMPORT WP
        WHERE
          CURRENTLY_PLANNED = '1'
          AND fiscal_year = '2021-2022'
      ) WP
      JOIN STAGING__ACCOUNT ACCOUNTS ON WP.IIS_ID = ACCOUNTS.ovs_iisid
      JOIN [dbo].SOURCE__FISCAL_YEAR FY ON WP.[YEAR] = FY.tc_fiscalyearnum
      JOIN [dbo].SOURCE__FISCAL_QUARTER FQ ON FQ.tc_name = WP.[QUARTER]
      AND FQ.tc_tcfiscalyearidname = WP.fiscal_year
      LEFT JOIN [dbo].tdgdata__bookableresource BR ON UPPER(
        TRIM(
          CONCAT(
            CONCAT(WP.InspectorFirstName, ' '),
            WP.InspectorLastName
          )
        )
      ) = UPPER(BR.name)
      AND import_number NOT IN (
        --WORKPLAN INSPECTIONS CREATED IN IIS ALREADY
        --IGNORE TO PREVENT DOUBLES
        SELECT
          import_number
        FROM
          (
            SELECT
              *,
              CASE
                WHEN QUARTER_1 = '1' THEN 'Q1'
                WHEN QUARTER_2 = '1' THEN 'Q2'
                WHEN QUARTER_3 = '1' THEN 'Q3'
                WHEN QUARTER_4 = '1' THEN 'Q4'
              END [QUARTER]
            FROM
              [dbo].SOURCE__WORKPLAN_IMPORT
          ) WP
          JOIN STAGING__WORK_ORDERS WO ON WP.IIS_ID = WO.ovs_iisid
          AND WP.fiscal_year = WO.ovs_fiscalyearname
          AND WP.QUARTER = WO.ovs_fiscalquartername
        WHERE
          WP.fiscal_year = '2021-2022'
      )
  ) CURRENT_WORKPLAN;



  --PULL SITE ADDRESS INTO WORK ORDER
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


