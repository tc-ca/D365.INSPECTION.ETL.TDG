USE [tdg-data-migration-db]

SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON


BEGIN
		/****** Object:  Table [dbo].[STAGING__tylegislation]   Script Date: 5/14/2021 10:50:15 PM ******/
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STAGING__tylegislation]') AND type in (N'U'))
		DROP TABLE [dbo].[STAGING__tylegislation]


		/****** Object:  Table [dbo].[tdgdata__qm_tylegislationsource]    Script Date: 5/16/2021 7:53:04 PM ******/
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STAGING__tylegislationsource]') AND type in (N'U'))
		DROP TABLE [dbo].[STAGING__tylegislationsource]


		/****** Object:  Table [dbo].[tdgdata__qm_tylegislationsource]    Script Date: 5/16/2021 7:53:04 PM ******/
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STAGING__tylegislationtype]') AND type in (N'U'))
		DROP TABLE [dbo].[STAGING__tylegislationtype]


		CREATE TABLE [STAGING__tylegislation] (
		[qm_enablingprovision]			UNIQUEIDENTIFIER,
		[qm_enablingprovisionname]		NVARCHAR(100),
		[qm_enablingregulation]			UNIQUEIDENTIFIER,
		[qm_enablingregulationname]		NVARCHAR(200),
		[qm_englishname]				NVARCHAR(100),
		[qm_frenchname]					NVARCHAR(100),
		[qm_legislationetxt]			NTEXT,
		[qm_legislationftxt]			NTEXT,
		[qm_legislationlbl]				NVARCHAR(100),
		[qm_name]						NVARCHAR(100),
		[qm_ordernbr]					INT,
		[qm_rclegislationid]			UNIQUEIDENTIFIER,
		[qm_rcparentlegislationid]		UNIQUEIDENTIFIER,
		[qm_rcparentlegislationidname]	NVARCHAR(100),
		[qm_tylegislationsourceid]		UNIQUEIDENTIFIER,
		[qm_tylegislationsourceidname]	NVARCHAR(200),
		[qm_tylegislationtypeid]		UNIQUEIDENTIFIER,
		[qm_tylegislationtypeidname]	NVARCHAR(200),
		[qm_violationdisplaytext]		NTEXT,
		[qm_violationdisplaytexten]		NTEXT,
		[qm_violationdisplaytextfr]		NTEXT,
		[qm_violationtext]				NTEXT
	)

	CREATE TABLE [dbo].[STAGING__tylegislationsource](
		[Id]						[UNIQUEIDENTIFIER] NOT NULL,
		[qm_name]					[nvarchar](500) NULL, -- needs to be increased in CRM from 100 to 500
		[qm_tylegislationsourceid]	[uniqueidentifier] NULL,
		[qm_legislationsourceelbl]	[nvarchar](500) NULL,
		[qm_legislationsourceflbl]	[nvarchar](500) NULL,
		[qm_legislationsourceetxt]	[nvarchar](500) NULL,
		[qm_legislationsourceftxt]	[nvarchar](500) NULL,
		[statecode]					[INT] NULL,
		[statuscode]				[INT] NULL
		,[ownerid]					[UNIQUEIDENTIFIER] NULL,
		[owneridtype]				[nvarchar](4000) NULL,
		[owningbusinessunit]		[UNIQUEIDENTIFIER] NULL,
		[owningteam]				[uniqueidentifier] NULL,
		[owninguser]				[UNIQUEIDENTIFIER] NULL
	) ON [PRIMARY]
	


	CREATE TABLE [dbo].[STAGING__tylegislationtype] (
		[Id]							[UNIQUEIDENTIFIER] NOT NULL,
		[qm_name]						[NVARCHAR](100) NULL,
		[qm_tylegislationtypeid]		[UNIQUEIDENTIFIER] NULL,
		[qm_legislationsectiontypeenm]	[nvarchar](500) NULL,
		[qm_legislationsectiontypefnm]	[nvarchar](500) NULL
		,[ownerid]						[UNIQUEIDENTIFIER] NULL,
		[owneridtype]					[NVARCHAR](4000) NULL,
		[owningbusinessunit]			[UNIQUEIDENTIFIER] NULL,
		[owningteam]					[uniqueidentifier] NULL,
		[owninguser]					[uniqueidentifier] NULL
	) ON [PRIMARY]

END

--DELETE REPLICATED CRM DATA AS A PRECAUTION IN CASE IT INTERFERES WITH OUR ETL
--===================================================================================================
--===================================================================================================
BEGIN 

	TRUNCATE TABLE dbo.tdgdata__qm_rclegislation;
	TRUNCATE TABLE dbo.tdgdata__qm_tylegislationtype;
	TRUNCATE TABLE dbo.tdgdata__qm_tylegislationsource;

END 

BEGIN

	INSERT INTO [STAGING__tylegislation]
	(
		qm_name,
		qm_tylegislationsourceidname,
		qm_rcparentlegislationidname,
		qm_legislationetxt,
		qm_tylegislationtypeidname,
		qm_legislationlbl,
		qm_enablingprovisionname,
		qm_enablingregulationname,
		qm_ordernbr,
		qm_legislationftxt,
		qm_violationdisplaytexten,
		qm_violationdisplaytextfr,
		qm_violationdisplaytext
	)
	--3411
	SELECT 
		[Name] ,
		[Legislation Source] ,
		[Parent Legislation] ,
		[English Text] ,
		[Legislation Type] ,
		[Label] ,
		[Enabling Act] ,
		[Enabling Regulation] ,
		[Order] ,
		[French Text] ,
		[Violation Display Text EN] ,
		[Violation Display Text FR] ,
		[Violation Text]
	FROM [26_TDGLegislation];

	
END


BEGIN

	--DEFAULTS MASTER DATA
	--=============================================DYNAMIC VALUES===========================================
	--these variables can change with the environment, so double check these match the environment you're syncing to
	--ROM-ACC-TDG-DATA VALUES
	DECLARE @CONST_TDGCORE_USERID                        VARCHAR(50) = 'ae39bb8b-4b92-eb11-b1ac-000d3ae85ba1';
	DECLARE @CONST_TDGCORE_DOMAINNAME                    VARCHAR(50) = 'tdg.core@034gc.onmicrosoft.com';
	DECLARE @CONST_TDG_TEAMID                            VARCHAR(50) = 'd5ddb27a-56b7-eb11-8236-000d3a84ec03';
	DECLARE @CONST_TDG_TEAMNAME                          VARCHAR(50) = 'Transportation of Dangerous Goods';
	DECLARE @CONST_TDG_BUSINESSUNITID                    VARCHAR(50) = '4E122E0C-73F3-EA11-A815-000D3AF3AC0D';
	DECLARE @CONST_PRICELISTID                           VARCHAR(50) = 'b92b6a16-7cf7-ea11-a815-000d3af3a7a7';
	--======================================================================================================

	--create a legislation source for each distinct entry in the excel data
	INSERT INTO [STAGING__tylegislationsource]
	(id, qm_name)
	SELECT newid() id, qm_tylegislationsourceidname qm_name FROM
	(
		SELECT DISTINCT qm_tylegislationsourceidname FROM [STAGING__tylegislation]
	) T;


	--INSERT KNOWN VALUES FOR LOOKUP
	INSERT INTO [dbo].[STAGING__tylegislationtype]
			   (
				[Id]
			   ,[qm_name]
			   ,[qm_legislationsectiontypeenm]
			   ,[qm_legislationsectiontypefnm]
			   )

	SELECT NEWID() , 'Appendix',		'Appendix',			'Appendice'			UNION
	SELECT NEWID() , 'Body',			'Body',				'Corps'				UNION
	SELECT NEWID() , 'Clause',			'Clause',			'Clause'			UNION
	SELECT NEWID() , 'Definition',		'Definition',		'D�finition'		UNION
	SELECT NEWID() , 'Heading',			'Heading',			'Titre'				UNION
	SELECT NEWID() , 'Marginal Note',	'Marginal Note',	'Note marginale'	UNION
	SELECT NEWID() , 'Paragraph',		'Paragraph',		'Paragraphe'		UNION
	SELECT NEWID() , 'Schedule',		'Schedule',			'Horaire'			UNION
	SELECT NEWID() , 'Section',			'Section',			'Section'			UNION
	SELECT NEWID() , 'Subparagraph',	'Subparagraph',		'Sous-paragraphe'	UNION
	SELECT NEWID() , 'Subsection',		'Subsection',		'Sous-section'	;


	--set the other id on the tables in case we use them, just in case 
	UPDATE [STAGING__tylegislationsource] SET qm_tylegislationsourceid = id;
	UPDATE [STAGING__tylegislationtype]	  SET qm_tylegislationtypeid = id;


	--Fix Names with double spaces
	UPDATE [STAGING__tylegislation]
	SET qm_name = REPLACE(qm_name, '  ', ' ')
	FROM [STAGING__tylegislation];


	--give all provisions an id
	UPDATE [STAGING__tylegislation] set qm_rclegislationid = newid()
	FROM [STAGING__tylegislation] 
	WHERE qm_rclegislationid is null;


	--match up the provisions to their legislation sources
	UPDATE [STAGING__tylegislation]
	SET qm_tylegislationsourceid = T2.Id
	--SELECT * 
	FROM [STAGING__tylegislation] T1 
	JOIN [STAGING__tylegislationsource] T2 ON T1.qm_tylegislationsourceidname = T2.qm_name;


	--match and update legislation type
	UPDATE [STAGING__tylegislation]
	SET qm_tylegislationtypeid = T2.Id
	--SELECT * 
	FROM [STAGING__tylegislation] T1 
	JOIN [STAGING__tylegislationtype] T2 ON T1.qm_tylegislationtypeidname = T2.qm_name;


	--match up the enabling act to children
	UPDATE T1
	SET qm_enablingprovision = t2.qm_rclegislationid
	--SELECT *
	FROM [STAGING__tylegislation] T1 
	JOIN [STAGING__tylegislation] T2 ON T1.qm_enablingprovisionname = T2.qm_name;


	--match up the enabling regulations to children
	UPDATE T1
	SET qm_enablingregulation = t2.qm_rclegislationid
	--SELECT *
	FROM [STAGING__tylegislation] T1 
	JOIN [STAGING__tylegislation] T2 ON T1.qm_enablingregulationname = T2.qm_name;


	--set ownership of records
	--UPDATE [STAGING__tylegislation] SET owner	= @CONST_TDG_TEAMID, [owneridtype] = 'team', [owningbusinessunit] = @CONST_TDG_BUSINESSUNITID, [owningteam] = @CONST_TDG_TEAMID;
	UPDATE [STAGING__tylegislationsource] SET [ownerid]	= @CONST_TDG_TEAMID, [owneridtype] = 'team', [owningbusinessunit] = @CONST_TDG_BUSINESSUNITID, [owningteam] = @CONST_TDG_TEAMID;
	UPDATE [STAGING__tylegislationtype] SET [ownerid]	= @CONST_TDG_TEAMID, [owneridtype] = 'team', [owningbusinessunit] = @CONST_TDG_BUSINESSUNITID, [owningteam] = @CONST_TDG_TEAMID;

END


SELECT * FROM [STAGING__tylegislation] order by qm_name;


--SANITY CHECKS
--how many match from replicated data to staging data
DECLARE @stagingCount int           = 0;
DECLARE @crmCount     int           = 0;
DECLARE @matchCount   int           = 0;
DECLARE @legislationSourceCount INT = 0;
DECLARE @legislationTypeSourceCount INT   = 0;
DECLARE @legTypeMatchCount INT      = 0;

SELECT @stagingCount = COUNT(*) 
FROM [STAGING__tylegislation];

SELECT @legislationSourceCount = COUNT(*) 
FROM [STAGING__tylegislationsource];

SELECT @legislationTypeSourceCount = COUNT(*) 
FROM [STAGING__tylegislationtype];

SELECT @crmCount = COUNT(*) 
FROM tdgdata__qm_rclegislation;

SELECT @matchCount = COUNT(*) 
FROM [dbo].[tdgdata__qm_rclegislation] T1
JOIN [STAGING__tylegislation] T2 ON T1.qm_name = T2.qm_name;

SELECT @legTypeMatchCount = COUNT(*) 
FROM [dbo].tdgdata__qm_tylegislationtype T1
JOIN [STAGING__tylegislationtype] T2 ON T1.qm_name = T2.qm_name;

SELECT @stagingCount staged_record_count, @crmCount crm_record_count, @matchCount records_matched_by_name, @legislationSourceCount legislation_Source_Count, @legislationTypeSourceCount legislation_Type_Source_Count, @legTypeMatchCount legType_Match_Count

--==============================
--PARENTS ARE MISSING 
--INTENTIONAL OR NOT?
--FIX HERE IF REQUIRED

--fix the parent legislation name field
--UPDATE TYLegislation
--SET ParentLegislation = LEFT(ParentLegislation, CHARINDEX('::', ParentLegislation)-1)
--FROM TYLegislation;


----match children up to their parents
--UPDATE T1
--SET ParentLegislationId = T2.LegislationId
--FROM [STAGING__tylegislation] T1 
--JOIN [STAGING__tylegislation] T2 ON T1.ParentLegislation = T2.Name;


----find missing parents from original legislation export
--INSERT INTO [STAGING__tylegislation]
--(
--	[Name],
--	[LegislationSource] ,
--	[ParentLegislation] ,
--	[English Text] ,
--	[Legislation Type],
--	[Label] ,
--	[EnablingAct] ,
--	[EnablingRegulation] ,
--	[Order] ,
--	[French Text] ,
--	[Violation Display Text EN] ,
--	[Violation Display Text FR] ,
--	[Violation Text]
--)

--SELECT 

--CASE WHEN [Label] IS NULL OR LEN(TRIM([Label])) <= 0 THEN [Name]
--ELSE CONCAT('TDGR ', [Label]) END [Name],

--'Transportation of Dangerous ods Regulations' [Legislation Source], 
--[Parent Legislation], 
--[English Text], 
--[Legislation Type], 
--[Label], 
--[Enabling Provision], 
--NULL EnablingRegulation, 
--T2.[Order], 
--T2.[French Text], 
--[Violation Display Text EN], 
--[Violation Display Text FR], 
--CONCAT([Violation Display Text EN], '::', [Violation Display Text FR]) [Violation Display Text]
--FROM [20_LEGISLATION_MATCHING] T2
--WHERE LEN(Name) > 0 AND Name in
--(
--	SELECT DISTINCT ParentLegislation 
--	FROM [STAGING__tylegislation] 
--	WHERE ParentLegislation not in (
--		SELECT DISTINCT NAME 
--		FROM [STAGING__tylegislation]
--	)
--)

--AND [Legislation Type] not in ('Heading', 'Schedule')

--order by t2.Label;


----SANITY
----who has missing parents :(
--SELECT * FROM [STAGING__tylegislation] WHERE ParentLegislation not in (
--	SELECT DISTINCT Name FROM [STAGING__tylegislation]
--) order by [order];


--====================================
--====================================================

