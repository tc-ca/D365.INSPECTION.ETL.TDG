/****** Object:  Table [dbo].[tdgdata__ovs_accountclass]    Script Date: 6/7/2021 11:29:16 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STAGING__accountclass]') AND type in (N'U'))
DROP TABLE [dbo].[STAGING__accountclass]

/****** Object:  Table [dbo].[STAGING__accountclass]    Script Date: 6/7/2021 11:29:16 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

CREATE TABLE [dbo].[STAGING__accountclass] (
	[Id] [uniqueidentifier] NOT NULL,
	[ovs_accountclassid] [uniqueidentifier] NULL,
	[ovs_accountclass] [uniqueidentifier] NULL,
	[ovs_name] [nvarchar](100) NULL,
	[ovs_primaryclass] [nvarchar](4000) NULL,
	[ovs_supplychaindirection] [nvarchar](4000) NULL,
	[ovs_accountclassname] [nvarchar](160) NULL,
	[statecode] [int] NULL,
	[statuscode] [int] NULL,
	[owninguser] [uniqueidentifier] NULL,
	[owningteam] [uniqueidentifier] NULL,
	[owningbusinessunit] [uniqueidentifier] NULL,
	[ownerid] [uniqueidentifier] NULL,
	[owneridtype] [nvarchar](4000) NULL,
 CONSTRAINT [EPK[dbo]].[STAGING__accountclass]]] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO





--DECLARE CONSTANTS
--===================================================================================================
--===================================================================================================
BEGIN 

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




--CLASS + SUPPLY CHAIN DIRECTION FROM IIS
--==================================================================
DROP TABLE IF EXISTS ##TEMP_STAKEHOLDER_CLASS;

--CONCAT classes by supply chain direction 
select 
STAKEHOLDER_ID,
STRING_AGG(HAZARD_CLASS_DIVISION_CD, ';') WITHIN GROUP (ORDER BY STAKEHOLDER_ID, SUPPLY_CHAIN_DIRECTION) AS HAZARD_CLASS_DIVISION_CD, 
SUPPLY_CHAIN_DIRECTION
INTO ##TEMP_STAKEHOLDER_CLASS
FROM
(
	--CONCAT Supply chain direction for classes
	SELECT 
	STAKEHOLDER_ID, 
	HAZARD_CLASS_DIVISION_CD,
	STRING_AGG(SUPPLY_CHAIN_DIRECTION, ';') WITHIN GROUP (ORDER BY STAKEHOLDER_ID, SUPPLY_CHAIN_DIRECTION) AS SUPPLY_CHAIN_DIRECTION
	FROM 
	(
		SELECT 
		DISTINCT
		[STAKEHOLDER_ID],

		CASE 
			WHEN [HAZARD_CLASS_DIVISION_CD] = '0' THEN 'Forbidden' 
			ELSE [HAZARD_CLASS_DIVISION_CD] 
		END [HAZARD_CLASS_DIVISION_CD]

		,CASE
			WHEN CHARINDEX('IN', DG_PKG_TRANS_DIR_CD) > 0	THEN 'Inbound'
			WHEN CHARINDEX('OUT', DG_PKG_TRANS_DIR_CD) > 0	THEN 'Outbound'
		END SUPPLY_CHAIN_DIRECTION
	
		FROM [dbo].[YD033_STAKEHOLDER_CLASS_PROFIL]
		WHERE DATE_DELETED_DTE IS NULL
	) T
	GROUP BY STAKEHOLDER_ID, HAZARD_CLASS_DIVISION_CD
) T2
group by STAKEHOLDER_ID, SUPPLY_CHAIN_DIRECTION 
ORDER BY STAKEHOLDER_ID;


INSERT INTO [dbo].[STAGING__accountclass]
           ([Id]
           ,[ovs_supplychaindirection]
           ,[ovs_primaryclass]
           ,[ovs_name]
		   ,ovs_accountclass)
SELECT 
NEWID() id
,SUPPLY_CHAIN_DIRECTION
,HAZARD_CLASS_DIVISION_CD
,CONCAT(HAZARD_CLASS_DIVISION_CD, ' - ', SUPPLY_CHAIN_DIRECTION) name
,accountid
FROM ##TEMP_STAKEHOLDER_CLASS T1
JOIN STAGING__ACCOUNT T2 ON T1.STAKEHOLDER_ID = T2.ovs_iisid
order by ovs_iisid;

SELECT * FROM STAGING__ACCOUNT;

--dynamics table has 2 id columns for some reason, need to do this on 
--many tables so that in case we use both, they will both be populated with the id
UPDATE STAGING__accountclass
SET ovs_accountclassid = Id;

--UPDATE
UPDATE STAGING__accountclass 
SET 
ownerid = @CONST_TDGCORE_USERID,
owneridtype = @CONST_OWNERIDTYPE_SYSTEMUSER,
owningbusinessunit = @CONST_BUSINESSUNIT_TDG_ID,
owninguser = @CONST_TDGCORE_USERID;


SELECT COUNT(*) COUNT_OF_STAGING__accountclass FROM STAGING__accountclass;

--QUERY FOR SSIS
SELECT 
[Id]
,[ovs_supplychaindirection]
,[ovs_primaryclass]
,[ovs_name]
,ovs_accountclass
,ovs_accountclassid
,ownerid
,owneridtype
,owningbusinessunit
,owninguser
FROM STAGING__accountclass;

--==================================================================