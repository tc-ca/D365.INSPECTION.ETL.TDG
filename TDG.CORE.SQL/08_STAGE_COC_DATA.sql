
--TABLE DEFINITIONS
--===================================================================================
--===================================================================================
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STAGING__COC]') AND type in (N'U'))
	DROP TABLE [dbo].[STAGING__COC];
	go

	CREATE TABLE [dbo].[STAGING__COC] (
		[Id] [uniqueidentifier] NOT NULL,
		[SinkCreatedOn] [datetime] NULL,
		[SinkModifiedOn] [datetime] NULL,
		[statecode] [int] NULL,
		[statuscode] [int] NULL,
		[instancetypecode] [int] NULL,
		[prioritycode] [int] NULL,
		[deliveryprioritycode] [int] NULL,
		[community] [int] NULL,
		[isbilled] [bit] NULL,
		[isworkflowcreated] [bit] NULL,
		[isregularactivity] [bit] NULL,
		[ismapiprivate] [bit] NULL,
		[leftvoicemail] [bit] NULL,
		[createdonbehalfby] [uniqueidentifier] NULL,
		[createdonbehalfby_entitytype] [nvarchar](128) NULL,
		[ovs_violation] [uniqueidentifier] NULL,
		[ovs_violation_entitytype] [nvarchar](128) NULL,
		[modifiedonbehalfby] [uniqueidentifier] NULL,
		[modifiedonbehalfby_entitytype] [nvarchar](128) NULL,
		[owningteam] [uniqueidentifier] NULL,
		[owningteam_entitytype] [nvarchar](128) NULL,
		[sendermailboxid] [uniqueidentifier] NULL,
		[sendermailboxid_entitytype] [nvarchar](128) NULL,
		[regardingobjectid] [uniqueidentifier] NULL,
		[regardingobjectid_entitytype] [nvarchar](128) NULL,
		[slaid] [uniqueidentifier] NULL,
		[slaid_entitytype] [nvarchar](128) NULL,
		[owninguser] [uniqueidentifier] NULL,
		[owninguser_entitytype] [nvarchar](128) NULL,
		[serviceid] [uniqueidentifier] NULL,
		[serviceid_entitytype] [nvarchar](128) NULL,
		[transactioncurrencyid] [uniqueidentifier] NULL,
		[transactioncurrencyid_entitytype] [nvarchar](128) NULL,
		[slainvokedid] [uniqueidentifier] NULL,
		[slainvokedid_entitytype] [nvarchar](128) NULL,
		[createdby] [uniqueidentifier] NULL,
		[createdby_entitytype] [nvarchar](128) NULL,
		[modifiedby] [uniqueidentifier] NULL,
		[modifiedby_entitytype] [nvarchar](128) NULL,
		[owningbusinessunit] [uniqueidentifier] NULL,
		[owningbusinessunit_entitytype] [nvarchar](128) NULL,
		[ownerid] [uniqueidentifier] NULL,
		[ownerid_entitytype] [nvarchar](128) NULL,
		[from] [uniqueidentifier] NULL,
		[to] [uniqueidentifier] NULL,
		[customers] [uniqueidentifier] NULL,
		[partners] [uniqueidentifier] NULL,
		[bcc] [uniqueidentifier] NULL,
		[cc] [uniqueidentifier] NULL,
		[resources] [uniqueidentifier] NULL,
		[organizer] [uniqueidentifier] NULL,
		[requiredattendees] [uniqueidentifier] NULL,
		[optionalattendees] [uniqueidentifier] NULL,
		[versionnumber] [bigint] NULL,
		[createdon] [datetime] NULL,
		[modifiedonbehalfbyyominame] [nvarchar](100) NULL,
		[ovs_justificationtxt] [nvarchar](max) NULL,
		[activityid] [uniqueidentifier] NULL,
		[ovs_blobpath] [nvarchar](300) NULL,
		[deliverylastattemptedon] [datetime] NULL,
		[sendermailboxidname] [nvarchar](100) NULL,
		[regardingobjectidyominame] [nvarchar](400) NULL,
		[owneridname] [nvarchar](100) NULL,
		[timezoneruleversionnumber] [int] NULL,
		[exchangeitemid] [nvarchar](200) NULL,
		[scheduledstart] [datetime] NULL,
		[actualstart] [datetime] NULL,
		[createdonbehalfbyyominame] [nvarchar](100) NULL,
		[exchangerate] [decimal](38, 10) NULL,
		[activityadditionalparams] [nvarchar](max) NULL,
		[seriesid] [uniqueidentifier] NULL,
		[subject] [nvarchar](100) NULL,
		[overriddencreatedon] [datetime] NULL,
		[ovs_daterequested] [datetime] NULL,
		[regardingobjectidname] [nvarchar](400) NULL,
		[senton] [datetime] NULL,
		[traversedpath] [nvarchar](1250) NULL,
		[createdonbehalfbyname] [nvarchar](100) NULL,
		[activitytypecode] [nvarchar](4000) NULL,
		[scheduleddurationminutes] [int] NULL,
		[utcconversiontimezonecode] [int] NULL,
		[lastonholdtime] [datetime] NULL,
		[sortdate] [datetime] NULL,
		[importsequencenumber] [int] NULL,
		[owneridyominame] [nvarchar](100) NULL,
		[processid] [uniqueidentifier] NULL,
		[scheduledend] [datetime] NULL,
		[description] [nvarchar](max) NULL,
		[modifiedon] [datetime] NULL,
		[createdbyname] [nvarchar](100) NULL,
		[regardingobjecttypecode] [nvarchar](4000) NULL,
		[modifiedonbehalfbyname] [nvarchar](100) NULL,
		[owneridtype] [nvarchar](4000) NULL,
		[stageid] [uniqueidentifier] NULL,
		[createdbyyominame] [nvarchar](100) NULL,
		[transactioncurrencyidname] [nvarchar](100) NULL,
		[actualend] [datetime] NULL,
		[modifiedbyyominame] [nvarchar](100) NULL,
		[onholdtime] [int] NULL,
		[serviceidname] [nvarchar](100) NULL,
		[exchangeweblink] [nvarchar](1250) NULL,
		[slainvokedidname] [nvarchar](100) NULL,
		[slaname] [nvarchar](100) NULL,
		[modifiedbyname] [nvarchar](100) NULL,
		[ovs_violationname] [nvarchar](300) NULL,
		[actualdurationminutes] [int] NULL,
		[postponeactivityprocessinguntil] [datetime] NULL,
	 CONSTRAINT [EPK[dbo]].[STAGING__COC]]] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

go


--CONFIRMATION OF COMPLIANCE

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



--===================================================================================
--===================================================================================

--STAGE CONFIRMATION OF COMPLIANCE DATA FROM STAGED VIOLATION DATA JOINED TO IIS VIOLATION FOLLOW UP TABLE

	--CONFIRMATION OF COMPLIANCE OPTIONSET VALUES
	--STATECODE  - DRAFT = 0, CLOSED = 1, CANCELED =2, ACTIVE =3
	--STATUSCODE - DRAFT = 1, CONFIRMATION ON-SITE = 2, CONFIRMATION RECEIVED ON TIME = 918640000, CONFIRMATION RECEIVED LATE = 918640001, CLOSED UNRESOLVED = 918640002, CLOSED ESCALATED = 918640003, CANCELLED = 3, ACTIVE = 4
	INSERT INTO [dbo].STAGING__COC
			   (
				[Id]
			   ,[statecode]
			   ,[statuscode]
			   ,[subject]
			   ,[ovs_violation]
			   ,[regardingobjectid]
			   ,[regardingobjectid_entitytype]
			   ,[regardingobjecttypecode]
			   ,[ovs_justificationtxt]
			   ,[actualstart]
			   ,[actualend]
			   ,scheduledstart
			   ,scheduledend
			   ,[ovs_daterequested]
			   ,[description])
     
	SELECT 
	NEWID() ID, 
	--,[activityid]
	--,[activitytypecode]

--	FOLLOW_UP_TYPE_CD	FOLLOW_UP_TYPE_ELBL
--1	Confirmation of compliance to be provided in 30 days
--2	Violation Resolved
--3	Confirmation of compliance not received
--4	Confirmation of compliance not requested by inspector

----Confirmation of compliance to be provided in 30 days = ACTIVE/ACTIVE
----Violation Resolved = CLOSED/CONFIRMATION RECEIVED - ON TIME
----Confirmation of compliance not received = CLOSED - UNRESOLVED
----Confirmation of compliance not requested by inspector = CLOSED/CONFIRMATION ON-SITE (TO BE CHANGED TO NEW STATUS OF NOT REQUESTED)

	--VIOLATIONS THAT DON'T HAVE ANY FOLLOWUP DATA, OR CHECKBOXES SELECTED IN IIS, WE WILL CREATE
	CASE WHEN T2.FOLLOW_UP_TYPE_CD = 2 THEN 1			--'CLOSED'
		 WHEN T2.FOLLOW_UP_TYPE_CD = 3 THEN 1			--'CLOSED'
		 WHEN T2.FOLLOW_UP_TYPE_CD = 4 THEN 1			--'CLOSED'
		 WHEN T2.FOLLOW_UP_TYPE_CD = 1 THEN 3			--'ACTIVE'
	END statecode,

	CASE WHEN T2.FOLLOW_UP_TYPE_CD = 2 THEN 918640000	-- 'CONFIRMATION RECEIVED - ON TIME'
		 WHEN T2.FOLLOW_UP_TYPE_CD = 3 THEN 918640002	--'UNRESOLVED'
		 WHEN T2.FOLLOW_UP_TYPE_CD = 4 THEN 2			--'CONFIRMATION ON-SITE'
		 WHEN T2.FOLLOW_UP_TYPE_CD = 1 THEN 4			--'ACTIVE'
	END statuscode

	,CONCAT('CC-', YEAR(T2.DATE_FOLLOW_UP_DTE), '-', REPLACE(STR(ROW_NUMBER() OVER (ORDER BY qm_syresultid), 8), ' ', '0')) [subject]

	,qm_syresultid					 [ovs_violation]
	,qm_workorderid					 [regardingobjectid]
	,'msdyn_workorder'				 [regardingobjectid_entitytype]
	,'msdyn_workorder'				 [regardingobjecttypecode]
	,t2.INSPECTION_JUSTIFICATION_TXT [ovs_justificationtxt]


	,T2.DATE_CREATED_DTE			 [actualstart]
	
	--IF THE STATUS IS ACTIVE, WE WON'T SET THE END DATE
	--IF THE STATUS IS NOT ACTIVE, WE'LL JUST INCREMENT THE END DATE A TINY BIT SO ITS NOT THE EXACT SAME AS THE START DATE, WHICH IS A VALIDATION RULE IN CRM
	,CASE 
		WHEN T2.FOLLOW_UP_TYPE_CD = 1 THEN NULL 
		ELSE DATE_FOLLOW_UP_DTE
	END [actualend]

	,T2.DATE_FOLLOW_UP_DTE - 30 [scheduledstart]
	,T2.DATE_FOLLOW_UP_DTE		[scheduledend] --SCHEDULED END = DUE DATE
	,T2.DATE_FOLLOW_UP_DTE - 30 [ovs_daterequested]
	,FOLLOW_UP_COMMENT_TXT		[description]

	FROM STAGING__VIOLATIONS T1
	LEFT JOIN [YD082_INSPECTION_VIOLATION] T2 ON T1.qm_iisviolationcd = t2.VIOLATION_CD AND T1.qm_iisactivityid = T2.ACTIVITY_ID
	JOIN TD005_FOLLOW_UP_TYPE T5 ON T2.FOLLOW_UP_TYPE_CD = T5.FOLLOW_UP_TYPE_CD
	WHERE 
	T2.DATE_DELETED_DTE IS NULL
	and qm_rclegislationid is not null;


	--UPDATE OWNERSHIP OF CoCs
	UPDATE STAGING__COC
	--SELECT T1.qm_iisactivityid, T1.qm_iisviolationcd, T1.qm_syresultid, T4.systemuserid, T3.bookableresourceid, T3.name, T2.msdyn_name, T2.ovs_primaryinspectorname, T1.qm_name STAGING__COC 
	SET ownerid = T4.systemuserid,
		owneridtype = @CONST_OWNERIDTYPE_SYSTEMUSER
	FROM STAGING__COC COC
	JOIN STAGING__VIOLATIONS T1 ON T1.qm_syresultid = COC.ovs_violation
	JOIN STAGING__WORK_ORDERS T2 ON T1.qm_workorderid = T2.msdyn_workorderid
	JOIN STAGING__BOOKABLE_RESOURCE T3 ON T2.ovs_primaryinspectorname = T3.name
	JOIN CRM__SYSTEMUSER T4 ON T3.userid = T4.systemuserid;

	--UPDATE THE OWNERSHIP OF COCS TO THE GENERIC TDG CORE USER WHERE WE COULD NOT FIND A MATCH FOR THE INSPECTOR
	UPDATE STAGING__COC
	SET ownerid = @CONST_TDGCORE_USERID,
		owneridtype = @CONST_OWNERIDTYPE_SYSTEMUSER
	FROM STAGING__COC
	WHERE OWNERID IS NULL;

	--UPDATE OWNERSHIP OF RECORDS   
	--UPDATE STAGING__COC
	--SET 
	--OWNERID				= @CONST_TDGCORE_USERID,
	--OWNERIDTYPE			= @CONST_OWNERIDTYPE_SYSTEMUSER,
	--OWNINGBUSINESSUNIT	= @CONST_BUSINESSUNIT_TDG_ID,
	--OWNINGUSER			= @CONST_TDGCORE_USERID;
	
	--SET ACTIVITYID WHICH IS PK IN CRM
	UPDATE STAGING__COC SET activityid = ID;

	--FIX EMPTY STRING JUSTIFICATIONS FROM IIS
	UPDATE STAGING__COC SET ovs_justificationtxt = NULL WHERE ovs_justificationtxt = ' ';



--BUSINESS ONLY WANTS DATA STARTING FROM APRIL 1 2019, SO DELETE ALL THE REST
--SELECT [subject], [actualstart], [description], [ovs_justificationtxt],

--CASE WHEN statecode = 1 THEN 'CLOSED'
--	WHEN statecode = 3 THEN 'ACTIVE'
--END statecode,

--CASE WHEN statuscode = 918640000 THEN 'CONFIRMATION RECEIVED - ON TIME'
--	WHEN statuscode = 918640002 THEN 'UNRESOLVED'
--	WHEN statuscode = 2 THEN 'CONFIRMATION ON-SITE'
--	WHEN statuscode = 4 THEN 'ACTIVE'
--END statuscode
	
--FROM STAGING__COC WHERE actualstart > CAST('04/01/2019' AS DATE) 
--ORDER BY statecode, actualstart;

--COMMAND TO BE USED IN SSIS
SELECT 
*
FROM STAGING__COC
WHERE actualstart > CAST('04/01/2019' AS DATE);

DECLARE @COC_AFTER_APRIL_1_2019					INT = 0, 
		@COC_BEFORE_APRIL_1_2019				INT = 0, 
		@VIOLATIONS_WITH_PROVISION				INT = 0, 
		@VIOLATIONS_WITH_NO_PROVISION			INT = 0,
		@ACTIVE_COC								INT = 0,
		@CONFIRM_ON_SITE						INT = 0,
		@UNRESOLVED								INT = 0,
		@CONFIRMED_ON_TIME						INT = 0,
		@ACTIVE_COC_AFTER_APRIL_1_2019			INT = 0,
		@CONFIRM_ON_SITE_AFTER_APRIL_1_2019		INT = 0,
		@UNRESOLVED_AFTER_APRIL_1_2019			INT = 0,
		@CONFIRMED_ON_TIME_AFTER_APRIL_1_2019	INT = 0;

SELECT @VIOLATIONS_WITH_NO_PROVISION		 = COUNT(*) FROM STAGING__VIOLATIONS where qm_rclegislationid is null;
SELECT @VIOLATIONS_WITH_PROVISION			 = COUNT(*) FROM STAGING__VIOLATIONS where qm_rclegislationid IS NOT NULL;
SELECT @COC_BEFORE_APRIL_1_2019				 = COUNT(*) FROM STAGING__COC where actualstart < CAST('04/01/2019' AS DATE);
SELECT @COC_AFTER_APRIL_1_2019				 = COUNT(*) FROM STAGING__COC where actualstart >= CAST('04/01/2019' AS DATE);

SELECT @CONFIRMED_ON_TIME					 = COUNT(*) FROM STAGING__COC	where statuscode = 918640000;
SELECT @UNRESOLVED							 = COUNT(*) FROM STAGING__COC	where statuscode = 918640002;
SELECT @CONFIRM_ON_SITE						 = COUNT(*) FROM STAGING__COC	where statuscode = 2;
SELECT @ACTIVE_COC							 = COUNT(*) FROM STAGING__COC	where statuscode = 4;

SELECT @CONFIRMED_ON_TIME_AFTER_APRIL_1_2019 = COUNT(*) FROM STAGING__COC where actualstart >= CAST('04/01/2019' AS DATE) AND statuscode = 918640000;
SELECT @UNRESOLVED_AFTER_APRIL_1_2019		 = COUNT(*) FROM STAGING__COC where actualstart >= CAST('04/01/2019' AS DATE) AND statuscode = 918640002;
SELECT @CONFIRM_ON_SITE_AFTER_APRIL_1_2019	 = COUNT(*) FROM STAGING__COC where actualstart >= CAST('04/01/2019' AS DATE) AND statuscode = 2;
SELECT @ACTIVE_COC_AFTER_APRIL_1_2019		 = COUNT(*) FROM STAGING__COC where actualstart >= CAST('04/01/2019' AS DATE) AND statuscode = 4;

SELECT  @COC_AFTER_APRIL_1_2019 COC_AFTER_APRIL_1_2019, 
		@COC_BEFORE_APRIL_1_2019 COC_BEFORE_APRIL_1_2019, 
		@VIOLATIONS_WITH_PROVISION VIOLATIONS_WITH_PROVISION, 
		@VIOLATIONS_WITH_NO_PROVISION VIOLATIONS_WITH_NO_PROVISION, 
		@CONFIRMED_ON_TIME CONFIRMED_ON_TIME, 
		@UNRESOLVED UNRESOLVED, 
		@CONFIRM_ON_SITE CONFIRM_ON_SITE, 
		@ACTIVE_COC ACTIVE_COC, 
		@CONFIRMED_ON_TIME_AFTER_APRIL_1_2019 CONFIRMED_ON_TIME_AFTER_APRIL_1_2019, 
		@UNRESOLVED_AFTER_APRIL_1_2019 UNRESOLVED_AFTER_APRIL_1_2019, 
		@CONFIRM_ON_SITE_AFTER_APRIL_1_2019 CONFIRM_ON_SITE_AFTER_APRIL_1_2019, 
		@ACTIVE_COC_AFTER_APRIL_1_2019 ACTIVE_COC_AFTER_APRIL_1_2019;


--COC ONLY CREATED FROM >= APRIL 1 2019





--select 
--activityid,
--actualend,
--actualstart,
--description,
--ovs_daterequested,
--ovs_justificationtxt,
--ovs_violation,
--ownerid,
--owneridtype,
--regardingobjectid,
--regardingobjecttypecode,
--statecode,
--statuscode,
--subject
--from 
--[STAGING__COC]