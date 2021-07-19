--/****** Object:  Table [dbo].[STAGING__WORKORDER_SUBSTATUS]    Script Date: 2021-07-18 11:07:39 AM ******/
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STAGING__WORKORDER_SUBSTATUS]') AND type in (N'U'))
--DROP TABLE [dbo].[STAGING__WORKORDER_SUBSTATUS]
--GO

--IF YOU WANT TO DROP AND RECREATE, COMMENT OUT BELOW LINE AND UNCOMMENT ABOVE

--ONLY CREATE TABLE IF IT DOESNT ALREADY EXIST
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STAGING__WORKORDER_SUBSTATUS]') AND type in (N'U'))
CREATE TABLE [dbo].[STAGING__WORKORDER_SUBSTATUS](
[createdby] [uniqueidentifier] NULL,
[createdby_entitytype] [nvarchar](128) NULL,
[createdbyname] [nvarchar](100) NULL,
[createdbyyominame] [nvarchar](100) NULL,
[createdon] [datetime] NULL,
[createdonbehalfby] [uniqueidentifier] NULL,
[createdonbehalfby_entitytype] [nvarchar](128) NULL,
[createdonbehalfbyname] [nvarchar](100) NULL,
[createdonbehalfbyyominame] [nvarchar](100) NULL,
[importsequencenumber] [int] NULL,
[modifiedby] [uniqueidentifier] NULL,
[modifiedby_entitytype] [nvarchar](128) NULL,
[modifiedbyname] [nvarchar](100) NULL,
[modifiedbyyominame] [nvarchar](100) NULL,
[modifiedon] [datetime] NULL,
[modifiedonbehalfby] [uniqueidentifier] NULL,
[modifiedonbehalfby_entitytype] [nvarchar](128) NULL,
[modifiedonbehalfbyname] [nvarchar](100) NULL,
[modifiedonbehalfbyyominame] [nvarchar](100) NULL,
[msdyn_defaultsubstatus] [bit] NULL,
[msdyn_name] [nvarchar](100) NULL,
[msdyn_systemstatus] [int] NULL,
[msdyn_workordersubstatusid] [uniqueidentifier] NOT NULL,
[overriddencreatedon] [datetime] NULL,
[ownerid] [uniqueidentifier] NULL,
[ownerid_entitytype] [nvarchar](128) NULL,
[owneridname] [nvarchar](100) NULL,
[owneridtype] [nvarchar](4000) NULL,
[owneridyominame] [nvarchar](100) NULL,
[owningbusinessunit] [uniqueidentifier] NULL,
[owningbusinessunit_entitytype] [nvarchar](128) NULL,
[owningteam] [uniqueidentifier] NULL,
[owningteam_entitytype] [nvarchar](128) NULL,
[owninguser] [uniqueidentifier] NULL,
[owninguser_entitytype] [nvarchar](128) NULL,
[SinkCreatedOn] [datetime] NULL,
[SinkModifiedOn] [datetime] NULL,
[statecode] [int] NULL,
[statuscode] [int] NULL,
[timezoneruleversionnumber] [int] NULL,
[utcconversiontimezonecode] [int] NULL,
[versionnumber] [bigint] NULL,
 CONSTRAINT [EPK[dbo]].[STAGING__WORKORDER_SUBSTATUS]]] PRIMARY KEY CLUSTERED 
(
	[msdyn_workordersubstatusid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

BEGIN TRANSACTION;

--=============================================DYNAMIC VALUES===========================================
DECLARE @CONST_TDGCORE_DOMAINNAME           VARCHAR(50) = 'tdg.core@034gc.onmicrosoft.com';
DECLARE @CONST_TDGCORE_USERID               VARCHAR(50) = (SELECT systemuserid FROM CRM__SYSTEMUSER  where domainname = 'tdg.core@034gc.onmicrosoft.com');
DECLARE @CONST_TEAM_TDG_ID                  VARCHAR(500)= (SELECT teamid FROM CRM__TEAM WHERE name = 'Transportation of Dangerous Goods');
DECLARE @CONST_BUSINESSUNIT_TDG_ID          VARCHAR(50) = (SELECT businessunitid FROM CRM__BUSINESSUNIT WHERE name = 'Transportation of Dangerous Goods');
DECLARE @CONST_OWNERIDTYPE_TEAM             VARCHAR(50)	= 'team';
DECLARE @CONST_OWNERIDTYPE_SYSTEMUSER       VARCHAR(50)	= 'systemuser';

SELECT  @CONST_TDGCORE_DOMAINNAME           TDGCORE_DOMAINNAME           
	   ,@CONST_TDGCORE_USERID               TDGCORE_USERID               
	   ,@CONST_TEAM_TDG_ID                  TEAM_TDG_ID                  
	   ,@CONST_BUSINESSUNIT_TDG_ID          BUSINESSUNIT_TDG_ID          
	   ,@CONST_OWNERIDTYPE_TEAM             OWNERIDTYPE_TEAM             
	   ,@CONST_OWNERIDTYPE_SYSTEMUSER		OWNERIDTYPE_SYSTEMUSER;
--===================================================================================================


--MOVE DATA FROM SOURCE TO STAGING UPDATING RECORD OWNERSHIP
--SINGLE OPERATION UPSERT PATTERN
--===================================================================================================
UPDATE [dbo].[STAGING__WORKORDER_SUBSTATUS] WITH (UPDLOCK, SERIALIZABLE)
   SET 
	  [msdyn_name]			   = T2.[msdyn_name]
     ,[msdyn_systemstatus]	   = T2.[msdyn_systemstatus]
     ,[ownerid]				   = T2.[ownerid]
     ,[owneridtype]			   = T2.[owneridtype]
     ,[owningbusinessunit]	   = T2.[owningbusinessunit]
     ,[owninguser]			   = T2.[owninguser]
     ,[statecode]			   = T2.[statecode]
     ,[statuscode]			   = T2.[statuscode]
	 ,[msdyn_defaultsubstatus] = 0
FROM
SOURCE__WORKORDER_SUBSTATUS T1
JOIN STAGING__WORKORDER_SUBSTATUS T2 ON T1.msdyn_workordersubstatusid = T2.msdyn_workordersubstatusid;


IF @@ROWCOUNT = 0 
BEGIN
	INSERT INTO [dbo].STAGING__WORKORDER_SUBSTATUS
			   (
				[msdyn_workordersubstatusid]
			   ,[msdyn_name]
			   ,[msdyn_systemstatus]
			   ,[ownerid]
			   ,[owneridtype]
			   ,[owningbusinessunit]
			   ,[owninguser]
			   ,[statecode]
			   ,[statuscode]
			   ,[msdyn_defaultsubstatus])

	SELECT 
	 [msdyn_workordersubstatusid]
	,[msdyn_name]
	,[msdyn_systemstatus]
	,@CONST_TDGCORE_USERID
	,@CONST_OWNERIDTYPE_SYSTEMUSER
	,@CONST_BUSINESSUNIT_TDG_ID
	,@CONST_TDGCORE_USERID
	,[statecode]
	,[statuscode]
	,0
	FROM SOURCE__WORKORDER_SUBSTATUS;
END

 
COMMIT TRANSACTION;
--===================================================================================================



--COUNT CHECK
--===================================================================================================
SELECT 
(SELECT COUNT(*) FROM SOURCE__WORKORDER_SUBSTATUS)  [SOURCE],
(SELECT COUNT(*) FROM STAGING__WORKORDER_SUBSTATUS) [STAGING];
--===================================================================================================



--SSIS QUERY
--SELECT 
--[msdyn_workordersubstatusid]
--,[msdyn_name]
--,[msdyn_systemstatus]
--,[ownerid]
--,[owneridtype]
--,[owningbusinessunit]
--,[owninguser]
--,[statecode]
--,[statuscode]
--,[msdyn_defaultsubstatus]
--FROM STAGING__WORKORDER_SUBSTATUS;