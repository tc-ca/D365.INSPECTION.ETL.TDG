
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[02_REGULATED_ENTITIES]') AND type in (N'U'))
DROP TABLE [dbo].[02_REGULATED_ENTITIES]
GO
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
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[03_SITES]') AND type in (N'U'))
DROP TABLE [dbo].[03_SITES]
GO
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

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[04_ACCOUNT]') AND type in (N'U'))
DROP TABLE [dbo].[04_ACCOUNT]
GO

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
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[06_WORK_ORDERS]') AND type in (N'U'))
DROP TABLE [dbo].[06_WORK_ORDERS]
GO

CREATE TABLE [dbo].[06_WORK_ORDERS] (

createdby	UNIQUEIDENTIFIER							  null,
createdbyname	NVARCHAR (200)							  null,
createdbyyominame	NVARCHAR (200)						  null,
createdon	DATETIME									  null,
createdonbehalfby	UNIQUEIDENTIFIER					  null,
createdonbehalfbyname	NVARCHAR (200)					  null,
createdonbehalfbyyominame	NVARCHAR (200)				  null,
exchangerate	NUMERIC (38, 10)						  null,
importsequencenumber	INT								  null,
modifiedby	UNIQUEIDENTIFIER							  null,
modifiedbyname	NVARCHAR (200)							  null,
modifiedbyyominame	NVARCHAR (200)						  null,
modifiedon	DATETIME									  null,
modifiedonbehalfby	UNIQUEIDENTIFIER					  null,
modifiedonbehalfbyname	NVARCHAR (200)					  null,
modifiedonbehalfbyyominame	NVARCHAR (200)				  null,
msdyn_address1	NVARCHAR (250)							  null,
msdyn_address2	NVARCHAR (250)							  null,
msdyn_address3	NVARCHAR (250)							  null,
msdyn_addressname	NVARCHAR (250)						  null,
msdyn_agreement	UNIQUEIDENTIFIER						  null,
msdyn_agreementname	NVARCHAR (100)						  null,
msdyn_autonumbering	NVARCHAR (100)						  null,
msdyn_billingaccount	UNIQUEIDENTIFIER				  null,
msdyn_billingaccountname	NVARCHAR (160)				  null,
msdyn_billingaccountyominame	NVARCHAR (160)			  null,
msdyn_bookingsummary	ntext							  null,
msdyn_childindex	INT									  null,
msdyn_city	NVARCHAR (80)								  null,
msdyn_closedby	UNIQUEIDENTIFIER						  null,
msdyn_closedbyname	NVARCHAR (200)						  null,
msdyn_closedbyyominame	NVARCHAR (200)					  null,
msdyn_completedon	DATETIME							  null,
msdyn_country	NVARCHAR (80)							  null,
msdyn_customerasset	UNIQUEIDENTIFIER					  null,
msdyn_customerassetname	NVARCHAR (100)					  null,
msdyn_datewindowend	DATETIME							  null,
msdyn_datewindowstart	DATETIME						  null,
msdyn_estimatesubtotalamount	NUMERIC (38, 2)			  null,
msdyn_estimatesubtotalamount_base	NUMERIC (38, 2)		  null,
msdyn_firstarrivedon	DATETIME						  null,
msdyn_followupnote	ntext								  null,
msdyn_followuprequired	bit								  null,
msdyn_followuprequiredname	NVARCHAR (255)				  null,
msdyn_functionallocation	UNIQUEIDENTIFIER			  null,
msdyn_functionallocationname	NVARCHAR (60)			  null,
msdyn_instructions	ntext								  null,
msdyn_internalflags	ntext								  null,
msdyn_iotalert	UNIQUEIDENTIFIER						  null,
msdyn_iotalertname	NVARCHAR (100)						  null,
msdyn_isfollowup	bit									  null,
msdyn_isfollowupname	NVARCHAR (255)					  null,
msdyn_ismobile	bit										  null,
msdyn_ismobilename	NVARCHAR (255)						  null,
msdyn_latitude	FLOAT									  null,
msdyn_longitude	FLOAT									  null,
msdyn_mapcontrol	NVARCHAR (100)						  null,
msdyn_name	NVARCHAR (100)								  null,
msdyn_opportunityid	UNIQUEIDENTIFIER					  null,
msdyn_opportunityidname	NVARCHAR (300)					  null,
msdyn_parentworkorder	UNIQUEIDENTIFIER				  null,
msdyn_parentworkordername	NVARCHAR (100)				  null,
msdyn_postalcode	NVARCHAR (20)						  null,
msdyn_preferredresource	UNIQUEIDENTIFIER				  null,
msdyn_preferredresourcename	NVARCHAR (100)				  null,
msdyn_pricelist	UNIQUEIDENTIFIER						  null,
msdyn_pricelistname	NVARCHAR (100)						  null,
msdyn_primaryincidentdescription	ntext				  null,
msdyn_primaryincidentestimatedduration	INT				  null,
msdyn_primaryincidenttype	UNIQUEIDENTIFIER			  null,
msdyn_primaryincidenttypename	NVARCHAR (100)			  null,
msdyn_priority	UNIQUEIDENTIFIER						  null,
msdyn_priorityname	NVARCHAR (100)						  null,
msdyn_reportedbycontact	UNIQUEIDENTIFIER				  null,
msdyn_reportedbycontactname	NVARCHAR (160)				  null,
msdyn_reportedbycontactyominame	NVARCHAR (450)			  null,
msdyn_serviceaccount	UNIQUEIDENTIFIER				  null,
msdyn_serviceaccountname	NVARCHAR (160)				  null,
msdyn_serviceaccountyominame	NVARCHAR (160)			  null,
msdyn_servicerequest	UNIQUEIDENTIFIER				  null,
msdyn_servicerequestname	NVARCHAR (200)				  null,
msdyn_serviceterritory	UNIQUEIDENTIFIER				  null,
msdyn_serviceterritoryname	NVARCHAR (200)				  null,
msdyn_stateorprovince	NVARCHAR (50)					  null,
msdyn_substatus	UNIQUEIDENTIFIER						  null,
msdyn_substatusname	NVARCHAR (100)						  null,
msdyn_subtotalamount	NUMERIC (38, 2)					  null,
msdyn_subtotalamount_base	NUMERIC (38, 2)				  null,
msdyn_supportcontact	UNIQUEIDENTIFIER				  null,
msdyn_supportcontactname	NVARCHAR (100)				  null,
msdyn_systemstatus	INT									  null,
msdyn_systemstatusname	NVARCHAR (255)					  null,
msdyn_taxable	bit										  null,
msdyn_taxablename	NVARCHAR (255)						  null,
msdyn_taxcode	UNIQUEIDENTIFIER						  null,
msdyn_taxcodename	NVARCHAR (100)						  null,
msdyn_timeclosed	DATETIME							  null,
msdyn_timefrompromised	DATETIME						  null,
msdyn_timegroup	UNIQUEIDENTIFIER						  null,
msdyn_timegroupdetailselected	UNIQUEIDENTIFIER		  null,
msdyn_timegroupdetailselectedname	NVARCHAR (100)		  null,
msdyn_timegroupname	NVARCHAR (100)						  null,
msdyn_timetopromised	DATETIME						  null,
msdyn_timewindowend	DATETIME							  null,
msdyn_timewindowstart	DATETIME						  null,
msdyn_totalamount	NUMERIC (38, 2)						  null,
msdyn_totalamount_base	NUMERIC (38, 2)					  null,
msdyn_totalestimatedduration	INT						  null,
msdyn_totalsalestax	NUMERIC (38, 2)						  null,
msdyn_totalsalestax_base	NUMERIC (38, 2)				  null,
msdyn_workhourtemplate	UNIQUEIDENTIFIER				  null,
msdyn_workhourtemplatename	NVARCHAR (100)				  null,
msdyn_worklocation	INT									  null,
msdyn_worklocationname	NVARCHAR (255)					  null,
msdyn_workorderarrivaltimekpiid	UNIQUEIDENTIFIER		  null,
msdyn_workorderarrivaltimekpiidname	NVARCHAR (100)		  null,
msdyn_workorderid	UNIQUEIDENTIFIER					  null,
msdyn_workorderresolutionkpiid	UNIQUEIDENTIFIER		  null,
msdyn_workorderresolutionkpiidname	NVARCHAR (100)		  null,
msdyn_workordersummary	ntext							  null,
msdyn_workordertype	UNIQUEIDENTIFIER					  null,
msdyn_workordertypename	NVARCHAR (100)					  null,
overriddencreatedon	DATETIME							  null,
ovs_asset	UNIQUEIDENTIFIER							  null,
ovs_assetcategory	UNIQUEIDENTIFIER					  null,
ovs_assetcategoryname	NVARCHAR (100)					  null,
ovs_assetname	NVARCHAR (100)							  null,
ovs_currentfiscalquarter	UNIQUEIDENTIFIER			  null,
ovs_currentfiscalquartername	NVARCHAR (100)			  null,
ovs_fiscalquarter	UNIQUEIDENTIFIER					  null,
ovs_fiscalquartername	NVARCHAR (100)					  null,
ovs_fiscalyear	UNIQUEIDENTIFIER						  null,
ovs_fiscalyearname	NVARCHAR (100)						  null,
ovs_iisid	NVARCHAR (100)								  null,
ovs_mocid	NVARCHAR (100)								  null,
ovs_operationid	UNIQUEIDENTIFIER						  null,
ovs_operationidname	NVARCHAR (200)						  null,
ovs_operationtypeid	UNIQUEIDENTIFIER					  null,
ovs_operationtypeidname	NVARCHAR (100)					  null,
ovs_oversighttype	UNIQUEIDENTIFIER					  null,
ovs_oversighttypename	NVARCHAR (100)					  null,
ovs_ovscountry	UNIQUEIDENTIFIER						  null,
ovs_ovscountryname	NVARCHAR (100)						  null,
ovs_primaryinspector	UNIQUEIDENTIFIER				  null,
ovs_primaryinspectorname	NVARCHAR (100)				  null,
ovs_rational	UNIQUEIDENTIFIER						  null,
ovs_rationalname	NVARCHAR (100)						  null,
ovs_regulatedentity	UNIQUEIDENTIFIER					  null,
ovs_regulatedentityname	NVARCHAR (160)					  null,
ovs_regulatedentityyominame	NVARCHAR (160)				  null,
ovs_revisedquarterid	UNIQUEIDENTIFIER				  null,
ovs_revisedquarteridname	NVARCHAR (100)				  null,
ovs_rolluptestdeletemeafter	DATETIME					  null,
ovs_rolluptestdeletemeafter_date	DATETIME			  null,
ovs_rolluptestdeletemeafter_state	INT					  null,
ovs_secondaryinspector	UNIQUEIDENTIFIER				  null,
ovs_secondaryinspectorname	NVARCHAR (100)				  null,
ovs_siteofviolation	UNIQUEIDENTIFIER					  null,
ovs_siteofviolationname	NVARCHAR (160)					  null,
ovs_siteofviolationyominame	NVARCHAR (160)				  null,
ovs_tyrational	UNIQUEIDENTIFIER						  null,
ovs_tyrationalname	NVARCHAR (100)						  null,
ownerid	UNIQUEIDENTIFIER								  null,
owneridname	NVARCHAR (200)								  null,
owneridtype	NVARCHAR (64)								  null,
owneridyominame	NVARCHAR (200)							  null,
owningbusinessunit	UNIQUEIDENTIFIER					  null,
owningteam	UNIQUEIDENTIFIER							  null,
owninguser	UNIQUEIDENTIFIER							  null,
processid	UNIQUEIDENTIFIER							  null,
qm_blobpath	NVARCHAR (200)								  null,
qm_remote	bit											  null,
qm_remotename	NVARCHAR (255)							  null,
qm_reportcontactid	UNIQUEIDENTIFIER					  null,
qm_reportcontactidname	NVARCHAR (160)					  null,
qm_reportcontactidyominame	NVARCHAR (450)				  null,
stageid	UNIQUEIDENTIFIER								  null,
statecode	INT											  null,
statecodename	NVARCHAR (255)							  null,
statuscode	INT											  null,
statuscodename	NVARCHAR (255)							  null,
timezoneruleversionnumber	INT							  null,
transactioncurrencyid	UNIQUEIDENTIFIER				  null,
transactioncurrencyidname	NVARCHAR (100)				  null,
traversedpath	NVARCHAR (1250)							  null,
utcconversiontimezonecode	INT							  null,
versionnumber	bigint									  null

) ON [PRIMARY]
GO



/****** Object:  Table [dbo].[07_VIOLATIONS]    Script Date: 4/20/2021 4:03:10 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[07_VIOLATIONS]') AND type in (N'U'))
DROP TABLE [dbo].[07_VIOLATIONS]
GO

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
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[11_CONTACT]') AND type in (N'U'))
DROP TABLE [dbo].[11_CONTACT]
GO

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
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[12_BOOKABLE_RESOURCE]') AND type in (N'U'))
DROP TABLE [dbo].[12_BOOKABLE_RESOURCE]
GO

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
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[17_BOOKABLE_RESOURCE_CATEGORIES]') AND type in (N'U'))
DROP TABLE [dbo].[17_BOOKABLE_RESOURCE_CATEGORIES]
GO

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
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[18_BOOKABLE_RESOURCE_CATEGORY_ASSN]') AND type in (N'U'))
DROP TABLE [dbo].[18_BOOKABLE_RESOURCE_CATEGORY_ASSN]
GO

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
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[21_TYRATIONAL]') AND type in (N'U'))
DROP TABLE [dbo].[21_TYRATIONAL]
GO

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
GO


/****** Object:  Table [dbo].[21_TYRATIONAL]    Script Date: 4/23/2021 12:20:19 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[22_OVERSIGHTTYPE]') AND type in (N'U'))
DROP TABLE [dbo].[22_OVERSIGHTTYPE]
GO

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
GO



/****** Object:  Table [dbo].[23_TERRITORY]    Script Date: 4/23/2021 12:39:57 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[23_TERRITORY]') AND type in (N'U'))
DROP TABLE [dbo].[23_TERRITORY]
GO


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
GO


/****** Object:  Table [dbo].[24_WORKORDERTYPE]    Script Date: 4/23/2021 1:43:19 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[24_WORKORDERTYPE]') AND type in (N'U'))
DROP TABLE [dbo].[24_WORKORDERTYPE]
GO

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
 GO










--insert lookups
--===================================================================================================
--===================================================================================================
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
SELECT	'994c3ec1-c104-eb11-a813-000d3af3a7a7'	[Id],	'994c3ec1-c104-eb11-a813-000d3af3a7a7'  [ovs_tyrationalid],	'Planned::Planifié'	[ovs_name],	'Planned'	[ovs_rationalelbl], 'Planifié'	[ovs_rationalflbl], 
		'd0483132-b964-eb11-a812-000d3af38846'	[ownerid], 'team'	[owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d'	[owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846'	[owningteam]

UNION

SELECT	'47f438c7-c104-eb11-a813-000d3af3a7a7'	[Id],	'47f438c7-c104-eb11-a813-000d3af3a7a7'  [ovs_tyrationalid],	'Unplanned::Non planifié'	[ovs_name],	'Unplanned'	[ovs_rationalelbl],	'Non planifié'	[ovs_rationalflbl], 
		'd0483132-b964-eb11-a812-000d3af38846'	[ownerid],	'team'	[owneridtype],	'4e122e0c-73f3-ea11-a815-000d3af3ac0d'	[owningbusinessunit],	'd0483132-b964-eb11-a812-000d3af38846'	[owningteam];   
GO


TRUNCATE TABLE [22_OVERSIGHTTYPE];

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

SELECT '72afccd3-269e-eb11-b1ac-000d3ae924d1', '72afccd3-269e-eb11-b1ac-000d3ae924d1', 'GC IPT::GC IPT (FR)', 'GC IPT', 'GC IPT (FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT 'abf3c4d9-269e-eb11-b1ac-000d3ae924d1', 'abf3c4d9-269e-eb11-b1ac-000d3ae924d1', 'GC CEP::GC IPT (FR)', 'GC IPT', 'GC IPT (FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT '50d0bdf1-269e-eb11-b1ac-000d3ae924d1', '50d0bdf1-269e-eb11-b1ac-000d3ae924d1', 'GC Targeted::GC Targeted (FR)', 'GC Targeted', 'GC Targeted (FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT '1cd7bd09-279e-eb11-b1ac-000d3ae924d1', '1cd7bd09-279e-eb11-b1ac-000d3ae924d1', 'GC Follow-up', 'GC Follow-up', 'GC Follow-up (FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT 'e99ab21b-279e-eb11-b1ac-000d3ae924d1', 'e99ab21b-279e-eb11-b1ac-000d3ae924d1', 'MOC Facility IPT', 'MOC Facility IPT', 'MOC Facility IPT (FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT '864baa27-279e-eb11-b1ac-000d3ae924d1', '864baa27-279e-eb11-b1ac-000d3ae924d1', 'MOC Facility Targeted', 'MOC Facility Targeted', 'MOC Facility Targeted (FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT 'c1e09a33-279e-eb11-b1ac-000d3ae924d1', 'c1e09a33-279e-eb11-b1ac-000d3ae924d1', 'MOC Facility Follow-up', 'MOC Facility Follow-up', 'MOC Facility Follow-up (FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT '9dee7316-5f9c-eb11-b1ac-000d3ae92708', '9dee7316-5f9c-eb11-b1ac-000d3ae92708', 'GC Triggered', 'GC Triggered', 'GC Triggered(FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT '07966e1c-5f9c-eb11-b1ac-000d3ae92708', '07966e1c-5f9c-eb11-b1ac-000d3ae92708', 'GC Opportunity', 'GC Opportunity', 'GC Opportunity(FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT '460b6c2a-5f9c-eb11-b1ac-000d3ae92708', '460b6c2a-5f9c-eb11-b1ac-000d3ae92708', 'GC Consignment', 'GC Consignment', 'GC Consignment(FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT '1cc06b3f-5f9c-eb11-b1ac-000d3ae92708', '1cc06b3f-5f9c-eb11-b1ac-000d3ae92708', 'GC Undeclared/ Misdeclared', 'GC Undeclared/ Misdeclared', 'GC Undeclared/ Misdeclared(FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT 'ea95bc68-5f9c-eb11-b1ac-000d3ae92708', 'ea95bc68-5f9c-eb11-b1ac-000d3ae92708', 'MOC Facility Triggered', 'MOC Facility Triggered', 'MOC Facility Triggered(FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT 'f6a0b96e-5f9c-eb11-b1ac-000d3ae92708', 'f6a0b96e-5f9c-eb11-b1ac-000d3ae92708', 'MOC Facility Opportunity', 'MOC Facility Opportunity', 'MOC Facility Opportunity(FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT 'a4965081-5f9c-eb11-b1ac-000d3ae92708', 'a4965081-5f9c-eb11-b1ac-000d3ae92708', 'Civil Aviation Document Review', 'Civil Aviation Document Review', 'Civil Aviation Document Review(FR)', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam];

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

SELECT 'b1ee680a-7cf7-ea11-a815-000d3af3a7a7', 'b1ee680a-7cf7-ea11-a815-000d3af3a7a7', 'Inspection::Inspection', 'b92b6a16-7cf7-ea11-a815-000d3af3a7a7', 'Inspection', 'FR Inspection', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam] UNION
SELECT '46706c0a-ad60-eb11-a812-000d3ae9471c', '46706c0a-ad60-eb11-a812-000d3ae9471c', 'Regulatory Authorization', 'b92b6a16-7cf7-ea11-a815-000d3af3a7a7', 'Regulatory Authorization', 'FR Regulatory Authorization', 'd0483132-b964-eb11-a812-000d3af38846' [ownerid], 'team' [owneridtype], '4e122e0c-73f3-ea11-a815-000d3af3ac0d' [owningbusinessunit], 'd0483132-b964-eb11-a812-000d3af38846' [owningteam];

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
ownerid = 'd0483132-b964-eb11-a812-000d3af38846',
owneridtype = 'team',
owningbusinessunit = '4e122e0c-73f3-ea11-a815-000d3af3ac0d',
owningteam = 'd0483132-b964-eb11-a812-000d3af38846';   



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
'2cfc9150-d6a3-eb11-b1ac-000d3ae8bee7' [bookableresourceid], --tdg core bookable resource id
'53275569-d460-eb11-a812-000d3ae947a6' [userid], -- tdg core system user id
'TDG Core'							   [name],
'tdg.core@034gc.onmicrosoft.com'       [msdyn_primaryemail],
'1337' [ovs_registeredinspectornumberrin],
'1337' [ovs_badgenumber];


--COUNTRY_SUBDIVISION_CD	msdyn_serviceterritory
--AB	02B86E9E-1707-EB11-A813-000D3AF3A0D7
--MB	02B86E9E-1707-EB11-A813-000D3AF3A0D7
--SK	02B86E9E-1707-EB11-A813-000D3AF3A0D7
--NU	02B86E9E-1707-EB11-A813-000D3AF3A0D7
--NT	02B86E9E-1707-EB11-A813-000D3AF3A0D7
--YT	02B86E9E-1707-EB11-A813-000D3AF3A0D7
--NL	FAB76E9E-1707-EB11-A813-000D3AF3A0D7
--PE	FAB76E9E-1707-EB11-A813-000D3AF3A0D7
--NS	FAB76E9E-1707-EB11-A813-000D3AF3A0D7
--NB	FAB76E9E-1707-EB11-A813-000D3AF3A0D7
--QC	FCB76E9E-1707-EB11-A813-000D3AF3A0D7
--ON	50B21A84-DB04-EB11-A813-000D3AF3AC0D
--BC	FEB76E9E-1707-EB11-A813-000D3AF3A0D7

INSERT [dbo].[23_TERRITORY] ([Id], [territoryid], [name], [ovs_territorynameenglish], [ovs_territorynamefrench]) 

SELECT N'2e7b2f75-989c-eb11-b1ac-000d3ae92708', N'2e7b2f75-989c-eb11-b1ac-000d3ae92708',	N'HQ-ES::FR HQ-ES',								N'HQ-ES',				 N'FR HQ-ES'			UNION
SELECT N'52c72783-989c-eb11-b1ac-000d3ae92708', N'52c72783-989c-eb11-b1ac-000d3ae92708',	N'HQ-CR::FR HQ-CR',								N'HQ-CR',				 N'FR HQ-CR'			UNION
SELECT N'FAB76E9E-1707-EB11-A813-000D3AF3A0D7',	N'FAB76E9E-1707-EB11-A813-000D3AF3A0D7',	N'Atlantic::Atlantique',						N'Atlantic',			 N'Atlantique'			UNION
SELECT N'FCB76E9E-1707-EB11-A813-000D3AF3A0D7',	N'FCB76E9E-1707-EB11-A813-000D3AF3A0D7',	N'Quebec::Québec',								N'Quebec',				 N'Québec'				UNION
SELECT N'FEB76E9E-1707-EB11-A813-000D3AF3A0D7',	N'FEB76E9E-1707-EB11-A813-000D3AF3A0D7',	N'Pacific::Pacifique',							N'Pacific',				 N'Pacifique'			UNION
SELECT N'02B86E9E-1707-EB11-A813-000D3AF3A0D7',	N'02B86E9E-1707-EB11-A813-000D3AF3A0D7',	N'Prairie and Northern::Prairies et du Nord',	N'Prairie and Northern', N'Prairies et du Nord'	UNION
SELECT N'04b86e9e-1707-eb11-a813-000d3af3a0d7',	N'04b86e9e-1707-eb11-a813-000d3af3a0d7',	N'National Capital::Capitale Nationale',		N'National Capital',	 N'Capitale Nationale'	UNION 
SELECT N'50B21A84-DB04-EB11-A813-000D3AF3AC0D',	N'50B21A84-DB04-EB11-A813-000D3AF3AC0D',	N'Ontario::Ontario',							N'Ontario',				 N'Ontario';
GO


--===================================================================================================
--===================================================================================================



--===================================================================================================
--===================================================================================================
--RUN LOOKUP MIGRATION SSIS PACKAGE W KINGSWAYSOFT SqlToCrm.dtsx
--===================================================================================================
--===================================================================================================



--SANTIY CHECKS
--===================================================================================================
--===================================================================================================
--staging tables should be empty before conversion
SELECT COUNT(*)	[02_REGULATED_ENTITIES]					FROM [dbo].[02_REGULATED_ENTITIES];
SELECT COUNT(*)	[03_SITES]								FROM [dbo].[03_SITES];
SELECT COUNT(*)	[04_ACCOUNT]							FROM [dbo].[04_ACCOUNT];
SELECT COUNT(*)	[06_WORK_ORDERS]						FROM [dbo].[06_WORK_ORDERS];
SELECT COUNT(*)	[07_VIOLATIONS]							FROM [dbo].[07_VIOLATIONS];
SELECT COUNT(*)	[11_CONTACT]							FROM [dbo].[11_CONTACT];
SELECT COUNT(*)	[18_BOOKABLE_RESOURCE_CATEGORY_ASSN]	FROM [dbo].[18_BOOKABLE_RESOURCE_CATEGORY_ASSN];

--staging tables for master lookup data should have values
SELECT COUNT(*)	[12_BOOKABLE_RESOURCE]					FROM [dbo].[12_BOOKABLE_RESOURCE];
SELECT COUNT(*)	[17_BOOKABLE_RESOURCE_CATEGORIES]		FROM [dbo].[17_BOOKABLE_RESOURCE_CATEGORIES];
SELECT COUNT(*)	[21_TYRATIONAL]							FROM [dbo].[21_TYRATIONAL];
SELECT COUNT(*)	[22_OVERSIGHTTYPE]						FROM [dbo].[22_OVERSIGHTTYPE];
SELECT COUNT(*)	[23_TERRITORY]							FROM [dbo].[23_TERRITORY];
SELECT COUNT(*)	[24_WORKORDERTYPE]						FROM [dbo].[24_WORKORDERTYPE];

--verify hardcoded values inserted in scripts have been loaded and exist in crm database before running conversion
SELECT [msdyn_name] msdyn_workordertype FROM msdyn_workordertype	WHERE msdyn_workordertypeid = 'B1EE680A-7CF7-EA11-A815-000D3AF3A7A7';
SELECT [ovs_name] gc_targeted			FROM ovs_oversighttype		where ovs_oversighttypeid	= '50D0BDF1-269E-EB11-B1AC-000D3AE924D1';
SELECT [ovs_name] moc_targeted			FROM ovs_oversighttype		where ovs_oversighttypeid	= '864BAA27-279E-EB11-B1AC-000D3AE924D1';
SELECT [ovs_name] gc_consignment		FROM ovs_oversighttype		where ovs_oversighttypeid	= '460B6C2A-5F9C-EB11-B1AC-000D3AE92708';
SELECT [ovs_name] moc_opportunity		FROM ovs_oversighttype		where ovs_oversighttypeid	= 'F6A0B96E-5F9C-EB11-B1AC-000D3AE92708';
SELECT [ovs_name] civ_doc_review		FROM ovs_oversighttype		where ovs_oversighttypeid	= 'A4965081-5F9C-EB11-B1AC-000D3AE92708';
SELECT [ovs_name] ovs_tyrational		FROM ovs_tyrational			WHERE ovs_tyrationalid		= '994c3ec1-c104-eb11-a813-000d3af3a7a7';
SELECT [ovs_name] ovs_tyrational		FROM ovs_tyrational			WHERE ovs_tyrationalid		= '47F438C7-C104-EB11-A813-000D3AF3A7A7'
SELECT [name] [12_BOOKABLE_RESOURCE]	FROM [12_BOOKABLE_RESOURCE] WHERE bookableresourceid	= '2cfc9150-d6a3-eb11-b1ac-000d3ae8bee7';
SELECT [fullname] systemuser			FROM systemuser				WHERE systemuserid			= '53275569-d460-eb11-a812-000d3ae947a6';
SELECT [fullname] systemuser			FROM systemuser				WHERE domainname			= 'tdg.core@034gc.onmicrosoft.com';
SELECT [name] team						FROM team					WHERE teamid				= 'd0483132-b964-eb11-a812-000d3af38846';
SELECT [name] team						FROM team					WHERE [name]				= 'Transportation of Dangerous Goods';
SELECT [name] pricelevel				FROM pricelevel				WHERE pricelevelid			= 'B92B6A16-7CF7-EA11-A815-000D3AF3A7A7';
SELECT [name] businessunit				FROM businessunit			WHERE businessunitid		= '4E122E0C-73F3-EA11-A815-000D3AF3AC0D';

select [name] territories				FROM territory t1 JOIN [05_TERRITORY_TRANSLATION] t2 on t1.territoryid = t2.msdyn_serviceterritory;
--===================================================================================================
--===================================================================================================



--===================================================================================================
--===================================================================================================
--CONVERT EXCEL DATA TO UNIQUE RECORDS WITH ADDRESS FROM "MATCHING_ID"
--===================================================================================================
--===================================================================================================
/****** Object:  Table [dbo].[02_REGULATED_ENTITIES]    Script Date: 4/22/2021 12:41:24 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[02_REGULATED_ENTITIES]') AND type in (N'U'))
DROP TABLE [dbo].[02_REGULATED_ENTITIES]
GO

CREATE TABLE [dbo].[02_REGULATED_ENTITIES](
	[REGULATED_ENTITY_ID] [uniqueidentifier] NULL,
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
	[NOTES] [nvarchar](500) NULL,
	[TYPE] [nvarchar](25) NULL
) ON [PRIMARY]
GO


INSERT INTO DBO.[02_REGULATED_ENTITIES]
(
	[REGULATED_ENTITY_ID],
	[REGULATED_ENTITY_ID_SOURCE],
	IIS_ID,
	[REGULATED_ENTITY_NAME],
	[CONSOLIDATED_COMMON_ENGLISH_NAME],
	[CONSOLIDATED_COMMON_FRENCH_NAME]
)
SELECT
	NEWID()								[REGULATED_ENTITY_ID],
	REGENT.REGULATED_ENTITY_ID			[REGULATED_ENTITY_ID_SOURCE],
	REGENT.MATCHING_ID,
	TRIM(REGENT.REGULATED_ENTITY_NAME),
	TRIM(REGENT.REGULATED_ENTITY_NAME),
	TRIM(REGENT.REGULATED_ENTITY_NAME)
FROM 
(

	SELECT REGULATED_ENTITY_ID, REGULATED_ENTITY_NAME, MATCHING_ID, COUNT(REGULATED_ENTITY_ID) COUNT_OF
	FROM (
		SELECT REGULATED_ENTITY_ID,  
		REGULATED_ENTITY_NAME,
		MATCHING_ID
		FROM [dbo].[01_IIS_DATA_CONSOLIDATION]
	) REGENT_NAMES WHERE REGULATED_ENTITY_NAME IS NOT NULL
	GROUP BY REGULATED_ENTITY_ID, REGULATED_ENTITY_NAME, MATCHING_ID
	HAVING COUNT(REGULATED_ENTITY_ID) > 1

) REGENT

------------------------------------------------
--CONVERT REGULATED ENTITY RECORDS TO ACCOUNTS--
------------------------------------------------

TRUNCATE TABLE [dbo].[04_ACCOUNT];

INSERT INTO [dbo].[04_ACCOUNT]
(
[accountnumber],
[description],
id,
accountid,
[ovs_legalname],
[name],
[ovs_accountnameenglish],
[ovs_accountnamefrench],
[owningteam],
[owningbusinessunit],
[owneridtype],
[ownerid],
[customertypecode]
)
SELECT
[REGULATED_ENTITY_ID_SOURCE]										   [accountnumber],
CONCAT('Converted from IIS.', CHAR(13)+CHAR(10), 'IIS ID: ', [IIS_ID], 
							  CHAR(13)+CHAR(10), 'Data Consolidation Matching ID: ', [REGULATED_ENTITY_ID_SOURCE]) [description], 
[REGULATED_ENTITY_ID]													id,
[REGULATED_ENTITY_ID]													[accountid],
[REGULATED_ENTITY_NAME]													[ovs_legalname],
[REGULATED_ENTITY_NAME]													[name],
[CONSOLIDATED_COMMON_ENGLISH_NAME]										[ovs_accountnameenglish],
[CONSOLIDATED_COMMON_FRENCH_NAME]										[ovs_accountnamefrench],
'd0483132-b964-eb11-a812-000d3af38846'									[owningteam],
'4e122e0c-73f3-ea11-a815-000d3af3ac0d'									[owningbusinessunit],
'team'																	[owneridtype],
'd0483132-b964-eb11-a812-000d3af38846'									[ownerid],
948010000																[customertypecode]
FROM [dbo].[02_REGULATED_ENTITIES] REGENT;


--=======================================SITES==========

TRUNCATE TABLE DBO.[03_SITES];

INSERT INTO [dbo].[03_SITES]
           ([SITE_ID]
           ,[IIS_ID]
           ,[REGULATED_ENTITY_ID]
           ,[REGULATED_ENTITY_ID_SOURCE]
		   ,[REGULATED_ENTITY_NAME]
           ,[COMPANY_NAME_FORMATTED]
           ,[COMPANY_NAME]
           ,[COUNTRY_SUBDIVISION_CD]
           ,[CITY_TOWN_NAME_NM]
           ,[ADDRESS]
           ,[POSTAL_CODE_TXT]
           ,[COMPLETED]
           ,[PLANNED2021])
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
	FROM [dbo].[01_IIS_DATA_CONSOLIDATION]
) SITES
--WHERE AND COMPLETED = 'Y'


--link SITES to regulated entities
UPDATE SITES
SET 
    SITES.REGULATED_ENTITY_ID = REGENT.REGULATED_ENTITY_ID 
FROM 
    [dbo].[03_SITES] as SITES
    INNER JOIN DBO.[02_REGULATED_ENTITIES] as REGENT ON SITES.[REGULATED_ENTITY_ID_SOURCE] = REGENT.[REGULATED_ENTITY_ID_SOURCE];



DROP TABLE IF EXISTS #TEMP_ACCOUNTS;
GO

CREATE TABLE #TEMP_ACCOUNTS (
	[accountnumber] [nvarchar](20) NULL,
	[description] [nvarchar](max) NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[ovs_iisid] [nvarchar](25) NULL,
	[ovs_legalname] [nvarchar](250) NULL,
	[name] [nvarchar](160) NULL,
	[ovs_accountnameenglish] [nvarchar](4000) NULL,
	[address1_stateorprovince] [nvarchar](50) NULL,
	[address1_city] [nvarchar](80) NULL,
	[address1_line1] [nvarchar](250) NULL,
	[address1_postalcode] [nvarchar](20) NULL,
	[owningteam] [uniqueidentifier] NULL,
	[owningbusinessunit] [uniqueidentifier] NULL,
	[owneridtype] [nvarchar](4000) NULL,
	[ownerid] [uniqueidentifier] NULL,
	[customertypecode] int,
	[msdyn_serviceterritory] [uniqueidentifier] NULL,
	[territoryid] [uniqueidentifier] NULL,
	[parentaccountid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

------------------------------------------------
--CONVERT SITE ENTITY RECORDS TO ACCOUNTS--
------------------------------------------------
INSERT INTO #TEMP_ACCOUNTS
([accountnumber],
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
[owningteam],
[owningbusinessunit],
[owneridtype],
[ownerid],
[customertypecode],
[msdyn_serviceterritory],
[territoryid],
[parentaccountid])

SELECT

IIS_ID																			[accountnumber],
CONCAT('Converted from IIS.', CHAR(13)+CHAR(10), 'IIS ID: ', IIS_ID)			[description],
NEWID()																			[ID],
IIS_ID																			[ovs_iisid],
LEGAL_NAME_ENM																	[ovs_legalname],
COMPANY_NAME																	[name],
OPERATING_NAME_ENM																[ovs_accountnameenglish],
T1.[COUNTRY_SUBDIVISION_CD]														[address1_stateorprovince],
[CITY_TOWN_NAME_NM]																[address1_city],
[ADDRESS]																		[address1_line1],
[POSTAL_CODE_TXT]																[address1_postalcode],
'd0483132-b964-eb11-a812-000d3af38846'											[owningteam],
'4E122E0C-73F3-EA11-A815-000D3AF3AC0D'											[owningbusinessunit],
'team'																			[owneridtype],
'd0483132-b964-eb11-a812-000d3af38846'											[ownerid],
948010001																		[customertypecode],
[msdyn_serviceterritory]														[msdyn_serviceterritory],
[msdyn_serviceterritory]														[territoryid],
T1.REGULATED_ENTITY_ID															[parentaccountid]

FROM 

(
	SELECT
	T1.*,
	CASE
		WHEN T2.LEGAL_NAME_ENM IS NULL OR T2.LEGAL_NAME_ENM = '' THEN NULL
		ELSE T2.LEGAL_NAME_ENM
	END LEGAL_NAME_ENM,
	[T2].OPERATING_NAME_ENM,
	T3.[msdyn_serviceterritory],
	NULL [parentaccountid]

	FROM
	[03_SITES] T1
	LEFT JOIN [10_IIS_EXPORT] T2 ON T1.IIS_ID = T2.STAKEHOLDER_ID
	LEFT JOIN [dbo].[05_TERRITORY_TRANSLATION] T3 ON UPPER(TRIM(T1.[COUNTRY_SUBDIVISION_CD])) = UPPER(TRIM(T3.[COUNTRY_SUBDIVISION_CD]))

	--Make sure that no regulated entity ids do not go into the system as sites
	--AND STAKEHOLDER_ID NOT IN
	--(
	--	SELECT
	--	IIS_ID
	--	FROM 
	--	[02_REGULATED_ENTITIES]
	--)
) T1



INSERT INTO [04_ACCOUNT]
(
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
	[owningteam],
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
[owningteam],
[owningbusinessunit],
[owneridtype],
[ownerid],
[customertypecode],
[msdyn_serviceterritory], 
[territoryid],
[parentaccountid]
FROM #TEMP_ACCOUNTS;





--===============================LOGIC FOR IIS DATA===


UPDATE [04_ACCOUNT]
SET 
--,name = T2.OPERATING_NAME,
ovs_legalname = T2.LEGAL_NAME,
ovs_accountnameenglish = T2.OPERATING_NAME,
address1_primarycontactname = T2.USER_CONTACT,
address1_telephone1 = T2.CONTACT_TFH,
address1_latitude = CASE WHEN ISNUMERIC(T2.LATITUDE_DEGREE_NBR) = 1 THEN CAST(T2.LATITUDE_DEGREE_NBR AS DECIMAL(38, 5)) ELSE NULL END,
address1_longitude = CASE WHEN ISNUMERIC(T2.LONGITUDE_DEGREE_NBR) = 1 THEN CAST(T2.LONGITUDE_DEGREE_NBR AS DECIMAL(38, 5)) ELSE NULL END,
address1_city  = TRIM(T2.CITY_TOWN_NAME_NM),
address1_country = TRIM(T2.COUNTRY),
address1_postalcode = TRIM(T2.POSTAL_CODE_TXT),
address1_stateorprovince = TRIM(T2.COUNTRY_SUBDIVISION_CD),
address1_line3 = TRIM(POBOX),
address1_postofficebox = TRIM(POBOX),

address1_line1 = 
CASE
	WHEN TRIM(T2.STREET) IS NULL OR TRIM(T2.STREET) = '' THEN
		address1_line1
	ELSE
		TRIM(T2.STREET)
END

FROM [04_ACCOUNT] T1
JOIN 
(
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
			WHEN STREET_NAME_NM IS NULL AND (PHYS_STREET_NAME_NM IS NULL OR TRIM(PHYS_STREET_NAME_NM) = '') THEN 
				NULL
			WHEN (STREET_NAME_NM IS NULL OR TRIM(STREET_NAME_NM) = '0') AND PHYS_STREET_NAME_NM IS NOT NULL THEN
				CONCAT(IIS.PHYS_STREET_NUMBER_NUM, ' ', IIS.PHYS_STREET_NAME_NM)
			ELSE 
				CONCAT(IIS.STREET_NUMBER_NUM, ' ', STREET_NAME_NM)
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
			WHEN IIS.UNIT_SUITE_NUM = 'P.O. Box' OR IIS.UNIT_SUITE_NUM = 'PO' THEN
				CONCAT('P.O. Box', ' ', STREET_NUMBER_NUM)
			WHEN IIS.UNIT_SUITE_NUM = 'RR' OR IIS.UNIT_SUITE_NUM = 'SS' THEN 
				CONCAT(IIS.UNIT_SUITE_NUM, ' ', STREET_NUMBER_NUM)
			ELSE 
				NULL
		END POBOX,

		--Phone
		--Out of the box field.
		--DATA MIGRATION RULES:
		--There is no field that needs to be migrated from IIS.
		IIS.CONTACT_PHONE,
		IIS.CONTACT_BUSINESS_PHONE,
		IIS.CONTACT_EMAIL,
		IIS.CONTACT_TFH,
		IIS.USER_CONTACT
		--Fax
		--Out of the box field.
		--DATA MIGRATION RULES:
		--There is no field that needs to be migrated from IIS.

		, ADDRESS_TYPE.[TYPE]
		FROM [03_SITES] SITES
		JOIN [10_IIS_EXPORT] IIS ON SITES.IIS_ID = IIS.STAKEHOLDER_ID
		JOIN (
			SELECT
			STAKEHOLDER_ID,
			CASE
				WHEN	(STREET_NUMBER_NUM IS NULL		OR TRIM(STREET_NUMBER_NUM) = '')		AND 
						(STREET_NAME_NM IS NULL			OR TRIM (STREET_NAME_NM) = '')			AND 
						(CITY_TOWN_NAME_NM IS NULL		OR TRIM(CITY_TOWN_NAME_NM) = '')		AND 
						(COUNTRY_SUBDIVISION_CD IS NULL OR TRIM(COUNTRY_SUBDIVISION_CD) = '')	AND 
						(POSTAL_CODE_TXT IS NULL		OR TRIM(POSTAL_CODE_TXT) = '') THEN
						'PHYSICAL'
				ELSE
					'CIVIC'
			END [TYPE]
			FROM [10_IIS_EXPORT]
		) ADDRESS_TYPE ON IIS.STAKEHOLDER_ID = ADDRESS_TYPE.STAKEHOLDER_ID
) T2

ON T1.ovs_iisid = T2.STAKEHOLDER_ID;



--MOC Registration Number
--Required to be migrated from IIS.  This field will be required for linking to FDR.
--get this field from the workplan uploads
UPDATE [04_ACCOUNT]
SET 
	ovs_mocid = T2.MOC_ID
FROM [04_ACCOUNT] T1
JOIN 
(
	SELECT DISTINCT SITES.IIS_ID, WORKPLANS.MOC_ID
	FROM [03_SITES] SITES
	JOIN [dbo].[09_WORKPLAN_IMPORT] WORKPLANS ON CAST(SITES.IIS_ID as varchar(10)) = WORKPLANS.IIS_ID
	WHERE MOC_ID IS NOT NULL and MOC_ID <> ''
) T2 
ON T1.ovs_iisid = T2.IIS_ID;


--View accounts linked to Sites
--SELECT *  
--FROM [04_ACCOUNT] T1
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
UPDATE [dbo].[04_ACCOUNT]
SET address1_postalcode = REPLACE(address1_postalcode, ' ', ''),
	address1_country = 'Canada',
	address1_line1 = TRIM(address1_line1),
	address1_latitude  = CASE WHEN address1_latitude IS NULL OR address1_latitude = 0.00000 THEN NULL ELSE address1_latitude END,
	address1_longitude = CASE WHEN address1_longitude IS NULL OR address1_longitude = 0.00000 THEN NULL ELSE address1_longitude END;


----=============================END IIS LOGIC====


	

--=============BOOKABLE RESOURCES===

INSERT INTO [dbo].[12_BOOKABLE_RESOURCE]
           (
		   bookableresourceid
		   ,[userid]
           ,[name]
           ,[msdyn_primaryemail]
           ,[ovs_registeredinspectornumberrin]
           ,[ovs_badgenumber])

SELECT * 
FROM
(
	SELECT newid() bookableresourceid, SYSUSER.systemuserid, CONCAT(SYSUSER.firstname, ' ', SYSUSER.lastname) name, domainname, RIN, BADGE FROM [dbo].systemuser SYSUSER 
	JOIN [16_IIS_INSPECTORS] INSP ON lower(INSP.Account_name) = lower(SYSUSER.domainname)
) T


UPDATE [dbo].[bookableresource]
SET 
owningbusinessunit = '4e122e0c-73f3-ea11-a815-000d3af3ac0d',
owneridtype = 'team',
ownerid = 'd0483132-b964-eb11-a812-000d3af38846',
owningteam = 'd0483132-b964-eb11-a812-000d3af38846',
resourcetype = 3,
statecode = 0,
statuscode = 1,
msdyn_derivecapacity = 0,
msdyn_displayonscheduleassistant = 1,
msdyn_displayonscheduleboard = 1,
msdyn_enabledforfieldservicemobile = 1,
msdyn_enabledripscheduling = 0,
msdyn_endlocation = 690970002, --location agnostic
msdyn_startlocation = 690970002, --location agnostic
msdyn_timeoffapprovalrequired = 0;

GO

---ADD "INSPECTOR" category to all inspectors
TRUNCATE TABLE [18_BOOKABLE_RESOURCE_CATEGORY_ASSN];

INSERT INTO [18_BOOKABLE_RESOURCE_CATEGORY_ASSN]
(resource, resourcecategory, statecode, statuscode, owningbusinessunit, owneridtype, ownerid , owningteam)

SELECT 
bookableresourceid, 
resourcecategory = '06DB6E56-01F9-EA11-A815-000D3AF3AC0D', --INSPECTOR 
statecode = 0, 
statuscode = 1, 
owningbusinessunit = '4e122e0c-73f3-ea11-a815-000d3af3ac0d',
owneridtype = 'team',
ownerid = 'd0483132-b964-eb11-a812-000d3af38846',
owningteam = 'd0483132-b964-eb11-a812-000d3af38846' FROM [dbo].[bookableresource]; 

--=====END BOOKABLE RESOURCES



--============WORK ORDERS

DROP TABLE IF EXISTS [19_IIS_INSPECTIONS];

CREATE TABLE [19_IIS_INSPECTIONS]
(
	[MONTH] int
	,[YEAR]	int	
	,FILE_NUMBER_NUM nvarchar (200)
	,FILE_STATUS_ETXT	varchar	(50)
	,FILE_STATUS_FTXT	varchar	(50)
	,ACTIVITY_TYPE_ENM	varchar	(250)
	,ACTIVITY_TYPE_FNM	varchar	(250)
	,ACTIVITY_DATE_DTE	datetime	
	,ACTIVITY_ID	numeric	
	,STAKEHOLDER_ID	numeric	
	,id	uniqueidentifier	
	,ovs_iisid	nvarchar	(50)
	,ACTIVITY_TYPE_CD	varchar	(20)
	,INSPECTION_REASON_ETXT	varchar	(250)
	,INSPECTION_REASON_FTXT	varchar	(250)
	,PRIMARY_INSPECTOR	nvarchar	(200)
	,PRIMARY_INSPECTOR_ID	numeric	
	,PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID	uniqueidentifier	
	,SECONDARY_INSPECTOR	nvarchar (200)
	,SECONDARY_INSPECTOR_ID	numeric	
	,SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID	uniqueidentifier
);

INSERT INTO [19_IIS_INSPECTIONS]

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
	TD045.ACTIVITY_TYPE_ENM, 
	TD045.ACTIVITY_TYPE_FNM,
	CONVERT(datetime, YD040.ACTIVITY_DATE_DTE) ACTIVITY_DATE_DTE,
	YD040.ACTIVITY_ID, 
	YD040.STAKEHOLDER_ID, 
	null id,--ACCOUNTS.id,
	null ovs_iisid,--ACCOUNTS.[ovs_iisid],
	TD045.ACTIVITY_TYPE_CD, 
	TD038.INSPECTION_REASON_ETXT, 
	TD038.INSPECTION_REASON_FTXT,
	PRIMARY_INSPECTOR.name PRIMARY_INSPECTOR,
	PRIMARY_INSPECTOR.STAKEHOLDER_ID PRIMARY_INSPECTOR_ID, 
	PRIMARY_INSPECTOR.id PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
	SECONDARY_INSPECTOR.name SECONDARY_INSPECTOR,
	SECONDARY_INSPECTOR.STAKEHOLDER_ID SECONDARY_INSPECTOR_ID,
	SECONDARY_INSPECTOR.id SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID
	FROM YD040_ACTIVITY YD040
	INNER JOIN YD095_STAKEHOLDER_FILE YD095 ON  YD040.FILE_NUMBER_NUM = YD095.FILE_NUMBER_NUM  
	INNER JOIN YD101_FILE_ACTIVITY_TYPE YD101 ON YD101.FILE_NUMBER_NUM = YD095.FILE_NUMBER_NUM AND YD101.DATE_DELETED_DTE IS NULL
	INNER JOIN TD045_ACTIVITY_TYPE TD045 ON YD101.ACTIVITY_TYPE_CD = TD045.ACTIVITY_TYPE_CD 
	INNER JOIN TD001_FILE_STATUS TD001 ON YD095.FILE_STATUS_CD = TD001.FILE_STATUS_CD
	LEFT JOIN YD041_INSPECTION YD041 ON YD040.ACTIVITY_ID = YD041.ACTIVITY_ID 
	LEFT JOIN TD038_INSPECTION_REASON TD038 ON YD041.INSPECTION_REASON_CD = TD038.INSPECTION_REASON_CD 
    
	LEFT JOIN
	(
		SELECT YD048.ACTIVITY_ID,
		YD048.STAKEHOLDER_ID
		,name
		,BR.id
		FROM YD048_ACTIVITY_ASSIGNMENT YD048 
		JOIN YD083_INDIVIDUAL_INFORMATION YD083 ON  YD048.STAKEHOLDER_ID = YD083.STAKEHOLDER_ID 
		JOIN [dbo].[bookableresource] BR ON UPPER(TRIM(CONCAT(CONCAT(YD083.STAKEHOLDER_NAME_FIRST_NM, ' '), YD083.STAKEHOLDER_NAME_FAMILY_NM))) = UPPER([dbo].[ReplaceASCII](name))
		WHERE YD083.DATE_DELETED_DTE IS NULL AND YD048.DATE_DELETED_DTE IS NULL AND ASSIGN_ROLE_CD = '1'
	) PRIMARY_INSPECTOR ON PRIMARY_INSPECTOR.ACTIVITY_ID = YD040.ACTIVITY_ID
    
	LEFT JOIN
	(
		SELECT YD048.ACTIVITY_ID,
		YD048.STAKEHOLDER_ID
		,name
		,BR.id
		FROM YD048_ACTIVITY_ASSIGNMENT YD048 
		JOIN YD083_INDIVIDUAL_INFORMATION YD083 ON  YD048.STAKEHOLDER_ID = YD083.STAKEHOLDER_ID 
		JOIN [dbo].[bookableresource] BR ON UPPER(TRIM(CONCAT(CONCAT(YD083.STAKEHOLDER_NAME_FIRST_NM, ' '), YD083.STAKEHOLDER_NAME_FAMILY_NM))) = UPPER([dbo].[ReplaceASCII](name))
		WHERE YD083.DATE_DELETED_DTE IS NULL AND YD048.DATE_DELETED_DTE IS NULL AND ASSIGN_ROLE_CD = '2'
	) SECONDARY_INSPECTOR ON SECONDARY_INSPECTOR.ACTIVITY_ID = YD040.ACTIVITY_ID
    
	--JOIN [dbo].[04_ACCOUNT] ACCOUNTS ON ACCOUNTS.ovs_iisid = YD040.STAKEHOLDER_ID

	WHERE 
	YD040.DATE_DELETED_DTE IS NULL AND 
	YD095.DATE_DELETED_DTE IS NULL AND 
	YD041.DATE_DELETED_DTE IS NULL AND 
	YD101.DATE_DELETED_DTE IS NULL 
	AND TD045.ACTIVITY_TYPE_PARENT_CD IS NULL AND TD045.DATE_DELETED_DTE IS NULL
	GROUP BY 
	YD095.FILE_NUMBER_NUM, 
	TD001.FILE_STATUS_ETXT, 
	TD001.FILE_STATUS_FTXT, 
	TD045.ACTIVITY_TYPE_ENM, 
	TD045.ACTIVITY_TYPE_FNM, 
	YD040.INSPECTION_DATE_DTE, 
	YD040.ACTIVITY_ID, 
	YD040.STAKEHOLDER_ID, 
	--ACCOUNTS.id,
	--ACCOUNTS.ovs_iisid,
	TD045.ACTIVITY_TYPE_CD, 
	TD038.INSPECTION_REASON_ETXT, 
	TD038.INSPECTION_REASON_FTXT,
	YD040.ACTIVITY_DATE_DTE,
	PRIMARY_INSPECTOR.name,
	PRIMARY_INSPECTOR.STAKEHOLDER_ID, 
	PRIMARY_INSPECTOR.id,
	SECONDARY_INSPECTOR.name,
	SECONDARY_INSPECTOR.STAKEHOLDER_ID,
	SECONDARY_INSPECTOR.id
			
) T;


--connect the IIS Inspections to the Accounts in ROM
UPDATE [19_IIS_INSPECTIONS]
SET 
id = ACCOUNTS.Id
,ovs_iisid = STAKEHOLDER_ID
FROM [19_IIS_INSPECTIONS]
JOIN [dbo].[04_ACCOUNT] ACCOUNTS ON ACCOUNTS.ovs_iisid = STAKEHOLDER_ID
WHERE ACCOUNTS.customertypecode <> 948010000;
-- make sure to not connect inspection to a regulated entity


----====================CREATE WORK ORDER RECORDS
----====================----====================----====================
----====================----====================----====================

TRUNCATE TABLE [06_WORK_ORDERS];

INSERT INTO [dbo].[06_WORK_ORDERS]
(
	 [msdyn_workorderid]
	,[msdyn_workordertype]
	,[msdyn_name]
	,[msdyn_pricelist]
	,[msdyn_serviceaccount]
	,[ovs_iisid]
	,[msdyn_systemstatus]
	,[ovs_primaryinspector]
	,[ovs_secondaryinspector]
	,[ownerid]
	,[owneridtype]
	,[owningbusinessunit]
	,owninguser
	,[msdyn_workordersummary]
	,[ovs_fiscalquarter]
	,[ovs_fiscalyear]
	,[ovs_oversighttype]
	,[ovs_rational]

	--,[qm_reportcontactid]
	--,[statecode]
	--,[statuscode]
)

SELECT ID, WORK_ORDER_TYPE, WORK_ORDER_NUMBER, PRICE_LIST, accountid, ovs_iisid, WORK_ORDER_STATUS, PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID, SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID,[OWNER],
	   OWNER_TYPE, OWNING_BUSINESS_UNIT, owning_user, WORK_ORDER_SUMMARY, FQ.tc_tcfiscalquarterid, FY.tc_tcfiscalyearid, OVERSIGHT_TYPE, RATIONALE FROM
(

	SELECT
		newid() ID,																				--WORK ORDER ID
		'B1EE680A-7CF7-EA11-A815-000D3AF3A7A7' WORK_ORDER_TYPE,									--work order type "Inspection"
		REPLACE(STR(ROW_NUMBER() OVER (ORDER BY ACTIVITY_ID),6),' ','0') WORK_ORDER_NUMBER,		--WO name, auto incremented number 1...x
		'B92B6A16-7CF7-EA11-A815-000D3AF3A7A7' PRICE_LIST,										--default price list
		id accountid,																			--account id for service account linked by the iis id
		[ovs_iisid],																			--IIS STAKEHOLDER_ID
		'690970004' WORK_ORDER_STATUS,															--"Closed - Posted"
		FILE_STATUS_ETXT,
		PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,													--PRIMARY INSPECTOR
		SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID												--SECONDARY INSPECTOR
		,PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID owner											--'D0483132-B964-EB11-A812-000D3AF38846' [OWNER]	--OWNER = primary inspector
		,'systemuser' [OWNER_TYPE]																--OWNER TYPE = systemuser
		,'4E122E0C-73F3-EA11-A815-000D3AF3AC0D' [OWNING_BUSINESS_UNIT]							--TDG Business Unit
		,PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID [owning_user]
		--,'D0483132-B964-EB11-A812-000D3AF38846' [OWNING_TEAM]									--OWNING TEAM = TDG Team
		,CAST(ACTIVITY_ID as nvarchar(500))	[WORK_ORDER_SUMMARY],	--WORK ORDER SUMMARY

		CASE 
			WHEN ([MONTH] >= 1 AND [MONTH] <=3)   THEN 'Q4'
			WHEN ([MONTH] >= 4 AND [MONTH] <=6)   THEN 'Q1'
			WHEN ([MONTH] >= 7 AND [MONTH] <=9)   THEN 'Q2'
			WHEN ([MONTH] >= 10 AND [MONTH] <=12) THEN 'Q3'
		END FISCAL_QUARTER,

		CASE 
			WHEN ([MONTH] >= 1 AND [MONTH] <=3) THEN 
				CONCAT(CONVERT(NVARCHAR(4), [YEAR] - 1),'-', CONVERT(NVARCHAR(4), [YEAR]))
			ELSE
				CONCAT(CONVERT(NVARCHAR(4), [YEAR]),'-', CONVERT(NVARCHAR(4), [YEAR] + 1))
		END FISCAL_YEAR,

--'07966E1C-5F9C-EB11-B1AC-000D3AE92708',	'GC Opportunity'
--'1CC06B3F-5F9C-EB11-B1AC-000D3AE92708',	'GC Undeclared / Misdeclared'
--'1CD7BD09-279E-EB11-B1AC-000D3AE924D1',	'GC Follow-up'
--'460B6C2A-5F9C-EB11-B1AC-000D3AE92708',	'GC Consignment'
--'50D0BDF1-269E-EB11-B1AC-000D3AE924D1',	'GC Targeted'
--'72AFCCD3-269E-EB11-B1AC-000D3AE924D1',	'GC IPT'
--'864BAA27-279E-EB11-B1AC-000D3AE924D1',	'MOC Facility Targeted'
--'9DEE7316-5F9C-EB11-B1AC-000D3AE92708',	'GC Triggered'
--'A4965081-5F9C-EB11-B1AC-000D3AE92708',	'Civil Aviation Document Review'
--'ABF3C4D9-269E-EB11-B1AC-000D3AE924D1',	'GC IPT'
--'C1E09A33-279E-EB11-B1AC-000D3AE924D1',	'MOC Facility Follow-up'
--'E99AB21B-279E-EB11-B1AC-000D3AE924D1',	'MOC Facility IPT'
--'EA95BC68-5F9C-EB11-B1AC-000D3AE92708',	'MOC Facility Triggered'
--'F6A0B96E-5F9C-EB11-B1AC-000D3AE92708',	'MOC Facility Opportunity'

		CASE 
			WHEN ACTIVITY_TYPE_ENM = 'Site Visit'							 THEN '50D0BDF1-269E-EB11-B1AC-000D3AE924D1'
			WHEN ACTIVITY_TYPE_ENM = 'MOC Facility Inspection (Planned)'	 THEN '864BAA27-279E-EB11-B1AC-000D3AE924D1'
			WHEN ACTIVITY_TYPE_ENM = 'General Compliance Inspection'		 THEN '50D0BDF1-269E-EB11-B1AC-000D3AE924D1'
			WHEN ACTIVITY_TYPE_ENM = 'Consignment'							 THEN '460B6C2A-5F9C-EB11-B1AC-000D3AE92708'
			WHEN ACTIVITY_TYPE_ENM = 'MOC Facility Inspection - (Unplanned)' THEN 'F6A0B96E-5F9C-EB11-B1AC-000D3AE92708'
			WHEN ACTIVITY_TYPE_ENM = 'Document Review'						 THEN 'A4965081-5F9C-EB11-B1AC-000D3AE92708'
		END OVERSIGHT_TYPE,

--994C3EC1-C104-EB11-A813-000D3AF3A7A7	Planned
--47F438C7-C104-EB11-A813-000D3AF3A7A7	Unplanned

		CASE 
			WHEN ACTIVITY_TYPE_ENM = 'Site Visit'							 THEN '994C3EC1-C104-EB11-A813-000D3AF3A7A7' --PLANNED
			WHEN ACTIVITY_TYPE_ENM = 'MOC Facility Inspection (Planned)'	 THEN '994C3EC1-C104-EB11-A813-000D3AF3A7A7' --PLANNED
			WHEN ACTIVITY_TYPE_ENM = 'General Compliance Inspection'		 THEN '994C3EC1-C104-EB11-A813-000D3AF3A7A7' --PLANNED
			WHEN ACTIVITY_TYPE_ENM = 'Consignment'							 THEN '47F438C7-C104-EB11-A813-000D3AF3A7A7' --UNPLANNED
			WHEN ACTIVITY_TYPE_ENM = 'MOC Facility Inspection - (Unplanned)' THEN '47F438C7-C104-EB11-A813-000D3AF3A7A7' --UNPLANNED
			WHEN ACTIVITY_TYPE_ENM = 'Document Review'						 THEN '47F438C7-C104-EB11-A813-000D3AF3A7A7' --UNPLANNED
		END RATIONALE
	
	FROM [19_IIS_INSPECTIONS]

	WHERE id IS NOT NULL

) T3
JOIN [dbo].[13_FISCAL_YEAR] FY ON FY.TC_NAME = T3.FISCAL_YEAR
JOIN [dbo].[14_FISCAL_QUARTER] FQ ON FQ.TC_NAME = T3.FISCAL_QUARTER AND FY.tc_tcfiscalyearid = FQ.tc_tcfiscalyearid;


--load the fiscal year, quarter and inspector names into the staging table, easier to look at the data
update [06_WORK_ORDERS] 
SET
	 [ovs_primaryinspectorname]		= BR.name
	,[ovs_secondaryinspectorname]	= BR2.name
	,[ovs_fiscalquartername]		= FQ.tc_name
	,[ovs_fiscalyearname]			= FY.tc_name
--SELECT 
--BR.name
--,BR2.name
--,FQ.tc_name
--,FY.tc_name
FROM 
[06_WORK_ORDERS] T1
JOIN [dbo].[13_FISCAL_YEAR] FY on T1.ovs_fiscalyear = FY.tc_tcfiscalyearid
JOIN [dbo].[14_FISCAL_QUARTER] FQ on T1.ovs_fiscalquarter = FQ.tc_tcfiscalquarterid
JOIN [dbo].[bookableresource] BR ON T1.ovs_primaryinspector = BR.bookableresourceid
LEFT JOIN [dbo].[bookableresource] BR2 ON T1.ovs_secondaryinspector = BR2.bookableresourceid


--UPDATE WORK ORDER ADDRESSES WITH ACCOUNT ADDRESSES 
UPDATE [06_WORK_ORDERS] 
SET 
msdyn_serviceterritory = A.territoryid, 
msdyn_address1 = A.address1_line1, 
msdyn_address2 = A.address1_line2, 
msdyn_address3 = A.address1_line3, 
msdyn_city = A.address1_city, 
msdyn_country = A.address1_country, 
msdyn_postalcode = A.address1_postalcode, 
msdyn_stateorprovince = A.address1_stateorprovince
FROM [06_WORK_ORDERS] WO
JOIN [04_ACCOUNT] A on WO.msdyn_serviceaccount = A.id;




--WHERE THE PRIMARY HASNT BEEN SET BECAUSE THE INSPECTOR DOES NOT HAVE AN ACCOUNT YET, THEN SET IT TO THE "TDG.CORE" user so we can at least get them in
UPDATE [06_WORK_ORDERS] 
SET 
[ovs_primaryinspector] = '2cfc9150-d6a3-eb11-b1ac-000d3ae8bee7' --TDG CORE BOOKABLE RESOURCE ID
,ownerid			   = '53275569-d460-eb11-a812-000d3ae947a6' -- tdg core system user
,owninguser			   = '53275569-d460-eb11-a812-000d3ae947a6' -- tdg core system user
FROM [06_WORK_ORDERS] WO
WHERE WO.ovs_primaryinspector IS NULL;

--==========================================


--==========================INSERT WORKORDERS FROM CURRENT WORKPLAN====


--SELECT * FROM [06_WORK_ORDERS] WHERE ovs_fiscalyearname = '2021-2022'

--Open - Unscheduled	690970000
--Open - Scheduled		690970001
--Open - In Progress	690970002
--Open - Completed		690970003
--Closed - Posted		690970004
--Closed - Canceled		690970005

--ANY Inspections from this years workplan that exist in IIS lets set to Open-Completed, hard to know if they're fully done or not
UPDATE [06_WORK_ORDERS]
SET [msdyn_systemstatus] = '690970003' --Open-Completed
WHERE ovs_fiscalyearname = '2021-2022';

--INSERT planned inspections for this fiscal year that havnt been started in IIS
INSERT INTO [dbo].[06_WORK_ORDERS]
(
	 [msdyn_workorderid]
	,[msdyn_workordertype]
	,[msdyn_name]
	,[msdyn_pricelist]
	,[msdyn_serviceaccount]
	,[ovs_iisid]
	,[msdyn_systemstatus]
	--,[ovs_primaryinspector]
	--,[ovs_secondaryinspector]
	,[ownerid]
	,[owneridtype]
	,[owningbusinessunit]
	--,owninguser
	,owningteam
	,[msdyn_workordersummary]

	,[ovs_fiscalquarter]
	,[ovs_fiscalquartername]
	,[ovs_fiscalyear]
	,[ovs_fiscalyearname]

	,[ovs_oversighttype]
	,[ovs_rational]
)

SELECT
	newid()																				[msdyn_workorderid],	--WORK ORDER ID
	'B1EE680A-7CF7-EA11-A815-000D3AF3A7A7'												WORK_ORDER_TYPE,		--work order type "Inspection"
	CONCAT([YEAR], REPLACE(STR(ROW_NUMBER() OVER (ORDER BY import_number),6),' ','0') )	WORK_ORDER_NUMBER,		--WO name, 2021 + auto incremented number 1...x
	'B92B6A16-7CF7-EA11-A815-000D3AF3A7A7'												PRICE_LIST,				--default price list
	accountid																			accountid,				--account id for service account linked by the iis id
	IIS_ID																				IIS_ID,					--IIS STAKEHOLDER_ID
	'690970000'																			WORK_ORDER_STATUS,		--"Unscheduled"
	--PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,											--PRIMARY INSPECTOR		--SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID																
	'D0483132-B964-EB11-A812-000D3AF38846'												[OWNER]					--OWNER = primary inspector
	--,PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID											[owner]					--'D0483132-B964-EB11-A812-000D3AF38846' [OWNER]
	,'systemuser'																		[OWNER_TYPE]			--OWNER TYPE = systemuser
	,'4E122E0C-73F3-EA11-A815-000D3AF3AC0D'												[OWNING_BUSINESS_UNIT]	--TDG Business Unit
	--,PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID											[owning_user]			--owning user is the primary inspector
	,'D0483132-B964-EB11-A812-000D3AF38846'												[OWNING_TEAM]			--OWNING TEAM = TDG Team
	,CONCAT('Work Order converted from 2021/2022 Workplan for IIS_ID = ', IIS_ID)		[WORK_ORDER_SUMMARY],	--WORK ORDER SUMMARY
	[tc_tcfiscalquarterid],
	[ovs_fiscalquartername],
	[tc_tcfiscalyearid],
	[ovs_fiscalyearname],

	CASE 
		WHEN [TYPE] = 'MOC'		THEN '864BAA27-279E-EB11-B1AC-000D3AE924D1'
		WHEN [TYPE] = 'GC'		THEN '50D0BDF1-269E-EB11-B1AC-000D3AE924D1'
		WHEN [TYPE] = 'HUBS'	THEN '50D0BDF1-269E-EB11-B1AC-000D3AE924D1'
	END																					OVERSIGHT_TYPE,

	'994C3EC1-C104-EB11-A813-000D3AF3A7A7'												RATIONALE --ALL WORK PLAN INSPECTIONS ARE PLANNED

FROM
(
	SELECT 
		WP.*, 
		ACCOUNTS.ID accountid,
		FQ.[tc_tcfiscalquarterid],
		FQ.[tc_name] [ovs_fiscalquartername],
		FY.[tc_tcfiscalyearid],
		FY.[tc_name] [ovs_fiscalyearname]
	FROM 
	(
		Select 
		
		CASE
			WHEN QUARTER_1 = '1' THEN 'Q1'
			WHEN QUARTER_2 = '1' THEN 'Q2'
			WHEN QUARTER_3 = '1' THEN 'Q3'
			WHEN QUARTER_4 = '1' THEN 'Q4'
		END [QUARTER],
		
		CASE
			WHEN QUARTER_1 = '1' OR QUARTER_2 = '1' OR QUARTER_3 = '1' THEN '2021'
			WHEN QUARTER_4 = '1' THEN '2022'
		END [YEAR]

		,CASE 
			WHEN Charindex(',', CURRENT_INSPECTOR) = 0 THEN 'TDG'
			ELSE Substring(CURRENT_INSPECTOR, 1,Charindex(',', CURRENT_INSPECTOR)-1)
		END [InspectorFirstName],
		
		CASE 
			WHEN Charindex(',', CURRENT_INSPECTOR) = 0 THEN 'CORE'
			ELSE Substring(CURRENT_INSPECTOR, Charindex(',', CURRENT_INSPECTOR)+1, LEN(CURRENT_INSPECTOR))
		END [InspectorLastName]
		
		,*	
		
		from [09_WORKPLAN_IMPORT] WP
		WHERE 
		CURRENTLY_PLANNED = '1' and fiscal_year = '2021-2022' AND
		CURRENT_INSPECTOR <> '' and CURRENT_INSPECTOR IS NOT NULL
	) WP
	--[dbo].[bookableresource] BR ON UPPER(TRIM(CONCAT(CONCAT(YD083.STAKEHOLDER_NAME_FIRST_NM, ' '), YD083.STAKEHOLDER_NAME_FAMILY_NM))) = UPPER([dbo].[ReplaceASCII](name))
	JOIN [04_ACCOUNT] ACCOUNTS ON WP.IIS_ID = ACCOUNTS.ovs_iisid
	JOIN [dbo].[13_FISCAL_YEAR] FY on WP.[YEAR] = FY.tc_fiscalyearnum
	JOIN [dbo].[14_FISCAL_QUARTER] FQ on FQ.tc_name = WP.[QUARTER] AND FQ.tc_tcfiscalyearidname = WP.fiscal_year
	AND import_number NOT IN
	(
		--WORKPLAN INSPECTIONS CREATED IN IIS ALREADY
		--IGNORE TO PREVENT DOUBLES
		SELECT import_number
		FROM
		(
			SELECT *, 

			CASE
				WHEN QUARTER_1 = '1' THEN 'Q1'
				WHEN QUARTER_2 = '1' THEN 'Q2'
				WHEN QUARTER_3 = '1' THEN 'Q3'
				WHEN QUARTER_4 = '1' THEN 'Q4'
			END [QUARTER]

			FROM [dbo].[09_WORKPLAN_IMPORT] 
		) WP
		JOIN [06_WORK_ORDERS] WO ON WP.IIS_ID = WO.ovs_iisid AND WP.fiscal_year = WO.ovs_fiscalyearname AND WP.QUARTER = WO.ovs_fiscalquartername
		where WP.fiscal_year = '2021-2022'
	)

) CURRENT_WORKPLAN;


--TODO: BOOKABLE RESOURCE BOOKINGS



--SELECT 
--     *
--  FROM [dbo].[06_WORK_ORDERS]
--  where ovs_fiscalyearname = '2021-2022'

--=================END WORKPLAN



--=====================CONTACTS

/****** Script for SelectTopNRows command from SSMS  ******/

TRUNCATE TABLE [11_CONTACT];
INSERT INTO [dbo].[11_CONTACT]
	   (
	   --id
	   [Id]
      ,[contactid]
	  
	  --owner
	  ,[owningbusinessunit]
      ,[owningteam]
      ,[ownerid]
      ,[owneridtype]

	  --contact
      ,[emailaddress1]
      ,[telephone1]
      ,[telephone2]
      ,[telephone3]

	  --account
      ,[accountid]
      ,[company]
	  ,[parentcustomeridtype]

	  --identifiaction
	  ,[firstname]
      ,[lastname]
      ,[fullname]
      --,[jobtitle]
)
SELECT 
	
	--id
	contactid, contactid, 
	
	--owner
	'4E122E0C-73F3-EA11-A815-000D3AF3AC0D'												[OWNING_BUSINESS_UNIT]	--TDG Business Unit
	,'D0483132-B964-EB11-A812-000D3AF38846'												[OWNING_TEAM]			--OWNING TEAM = TDG Team
	,'D0483132-B964-EB11-A812-000D3AF38846'												[OWNER]					--OWNER = primary inspector
	,'team'																				[OWNER_TYPE]			--OWNER TYPE = systemuser
	
	--contact
	,CONTACT_EMAIL
	,CONTACT_BUSINESS_PHONE
	,CONTACT_TFH
	,CONTACT_PHONE

	--account
	,accountid
	,accountid company
	,'account' parentcustomeridtype
	
	--identification
	,CONTACT_FIRST_NAME, 
	LEFT(CONTACT_LAST_NAME, 50) CONTACT_LAST_NAME,  
	USER_CONTACT [fullname]
FROM
(
	SELECT NEWID() contactid, ACCOUNTS.accountid, ACCOUNTS.name, IIS.CONTACT_BUSINESS_PHONE, IIS.CONTACT_EMAIL, IIS.CONTACT_PHONE, IIS.CONTACT_TFH, IIS.USER_CONTACT

	,CASE 
		WHEN Charindex(' ', USER_CONTACT) = 0 THEN 'TDG'
		ELSE TRIM(Substring(USER_CONTACT, 1,Charindex(' ', USER_CONTACT)-1))
	END CONTACT_FIRST_NAME,
		
	CASE 
		WHEN Charindex(' ', USER_CONTACT) = 0 THEN 'CORE'
		ELSE TRIM(Substring(USER_CONTACT, Charindex(' ', USER_CONTACT)+1, LEN(USER_CONTACT)))
	END CONTACT_LAST_NAME


	FROM [dbo].[04_ACCOUNT] ACCOUNTS
	JOIN [dbo].[10_IIS_EXPORT] IIS ON ACCOUNTS.ovs_iisid = IIS.STAKEHOLDER_ID
	WHERE IIS.USER_CONTACT <> '' and IIS.USER_CONTACT IS NOT NULL
) T;


UPDATE [11_CONTACT] 
SET parentcustomeridtype = 'account';

--Set contacts to primary contact of the account
--SELECT * FROM [04_ACCOUNT];
update [04_ACCOUNT]
SET 
primarycontactid = t1.contactid, 
ovs_primarycontactemail = t1.emailaddress1, 
ovs_primarycontactphone = t1.telephone1
FROM [11_CONTACT] t1
JOIN [04_ACCOUNT] t2 on t1.accountid = t2.accountid

--SELECT * FROM [11_CONTACT];
update [11_CONTACT]
SET
accountid = T1.Id,
company = t1.Id
FROM [04_ACCOUNT] t1
JOIN [11_CONTACT] t2 on t1.Id = t2.accountid and t1.Id = T2.accountid


-----===END CONTACTS



--Violations (qm_syresults)
--not all legislation from IIS are mapped to ROM, but migrate the matches we do have 
--SELECT * FROM [20_LEGISLATION_MATCHING];
--=========================================================================================================
--=========================================================================================================
	DROP TABLE IF EXISTS #TEMP_INSPECTIONS;

	--get violations and enforcement actions into temp table
    SELECT 
    YD095.FILE_NUMBER_NUM, 
    TD001.FILE_STATUS_ETXT, 
    TD001.FILE_STATUS_FTXT,	
    TD045.ACTIVITY_TYPE_ENM, 
    TD045.ACTIVITY_TYPE_FNM, 
    YD040.INSPECTION_DATE_DTE, 
    YD040.ACTIVITY_ID, 
    YD040.STAKEHOLDER_ID, 
    TD045.ACTIVITY_TYPE_CD, 
    TD038.INSPECTION_REASON_ETXT, 
    TD038.INSPECTION_REASON_FTXT,
    VIOLATIONS.VIOLATION_CD,
	VIOLATIONS.VIOLATION_COMMENTS_TXT,
	VIOLATIONS.MOC_SERIAL_NUMBER_NUM,
	VIOLATIONS.MOC_TYPE_CD, 
	VIOLATIONS.MOC_VIOLATION_COMMENTS_TXT, 
	VIOLATIONS.TDG_SPECIFICATION_CD, 
	VIOLATIONS.UN_NUMBER_ID
	--,ENFORCEMENT_ACTIONS.ENFORCEMENT_ACTION_TYPE_CD

	INTO #TEMP_INSPECTIONS

    FROM YD040_ACTIVITY YD040
    INNER JOIN YD095_STAKEHOLDER_FILE YD095 ON  YD040.FILE_NUMBER_NUM = YD095.FILE_NUMBER_NUM  
    INNER JOIN YD101_FILE_ACTIVITY_TYPE YD101 ON YD101.FILE_NUMBER_NUM = YD095.FILE_NUMBER_NUM AND YD101.DATE_DELETED_DTE IS NULL
    INNER JOIN TD045_ACTIVITY_TYPE TD045 ON YD101.ACTIVITY_TYPE_CD = TD045.ACTIVITY_TYPE_CD 
    INNER JOIN TD001_FILE_STATUS TD001 ON YD095.FILE_STATUS_CD = TD001.FILE_STATUS_CD  
    LEFT JOIN YD041_INSPECTION YD041 ON YD040.ACTIVITY_ID = YD041.ACTIVITY_ID 
    LEFT JOIN TD038_INSPECTION_REASON TD038 ON YD041.INSPECTION_REASON_CD = TD038.INSPECTION_REASON_CD 
    
    LEFT JOIN
    (
        SELECT YD020.ACTIVITY_ID,
        YD020.VIOLATION_CD,
		YD020.VIOLATION_COMMENTS_TXT,
		YD021.MOC_SERIAL_NUMBER_NUM,
		YD021.MOC_TYPE_CD, 
		YD021.MOC_VIOLATION_COMMENTS_TXT, 
		YD021.TDG_SPECIFICATION_CD, 
		YD021.UN_NUMBER_ID
        FROM YD020_INSPECTION_VIOLATION YD020
		LEFT JOIN YD021_MOCLIST YD021 ON YD020.ACTIVITY_ID = YD021.ACTIVITY_ID AND YD020.VIOLATION_CD = YD021.VIOLATION_CD
        WHERE YD020.DATE_DELETED_DTE IS NULL
    ) VIOLATIONS ON VIOLATIONS.ACTIVITY_ID = YD040.ACTIVITY_ID
    
    
    --LEFT JOIN
    --(
    --    SELECT YD023.ACTIVITY_ID,
    --    YD023.ENFORCEMENT_ACTION_TYPE_CD
    --    FROM YD023_VIOL_ENFORCEMENT_ACTION YD023 
    --    WHERE YD023.DATE_DELETED_DTE IS NULL
    --    GROUP BY YD023.ACTIVITY_ID, YD023.ENFORCEMENT_ACTION_TYPE_CD
    --) ENFORCEMENT_ACTIONS ON ENFORCEMENT_ACTIONS.ACTIVITY_ID = YD040.ACTIVITY_ID
    
    WHERE 
    YD040.DATE_DELETED_DTE IS NULL AND 
    YD095.DATE_DELETED_DTE IS NULL AND 
    YD041.DATE_DELETED_DTE IS NULL AND 
    YD101.DATE_DELETED_DTE IS NULL 
    --AND TD045.ACTIVITY_TYPE_PARENT_CD IS NULL 
    GROUP BY 
    YD095.FILE_NUMBER_NUM, 
    TD001.FILE_STATUS_ETXT, 
    TD001.FILE_STATUS_FTXT, 
    TD045.ACTIVITY_TYPE_ENM, 
    TD045.ACTIVITY_TYPE_FNM, 
    YD040.INSPECTION_DATE_DTE, 
    YD040.ACTIVITY_ID, 
    YD040.STAKEHOLDER_ID, 
    TD045.ACTIVITY_TYPE_CD, 
    TD038.INSPECTION_REASON_ETXT, 
    TD038.INSPECTION_REASON_FTXT,
    VIOLATIONS.VIOLATION_CD,
	VIOLATIONS.VIOLATION_COMMENTS_TXT,
	VIOLATIONS.MOC_SERIAL_NUMBER_NUM,
	VIOLATIONS.MOC_TYPE_CD, 
	VIOLATIONS.MOC_VIOLATION_COMMENTS_TXT, 
	VIOLATIONS.TDG_SPECIFICATION_CD, 
	VIOLATIONS.UN_NUMBER_ID;
	--,ENFORCEMENT_ACTIONS.ENFORCEMENT_ACTION_TYPE_CD;


	DROP TABLE IF EXISTS #TEMP_VIOLATIONS;

	SELECT
	ACTIVITY_ID, 
	STAKEHOLDER_ID,
	T3.LegislationId,
	T3.Label,
	T3.Name,
	T3.[English Text],
	T1.VIOLATION_CD, 
	T1.VIOLATION_COMMENTS_TXT,
	T1.MOC_SERIAL_NUMBER_NUM,
	T1.MOC_TYPE_CD, 
	T1.MOC_VIOLATION_COMMENTS_TXT, 
	T1.TDG_SPECIFICATION_CD, 
	T1.UN_NUMBER_ID,
	T2.VIOLATION_REFERENCE_CD,
	T4.msdyn_workorderid,
	CAST(T4.msdyn_workordersummary as nvarchar(4000)) msdyn_workordersummary,
	T4.msdyn_address1,
	T4.msdyn_address2,
	T4.msdyn_address3,
	T4.msdyn_addressname,
	T4.msdyn_name,
	T4.msdyn_postalcode,
	T4.msdyn_serviceaccount,
	T4.msdyn_serviceterritory,
	T4.ovs_iisid,
	T4.qm_reportcontactid
	INTO #TEMP_VIOLATIONS
	FROM #TEMP_INSPECTIONS T1
	JOIN [dbo].[TD070_VIOLATION] T2 ON T1.VIOLATION_CD = T2.VIOLATION_CD
	JOIN [20_LEGISLATION_MATCHING] T3 ON T2.VIOLATION_CD = T3.VIOLATION_CD
	JOIN [06_WORK_ORDERS] T4 ON CAST(T4.msdyn_workordersummary as nvarchar(MAX)) = CAST(T1.ACTIVITY_ID as nvarchar(MAX));


	--SELECT DISTINCT * FROM #TEMP_VIOLATIONS;
	
TRUNCATE TABLE [07_VIOLATIONS];

INSERT INTO [dbo].[07_VIOLATIONS]
           (
			[qm_syresultid]
           ,[qm_externalcomments]
		   ,[qm_internalcomments]
           ,[qm_isviolation]
           ,[qm_name]
           ,[qm_rclegislationid]
           ,[qm_referenceid]
           ,[qm_violationcount]
           ,[qm_workorderid]
		   ,[ownerid]
           ,[owneridtype]
           ,[owningbusinessunit]
           ,[owningteam])

SELECT

newid(), 

CASE
WHEN MOC_VIOLATION_COMMENTS_TXT IS NULL OR TRIM(MOC_VIOLATION_COMMENTS_TXT) = '' THEN VIOLATION_COMMENTS_TXT 
ELSE CONCAT(T1.VIOLATION_COMMENTS_TXT, CHAR(13)+CHAR(10), 'MOC', CHAR(13)+CHAR(10), T1.MOC_VIOLATION_COMMENTS_TXT)
END,

CONCAT(
	CASE WHEN MOC_SERIAL_NUMBER_NUM IS NULL THEN '' ELSE CONCAT('MOC_SERIAL_NUMBER_NUM=', MOC_SERIAL_NUMBER_NUM, ';') END, 
	CASE WHEN MOC_TYPE_CD IS NULL			THEN '' ELSE CONCAT('MOC_TYPE_CD=', MOC_TYPE_CD, ';') END, 
	CASE WHEN TDG_SPECIFICATION_CD IS NULL	THEN '' ELSE CONCAT('TDG_SPECIFICATION_CD=', TDG_SPECIFICATION_CD, ';') END, 
	CASE WHEN UN_NUMBER_ID IS NULL			THEN '' ELSE CONCAT('UN_NUMBER_ID=', UN_NUMBER_ID, ';') END
),

1, 

CASE 
WHEN MOC_SERIAL_NUMBER_NUM IS NULL OR TRIM(MOC_SERIAL_NUMBER_NUM) = '' THEN TRIM([Label]) 
ELSE CONCAT(TRIM([Label]), ' - ', MOC_SERIAL_NUMBER_NUM)
END, 

LegislationId,
MOC_SERIAL_NUMBER_NUM,
1, 
msdyn_workorderid,
'd0483132-b964-eb11-a812-000d3af38846'									[ownerid],
'team'																	[owneridtype],
'4e122e0c-73f3-ea11-a815-000d3af3ac0d'									[owningbusinessunit],
'd0483132-b964-eb11-a812-000d3af38846'									[owningteam]
FROM
(
	SELECT DISTINCT * FROM #TEMP_VIOLATIONS
) T1
--=========================================================================================================
--=========================================================================================================





--POST MIGRATION SANITY CHECKS
--=========================================================================================================
--=========================================================================================================

--staging data check; tables should no longer be empty
SELECT COUNT(*)	[02_REGULATED_ENTITIES]					FROM [dbo].[02_REGULATED_ENTITIES];
SELECT COUNT(*)	[03_SITES]								FROM [dbo].[03_SITES];
SELECT COUNT(*)	[04_ACCOUNT]							FROM [dbo].[04_ACCOUNT];
SELECT COUNT(*)	[06_WORK_ORDERS]						FROM [dbo].[06_WORK_ORDERS];
SELECT COUNT(*)	[07_VIOLATIONS]							FROM [dbo].[07_VIOLATIONS];
SELECT COUNT(*)	[11_CONTACT]							FROM [dbo].[11_CONTACT];
SELECT COUNT(*)	[12_BOOKABLE_RESOURCE]					FROM [dbo].[12_BOOKABLE_RESOURCE];
SELECT COUNT(*)	[18_BOOKABLE_RESOURCE_CATEGORY_ASSN]	FROM [dbo].[18_BOOKABLE_RESOURCE_CATEGORY_ASSN];



--once data 
--match account staging table to replicated crm account table to see how many accounts were migrated
SELECT * FROM 
[dbo].[account] T1
JOIN [dbo].[04_ACCOUNT] T2 ON T1.accountid = T2.id
WHERE T2.customertypecode <> 948010000


--match contact staging table to replicated crm contact table to see how many contacts were migrated
SELECT * FROM 
[dbo].[11_CONTACT] T1
JOIN [dbo].[contact] T2 ON T1.accountid = T2.parentcustomerid;


--match contact staging table to replicated crm account table to see how many contacts were assigned to sites in crm
SELECT * FROM 
[dbo].[11_CONTACT] T1
JOIN [dbo].[account] T2 ON T1.accountid = T2.accountid;


--match work order staging table to replicated crm work order table to see how many work order were created in crm
SELECT * FROM 
[dbo].[06_WORK_ORDERS] T1
JOIN [dbo].msdyn_workorder T2 ON T1.msdyn_workorderid = T2.msdyn_workorderid;


--match violation staging table to replicated crm violation table to see how many violations were created in crm
--SELECT * FROM 
--[dbo].[07_VIOLATIONS] T1
--JOIN [dbo].[qm_syresult] T2 ON T1.qm_syresultid = T2.qm_syresultid;
--=========================================================================================================
--=========================================================================================================