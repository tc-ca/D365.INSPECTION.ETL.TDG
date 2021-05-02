	--TABLE DEFINITIONS
	--===================================================================================================
	--===================================================================================================
BEGIN

	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[02_REGULATED_ENTITIES]') AND type in (N'U'))
	DROP TABLE [dbo].[02_REGULATED_ENTITIES]

	CREATE TABLE [dbo].[02_REGULATED_ENTITIES] (
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
	) ON [PRIMARY]


	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[03_SITES]') AND type in (N'U'))
	DROP TABLE [dbo].[03_SITES]

	CREATE TABLE [dbo].[03_SITES] (
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
	) ON [PRIMARY]




	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[04_ACCOUNT]') AND type in (N'U'))
	DROP TABLE [dbo].[04_ACCOUNT]


	CREATE TABLE [dbo].[04_ACCOUNT] (
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
	) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]



	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[06_WORK_ORDERS]') AND type in (N'U'))
	DROP TABLE [dbo].[06_WORK_ORDERS]


	CREATE TABLE [dbo].[06_WORK_ORDERS] (

	createdby UNIQUEIDENTIFIER         null,
	createdbyname NVARCHAR (200)         null,
	createdbyyominame NVARCHAR (200)        null,
	createdon DATETIME           null,
	createdonbehalfby UNIQUEIDENTIFIER       null,
	createdonbehalfbyname NVARCHAR (200)       null,
	createdonbehalfbyyominame NVARCHAR (200)      null,
	exchangerate NUMERIC (38, 10)        null,
	importsequencenumber INT          null,
	modifiedby UNIQUEIDENTIFIER         null,
	modifiedbyname NVARCHAR (200)         null,
	modifiedbyyominame NVARCHAR (200)        null,
	modifiedon DATETIME           null,
	modifiedonbehalfby UNIQUEIDENTIFIER       null,
	modifiedonbehalfbyname NVARCHAR (200)       null,
	modifiedonbehalfbyyominame NVARCHAR (200)      null,
	msdyn_address1 NVARCHAR (250)         null,
	msdyn_address2 NVARCHAR (250)         null,
	msdyn_address3 NVARCHAR (250)         null,
	msdyn_addressname NVARCHAR (250)        null,
	msdyn_agreement UNIQUEIDENTIFIER        null,
	msdyn_agreementname NVARCHAR (100)        null,
	msdyn_autonumbering NVARCHAR (100)        null,
	msdyn_billingaccount UNIQUEIDENTIFIER      null,
	msdyn_billingaccountname NVARCHAR (160)      null,
	msdyn_billingaccountyominame NVARCHAR (160)     null,
	msdyn_bookingsummary ntext         null,
	msdyn_childindex INT           null,
	msdyn_city NVARCHAR (80)          null,
	msdyn_closedby UNIQUEIDENTIFIER        null,
	msdyn_closedbyname NVARCHAR (200)        null,
	msdyn_closedbyyominame NVARCHAR (200)       null,
	msdyn_completedon DATETIME         null,
	msdyn_country NVARCHAR (80)         null,
	msdyn_customerasset UNIQUEIDENTIFIER       null,
	msdyn_customerassetname NVARCHAR (100)       null,
	msdyn_datewindowend DATETIME         null,
	msdyn_datewindowstart DATETIME        null,
	msdyn_estimatesubtotalamount NUMERIC (38, 2)     null,
	msdyn_estimatesubtotalamount_base NUMERIC (38, 2)    null,
	msdyn_firstarrivedon DATETIME        null,
	msdyn_followupnote ntext          null,
	msdyn_followuprequired bit          null,
	msdyn_followuprequiredname NVARCHAR (255)      null,
	msdyn_functionallocation UNIQUEIDENTIFIER     null,
	msdyn_functionallocationname NVARCHAR (60)     null,
	msdyn_instructions ntext          null,
	msdyn_internalflags ntext          null,
	msdyn_iotalert UNIQUEIDENTIFIER        null,
	msdyn_iotalertname NVARCHAR (100)        null,
	msdyn_isfollowup bit           null,
	msdyn_isfollowupname NVARCHAR (255)       null,
	msdyn_ismobile bit            null,
	msdyn_ismobilename NVARCHAR (255)        null,
	msdyn_latitude FLOAT           null,
	msdyn_longitude FLOAT           null,
	msdyn_mapcontrol NVARCHAR (100)        null,
	msdyn_name NVARCHAR (100)          null,
	msdyn_opportunityid UNIQUEIDENTIFIER       null,
	msdyn_opportunityidname NVARCHAR (300)       null,
	msdyn_parentworkorder UNIQUEIDENTIFIER      null,
	msdyn_parentworkordername NVARCHAR (100)      null,
	msdyn_postalcode NVARCHAR (20)        null,
	msdyn_preferredresource UNIQUEIDENTIFIER      null,
	msdyn_preferredresourcename NVARCHAR (100)      null,
	msdyn_pricelist UNIQUEIDENTIFIER        null,
	msdyn_pricelistname NVARCHAR (100)        null,
	msdyn_primaryincidentdescription ntext      null,
	msdyn_primaryincidentestimatedduration INT      null,
	msdyn_primaryincidenttype UNIQUEIDENTIFIER     null,
	msdyn_primaryincidenttypename NVARCHAR (100)     null,
	msdyn_priority UNIQUEIDENTIFIER        null,
	msdyn_priorityname NVARCHAR (100)        null,
	msdyn_reportedbycontact UNIQUEIDENTIFIER      null,
	msdyn_reportedbycontactname NVARCHAR (160)      null,
	msdyn_reportedbycontactyominame NVARCHAR (450)     null,
	msdyn_serviceaccount UNIQUEIDENTIFIER      null,
	msdyn_serviceaccountname NVARCHAR (160)      null,
	msdyn_serviceaccountyominame NVARCHAR (160)     null,
	msdyn_servicerequest UNIQUEIDENTIFIER      null,
	msdyn_servicerequestname NVARCHAR (200)      null,
	msdyn_serviceterritory UNIQUEIDENTIFIER      null,
	msdyn_serviceterritoryname NVARCHAR (200)      null,
	msdyn_stateorprovince NVARCHAR (50)       null,
	msdyn_substatus UNIQUEIDENTIFIER        null,
	msdyn_substatusname NVARCHAR (100)        null,
	msdyn_subtotalamount NUMERIC (38, 2)       null,
	msdyn_subtotalamount_base NUMERIC (38, 2)      null,
	msdyn_supportcontact UNIQUEIDENTIFIER      null,
	msdyn_supportcontactname NVARCHAR (100)      null,
	msdyn_systemstatus INT           null,
	msdyn_systemstatusname NVARCHAR (255)       null,
	msdyn_taxable bit            null,
	msdyn_taxablename NVARCHAR (255)        null,
	msdyn_taxcode UNIQUEIDENTIFIER        null,
	msdyn_taxcodename NVARCHAR (100)        null,
	msdyn_timeclosed DATETIME         null,
	msdyn_timefrompromised DATETIME        null,
	msdyn_timegroup UNIQUEIDENTIFIER        null,
	msdyn_timegroupdetailselected UNIQUEIDENTIFIER    null,
	msdyn_timegroupdetailselectedname NVARCHAR (100)    null,
	msdyn_timegroupname NVARCHAR (100)        null,
	msdyn_timetopromised DATETIME        null,
	msdyn_timewindowend DATETIME         null,
	msdyn_timewindowstart DATETIME        null,
	msdyn_totalamount NUMERIC (38, 2)        null,
	msdyn_totalamount_base NUMERIC (38, 2)       null,
	msdyn_totalestimatedduration INT        null,
	msdyn_totalsalestax NUMERIC (38, 2)        null,
	msdyn_totalsalestax_base NUMERIC (38, 2)      null,
	msdyn_workhourtemplate UNIQUEIDENTIFIER      null,
	msdyn_workhourtemplatename NVARCHAR (100)      null,
	msdyn_worklocation INT           null,
	msdyn_worklocationname NVARCHAR (255)       null,
	msdyn_workorderarrivaltimekpiid UNIQUEIDENTIFIER    null,
	msdyn_workorderarrivaltimekpiidname NVARCHAR (100)    null,
	msdyn_workorderid UNIQUEIDENTIFIER       null,
	msdyn_workorderresolutionkpiid UNIQUEIDENTIFIER    null,
	msdyn_workorderresolutionkpiidname NVARCHAR (100)    null,
	msdyn_workordersummary ntext         null,
	msdyn_workordertype UNIQUEIDENTIFIER       null,
	msdyn_workordertypename NVARCHAR (100)       null,
	overriddencreatedon DATETIME         null,
	ovs_asset UNIQUEIDENTIFIER         null,
	ovs_assetcategory UNIQUEIDENTIFIER       null,
	ovs_assetcategoryname NVARCHAR (100)       null,
	ovs_assetname NVARCHAR (100)         null,
	ovs_currentfiscalquarter UNIQUEIDENTIFIER     null,
	ovs_currentfiscalquartername NVARCHAR (100)     null,
	ovs_fiscalquarter UNIQUEIDENTIFIER       null,
	ovs_fiscalquartername NVARCHAR (100)       null,
	ovs_fiscalyear UNIQUEIDENTIFIER        null,
	ovs_fiscalyearname NVARCHAR (100)        null,
	ovs_iisid NVARCHAR (100)          null,
	ovs_mocid NVARCHAR (100)          null,
	ovs_operationid UNIQUEIDENTIFIER        null,
	ovs_operationidname NVARCHAR (200)        null,
	ovs_operationtypeid UNIQUEIDENTIFIER       null,
	ovs_operationtypeidname NVARCHAR (100)       null,
	ovs_oversighttype UNIQUEIDENTIFIER       null,
	ovs_oversighttypename NVARCHAR (100)       null,
	ovs_ovscountry UNIQUEIDENTIFIER        null,
	ovs_ovscountryname NVARCHAR (100)        null,
	ovs_primaryinspector UNIQUEIDENTIFIER      null,
	ovs_primaryinspectorname NVARCHAR (100)      null,
	ovs_rational UNIQUEIDENTIFIER        null,
	ovs_rationalname NVARCHAR (100)        null,
	ovs_regulatedentity UNIQUEIDENTIFIER       null,
	ovs_regulatedentityname NVARCHAR (160)       null,
	ovs_regulatedentityyominame NVARCHAR (160)      null,
	ovs_revisedquarterid UNIQUEIDENTIFIER      null,
	ovs_revisedquarteridname NVARCHAR (100)      null,
	ovs_rolluptestdeletemeafter DATETIME       null,
	ovs_rolluptestdeletemeafter_date DATETIME     null,
	ovs_rolluptestdeletemeafter_state INT       null,
	ovs_secondaryinspector UNIQUEIDENTIFIER      null,
	ovs_secondaryinspectorname NVARCHAR (100)      null,
	ovs_siteofviolation UNIQUEIDENTIFIER       null,
	ovs_siteofviolationname NVARCHAR (160)       null,
	ovs_siteofviolationyominame NVARCHAR (160)      null,
	ovs_tyrational UNIQUEIDENTIFIER        null,
	ovs_tyrationalname NVARCHAR (100)        null,
	ownerid UNIQUEIDENTIFIER          null,
	owneridname NVARCHAR (200)          null,
	owneridtype NVARCHAR (64)          null,
	owneridyominame NVARCHAR (200)         null,
	owningbusinessunit UNIQUEIDENTIFIER       null,
	owningteam UNIQUEIDENTIFIER         null,
	owninguser UNIQUEIDENTIFIER         null,
	processid UNIQUEIDENTIFIER         null,
	qm_blobpath NVARCHAR (200)          null,
	qm_remote bit             null,
	qm_remotename NVARCHAR (255)         null,
	qm_reportcontactid UNIQUEIDENTIFIER       null,
	qm_reportcontactidname NVARCHAR (160)       null,
	qm_reportcontactidyominame NVARCHAR (450)      null,
	stageid UNIQUEIDENTIFIER          null,
	statecode INT             null,
	statecodename NVARCHAR (255)         null,
	statuscode INT             null,
	statuscodename NVARCHAR (255)         null,
	timezoneruleversionnumber INT         null,
	transactioncurrencyid UNIQUEIDENTIFIER      null,
	transactioncurrencyidname NVARCHAR (100)      null,
	traversedpath NVARCHAR (1250)         null,
	utcconversiontimezonecode INT         null,
	versionnumber bigint           null

	) ON [PRIMARY]




	/****** Object:  Table [dbo].[07_VIOLATIONS]    Script Date: 4/20/2021 4:03:10 PM ******/
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[07_VIOLATIONS]') AND type in (N'U'))
	DROP TABLE [dbo].[07_VIOLATIONS]


	CREATE TABLE [07_VIOLATIONS] (
		[createdby] UNIQUEIDENTIFIER,
		[createdbyname] NVARCHAR(200),
		[createdbyyominame] NVARCHAR(200),
		[createdon] DATETIME,
		[createdonbehalfby] UNIQUEIDENTIFIER,
		[createdonbehalfbyname] NVARCHAR(200),
		[createdonbehalfbyyominame] NVARCHAR(200),
		[importsequencenumber] INT,
		[modifiedby] UNIQUEIDENTIFIER,
		[modifiedbyname] NVARCHAR(200),
		[modifiedbyyominame] NVARCHAR(200),
		[modifiedon] DATETIME,
		[modifiedonbehalfby] UNIQUEIDENTIFIER,
		[modifiedonbehalfbyname] NVARCHAR(200),
		[modifiedonbehalfbyyominame] NVARCHAR(200),
		[overriddencreatedon] DATETIME,
		[ownerid] UNIQUEIDENTIFIER,
		[owneridname] NVARCHAR(200),
		[owneridtype] NVARCHAR(64),
		[owneridyominame] NVARCHAR(200),
		[owningbusinessunit] UNIQUEIDENTIFIER,
		[owningteam] UNIQUEIDENTIFIER,
		[owninguser] UNIQUEIDENTIFIER,
		[qm_approximatetotal] INT,
		[qm_blobpath] NVARCHAR(200),
		[qm_cysafetyassessmentid] UNIQUEIDENTIFIER,
		[qm_cysafetyassessmentidname] NVARCHAR(100),
		[qm_externalcomments] NTEXT,
		[qm_internalcomments] NTEXT,
		[qm_isviolation] BIT,
		[qm_isviolationname] NVARCHAR(255),
		[qm_name] NVARCHAR(300),
		[qm_questionid] UNIQUEIDENTIFIER,
		[qm_questionidname] NVARCHAR(300),
		[qm_rclegislationid] UNIQUEIDENTIFIER,
		[qm_rclegislationidname] NVARCHAR(100),
		[qm_referenceid] NVARCHAR(255),
		[qm_responseid] NVARCHAR(4000),
		[qm_samplesize] INT,
		[qm_syresultid] UNIQUEIDENTIFIER,
		[qm_violationcount] INT,
		[qm_workorderid] UNIQUEIDENTIFIER,
		[qm_workorderidname] NVARCHAR(100),
		[statecode] INT,
		[statecodename] NVARCHAR(255),
		[statuscode] INT,
		[statuscodename] NVARCHAR(255),
		[timezoneruleversionnumber] INT,
		[utcconversiontimezonecode] INT,
		[versionnumber] BIGINT
	) ON [PRIMARY]



	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[11_CONTACT]') AND type in (N'U'))
	DROP TABLE [dbo].[11_CONTACT]


	CREATE TABLE [dbo].[11_CONTACT](
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
	) ON [PRIMARY]



	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[12_BOOKABLE_RESOURCE]') AND type in (N'U'))
	DROP TABLE [dbo].[12_BOOKABLE_RESOURCE]


	CREATE TABLE [12_BOOKABLE_RESOURCE] (
		[accountid] UNIQUEIDENTIFIER,
		[accountidname] NVARCHAR(160),
		[accountidyominame] NVARCHAR(160),
		[bookableresourceid] UNIQUEIDENTIFIER,
		[calendarid] UNIQUEIDENTIFIER,
		[calendaridname] NVARCHAR(160),
		[contactid] UNIQUEIDENTIFIER,
		[contactidname] NVARCHAR(160),
		[contactidyominame] NVARCHAR(160),
		[createdby] UNIQUEIDENTIFIER,
		[createdbyname] NVARCHAR(200),
		[createdbyyominame] NVARCHAR(200),
		[createdon] DATETIME,
		[createdonbehalfby] UNIQUEIDENTIFIER,
		[createdonbehalfbyname] NVARCHAR(200),
		[createdonbehalfbyyominame] NVARCHAR(200),
		[exchangerate] NUMERIC(38, 10),
		[importsequencenumber] INT,
		[modifiedby] UNIQUEIDENTIFIER,
		[modifiedbyname] NVARCHAR(200),
		[modifiedbyyominame] NVARCHAR(200),
		[modifiedon] DATETIME,
		[modifiedonbehalfby] UNIQUEIDENTIFIER,
		[modifiedonbehalfbyname] NVARCHAR(200),
		[modifiedonbehalfbyyominame] NVARCHAR(200),
		[msdyn_bookingstodrip] INT,
		[msdyn_crewstrategy] INT,
		[msdyn_crewstrategyname] NVARCHAR(255),
		[msdyn_derivecapacity] BIT,
		[msdyn_derivecapacityname] NVARCHAR(255),
		[msdyn_displayonscheduleassistant] BIT,
		[msdyn_displayonscheduleassistantname] NVARCHAR(255),
		[msdyn_displayonscheduleboard] BIT,
		[msdyn_displayonscheduleboardname] NVARCHAR(255),
		[msdyn_enableappointments] INT,
		[msdyn_enableappointmentsname] NVARCHAR(255),
		[msdyn_enabledforfieldservicemobile] BIT,
		[msdyn_enabledforfieldservicemobilename] NVARCHAR(255),
		[msdyn_enabledripscheduling] BIT,
		[msdyn_enabledripschedulingname] NVARCHAR(255),
		[msdyn_endlocation] INT,
		[msdyn_endlocationname] NVARCHAR(255),
		[msdyn_facilityequipmentid] UNIQUEIDENTIFIER,
		[msdyn_facilityequipmentidname] NVARCHAR(160),
		[msdyn_generictype] INT,
		[msdyn_generictypename] NVARCHAR(255),
		[msdyn_hourlyrate] NUMERIC(38, 2),
		[msdyn_hourlyrate_base] NUMERIC(38, 2),
		[msdyn_internalflags] NTEXT,
		[msdyn_latitude] FLOAT,
		[msdyn_locationtimestamp] DATETIME,
		[msdyn_longitude] FLOAT,
		[msdyn_organizationalunit] UNIQUEIDENTIFIER,
		[msdyn_organizationalunitname] NVARCHAR(100),
		[msdyn_pooltype] NVARCHAR(4000),
		[msdyn_pooltypename] NVARCHAR(255),
		[msdyn_primaryemail] NVARCHAR(100),
		[msdyn_startlocation] INT,
		[msdyn_startlocationname] NVARCHAR(255),
		[msdyn_targetutilization] INT,
		[msdyn_timeoffapprovalrequired] BIT,
		[msdyn_timeoffapprovalrequiredname] NVARCHAR(255),
		[msdyn_warehouse] UNIQUEIDENTIFIER,
		[msdyn_warehousename] NVARCHAR(100),
		[name] NVARCHAR(100),
		[overriddencreatedon] DATETIME,
		[ovs_badgenumber] NVARCHAR(100),
		[ovs_registeredinspectornumberrin] NVARCHAR(100),
		[ownerid] UNIQUEIDENTIFIER,
		[owneridname] NVARCHAR(200),
		[owneridtype] NVARCHAR(64),
		[owneridyominame] NVARCHAR(200),
		[owningbusinessunit] UNIQUEIDENTIFIER,
		[owningteam] UNIQUEIDENTIFIER,
		[owninguser] UNIQUEIDENTIFIER,
		[processid] UNIQUEIDENTIFIER,
		[resourcetype] INT,
		[resourcetypename] NVARCHAR(255),
		[stageid] UNIQUEIDENTIFIER,
		[statecode] INT,
		[statecodename] NVARCHAR(255),
		[statuscode] INT,
		[statuscodename] NVARCHAR(255),
		[timezone] INT,
		[timezoneruleversionnumber] INT,
		[transactioncurrencyid] UNIQUEIDENTIFIER,
		[transactioncurrencyidname] NVARCHAR(100),
		[traversedpath] NVARCHAR(1250),
		[userid] UNIQUEIDENTIFIER,
		[useridname] NVARCHAR(200),
		[useridyominame] NVARCHAR(200),
		[utcconversiontimezonecode] INT,
		[versionnumber] BIGINT
	) ON [PRIMARY]


	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[17_BOOKABLE_RESOURCE_CATEGORIES]') AND type in (N'U'))
	DROP TABLE [dbo].[17_BOOKABLE_RESOURCE_CATEGORIES]


	CREATE TABLE [17_BOOKABLE_RESOURCE_CATEGORIES] (
		[bookableresourcecategoryid] UNIQUEIDENTIFIER,
		[createdby] UNIQUEIDENTIFIER,
		[createdbyname] NVARCHAR(200),
		[createdbyyominame] NVARCHAR(200),
		[createdon] DATETIME,
		[createdonbehalfby] UNIQUEIDENTIFIER,
		[createdonbehalfbyname] NVARCHAR(200),
		[createdonbehalfbyyominame] NVARCHAR(200),
		[description] NVARCHAR(100),
		[exchangerate] NUMERIC(38, 10),
		[importsequencenumber] INT,
		[modifiedby] UNIQUEIDENTIFIER,
		[modifiedbyname] NVARCHAR(200),
		[modifiedbyyominame] NVARCHAR(200),
		[modifiedon] DATETIME,
		[modifiedonbehalfby] UNIQUEIDENTIFIER,
		[modifiedonbehalfbyname] NVARCHAR(200),
		[modifiedonbehalfbyyominame] NVARCHAR(200),
		[name] NVARCHAR(100),
		[overriddencreatedon] DATETIME,
		[ownerid] UNIQUEIDENTIFIER,
		[owneridname] NVARCHAR(200),
		[owneridtype] NVARCHAR(64),
		[owneridyominame] NVARCHAR(200),
		[owningbusinessunit] UNIQUEIDENTIFIER,
		[owningteam] UNIQUEIDENTIFIER,
		[owninguser] UNIQUEIDENTIFIER,
		[statecode] INT,
		[statecodename] NVARCHAR(255),
		[statuscode] INT,
		[statuscodename] NVARCHAR(255),
		[timezoneruleversionnumber] INT,
		[transactioncurrencyid] UNIQUEIDENTIFIER,
		[transactioncurrencyidname] NVARCHAR(100),
		[utcconversiontimezonecode] INT,
		[versionnumber] BIGINT
	) ON [PRIMARY]



	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[18_BOOKABLE_RESOURCE_CATEGORY_ASSN]') AND type in (N'U'))
	DROP TABLE [dbo].[18_BOOKABLE_RESOURCE_CATEGORY_ASSN]


	CREATE TABLE [18_BOOKABLE_RESOURCE_CATEGORY_ASSN] (
		[bookableresourcecategoryassnid] UNIQUEIDENTIFIER,
		[createdby] UNIQUEIDENTIFIER,
		[createdbyname] NVARCHAR(200),
		[createdbyyominame] NVARCHAR(200),
		[createdon] DATETIME,
		[createdonbehalfby] UNIQUEIDENTIFIER,
		[createdonbehalfbyname] NVARCHAR(200),
		[createdonbehalfbyyominame] NVARCHAR(200),
		[exchangerate] NUMERIC(38, 10),
		[importsequencenumber] INT,
		[modifiedby] UNIQUEIDENTIFIER,
		[modifiedbyname] NVARCHAR(200),
		[modifiedbyyominame] NVARCHAR(200),
		[modifiedon] DATETIME,
		[modifiedonbehalfby] UNIQUEIDENTIFIER,
		[modifiedonbehalfbyname] NVARCHAR(200),
		[modifiedonbehalfbyyominame] NVARCHAR(200),
		[name] NVARCHAR(100),
		[overriddencreatedon] DATETIME,
		[ownerid] UNIQUEIDENTIFIER,
		[owneridname] NVARCHAR(200),
		[owneridtype] NVARCHAR(64),
		[owneridyominame] NVARCHAR(200),
		[owningbusinessunit] UNIQUEIDENTIFIER,
		[owningteam] UNIQUEIDENTIFIER,
		[owninguser] UNIQUEIDENTIFIER,
		[resource] UNIQUEIDENTIFIER,
		[resourcecategory] UNIQUEIDENTIFIER,
		[resourcecategoryname] NVARCHAR(100),
		[resourcename] NVARCHAR(100),
		[statecode] INT,
		[statecodename] NVARCHAR(255),
		[statuscode] INT,
		[statuscodename] NVARCHAR(255),
		[timezoneruleversionnumber] INT,
		[transactioncurrencyid] UNIQUEIDENTIFIER,
		[transactioncurrencyidname] NVARCHAR(100),
		[utcconversiontimezonecode] INT,
		[versionnumber] BIGINT
	)



	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[19_IIS_INSPECTIONS]') AND type in (N'U'))
	DROP TABLE [dbo].[19_IIS_INSPECTIONS]


	CREATE TABLE [19_IIS_INSPECTIONS]
	(
	 [MONTH] int
	 ,[YEAR] int 
	 ,FILE_NUMBER_NUM nvarchar (200)
	 ,FILE_STATUS_ETXT varchar (50)
	 ,FILE_STATUS_FTXT varchar (50)
	 ,ACTIVITY_DATE_DTE datetime 
	 ,ACTIVITY_ID numeric 
	 ,STAKEHOLDER_ID numeric 
	 ,id uniqueidentifier 
	 ,ovs_iisid nvarchar (50)
	 ,INSPECTION_REASON_ETXT varchar (250)
	 ,INSPECTION_REASON_FTXT varchar (250)
 
	 ,ACTIVITY_TYPE_CD varchar (250) 
	 ,ACTIVITY_TYPE_ENM varchar (500)
	 ,SUBACTIVITY_TYPE_CDS varchar (250) 
	 ,SUBACTIVITY_TYPE_ENMS varchar (500)

	 ,PRIMARY_INSPECTOR nvarchar (200)
	 ,PRIMARY_INSPECTOR_ID numeric 
	 ,PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID uniqueidentifier 
	 ,PRIMARY_INSPECTOR_USER_ID uniqueidentifier
	 ,SECONDARY_INSPECTOR nvarchar (200)
	 ,SECONDARY_INSPECTOR_ID numeric 
	 ,SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID uniqueidentifier
	 ,SECONDARY_INSPECTOR_USER_ID uniqueidentifier
	);



	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[21_TYRATIONAL]') AND type in (N'U'))
	DROP TABLE [dbo].[21_TYRATIONAL]


	CREATE TABLE [dbo].[21_TYRATIONAL] (
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



	/****** Object:  Table [dbo].[21_TYRATIONAL]    Script Date: 4/23/2021 12:20:19 PM ******/
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[22_OVERSIGHTTYPE]') AND type in (N'U'))
	DROP TABLE [dbo].[22_OVERSIGHTTYPE]


	CREATE TABLE [dbo].[22_OVERSIGHTTYPE](
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




	/****** Object:  Table [dbo].[23_TERRITORY]    Script Date: 4/23/2021 12:39:57 PM ******/
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[23_TERRITORY]') AND type in (N'U'))
	DROP TABLE [dbo].[23_TERRITORY]



	CREATE TABLE [dbo].[23_TERRITORY] (
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
	)



	/****** Object:  Table [dbo].[24_WORKORDERTYPE]    Script Date: 4/23/2021 1:43:19 PM ******/
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[24_WORKORDERTYPE]') AND type in (N'U'))
	DROP TABLE [dbo].[24_WORKORDERTYPE]


	CREATE TABLE [dbo].[24_WORKORDERTYPE](
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


	--INSERT MASTER DATA
	--===================================================================================================
	--===================================================================================================
BEGIN
	 --DEFAULT MASTER DATA
	DECLARE @CONST_WORKORDERTYPE_INSPECTION           VARCHAR(50) = 'b1ee680a-7cf7-ea11-a815-000d3af3a7a7';
	DECLARE @CONST_OVERSIGHTTYPE_GCTARGETED           VARCHAR(50) = '50D0BDF1-269E-EB11-B1AC-000D3AE924D1';
	DECLARE @CONST_OVERSIGHTTYPE_MOCTARGETED          VARCHAR(50) = '864BAA27-279E-EB11-B1AC-000D3AE924D1';
	DECLARE @CONST_OVERSIGHTTYPE_GCCONSIGNMENT        VARCHAR(50) = '460B6C2A-5F9C-EB11-B1AC-000D3AE92708';
	DECLARE @CONST_OVERSIGHTTYPE_MOCOPPORTUNITY       VARCHAR(50) = 'F6A0B96E-5F9C-EB11-B1AC-000D3AE92708';
	DECLARE @CONST_OVERSIGHTTYPE_CIVDOCREVIEW         VARCHAR(50) = 'A4965081-5F9C-EB11-B1AC-000D3AE92708';
	DECLARE @CONST_OVERSIGHTTYPE_RATIONALE_PLANNED    VARCHAR(50) = '994c3ec1-c104-eb11-a813-000d3af3a7a7';
	DECLARE @CONST_OVERSIGHTTYPE_RATIONALE_UNPLANNED  VARCHAR(50) = '47f438c7-c104-eb11-a813-000d3af3a7a7';
	DECLARE @CONST_TDGCORE_BOOKABLE_RESOURCE_ID       VARCHAR(50) = '2cfc9150-d6a3-eb11-b1ac-000d3ae8bee7';
	DECLARE @CONST_TDGCORE_USERID                     VARCHAR(50) = '53275569-d460-eb11-a812-000d3ae947a6';
	DECLARE @CONST_TDGCORE_DOMAINNAME                 VARCHAR(50) = 'tdg.core@034gc.onmicrosoft.com';
	DECLARE @CONST_TDG_TEAMID                         VARCHAR(50) = 'd0483132-b964-eb11-a812-000d3af38846';
	DECLARE @CONST_TDG_TEAMNAME                       VARCHAR(50) = 'Transportation of Dangerous Goods';
	DECLARE @CONST_TDG_BUSINESSUNITID                 VARCHAR(50) = '4E122E0C-73F3-EA11-A815-000D3AF3AC0D';
	DECLARE @CONST_PRICELISTID                        VARCHAR(50) = 'B92B6A16-7CF7-EA11-A815-000D3AF3A7A7'; 
	DECLARE @CONST_RATIONALE_PLANNED                  VARCHAR(50) = '994C3EC1-C104-EB11-A813-000D3AF3A7A7';
	DECLARE @CONST_RATIONALE_UNPLANNED                VARCHAR(50) = '47F438C7-C104-EB11-A813-000D3AF3A7A7';

	INSERT INTO [dbo].[21_TYRATIONAL]
			   ([Id]
		 ,[ovs_tyrationalid]
			   ,[ovs_name]
			   ,[ovs_rationalelbl]
			   ,[ovs_rationalflbl]
			   ,[ownerid]
			   ,[owneridtype]
			   ,[owningbusinessunit]
			   ,[owningteam]
	   )
	SELECT @CONST_RATIONALE_PLANNED [Id], @CONST_RATIONALE_PLANNED  [ovs_tyrationalid], 'Planned::Planifi�' [ovs_name], 'Planned' [ovs_rationalelbl], 'Planifi�' [ovs_rationalflbl],
	  @CONST_TDG_TEAMID [ownerid], 'team' [owneridtype], @CONST_TDG_BUSINESSUNITID [owningbusinessunit], @CONST_TDG_TEAMID [owningteam]

	UNION

	SELECT @CONST_RATIONALE_UNPLANNED [Id], @CONST_RATIONALE_UNPLANNED  [ovs_tyrationalid], 'Unplanned::Non planifi�' [ovs_name], 'Unplanned' [ovs_rationalelbl], 'Non planifi�' [ovs_rationalflbl], 
	  @CONST_TDG_TEAMID [ownerid], 'team' [owneridtype], @CONST_TDG_BUSINESSUNITID [owningbusinessunit], @CONST_TDG_TEAMID [owningteam];   

	INSERT INTO [dbo].[22_OVERSIGHTTYPE]
			   ([Id]
			   ,[ovs_oversighttypeid]
			   ,[ovs_name]
			   ,[ovs_oversighttypenameenglish]
			   ,[ovs_oversighttypenamefrench]
			   ,[ownerid]
			   ,[owneridtype]
			   ,[owningbusinessunit]
			   ,[owningteam])

	SELECT '72afccd3-269e-eb11-b1ac-000d3ae924d1', '72afccd3-269e-eb11-b1ac-000d3ae924d1', 'GC IPT::GC IPT (FR)'           , 'GC IPT'                        , 'GC IPT (FR)'                       , @CONST_TDG_TEAMID [ownerid], 'team' [owneridtype], @CONST_TDG_BUSINESSUNITID [owningbusinessunit], @CONST_TDG_TEAMID [owningteam] UNION
	SELECT 'abf3c4d9-269e-eb11-b1ac-000d3ae924d1', 'abf3c4d9-269e-eb11-b1ac-000d3ae924d1', 'GC CEP::GC IPT (FR)'           , 'GC IPT'                        , 'GC IPT (FR)'                       , @CONST_TDG_TEAMID [ownerid], 'team' [owneridtype], @CONST_TDG_BUSINESSUNITID [owningbusinessunit], @CONST_TDG_TEAMID [owningteam] UNION
	SELECT @CONST_OVERSIGHTTYPE_GCTARGETED       , @CONST_OVERSIGHTTYPE_GCTARGETED       , 'GC Targeted::GC Targeted (FR)' , 'GC Targeted'                   , 'GC Targeted (FR)'                  , @CONST_TDG_TEAMID [ownerid], 'team' [owneridtype], @CONST_TDG_BUSINESSUNITID [owningbusinessunit], @CONST_TDG_TEAMID [owningteam] UNION
	SELECT '1cd7bd09-279e-eb11-b1ac-000d3ae924d1', '1cd7bd09-279e-eb11-b1ac-000d3ae924d1', 'GC Follow-up'                  , 'GC Follow-up'                  , 'GC Follow-up (FR)'                 , @CONST_TDG_TEAMID [ownerid], 'team' [owneridtype], @CONST_TDG_BUSINESSUNITID [owningbusinessunit], @CONST_TDG_TEAMID [owningteam] UNION
	SELECT 'e99ab21b-279e-eb11-b1ac-000d3ae924d1', 'e99ab21b-279e-eb11-b1ac-000d3ae924d1', 'MOC Facility IPT'              , 'MOC Facility IPT'              , 'MOC Facility IPT (FR)'             , @CONST_TDG_TEAMID [ownerid], 'team' [owneridtype], @CONST_TDG_BUSINESSUNITID [owningbusinessunit], @CONST_TDG_TEAMID [owningteam] UNION
	SELECT @CONST_OVERSIGHTTYPE_MOCTARGETED      , @CONST_OVERSIGHTTYPE_MOCTARGETED      , 'MOC Facility Targeted'         , 'MOC Facility Targeted'         , 'MOC Facility Targeted (FR)'        , @CONST_TDG_TEAMID [ownerid], 'team' [owneridtype], @CONST_TDG_BUSINESSUNITID [owningbusinessunit], @CONST_TDG_TEAMID [owningteam] UNION
	SELECT 'c1e09a33-279e-eb11-b1ac-000d3ae924d1', 'c1e09a33-279e-eb11-b1ac-000d3ae924d1', 'MOC Facility Follow-up'        , 'MOC Facility Follow-up'        , 'MOC Facility Follow-up (FR)'       , @CONST_TDG_TEAMID [ownerid], 'team' [owneridtype], @CONST_TDG_BUSINESSUNITID [owningbusinessunit], @CONST_TDG_TEAMID [owningteam] UNION
	SELECT '9dee7316-5f9c-eb11-b1ac-000d3ae92708', '9dee7316-5f9c-eb11-b1ac-000d3ae92708', 'GC Triggered'                  , 'GC Triggered'                  , 'GC Triggered(FR)'                  , @CONST_TDG_TEAMID [ownerid], 'team' [owneridtype], @CONST_TDG_BUSINESSUNITID [owningbusinessunit], @CONST_TDG_TEAMID [owningteam] UNION
	SELECT '07966e1c-5f9c-eb11-b1ac-000d3ae92708', '07966e1c-5f9c-eb11-b1ac-000d3ae92708', 'GC Opportunity'                , 'GC Opportunity'                , 'GC Opportunity(FR)'                , @CONST_TDG_TEAMID [ownerid], 'team' [owneridtype], @CONST_TDG_BUSINESSUNITID [owningbusinessunit], @CONST_TDG_TEAMID [owningteam] UNION
	SELECT @CONST_OVERSIGHTTYPE_GCCONSIGNMENT    , @CONST_OVERSIGHTTYPE_GCCONSIGNMENT    , 'GC Consignment'                , 'GC Consignment'                , 'GC Consignment(FR)'                , @CONST_TDG_TEAMID [ownerid], 'team' [owneridtype], @CONST_TDG_BUSINESSUNITID [owningbusinessunit], @CONST_TDG_TEAMID [owningteam] UNION
	SELECT '1cc06b3f-5f9c-eb11-b1ac-000d3ae92708', '1cc06b3f-5f9c-eb11-b1ac-000d3ae92708', 'GC Undeclared/ Misdeclared'    , 'GC Undeclared/ Misdeclared'    , 'GC Undeclared/ Misdeclared(FR)'    , @CONST_TDG_TEAMID [ownerid], 'team' [owneridtype], @CONST_TDG_BUSINESSUNITID [owningbusinessunit], @CONST_TDG_TEAMID [owningteam] UNION
	SELECT 'ea95bc68-5f9c-eb11-b1ac-000d3ae92708', 'ea95bc68-5f9c-eb11-b1ac-000d3ae92708', 'MOC Facility Triggered'        , 'MOC Facility Triggered'        , 'MOC Facility Triggered(FR)'        , @CONST_TDG_TEAMID [ownerid], 'team' [owneridtype], @CONST_TDG_BUSINESSUNITID [owningbusinessunit], @CONST_TDG_TEAMID [owningteam] UNION
	SELECT @CONST_OVERSIGHTTYPE_MOCOPPORTUNITY   , @CONST_OVERSIGHTTYPE_MOCOPPORTUNITY   , 'MOC Facility Opportunity'      , 'MOC Facility Opportunity'      , 'MOC Facility Opportunity(FR)'      , @CONST_TDG_TEAMID [ownerid], 'team' [owneridtype], @CONST_TDG_BUSINESSUNITID [owningbusinessunit], @CONST_TDG_TEAMID [owningteam] UNION
	SELECT @CONST_OVERSIGHTTYPE_CIVDOCREVIEW     , @CONST_OVERSIGHTTYPE_CIVDOCREVIEW     , 'Civil Aviation Document Review', 'Civil Aviation Document Review', 'Civil Aviation Document Review(FR)', @CONST_TDG_TEAMID [ownerid], 'team' [owneridtype], @CONST_TDG_BUSINESSUNITID [owningbusinessunit], @CONST_TDG_TEAMID [owningteam];

	UPDATE [22_OVERSIGHTTYPE] SET [ovs_name] = CONCAT(ovs_oversighttypenameenglish, '::', ovs_oversighttypenamefrench);

	INSERT INTO [dbo].[24_WORKORDERTYPE]
			   ([Id]
			   ,[msdyn_workordertypeid]
			   ,[msdyn_name]
			   ,[msdyn_pricelist]
			   ,[ovs_workordertypenameenglish]
			   ,[ovs_workordertypenamefrench]
			   ,[ownerid]
			   ,[owneridtype]
			   ,[owningbusinessunit]
			   ,[owningteam])

	SELECT @CONST_WORKORDERTYPE_INSPECTION       , @CONST_WORKORDERTYPE_INSPECTION			, 'Inspection::Inspection'	, @CONST_PRICELISTID, 'Inspection'				, 'FR Inspection'				, @CONST_TDG_TEAMID [ownerid], 'team' [owneridtype], @CONST_TDG_BUSINESSUNITID [owningbusinessunit], @CONST_TDG_TEAMID [owningteam] UNION
	SELECT '46706c0a-ad60-eb11-a812-000d3ae9471c', '46706c0a-ad60-eb11-a812-000d3ae9471c'	, 'Regulatory Authorization', @CONST_PRICELISTID, 'Regulatory Authorization', 'FR Regulatory Authorization'	, @CONST_TDG_TEAMID [ownerid], 'team' [owneridtype], @CONST_TDG_BUSINESSUNITID [owningbusinessunit], @CONST_TDG_TEAMID [owningteam];

	UPDATE [24_WORKORDERTYPE] SET [msdyn_name] = CONCAT([ovs_workordertypenameenglish], '::', [ovs_workordertypenamefrench]);

	INSERT INTO [dbo].[17_BOOKABLE_RESOURCE_CATEGORIES]
			   ([bookableresourcecategoryid]
			   ,[description]
			   ,[name]
			   ,[ownerid]
			   ,[owneridtype]
			   ,[owningbusinessunit]
			   ,[owningteam])

	SELECT 
	'06DB6E56-01F9-EA11-A815-000D3AF3AC0D', --INSPECTOR 
	'Mark a Bookable Resource as an Inspector',
	'Inspector::Inspecteur',
	ownerid = @CONST_TDG_TEAMID,
	owneridtype = 'team',
	owningbusinessunit = @CONST_TDG_BUSINESSUNITID,
	owningteam = @CONST_TDG_TEAMID;   

	INSERT INTO [dbo].[12_BOOKABLE_RESOURCE]
			   (
		  bookableresourceid
		  ,[userid]
		  ,[name]
		  ,[msdyn_primaryemail]
		  ,[ovs_registeredinspectornumberrin]
		  ,[ovs_badgenumber]
	   )

	SELECT 
	@CONST_TDGCORE_BOOKABLE_RESOURCE_ID [bookableresourceid], --tdg core bookable resource id
	@CONST_TDGCORE_USERID [userid], -- tdg core system user id
	'TDG Core'          [name],
	@CONST_TDGCORE_DOMAINNAME       [msdyn_primaryemail],
	'1337' [ovs_registeredinspectornumberrin],
	'1337' [ovs_badgenumber];


	--COUNTRY_SUBDIVISION_CD msdyn_serviceterritory
	--AB 02B86E9E-1707-EB11-A813-000D3AF3A0D7
	--MB 02B86E9E-1707-EB11-A813-000D3AF3A0D7
	--SK 02B86E9E-1707-EB11-A813-000D3AF3A0D7
	--NU 02B86E9E-1707-EB11-A813-000D3AF3A0D7
	--NT 02B86E9E-1707-EB11-A813-000D3AF3A0D7
	--YT 02B86E9E-1707-EB11-A813-000D3AF3A0D7
	--NL FAB76E9E-1707-EB11-A813-000D3AF3A0D7
	--PE FAB76E9E-1707-EB11-A813-000D3AF3A0D7
	--NS FAB76E9E-1707-EB11-A813-000D3AF3A0D7
	--NB FAB76E9E-1707-EB11-A813-000D3AF3A0D7
	--QC FCB76E9E-1707-EB11-A813-000D3AF3A0D7
	--ON 50B21A84-DB04-EB11-A813-000D3AF3AC0D
	--BC FEB76E9E-1707-EB11-A813-000D3AF3A0D7

	INSERT [dbo].[23_TERRITORY] ([Id], [territoryid], [name], [ovs_territorynameenglish], [ovs_territorynamefrench]) 

	SELECT N'2e7b2f75-989c-eb11-b1ac-000d3ae92708', N'2e7b2f75-989c-eb11-b1ac-000d3ae92708', N'HQ-ES::FR HQ-ES'                          ,        N'HQ-ES'          ,     N'FR HQ-ES'        UNION
	SELECT N'52c72783-989c-eb11-b1ac-000d3ae92708', N'52c72783-989c-eb11-b1ac-000d3ae92708', N'HQ-CR::FR HQ-CR'                          ,        N'HQ-CR'          ,     N'FR HQ-CR'        UNION
	SELECT N'FAB76E9E-1707-EB11-A813-000D3AF3A0D7', N'FAB76E9E-1707-EB11-A813-000D3AF3A0D7', N'Atlantic::Atlantique'                     ,      N'Atlantic'         ,    N'Atlantique'       UNION
	SELECT N'FCB76E9E-1707-EB11-A813-000D3AF3A0D7', N'FCB76E9E-1707-EB11-A813-000D3AF3A0D7', N'Quebec::Qu�bec'                           ,        N'Quebec'         ,     N'Qu�bec'          UNION
	SELECT N'FEB76E9E-1707-EB11-A813-000D3AF3A0D7', N'FEB76E9E-1707-EB11-A813-000D3AF3A0D7', N'Pacific::Pacifique'                       ,       N'Pacific'         ,     N'Pacifique'       UNION
	SELECT N'02B86E9E-1707-EB11-A813-000D3AF3A0D7', N'02B86E9E-1707-EB11-A813-000D3AF3A0D7', N'Prairie and Northern::Prairies et du Nord', N'Prairie and Northern'  , N'Prairies et du Nord' UNION
	SELECT N'04b86e9e-1707-eb11-a813-000d3af3a0d7', N'04b86e9e-1707-eb11-a813-000d3af3a0d7', N'National Capital::Capitale Nationale'     ,  N'National Capital'     ,  N'Capitale Nationale' UNION 
	SELECT N'50B21A84-DB04-EB11-A813-000D3AF3AC0D', N'50B21A84-DB04-EB11-A813-000D3AF3AC0D', N'Ontario::Ontario'                         ,       N'Ontario'         ,     N'Ontario';
END


	--BOOKABLE RESOURCES
	--===================================================================================================
	--===================================================================================================
BEGIN
	INSERT INTO [dbo].[12_BOOKABLE_RESOURCE] (bookableresourceid, [userid], [name], [msdyn_primaryemail], [ovs_registeredinspectornumberrin], [ovs_badgenumber])

	SELECT * 
	FROM
	(
		 SELECT newid() bookableresourceid, SYSUSER.systemuserid, CONCAT(SYSUSER.firstname, ' ', SYSUSER.lastname) name, domainname, RIN, BADGE--, SYSUSER.isdisabled, SYSUSER.islicensed, SYSUSER.issyncwithdirectory, SYSUSER.territoryid
		 FROM [dbo].systemuser SYSUSER 
		 JOIN [16_IIS_INSPECTORS] INSP ON 
		 lower(TRIM(INSP.Account_name)) = lower(TRIM(SYSUSER.domainname))
	) T

	UPDATE [dbo].[12_BOOKABLE_RESOURCE]
	SET 
	owningbusinessunit                 = @CONST_TDG_BUSINESSUNITID,
	owneridtype                        = 'team',
	ownerid                            = @CONST_TDG_TEAMID,
	owningteam                         = @CONST_TDG_TEAMID,
	resourcetype                       = 3,
	statecode                          = 0,
	statuscode                         = 1,
	msdyn_derivecapacity               = 0,
	msdyn_displayonscheduleassistant   = 1,
	msdyn_displayonscheduleboard       = 1,
	msdyn_enabledforfieldservicemobile = 1,
	msdyn_enabledripscheduling         = 0,
	msdyn_endlocation                  = 690970002,                 --location agnostic
	msdyn_startlocation                = 690970002,                 --location agnostic
	msdyn_timeoffapprovalrequired      = 0;


	INSERT INTO [18_BOOKABLE_RESOURCE_CATEGORY_ASSN]
	(resource, resourcecategory, statecode, statuscode, owningbusinessunit, owneridtype, ownerid , owningteam)

	SELECT 
	bookableresourceid, 
	resourcecategory   = '06DB6E56-01F9-EA11-A815-000D3AF3AC0D', --INSPECTOR
	statecode          = 0,
	statuscode         = 1,
	owningbusinessunit = @CONST_TDG_BUSINESSUNITID,
	owneridtype        = 'team',
	ownerid            = @CONST_TDG_TEAMID,
	owningteam         = @CONST_TDG_TEAMID
	FROM [dbo].[12_BOOKABLE_RESOURCE]; 
END


--===================================================================================================
--===================================================================================================
--RUN MASTER DATA SSIS PACKAGE AFTER THIS
--KINGSWAYSOFT - SqlToCrm.dtsx
--===================================================================================================
--===================================================================================================


--WAIT UNTIL BOOKABLE RESOURCES ARE SYNCED WITH CRM
SELECT fullname, domainname FROM [dbo].[12_BOOKABLE_RESOURCE] BR
JOIN [dbo].bookableresource CRMBR ON BR.bookableresourceid = CRMBR.bookableresourceid
JOIN [dbo].[systemuser] SYSUSER ON BR.userid = SYSUSER.systemuserid 