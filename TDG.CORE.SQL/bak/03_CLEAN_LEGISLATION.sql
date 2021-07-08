USE [tdg-data-migration-db]

SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON


BEGIN
	/****** Object:  Table [dbo].[STAGING__tylegislation]   Script Date: 5/14/2021 10:50:15 PM ******/
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STAGING__tylegislation]') AND type in (N'U'))
	DROP TABLE [dbo].[STAGING__tylegislation];


	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STAGING__tylegislationsource]') AND type in (N'U'))
	DROP TABLE [dbo].[STAGING__tylegislationsource];


	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STAGING__tylegislationtype]') AND type in (N'U'))
	DROP TABLE [dbo].[STAGING__tylegislationtype];


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
	) ON [PRIMARY];

	CREATE TABLE [dbo].[STAGING__tylegislationsource](
		[Id] [uniqueidentifier] NOT NULL,
		[statecode] [int] NULL,
		[statuscode] [int] NULL,
		[qm_sourcetype] [int] NULL,
		[qm_legislationsourceelbl] [nvarchar](100) NULL,
		[qm_tylegislationsourceid] [uniqueidentifier] NULL,
		[qm_name] [nvarchar](500) NULL,
		[qm_legislationsourceflbl] [nvarchar](100) NULL,
		[qm_legislationsourceetxt] [nvarchar](500) NULL,
		[qm_legislationsourceftxt] [nvarchar](250) NULL,
		[ownerid]					[UNIQUEIDENTIFIER] NULL,
		[owneridtype]				[nvarchar](4000) NULL,
		[owningbusinessunit]		[UNIQUEIDENTIFIER] NULL,
		[owningteam]				[uniqueidentifier] NULL,
		[owninguser]				[UNIQUEIDENTIFIER] NULL
	) ON [PRIMARY];

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
	) ON [PRIMARY];

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
		qm_rclegislationid,
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
		[(Do Not Modify) Legislation],
		[Name],
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
	FROM SOURCE__LEGISLATION;

	
END


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

	--create a legislation source for each distinct entry in the excel data
	--INSERT INTO [STAGING__tylegislationsource]
	--(id, qm_name)
	--SELECT newid() id, qm_tylegislationsourceidname qm_name FROM
	--(
	--	SELECT DISTINCT qm_tylegislationsourceidname FROM [STAGING__tylegislation]
	--) T;

	--Act			930840000
	--Regulation	930840001
	--Standard		930840002
	DECLARE @CONST_SOURCETYPE_ACT       VARCHAR(50) = 930840000;
	DECLARE @CONST_SOURCETYPE_REG		VARCHAR(50) = 930840001;
	DECLARE @CONST_SOURCETYPE_STANDARD	VARCHAR(50) = 930840002;


	--we now have known values 
INSERT INTO [STAGING__tylegislationsource]
(id, qm_name, qm_sourcetype)

SELECT 'da41105f-9f78-499d-98ca-62d4dbbcb123' ID, 'CGSB-43.123 - Aerosol containers and gas cartridges for transport of dangerous goods ' qm_name,                                                                                @CONST_SOURCETYPE_STANDARD [Source Type] UNION
SELECT '7bc0fd8d-0dd2-4f58-96fa-9308278a654d' ID, 'CGSB-43.125 - Packaging of Category A and Category B infectious substances (Class 6.2) and clinical, (bio) medical or regulated medical waste' qm_name,                        @CONST_SOURCETYPE_STANDARD [Source Type] UNION
SELECT 'f4e16f52-5094-4892-bc22-46900e359b2f' ID, 'CGSB-43.145 - Design, manufacture and use of large packagings for the transportation of dangerous goods, classes 3, 4, 5, 6.1, 8 and 9' qm_name,                               @CONST_SOURCETYPE_STANDARD [Source Type] UNION
SELECT '3a1b2ac8-2401-4c6f-bf56-7d8c8185e1cd' ID, 'CSA B340 Selection and use of cylinders, spheres, tubes and other containers for the transportation of dangerous goods, Class 2' qm_name,                                      @CONST_SOURCETYPE_STANDARD [Source Type] UNION
SELECT 'b233c8e8-4fab-4e4a-815b-cd4b5a24429a' ID, 'CSA B342 Selection and use of UN pressure receptacles, multiple-element gas containers, and other pressure receptacles for the transport of dangerous goods, Class 2' qm_name, @CONST_SOURCETYPE_STANDARD [Source Type] UNION
SELECT '8c459127-f685-45d8-8004-975d2506c7a8' ID, 'CSA B620 Highway tanks and TC portable tanks for the transportation of dangerous goods' qm_name,                                                                               @CONST_SOURCETYPE_STANDARD [Source Type] UNION
SELECT 'ce3174a0-81af-4d0d-a4b2-66b5185b2039' ID, 'CSA B621 Selection and use of highway tanks, TC portable tanks, and other large containers for the transportation of dangerous goods, Classes 3, 4, 5, 6.1, 8, and 9' qm_name, @CONST_SOURCETYPE_STANDARD [Source Type] UNION
SELECT '8797d6af-f2dc-4ab8-bfc1-cccabac17387' ID, 'CSA B622 Selection and use of highway tanks and TC portable tanks for the transportation of dangerous goods, Classes 2' qm_name,                                               @CONST_SOURCETYPE_STANDARD [Source Type] UNION
SELECT '968e6532-0a86-4bde-a6e5-2329fdcbcc51' ID, 'CSA B626 Portable tank specification TC 44' qm_name,                                                                                                                           @CONST_SOURCETYPE_STANDARD [Source Type] UNION
SELECT 'bf1c3510-93f7-4987-996b-463e173409e4' ID, 'Transportation of Dangerous Goods Act' qm_name,                                                                                                                                @CONST_SOURCETYPE_ACT 	 [Source Type] UNION
SELECT '52551b47-5ecc-4215-b9e2-3461ee0686f3' ID, 'Transportation of Dangerous Goods Regulations' qm_name,                                                                                                                        @CONST_SOURCETYPE_REG 	 [Source Type];

update [STAGING__tylegislationsource]
set qm_legislationsourceetxt = qm_name,
	qm_legislationsourceftxt = concat('(Translate)', qm_name);


	--INSERT KNOWN VALUES FOR LOOKUP
	INSERT INTO [dbo].[STAGING__tylegislationtype]
			   (
				[Id]
			   ,[qm_name]
			   ,[qm_legislationsectiontypeenm]
			   ,[qm_legislationsectiontypefnm]
			   )

	SELECT '0b8b5523-276f-4ae5-baa8-9f957003aaae' , 'Appendix',		'Appendix',			'Appendice'			UNION
	SELECT '92aaba9b-2e6a-49ab-8776-dfba5cc95fd6' , 'Body',			'Body',				'Corps'				UNION
	SELECT '2e2cec3d-bd45-453c-ba8b-d04072a3bfff' , 'Clause',			'Clause',			'Clause'			UNION
	SELECT 'd2f63383-b194-4e24-8f21-fa81d6b240a7' , 'Definition',		'Definition',		'Definition'		UNION
	SELECT '6c358a04-9145-4fa6-a657-365fb49c3982' , 'Heading',			'Heading',			'Titre'				UNION
	SELECT '8669c014-cd83-44bf-8938-4c1176bf119e' , 'Marginal Note',	'Marginal Note',	'Note marginale'	UNION
	SELECT '550e331b-72ec-4606-a73f-a89481220339' , 'Paragraph',		'Paragraph',		'Paragraphe'		UNION
	SELECT '8c9f5e79-50f1-447e-adf7-36dc25b9bd6d' , 'Schedule',		'Schedule',			'Horaire'			UNION
	SELECT '25c835b0-6cc3-4906-962c-776d31de8bee' , 'Section',			'Section',			'Section'			UNION
	SELECT 'f54df8e1-1088-488a-8d81-923ef02e3d30' , 'Subparagraph',	'Subparagraph',		'Sous-paragraphe'	UNION
	SELECT '74956843-c216-449f-9296-517d731cd887' , 'Subsection',		'Subsection',		'Sous-section'	;


	--set the other id on the tables in case we use them, just in case 
	UPDATE [STAGING__tylegislationsource] SET qm_tylegislationsourceid = id;
	UPDATE [STAGING__tylegislationtype]	  SET qm_tylegislationtypeid = id;


	--Fix Names with double spaces
	UPDATE [STAGING__tylegislation]
	SET qm_name = REPLACE(qm_name, '  ', ' ')
	FROM [STAGING__tylegislation];


	--give all provisions an id
	--UPDATE [STAGING__tylegislation] set qm_rclegislationid = newid()
	--FROM [STAGING__tylegislation] 
	--WHERE qm_rclegislationid is null;


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


	--set english name, french name
	UPDATE [STAGING__tylegislation]
	SET 
	qm_englishname = qm_name,
	qm_frenchname = REPLACE(qm_name, 'TDG','TMD');


	--localization plugins
	--=========================================================================
	--=========================================================================
	--name, violation text and violation display text
	UPDATE [STAGING__tylegislation]
	SET 
	qm_name					= CONCAT(qm_englishname, '::', qm_frenchname),
	qm_violationtext		= CASE WHEN qm_legislationetxt IS NULL THEN NULL ELSE CONCAT(qm_legislationetxt, '::', qm_legislationftxt) END,
	qm_violationdisplaytext = CASE WHEN qm_violationdisplaytexten IS NULL THEN NULL ELSE CONCAT(qm_violationdisplaytexten, '::', qm_violationdisplaytextfr) END
	FROM [STAGING__tylegislation];


	--legislation type
	UPDATE [STAGING__tylegislationtype]
	SET 
	qm_name	= CONCAT([qm_legislationsectiontypeenm], '::', [qm_legislationsectiontypefnm])
	FROM [STAGING__tylegislation];
	
	--=========================================================================
	--=========================================================================



	--OWNERSHIP OF RECORDS
	--=========================================================================
	--=========================================================================
	--set ownership of records
	--UPDATE [STAGING__tylegislation] SET owner	= @CONST_TDGCORE_USERID, [owneridtype] = @CONST_OWNERIDTYPE_SYSTEMUSER, [owningbusinessunit] = @CONST_BUSINESSUNIT_TDG_ID, [owninguser] = @CONST_TDGCORE_USERID;
	UPDATE [STAGING__tylegislationsource] SET [ownerid]	= @CONST_TDGCORE_USERID, [owneridtype] = @CONST_OWNERIDTYPE_SYSTEMUSER, [owningbusinessunit] = @CONST_BUSINESSUNIT_TDG_ID, [owninguser] = @CONST_TDGCORE_USERID;
	UPDATE [STAGING__tylegislationtype] SET [ownerid]	= @CONST_TDGCORE_USERID, [owneridtype] = @CONST_OWNERIDTYPE_SYSTEMUSER, [owningbusinessunit] = @CONST_BUSINESSUNIT_TDG_ID, [owninguser] = @CONST_TDGCORE_USERID;
	--=========================================================================
	--=========================================================================

END


--SELECT * FROM [STAGING__tylegislation] order by qm_name;

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

--SOURCE DATA
SELECT COUNT(*) SOURCE__LEGISLATION FROM SOURCE__LEGISLATION;

--STAGING DATA
SELECT COUNT(*) STAGING__tylegislation FROM STAGING__tylegislation;
SELECT COUNT(*) STAGING__tylegislationsource FROM STAGING__tylegislationsource;
SELECT COUNT(*) STAGING__tylegislationtype FROM STAGING__tylegislationtype;

--DATA SYNCED TO DYNAMICS
SELECT COUNT(*) tdgdata__qm_rclegislation FROM tdgdata__qm_rclegislation;
SELECT COUNT(*) tdgdata__qm_tylegislationcharacteristic FROM tdgdata__qm_tylegislationcharacteristic;
SELECT COUNT(*) tdgdata__qm_tylegislationtype FROM tdgdata__qm_tylegislationtype;
SELECT COUNT(*) tdgdata__qm_tylegislationsource FROM tdgdata__qm_tylegislationsource;

--===================================================================================================
--===================================================================================================
--RUN MASTER DATA SSIS PACKAGE AFTER THIS
--KINGSWAYSOFT - SqlToCrm.dtsx
--===================================================================================================
--===================================================================================================

--WAIT UNTIL BOOKABLE RESOURCES ARE SYNCED WITH CRM
--ONCE THE BELOW QUERY RETURNS DATA, YOU'RE GOOD TO GO TO NEXT RUN KINGSWAY TO SYNC THE DATA
--SELECT
--	CRMBR.bookableresourceid,
--	BR.bookableresourceid,
--	fullname,
--	domainname
--FROM
--	[dbo].[STAGING__BOOKABLE_RESOURCE] BR
--	JOIN [dbo].tdgdata__bookableresource CRMBR ON BR.bookableresourceid = CRMBR.bookableresourceid
--	JOIN [dbo].tdgdata__systemuser SYSUSER ON BR.userid = SYSUSER.systemuserid;