--TABLE DEFINITIONS
--===================================================================================================
--===================================================================================================

	IF EXISTS (
		SELECT
			*
		FROM
			sys.objects
		WHERE
			object_id = OBJECT_ID( '[dbo].[STAGING__ACCOUNT]')
			AND TYPE IN ('U')
	) DROP TABLE [dbo].[STAGING__ACCOUNT];
	GO


	DROP TABLE IF EXISTS #TEMP_ACCOUNTS; 
	GO


	CREATE TABLE [dbo].[STAGING__ACCOUNT] (
		[accountcategorycode] [int] NULL,
		[accountclassificationcode] [int] NULL,
		[accountid] [uniqueidentifier] NULL,
		[accountnumber] [nvarchar](20) NULL,
		[accountratingcode] [int] NULL,
		[address1_addressid] [uniqueidentifier] NULL,
		[address1_addresstypecode] [int] NULL,
		[address1_city] [nvarchar](80) NULL,
		[address1_composite] [nvarchar](max) NULL,
		[address1_country] [nvarchar](80) NULL,
		[address1_county] [nvarchar](50) NULL,
		[address1_fax] [nvarchar](50) NULL,
		[address1_freighttermscode] [int] NULL,
		[address1_latitude] [decimal](38, 5) NULL,
		[address1_line1] [nvarchar](250) NULL,
		[address1_line2] [nvarchar](250) NULL,
		[address1_line3] [nvarchar](250) NULL,
		[address1_longitude] [decimal](38, 5) NULL,
		[address1_name] [nvarchar](200) NULL,
		[address1_postalcode] [nvarchar](20) NULL,
		[address1_postofficebox] [nvarchar](20) NULL,
		[address1_primarycontactname] [nvarchar](100) NULL,
		[address1_shippingmethodcode] [int] NULL,
		[address1_stateorprovince] [nvarchar](50) NULL,
		[address1_telephone1] [nvarchar](50) NULL,
		[address1_telephone2] [nvarchar](50) NULL,
		[address1_telephone3] [nvarchar](50) NULL,
		[address1_upszone] [nvarchar](4) NULL,
		[address1_utcoffset] [int] NULL,
		[address2_addressid] [uniqueidentifier] NULL,
		[address2_addresstypecode] [int] NULL,
		[address2_city] [nvarchar](80) NULL,
		[address2_composite] [nvarchar](max) NULL,
		[address2_country] [nvarchar](80) NULL,
		[address2_county] [nvarchar](50) NULL,
		[address2_fax] [nvarchar](50) NULL,
		[address2_freighttermscode] [int] NULL,
		[address2_latitude] [decimal](38, 5) NULL,
		[address2_line1] [nvarchar](250) NULL,
		[address2_line2] [nvarchar](250) NULL,
		[address2_line3] [nvarchar](250) NULL,
		[address2_longitude] [decimal](38, 5) NULL,
		[address2_name] [nvarchar](200) NULL,
		[address2_postalcode] [nvarchar](20) NULL,
		[address2_postofficebox] [nvarchar](20) NULL,
		[address2_primarycontactname] [nvarchar](100) NULL,
		[address2_shippingmethodcode] [int] NULL,
		[address2_stateorprovince] [nvarchar](50) NULL,
		[address2_telephone1] [nvarchar](50) NULL,
		[address2_telephone2] [nvarchar](50) NULL,
		[address2_telephone3] [nvarchar](50) NULL,
		[address2_upszone] [nvarchar](4) NULL,
		[address2_utcoffset] [int] NULL,
		[aging30] [decimal](38, 2) NULL,
		[aging30_base] [decimal](38, 4) NULL,
		[aging60] [decimal](38, 2) NULL,
		[aging60_base] [decimal](38, 4) NULL,
		[aging90] [decimal](38, 2) NULL,
		[aging90_base] [decimal](38, 4) NULL,
		[businesstypecode] [int] NULL,
		[createdby] [uniqueidentifier] NULL,
		[createdby_entitytype] [nvarchar](128) NULL,
		[createdbyexternalparty] [uniqueidentifier] NULL,
		[createdbyexternalparty_entitytype] [nvarchar](128) NULL,
		[createdbyexternalpartyname] [nvarchar](100) NULL,
		[createdbyexternalpartyyominame] [nvarchar](100) NULL,
		[createdbyname] [nvarchar](100) NULL,
		[createdbyyominame] [nvarchar](100) NULL,
		[createdon] [datetime] NULL,
		[createdonbehalfby] [uniqueidentifier] NULL,
		[createdonbehalfby_entitytype] [nvarchar](128) NULL,
		[createdonbehalfbyname] [nvarchar](100) NULL,
		[createdonbehalfbyyominame] [nvarchar](100) NULL,
		[creditlimit] [decimal](38, 2) NULL,
		[creditlimit_base] [decimal](38, 4) NULL,
		[creditonhold] [bit] NULL,
		[customersizecode] [int] NULL,
		[customertypecode] [int] NULL,
		[defaultpricelevelid] [uniqueidentifier] NULL,
		[defaultpricelevelid_entitytype] [nvarchar](128) NULL,
		[defaultpricelevelidname] [nvarchar](100) NULL,
		[description] [nvarchar](max) NULL,
		[donotbulkemail] [bit] NULL,
		[donotbulkpostalmail] [bit] NULL,
		[donotemail] [bit] NULL,
		[donotfax] [bit] NULL,
		[donotphone] [bit] NULL,
		[donotpostalmail] [bit] NULL,
		[donotsendmm] [bit] NULL,
		[emailaddress1] [nvarchar](100) NULL,
		[emailaddress2] [nvarchar](100) NULL,
		[emailaddress3] [nvarchar](100) NULL,
		[entityimage_timestamp] [bigint] NULL,
		[entityimage_url] [nvarchar](200) NULL,
		[entityimageid] [uniqueidentifier] NULL,
		[exchangerate] [decimal](38, 10) NULL,
		[fax] [nvarchar](50) NULL,
		[followemail] [bit] NULL,
		[ftpsiteurl] [nvarchar](200) NULL,
		[Id] [uniqueidentifier] NOT NULL,
		[importsequencenumber] [int] NULL,
		[industrycode] [int] NULL,
		[isprivate] [bit] NULL,
		[lastonholdtime] [datetime] NULL,
		[lastusedincampaign] [datetime] NULL,
		[marketcap] [decimal](38, 2) NULL,
		[marketcap_base] [decimal](38, 4) NULL,
		[marketingonly] [bit] NULL,
		[masteraccountidname] [nvarchar](100) NULL,
		[masteraccountidyominame] [nvarchar](100) NULL,
		[masterid] [uniqueidentifier] NULL,
		[masterid_entitytype] [nvarchar](128) NULL,
		[merged] [bit] NULL,
		[modifiedby] [uniqueidentifier] NULL,
		[modifiedby_entitytype] [nvarchar](128) NULL,
		[modifiedbyexternalparty] [uniqueidentifier] NULL,
		[modifiedbyexternalparty_entitytype] [nvarchar](128) NULL,
		[modifiedbyexternalpartyname] [nvarchar](100) NULL,
		[modifiedbyexternalpartyyominame] [nvarchar](100) NULL,
		[modifiedbyname] [nvarchar](100) NULL,
		[modifiedbyyominame] [nvarchar](100) NULL,
		[modifiedon] [datetime] NULL,
		[modifiedonbehalfby] [uniqueidentifier] NULL,
		[modifiedonbehalfby_entitytype] [nvarchar](128) NULL,
		[modifiedonbehalfbyname] [nvarchar](100) NULL,
		[modifiedonbehalfbyyominame] [nvarchar](100) NULL,
		[msdyn_billingaccount] [uniqueidentifier] NULL,
		[msdyn_billingaccount_entitytype] [nvarchar](128) NULL,
		[msdyn_billingaccountname] [nvarchar](160) NULL,
		[msdyn_billingaccountyominame] [nvarchar](160) NULL,
		[msdyn_preferredresource] [uniqueidentifier] NULL,
		[msdyn_preferredresource_entitytype] [nvarchar](128) NULL,
		[msdyn_preferredresourcename] [nvarchar](100) NULL,
		[msdyn_salestaxcode] [uniqueidentifier] NULL,
		[msdyn_salestaxcode_entitytype] [nvarchar](128) NULL,
		[msdyn_salestaxcodename] [nvarchar](100) NULL,
		[msdyn_serviceterritory] [uniqueidentifier] NULL,
		[msdyn_serviceterritory_entitytype] [nvarchar](128) NULL,
		[msdyn_serviceterritoryname] [nvarchar](200) NULL,
		[msdyn_taxexempt] [bit] NULL,
		[msdyn_taxexemptnumber] [nvarchar](20) NULL,
		[msdyn_travelcharge] [decimal](38, 2) NULL,
		[msdyn_travelcharge_base] [decimal](38, 2) NULL,
		[msdyn_travelchargetype] [int] NULL,
		[msdyn_workhourtemplate] [uniqueidentifier] NULL,
		[msdyn_workhourtemplate_entitytype] [nvarchar](128) NULL,
		[msdyn_workhourtemplatename] [nvarchar](100) NULL,
		[msdyn_workorderinstructions] [nvarchar](max) NULL,
		[name] [nvarchar](160) NULL,
		[numberofemployees] [int] NULL,
		[onholdtime] [int] NULL,
		[opendeals] [int] NULL,
		[opendeals_date] [datetime] NULL,
		[opendeals_state] [int] NULL,
		[openrevenue] [decimal](38, 2) NULL,
		[openrevenue_base] [decimal](38, 2) NULL,
		[openrevenue_date] [datetime] NULL,
		[openrevenue_state] [int] NULL,
		[originatingleadid] [uniqueidentifier] NULL,
		[originatingleadid_entitytype] [nvarchar](128) NULL,
		[originatingleadidname] [nvarchar](100) NULL,
		[originatingleadidyominame] [nvarchar](100) NULL,
		[overriddencreatedon] [datetime] NULL,
		[ovs_accountnameenglish] [nvarchar](4000) NULL,
		[ovs_accountnamefrench] [nvarchar](4000) NULL,
		[ovs_country] [uniqueidentifier] NULL,
		[ovs_country_entitytype] [nvarchar](128) NULL,
		[ovs_countryname] [nvarchar](100) NULL,
		[ovs_iisid] [nvarchar](25) NULL,
		[ovs_legalname] [nvarchar](4000) NULL,
		[ovs_mocid] [nvarchar](100) NULL,
		[ovs_naicscode] [nvarchar](6) NULL,
		[ovs_primarycontactemail] [nvarchar](100) NULL,
		[ovs_primarycontactphone] [nvarchar](100) NULL,
		[ovs_sitetype] [uniqueidentifier] NULL,
		[ovs_sitetype_entitytype] [nvarchar](128) NULL,
		[ovs_sitetypename] [nvarchar](100) NULL,
		[ownerid] [uniqueidentifier] NULL,
		[ownerid_entitytype] [nvarchar](128) NULL,
		[owneridname] [nvarchar](100) NULL,
		[owneridtype] [nvarchar](4000) NULL,
		[owneridyominame] [nvarchar](100) NULL,
		[ownershipcode] [int] NULL,
		[owningbusinessunit] [uniqueidentifier] NULL,
		[owningbusinessunit_entitytype] [nvarchar](128) NULL,
		[owningteam] [uniqueidentifier] NULL,
		[owningteam_entitytype] [nvarchar](128) NULL,
		[owninguser] [uniqueidentifier] NULL,
		[owninguser_entitytype] [nvarchar](128) NULL,
		[parentaccountid] [uniqueidentifier] NULL,
		[parentaccountid_entitytype] [nvarchar](128) NULL,
		[parentaccountidname] [nvarchar](100) NULL,
		[parentaccountidyominame] [nvarchar](100) NULL,
		[participatesinworkflow] [bit] NULL,
		[paymenttermscode] [int] NULL,
		[preferredappointmentdaycode] [int] NULL,
		[preferredappointmenttimecode] [int] NULL,
		[preferredcontactmethodcode] [int] NULL,
		[preferredequipmentid] [uniqueidentifier] NULL,
		[preferredequipmentid_entitytype] [nvarchar](128) NULL,
		[preferredequipmentidname] [nvarchar](100) NULL,
		[preferredserviceid] [uniqueidentifier] NULL,
		[preferredserviceid_entitytype] [nvarchar](128) NULL,
		[preferredserviceidname] [nvarchar](100) NULL,
		[preferredsystemuserid] [uniqueidentifier] NULL,
		[preferredsystemuserid_entitytype] [nvarchar](128) NULL,
		[preferredsystemuseridname] [nvarchar](100) NULL,
		[preferredsystemuseridyominame] [nvarchar](100) NULL,
		[primarycontactid] [uniqueidentifier] NULL,
		[primarycontactid_entitytype] [nvarchar](128) NULL,
		[primarycontactidname] [nvarchar](100) NULL,
		[primarycontactidyominame] [nvarchar](100) NULL,
		[primarysatoriid] [nvarchar](200) NULL,
		[primarytwitterid] [nvarchar](128) NULL,
		[processid] [uniqueidentifier] NULL,
		[revenue] [decimal](38, 2) NULL,
		[revenue_base] [decimal](38, 4) NULL,
		[sharesoutstanding] [int] NULL,
		[shippingmethodcode] [int] NULL,
		[sic] [nvarchar](20) NULL,
		[SinkCreatedOn] [datetime] NULL,
		[SinkModifiedOn] [datetime] NULL,
		[slaid] [uniqueidentifier] NULL,
		[slaid_entitytype] [nvarchar](128) NULL,
		[slainvokedid] [uniqueidentifier] NULL,
		[slainvokedid_entitytype] [nvarchar](128) NULL,
		[slainvokedidname] [nvarchar](100) NULL,
		[slaname] [nvarchar](100) NULL,
		[stageid] [uniqueidentifier] NULL,
		[statecode] [int] NULL,
		[statuscode] [int] NULL,
		[stockexchange] [nvarchar](20) NULL,
		[teamsfollowed] [int] NULL,
		[telephone1] [nvarchar](50) NULL,
		[telephone2] [nvarchar](50) NULL,
		[telephone3] [nvarchar](50) NULL,
		[territorycode] [int] NULL,
		[territoryid] [uniqueidentifier] NULL,
		[territoryid_entitytype] [nvarchar](128) NULL,
		[territoryidname] [nvarchar](100) NULL,
		[tickersymbol] [nvarchar](10) NULL,
		[timespentbymeonemailandmeetings] [nvarchar](1250) NULL,
		[timezoneruleversionnumber] [int] NULL,
		[transactioncurrencyid] [uniqueidentifier] NULL,
		[transactioncurrencyid_entitytype] [nvarchar](128) NULL,
		[transactioncurrencyidname] [nvarchar](100) NULL,
		[traversedpath] [nvarchar](1250) NULL,
		[utcconversiontimezonecode] [int] NULL,
		[versionnumber] [bigint] NULL,
		[websiteurl] [nvarchar](200) NULL,
		[yominame] [nvarchar](160) NULL
	) ON [PRIMARY];
	GO




	
--DECLARE CONSTANTS
--===================================================================================================

--=============================================DYNAMIC VALUES===========================================
--these variables can change with the environment, so double check these match the environment you're syncing to
DECLARE @CONST_TDGCORE_DOMAINNAME  VARCHAR(50)  = 'tdg.core@034gc.onmicrosoft.com';
DECLARE @CONST_TDGCORE_USERID      VARCHAR(50)  = (SELECT systemuserid FROM CRM__SYSTEMUSER  where domainname = 'tdg.core@034gc.onmicrosoft.com');
DECLARE @CONST_TEAM_TDG_ID          VARCHAR(500) = (SELECT teamid FROM CRM__TEAM WHERE name = 'Transportation of Dangerous Goods');
DECLARE @CONST_BUSINESSUNIT_TDG_ID VARCHAR(50)  = (SELECT businessunitid FROM CRM__BUSINESSUNIT WHERE name = 'Transportation of Dangerous Goods');

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

--TERRITORIES / REGIONS
DECLARE @CONST_TERRITORY_HQ_ES                       VARCHAR(50) = '2e7b2f75-989c-eb11-b1ac-000d3ae92708';
DECLARE @CONST_TERRITORY_HQ_CR                       VARCHAR(50) = '52c72783-989c-eb11-b1ac-000d3ae92708';
DECLARE @CONST_TERRITORY_ATLANTIC                    VARCHAR(50) = 'FAB76E9E-1707-EB11-A813-000D3AF3A0D7';
DECLARE @CONST_TERRITORY_QUEBEC                      VARCHAR(50) = 'FCB76E9E-1707-EB11-A813-000D3AF3A0D7';
DECLARE @CONST_TERRITORY_PACIFIQUE                   VARCHAR(50) = 'FEB76E9E-1707-EB11-A813-000D3AF3A0D7';
DECLARE @CONST_TERRITORY_PNR                         VARCHAR(50) = '02B86E9E-1707-EB11-A813-000D3AF3A0D7';
DECLARE @CONST_TERRITORY_ONTARIO                     VARCHAR(50) = '50B21A84-DB04-EB11-A813-000D3AF3AC0D';
	




--CONVERT EXCEL DATA TO REGULATED ENTITY RECORDS IN STAGING TABLE
--===================================================================================================
--===================================================================================================
INSERT INTO
  DBO.SOURCE__REGULATED_ENTITIES (
    [REGULATED_ENTITY_ID],
    [REGULATED_ENTITY_ID_SOURCE],
    IIS_ID,
    [REGULATED_ENTITY_NAME],
    [CONSOLIDATED_COMMON_ENGLISH_NAME],
    [CONSOLIDATED_COMMON_FRENCH_NAME]
  )
SELECT
  NEWID() [REGULATED_ENTITY_ID],
  REGENT.REGULATED_ENTITY_ID [REGULATED_ENTITY_ID_SOURCE],
  REGENT.MATCHING_ID [IIS_ID],
  TRIM(REGENT.REGULATED_ENTITY_NAME) [REGULATED_ENTITY_NAME],
  TRIM(REGENT.REGULATED_ENTITY_NAME) [CONSOLIDATED_COMMON_ENGLISH_NAME],
  TRIM(REGENT.REGULATED_ENTITY_NAME) [CONSOLIDATED_COMMON_ENGLISH_NAME]
FROM
  (
    SELECT
      REGULATED_ENTITY_ID,
      REGULATED_ENTITY_NAME,
	  REGULATED_ENTITY_NAME_ALPHANUM,
      MATCHING_ID,
      COUNT(REGULATED_ENTITY_ID) COUNT_OF
    FROM
      (
        SELECT
          REGULATED_ENTITY_ID,
          dbo.fn_StripCharacters(REGULATED_ENTITY_NAME, '^a-z0-9') REGULATED_ENTITY_NAME_ALPHANUM,
		  REGULATED_ENTITY_NAME,
          MATCHING_ID
        FROM
          [dbo].SOURCE__DATA_CONSOLIDATION
      ) REGENT_NAMES
    WHERE
      REGULATED_ENTITY_NAME IS NOT NULL
    GROUP BY
      REGULATED_ENTITY_ID,
	  REGULATED_ENTITY_NAME,
      REGULATED_ENTITY_NAME_ALPHANUM,
      MATCHING_ID
    HAVING
      COUNT(REGULATED_ENTITY_ID) > 1
  ) REGENT
  ORDER BY REGULATED_ENTITY_NAME;


  --CONVERT REGULATED ENTITY RECORDS TO ACCOUNTS--
  --===================================================================================================
  --===================================================================================================
INSERT INTO
  [dbo].STAGING__ACCOUNT (
    [description],
    [accountnumber],
    id,
    accountid,
    [ovs_legalname],
    [name],
    [ovs_accountnameenglish],
    [ovs_accountnamefrench],
    [owninguser],
    [owningbusinessunit],
    [owneridtype],
    [ownerid],
    [customertypecode]
  )
SELECT
  CONCAT(
    'Converted from IIS.',
    CHAR(13) + CHAR(10),
    'IIS ID: ',
    [IIS_ID],
    CHAR(13) + CHAR(10),
    'Data Consolidation Matching ID: ',
    [REGULATED_ENTITY_ID_SOURCE]
  ) [description],
  [REGULATED_ENTITY_ID_SOURCE] [accountnumber],
  [REGULATED_ENTITY_ID] [id],
  [REGULATED_ENTITY_ID] [accountid],
  [REGULATED_ENTITY_NAME] [ovs_legalname],
  [REGULATED_ENTITY_NAME] [name],
  [CONSOLIDATED_COMMON_ENGLISH_NAME] [ovs_accountnameenglish],
  [CONSOLIDATED_COMMON_FRENCH_NAME] [ovs_accountnamefrench],
  @CONST_TDGCORE_USERID [owninguser],
  @CONST_BUSINESSUNIT_TDG_ID [owningbusinessunit],
  @CONST_OWNERIDTYPE_SYSTEMUSER [owneridtype],
  @CONST_TDGCORE_USERID [ownerid],
  948010000 [customertypecode]
FROM
  [dbo].SOURCE__REGULATED_ENTITIES REGENT;


--SITES
--===================================================================================================
--===================================================================================================
INSERT INTO
  [dbo].SOURCE__SITES (
    [SITE_ID],
    [IIS_ID],
    [REGULATED_ENTITY_ID],
    [REGULATED_ENTITY_ID_SOURCE],
    [REGULATED_ENTITY_NAME],
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
  NEWID() [SITE_ID],
  SITES.IIS_ID,
  NULL [REGULATED_ENTITY_ID],
  SITES.REGULATED_ENTITY_ID [REGULATED_ENTITY_ID_SOURCE],
  SITES.[REGULATED_ENTITY_NAME],
  SITES.COMPANY_NAME_FORMATTED,
  SITES.COMPANY_NAME,
  SITES.COUNTRY_SUBDIVISION_CD,
  SITES.CITY_TOWN_NAME_NM,
  SITES.ADDRESS,
  SITES.POSTAL_CODE_TXT,
  SITES.COMPLETED,
  SITES.[PLANNED2021]
FROM
  (
    SELECT
      [COMPLETED],
      [ASSIGNED_TO],
      [IIS_ID],
      [COMPANY_NAME_FORMATTED],
      [PLANNED2021],
      [COMPANY_NAME],
      [COUNTRY_SUBDIVISION_CD],
      [CITY_TOWN_NAME_NM],
      [ADDRESS],
      [POSTAL_CODE_TXT],
      [FILE_STATUS_CD],
      [SOUNDEX_NAME],
      [MATCHING_ID],
      [FUZZY_MATCH],
      [REGULATED_ENTITY_ID],
      [REGULATED_ENTITY_NAME],
      [CONSOLIDATED_COMMON_ENGLISH_NAME],
      [CONSOLIDATED_COMMON_FRENCH_NAME],
      [NOTES]
    FROM
      [dbo].SOURCE__DATA_CONSOLIDATION
  ) SITES; --link SITES to regulated entities


UPDATE
  SITES
SET
  SITES.REGULATED_ENTITY_ID = REGENT.REGULATED_ENTITY_ID
FROM
  [dbo].SOURCE__SITES AS SITES
  INNER JOIN DBO.SOURCE__REGULATED_ENTITIES AS REGENT ON SITES.[REGULATED_ENTITY_ID_SOURCE] = REGENT.[REGULATED_ENTITY_ID_SOURCE];



CREATE TABLE #TEMP_ACCOUNTS (
[accountnumber]            [nvarchar](20) NULL,
[description]              [nvarchar](max) NULL,
[Id]                       [uniqueidentifier] NOT NULL,
[ovs_iisid]                [nvarchar](25) NULL,
[ovs_legalname]            [nvarchar](250) NULL,
[name]                     [nvarchar](160) NULL,
[ovs_accountnameenglish]   [nvarchar](4000) NULL,
[address1_stateorprovince] [nvarchar](50) NULL,
[address1_city]            [nvarchar](80) NULL,
[address1_line1]           [nvarchar](250) NULL,
[address1_postalcode]      [nvarchar](20) NULL,
[owninguser]               [uniqueidentifier] NULL,
[owningbusinessunit]       [uniqueidentifier] NULL,
[owneridtype]              [nvarchar](4000) NULL,
[ownerid]                  [uniqueidentifier] NULL,
[customertypecode]         int,
[msdyn_serviceterritory]   [uniqueidentifier] NULL,
[territoryid]              [uniqueidentifier] NULL,
[parentaccountid]          [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

--CONVERT SITE ENTITY RECORDS TO ACCOUNTS--
INSERT INTO
  #TEMP_ACCOUNTS
  (
    [accountnumber],
    [description],
    [ID],
    [ovs_iisid],
    [ovs_legalname],
    [name],
    [ovs_accountnameenglish],
    [address1_stateorprovince],
    [address1_city],
    [address1_line1],
    [address1_postalcode],
    [owninguser],
    [owningbusinessunit],
    [owneridtype],
    [ownerid],
    [customertypecode],
    [msdyn_serviceterritory],
    [territoryid],
    [parentaccountid]
  )
SELECT
  IIS_ID [accountnumber],
  CONCAT(
    'Converted from IIS.',
    CHAR(13) + CHAR(10),
    'IIS ID: ',
    IIS_ID
  ) [description],
  NEWID()                     [ID],
  IIS_ID                      [ovs_iisid],
  LEGAL_NAME_ENM              [ovs_legalname],
  COMPANY_NAME                [name],
  OPERATING_NAME_ENM          [ovs_accountnameenglish],
  T1.[COUNTRY_SUBDIVISION_CD] [address1_stateorprovince],
  [CITY_TOWN_NAME_NM]         [address1_city],
  [ADDRESS]                   [address1_line1],
  [POSTAL_CODE_TXT]           [address1_postalcode],
  @CONST_TDGCORE_USERID           [owninguser],
  @CONST_BUSINESSUNIT_TDG_ID   [owningbusinessunit],
  @CONST_OWNERIDTYPE_SYSTEMUSER     [owneridtype],
  @CONST_TDGCORE_USERID           [ownerid],
  948010001                   [customertypecode],
  msdyn_serviceterritory    [msdyn_serviceterritory],
  [msdyn_serviceterritory]    [territoryid],
  T1.REGULATED_ENTITY_ID      [parentaccountid]
FROM
  (
    SELECT
      T1.*,
      CASE
        WHEN T2.LEGAL_NAME_ENM IS NULL
        OR T2.LEGAL_NAME_ENM = '' THEN NULL
        ELSE T2.LEGAL_NAME_ENM
      END LEGAL_NAME_ENM,
      [T2].OPERATING_NAME_ENM,
      T3.[msdyn_serviceterritory],
      NULL [parentaccountid]
    FROM
      SOURCE__SITES T1
      LEFT JOIN SOURCE__IIS_EXPORT T2 ON T1.IIS_ID = T2.STAKEHOLDER_ID
      LEFT JOIN [dbo].SOURCE__TERRITORY_TRANSLATION T3 ON UPPER(TRIM(T1.[COUNTRY_SUBDIVISION_CD])) = UPPER(TRIM(T3.[COUNTRY_SUBDIVISION_CD])) 
	  --Make sure that no regulated entity ids do not go into the system as sites
      --AND STAKEHOLDER_ID NOT IN
      --(
      -- SELECT
      -- IIS_ID
      -- FROM
      -- [02_REGULATED_ENTITIES]
      --)
  ) T1;


INSERT INTO
  STAGING__ACCOUNT (
    [accountnumber],
    [description],
    [id],
    [accountid],
    [ovs_iisid],
    [ovs_legalname],
    [name],
    [ovs_accountnameenglish],
    [address1_stateorprovince],
    [address1_city],
    [address1_line1],
    [address1_postalcode],
    [owninguser],
    [owningbusinessunit],
    [owneridtype],
    [ownerid],
    [customertypecode],
    [msdyn_serviceterritory],
    [territoryid],
    [parentaccountid]
  )
SELECT
  [accountnumber],
  [description],
  [id],
  [id] [accountid],
  [ovs_iisid],
  [ovs_legalname],
  [name],
  [ovs_accountnameenglish],
  [address1_stateorprovince],
  [address1_city],
  [address1_line1],
  [address1_postalcode],
  [owninguser],
  [owningbusinessunit],
  [owneridtype],
  [ownerid],
  [customertypecode],
  [msdyn_serviceterritory],
  [territoryid],
  [parentaccountid]
FROM
  #TEMP_ACCOUNTS;

  --LOGIC FOR IIS DATA
  --===================================================================================================
UPDATE
  STAGING__ACCOUNT
SET
  --,name = T2.OPERATING_NAME,
  ovs_legalname = T2.LEGAL_NAME,
  ovs_accountnameenglish = T2.OPERATING_NAME,
  address1_primarycontactname = T2.USER_CONTACT,
  address1_telephone1 = T2.CONTACT_TFH,
  address1_latitude = CASE
    WHEN ISNUMERIC(T2.LATITUDE_DEGREE_NBR) = 1 THEN CAST(T2.LATITUDE_DEGREE_NBR AS DECIMAL(38, 5))
    ELSE NULL
  END,
  address1_longitude = CASE
    WHEN ISNUMERIC(T2.LONGITUDE_DEGREE_NBR) = 1 THEN CAST(T2.LONGITUDE_DEGREE_NBR AS DECIMAL(38, 5))
    ELSE NULL
  END,
  address1_city = TRIM(T2.CITY_TOWN_NAME_NM),
  address1_country = TRIM(T2.COUNTRY),
  address1_postalcode = TRIM(T2.POSTAL_CODE_TXT),
  address1_stateorprovince = TRIM(T2.COUNTRY_SUBDIVISION_CD),
  address1_line3 = TRIM(POBOX),
  address1_postofficebox = TRIM(POBOX),
  address1_line1 = CASE
    WHEN TRIM(T2.STREET) IS NULL
    OR TRIM(T2.STREET) = '' THEN address1_line1
    ELSE TRIM(T2.STREET)
  END
FROM
  STAGING__ACCOUNT T1
  JOIN (
    SELECT
      --IIS Number
      IIS.STAKEHOLDER_ID,
      --Legal Name
      --DATA MIGRATION RULES:
      --If Legal name doesn't exist in IIS, then include make the Legal Name "Legal Name was not on file in IIS, please confirm Legal Name".
      --BUSINESS REASON: This is what is used on the Inspection Report and Tickets and other official documents
      CASE
        WHEN IIS.LEGAL_NAME_ENM IS NULL THEN 'Legal Name was not on file in IIS, please confirm Legal Name'
        ELSE TRIM(IIS.LEGAL_NAME_ENM)
      END LEGAL_NAME,
      --Operating Name
      --DATA MIGRATION RULES:
      --If Operating Name doesn't exist in IIS, then use the Legal Name in IIS for the Operating Name.
      --BUSINESS REASON: This is required so that you know the name of the company you are looking for by name.
      CASE
        WHEN IIS.OPERATING_NAME_ENM IS NULL THEN IIS.LEGAL_NAME_ENM
        ELSE TRIM(IIS.OPERATING_NAME_ENM)
      END OPERATING_NAME,
      --Address 1 - Out of the box fields in ROM; Concept of "Civic General Address" in IIS
      --DATA MIGRATION RULE FOR ALL ADDRESS FIELDS
      --If the "Civic General Address" within the address from Address Type = "Civic" is blank, then use the Address Type = "Physical" to then fill in all the fields for the address
      --Street 1
      --DATA MIGRATION RULES:
      --Use the "Civic General Address" from IIS for this field for Address Type Civic. into this field.
      --If this field is blank in IIS, leave this field blank in ROM.
      IIS.PHYS_STREET_NUMBER_NUM,
      IIS.PHYS_STREET_NAME_NM,
      IIS.STREET_NUMBER_NUM,
      IIS.STREET_NAME_NM,
      CASE
        WHEN STREET_NAME_NM IS NULL
        AND (
          PHYS_STREET_NAME_NM IS NULL
          OR TRIM(PHYS_STREET_NAME_NM) = ''
        ) THEN NULL
        WHEN (
          STREET_NAME_NM IS NULL
          OR TRIM(STREET_NAME_NM) = '0'
        )
        AND PHYS_STREET_NAME_NM IS NOT NULL THEN CONCAT(
          IIS.PHYS_STREET_NUMBER_NUM,
          ' ',
          IIS.PHYS_STREET_NAME_NM
        )
        ELSE CONCAT(IIS.STREET_NUMBER_NUM, ' ', STREET_NAME_NM)
      END STREET,
      --City
      --DATA MIGRATION RULES:
      --Migrate the IIS "City Town Name" for Address Type Civic. into this field
      CASE
        WHEN ADDRESS_TYPE.[TYPE] = 'PHYSICAL' THEN IIS.PHYS_CITY_TOWN_NAME_NM
        ELSE IIS.CITY_TOWN_NAME_NM
      END CITY_TOWN_NAME_NM,
      --Province
      --DATA MIGRATION RULES:
      --Migrate the IIS "Country Sub Divsiion Code" for Address Type Civic. into this field
      CASE
        WHEN ADDRESS_TYPE.[TYPE] = 'PHYSICAL' THEN IIS.PHYS_COUNTRY_SUBDIVISION_CD
        ELSE IIS.COUNTRY_SUBDIVISION_CD
      END COUNTRY_SUBDIVISION_CD,
      --Postal Code
      --DATA MIGRATION RULES:
      --Migrate the IIS "Postal Code" for Address Type Civic. into this field
      CASE
        WHEN ADDRESS_TYPE.[TYPE] = 'PHYSICAL' THEN IIS.PHYS_POSTAL_CODE_TXT
        ELSE IIS.POSTAL_CODE_TXT
      END POSTAL_CODE_TXT,
      --Country
      --DATA MIGRATION RULES:
      --Migrate the IIS "Country" for Address Type Civic. into this field
      CASE
        WHEN ADDRESS_TYPE.[TYPE] = 'CIVIC' THEN 'Canada'
        WHEN IIS.[PHYS_COUNTRY_CD] IS NULL THEN 'Canada'
        ELSE IIS.[PHYS_COUNTRY_ENM]
      END COUNTRY,
      --Lat / Long
      --DATA MIGRATION RULES:
      --Migrate the IIS "Lat Long" for Address Type Civic. into this field
      --If this field is currently blank in IIS, leave it blank in ROM.
      CASE
        WHEN ADDRESS_TYPE.[TYPE] = 'CIVIC' THEN IIS.[LATITUDE_DEGREE_NBR]
        ELSE IIS.[PHYS_LATITUDE_DEGREE_NBR]
      END LATITUDE_DEGREE_NBR,
      CASE
        WHEN ADDRESS_TYPE.[TYPE] = 'CIVIC' THEN IIS.LATITUDE_MINUTE_NBR
        ELSE IIS.[PHYS_LATITUDE_MINUTE_NBR]
      END LATITUDE_MINUTE_NBR,
      CASE
        WHEN ADDRESS_TYPE.[TYPE] = 'CIVIC' THEN IIS.LONGITUDE_DEGREE_NBR
        ELSE IIS.[PHYS_LONGITUDE_DEGREE_NBR]
      END LONGITUDE_DEGREE_NBR,
      CASE
        WHEN ADDRESS_TYPE.[TYPE] = 'CIVIC' THEN IIS.LONGITUDE_MINUTE_NBR
        ELSE IIS.[PHYS_LONGITUDE_MINUTE_NBR]
      END LONGITUDE_MINUTE_NBR,
      --Street 3
      --DATA MIGRATION RULES:
      --Use the "PO Box" field from IIS for this field.
      --If this field is blank in IIS, leave this field blank in ROM.
      CASE
        WHEN IIS.UNIT_SUITE_NUM = 'P.O. Box'
        OR IIS.UNIT_SUITE_NUM = 'PO' THEN CONCAT('P.O. Box', ' ', STREET_NUMBER_NUM)
        WHEN IIS.UNIT_SUITE_NUM = 'RR'
        OR IIS.UNIT_SUITE_NUM = 'SS' THEN CONCAT(IIS.UNIT_SUITE_NUM, ' ', STREET_NUMBER_NUM)
        ELSE NULL
      END POBOX,
      --Phone
      --Out of the box field.
      --DATA MIGRATION RULES:
      --There is no field that needs to be migrated from IIS.
      IIS.CONTACT_PHONE,
      IIS.CONTACT_BUSINESS_PHONE,
      IIS.CONTACT_EMAIL,
      IIS.CONTACT_TFH,
      IIS.USER_CONTACT --Fax
      --Out of the box field.
      --DATA MIGRATION RULES:
      --There is no field that needs to be migrated from IIS.
,
      ADDRESS_TYPE.[TYPE]
    FROM
      SOURCE__SITES SITES
      JOIN SOURCE__IIS_EXPORT IIS ON SITES.IIS_ID = IIS.STAKEHOLDER_ID
      JOIN (
        SELECT
          STAKEHOLDER_ID,
          CASE
            WHEN (
              STREET_NUMBER_NUM IS NULL
              OR TRIM(STREET_NUMBER_NUM) = ''
            )
            AND (
              STREET_NAME_NM IS NULL
              OR TRIM (STREET_NAME_NM) = ''
            )
            AND (
              CITY_TOWN_NAME_NM IS NULL
              OR TRIM(CITY_TOWN_NAME_NM) = ''
            )
            AND (
              COUNTRY_SUBDIVISION_CD IS NULL
              OR TRIM(COUNTRY_SUBDIVISION_CD) = ''
            )
            AND (
              POSTAL_CODE_TXT IS NULL
              OR TRIM(POSTAL_CODE_TXT) = ''
            ) THEN 'PHYSICAL'
            ELSE 'CIVIC'
          END [TYPE]
        FROM
          SOURCE__IIS_EXPORT
      ) ADDRESS_TYPE ON IIS.STAKEHOLDER_ID = ADDRESS_TYPE.STAKEHOLDER_ID
  ) T2 ON T1.ovs_iisid = T2.STAKEHOLDER_ID;


--MOC Registration Number
--Required to be migrated from IIS.  This field will be required for linking to FDR.
--get this field from the workplan uploads
UPDATE
  STAGING__ACCOUNT
SET
  ovs_mocid = T2.MOC_ID
FROM
  STAGING__ACCOUNT T1
  JOIN (
    SELECT
      DISTINCT SITES.IIS_ID,
      WORKPLANS.MOC_ID
    FROM
      SOURCE__SITES SITES
      JOIN [dbo].SOURCE__WORKPLAN_IMPORT WORKPLANS ON CAST(SITES.IIS_ID AS varchar(10)) = WORKPLANS.IIS_ID
    WHERE
      MOC_ID IS NOT NULL
      AND MOC_ID <> ''
  ) T2 ON T1.ovs_iisid = T2.IIS_ID;


--View accounts linked to Sites
--SELECT *
--FROM STAGING__ACCOUNT T1
--JOIN [03_SITES] T2 ON T1.ovs_iisid = T2.IIS_ID;
--SITE OPERATING PROFILE TAGS:
--The following are all characteristics of a site that will be used to build / filter the questionnaire.
--During Data Migration the expectation is that these tags will be extracted / translated from the existing data in IIS and imported into ROM.
--Means of Containment
--DATA MIGRATION RULES:
--Migrate the
--Means of Containment Facility Type
--DATA MIGRATION RULES:
--Mode
--DATA MIGRATION RULES:
--This field is in IIS as "Mode".  It is check boxes in IIS.
--Migrate the value from IIS to Mode.
--This is a Mandatory field.
--Valid Values
--Rail
--Road
--Air
--Marine
--The field name remains as "Mode".
--This is a tag that will be associated with a site.  It will need to be in the Site Operating Profile section; these values are used to build / filter the questionnaire.
--Multiple values for Mode can be selected
--Try to sanitize some bad data from IIS
UPDATE
  [dbo].STAGING__ACCOUNT
SET
  address1_postalcode = REPLACE(address1_postalcode, ' ', ''),
  address1_country = 'Canada',
  address1_line1 = TRIM(address1_line1),
  address1_latitude = CASE
    WHEN address1_latitude IS NULL
    OR address1_latitude = 0.00000 THEN NULL
    ELSE address1_latitude
  END,
  address1_longitude = CASE
    WHEN address1_longitude IS NULL
    OR address1_longitude = 0.00000 THEN NULL
    ELSE address1_longitude
  END;


  select count(name) COUNTOF_ACCOUNTS
  from STAGING__ACCOUNT;

  --SELECT * FROM STAGING__ACCOUNT
  --order by name;