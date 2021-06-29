/****** Object:  Table [dbo].[STAGING__ACCOUNTUN]    Script Date: 6/28/2021 7:37:13 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STAGING__ACCOUNTUN]') AND type in (N'U'))
DROP TABLE [dbo].[STAGING__ACCOUNTUN]
GO

/****** Object:  Table [dbo].[STAGING__ACCOUNTUN]    Script Date: 6/28/2021 7:37:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[STAGING__ACCOUNTUN](
	[Id] [uniqueidentifier] NOT NULL,
	[SinkCreatedOn] [datetime] NULL,
	[SinkModifiedOn] [datetime] NULL,
	[statecode] [int] NULL,
	[statuscode] [int] NULL,
	[ovs_supplychaindirection] [nvarchar](4000) NULL,
	[owninguser] [uniqueidentifier] NULL,
	[owninguser_entitytype] [nvarchar](128) NULL,
	[createdonbehalfby] [uniqueidentifier] NULL,
	[createdonbehalfby_entitytype] [nvarchar](128) NULL,
	[owningbusinessunit] [uniqueidentifier] NULL,
	[owningbusinessunit_entitytype] [nvarchar](128) NULL,
	[owningteam] [uniqueidentifier] NULL,
	[owningteam_entitytype] [nvarchar](128) NULL,
	[modifiedby] [uniqueidentifier] NULL,
	[modifiedby_entitytype] [nvarchar](128) NULL,
	[createdby] [uniqueidentifier] NULL,
	[createdby_entitytype] [nvarchar](128) NULL,
	[ovs_accountunnumber] [uniqueidentifier] NULL, --ACCOUNTID
	[ovs_accountunnumber_entitytype] [nvarchar](128) NULL,
	[ovs_unnumber] [uniqueidentifier] NULL, --UNNUMBER
	[ovs_unnumber_entitytype] [nvarchar](128) NULL,
	[modifiedonbehalfby] [uniqueidentifier] NULL,
	[modifiedonbehalfby_entitytype] [nvarchar](128) NULL,
	[ownerid] [uniqueidentifier] NULL,
	[ownerid_entitytype] [nvarchar](128) NULL,
	[createdonbehalfbyyominame] [nvarchar](100) NULL,
	[modifiedon] [datetime] NULL,
	[owneridname] [nvarchar](100) NULL,
	[ovs_accountunnumbername] [nvarchar](160) NULL,
	[ovs_unnumbername] [nvarchar](100) NULL,
	[ovs_accountunid] [uniqueidentifier] NULL, --PK
	[importsequencenumber] [int] NULL,
	[utcconversiontimezonecode] [int] NULL,
	[createdbyyominame] [nvarchar](100) NULL,
	[modifiedbyname] [nvarchar](100) NULL,
	[modifiedbyyominame] [nvarchar](100) NULL,
	[timezoneruleversionnumber] [int] NULL,
	[owneridtype] [nvarchar](4000) NULL,
	[ovs_name] [nvarchar](100) NULL,
	[owneridyominame] [nvarchar](100) NULL,
	[modifiedonbehalfbyyominame] [nvarchar](100) NULL,
	[createdbyname] [nvarchar](100) NULL,
	[createdon] [datetime] NULL,
	[createdonbehalfbyname] [nvarchar](100) NULL,
	[modifiedonbehalfbyname] [nvarchar](100) NULL,
	[versionnumber] [bigint] NULL,
	[ovs_accountunnumberyominame] [nvarchar](160) NULL,
	[overriddencreatedon] [datetime] NULL,
 CONSTRAINT [EPK[dbo]].[STAGING__ACCOUNTUN]]] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


--DROP TEMP TABLES
--==================================================================
DROP TABLE IF EXISTS #TEMP__ACCOUNT_UNNUMBERS; 
GO
--==================================================================


--DECLARE DYNAMICS VALUES
--===================================================================================================
DECLARE @CONST_TDGCORE_DOMAINNAME  VARCHAR(50)  = 'tdg.core@034gc.onmicrosoft.com';
DECLARE @CONST_TDGCORE_USERID      VARCHAR(50)  = (SELECT systemuserid FROM CRM__SYSTEMUSER  where domainname = 'tdg.core@034gc.onmicrosoft.com');
DECLARE @CONST_TEAM_TDG_ID          VARCHAR(500) = (SELECT teamid FROM CRM__TEAM WHERE name = 'Transportation of Dangerous Goods');
DECLARE @CONST_BUSINESSUNIT_TDG_ID VARCHAR(50)  = (SELECT businessunitid FROM CRM__BUSINESSUNIT WHERE name = 'Transportation of Dangerous Goods');
DECLARE @CONST_OWNERIDTYPE_TEAM VARCHAR(50)			= 'team';
DECLARE @CONST_OWNERIDTYPE_SYSTEMUSER VARCHAR(50)	= 'systemuser';

--WILL LOSE THESE VARIABLE VALUES IF 'GO' IS USED FROM THIS POINT ON
--===================================================================================================


--MAIN QUERY
--JOINS IIS DATA WITH ROM DATA BY UNNUMBER AND SHIPPING NAME AND LOADS DATA INTO TEMP TABLE
--==================================================================
--930840000 INBOUND
--930840001 OUTBOUND

SELECT 
newid()			[ovs_accountunid] --PK
,''				[ovs_name]
,T3.id			[ovs_unnumber] --UN NUMBER
,T4.accountid	[ovs_accountunnumber] --ACCOUNTID

,CASE 
WHEN INBOUND_IND = 1 AND OUTBOUND_IND = 1 THEN '930840000;930840001'
WHEN INBOUND_IND = 1 AND OUTBOUND_IND = 0 THEN '930840000'
WHEN INBOUND_IND = 0 AND OUTBOUND_IND = 1 THEN '930840001'
WHEN INBOUND_IND = 0 AND OUTBOUND_IND = 0 THEN NULL
END [ovs_supplychaindirection]

INTO #TEMP__ACCOUNT_UNNUMBERS
FROM [dbo].[YD031_STAKEHOLDER_DG_PROFILE] T1
JOIN [XD002_DANGEROUS_GOOD] T2 ON T1.UN_NUMBER_ID = T2.UN_NUMBER_ID 
JOIN STAGING_UN_NUMBERS T3 ON (LEN(T1.UN_NUMBER_ID) = 6 AND T3.tdg_name = T1.UN_NUMBER_ID) OR (LEN(T1.UN_NUMBER_ID) = 7 AND (T2.SHIPPING_NAME_ENM = T3.tdg_shippingnamedescriptionetxt OR T2.SHIPPING_NAME_FNM = T3.tdg_shippingnamedescriptionFtxt))
JOIN STAGING__ACCOUNT T4 ON T1.STAKEHOLDER_ID = T4.ovs_iisid
ORDER BY T1.[UN_NUMBER_ID];
--==================================================================


--INSERT THE DATA INTO THE STAGING TABLE
--==================================================================
INSERT INTO [dbo].[STAGING__ACCOUNTUN]
           ([Id]
           ,[ovs_accountunid] --PK
           ,[ovs_supplychaindirection]
           ,[ovs_accountunnumber] --ACCOUNT ID
           ,[ovs_unnumber] --UN NUMBER
           ,[ovs_name])
SELECT 
 [ovs_accountunid] Id
,[ovs_accountunid] --PK
,[ovs_supplychaindirection]
,[ovs_accountunnumber]
,[ovs_unnumber] --UN NUMBER
,[ovs_name]
FROM #TEMP__ACCOUNT_UNNUMBERS
--==================================================================


--UPDATE OWNERSHIP OF RECORDS TO THE GENERIC TDG CORE USER
--==================================================================
UPDATE STAGING__accountclass 
SET 
ownerid = @CONST_TDGCORE_USERID,
owneridtype = @CONST_OWNERIDTYPE_SYSTEMUSER,
owningbusinessunit = @CONST_BUSINESSUNIT_TDG_ID,
owninguser = @CONST_TDGCORE_USERID;
--==================================================================


--QUERY FOR SSIS
SELECT 
[Id]
,[ovs_supplychaindirection]
,[ovs_accountunnumber] --ACCOUNT ID
,[ovs_unnumber] --UN NUMBER
,[ovs_accountunid]
,[ovs_name]
,ownerid
,owneridtype
,owningbusinessunit
,owninguser
FROM [STAGING__ACCOUNTUN];
