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


--TABLE DEFINITIONS	
--===================================================================================
--===================================================================================
BEGIN

	/****** Object:  Table [dbo].[STAGING__VIOLATIONS]    Script Date: 6/5/2021 11:40:27 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STAGING__VIOLATIONS]') AND type in (N'U'))
DROP TABLE [dbo].[STAGING__VIOLATIONS]


CREATE TABLE [dbo].[STAGING__VIOLATIONS] (
	[Id] [uniqueidentifier] NOT NULL,
	[SinkCreatedOn] [datetime] NULL,
	[SinkModifiedOn] [datetime] NULL,
	[statecode] [int] NULL,
	[statuscode] [int] NULL,
	[tdg_certificatetypecd] [int] NULL,
	[qm_isviolation] [bit] NULL,
	[modifiedonbehalfby] [uniqueidentifier] NULL,
	[modifiedonbehalfby_entitytype] [nvarchar](128) NULL,
	[owningteam] [uniqueidentifier] NULL,
	[owningteam_entitytype] [nvarchar](128) NULL,
	[owninguser] [uniqueidentifier] NULL,
	[owninguser_entitytype] [nvarchar](128) NULL,
	[createdonbehalfby] [uniqueidentifier] NULL,
	[createdonbehalfby_entitytype] [nvarchar](128) NULL,
	[qm_questionid] [uniqueidentifier] NULL,
	[qm_questionid_entitytype] [nvarchar](128) NULL,
	[qm_cysafetyassessmentid] [uniqueidentifier] NULL,
	[qm_cysafetyassessmentid_entitytype] [nvarchar](128) NULL,
	[modifiedby] [uniqueidentifier] NULL,
	[modifiedby_entitytype] [nvarchar](128) NULL,
	[createdby] [uniqueidentifier] NULL,
	[createdby_entitytype] [nvarchar](128) NULL,
	[qm_workorderid] [uniqueidentifier] NULL,
	[qm_workorderid_entitytype] [nvarchar](128) NULL,
	[qm_iisactivityid] NUMERIC(18,0),
	[qm_iisviolationcd] NUMERIC(18,0),
	[qm_enablingact] [uniqueidentifier] NULL,
	[qm_enablingact_entitytype] [nvarchar](128) NULL,
	[qm_rclegislationid] [uniqueidentifier] NULL,
	[qm_rclegislationid_entitytype] [nvarchar](128) NULL,
	[owningbusinessunit] [uniqueidentifier] NULL,
	[owningbusinessunit_entitytype] [nvarchar](128) NULL,
	[qm_enablingregulation] [uniqueidentifier] NULL,
	[qm_enablingregulation_entitytype] [nvarchar](128) NULL,
	[ownerid] [uniqueidentifier] NULL,
	[ownerid_entitytype] [nvarchar](128) NULL,
	[createdonbehalfbyyominame] [nvarchar](100) NULL,
	[qm_approximatetotal] [int] NULL,
	[owneridname] [nvarchar](100) NULL,
	[qm_cysafetyassessmentidname] [nvarchar](100) NULL,
	[qm_violationdisplaylabel] [nvarchar](max) NULL,
	[qm_referenceid] [nvarchar](255) NULL,
	[qm_rclegislationidname] [nvarchar](100) NULL,
	[tdg_certificatenumber] [nvarchar](100) NULL,
	[ovs_duedate] [datetime] NULL,
	[qm_name] [nvarchar](300) NULL,
	[importsequencenumber] [int] NULL,
	[qm_internalcomments] [nvarchar](max) NULL,
	[qm_workorderidname] [nvarchar](100) NULL,
	[utcconversiontimezonecode] [int] NULL,
	[createdbyyominame] [nvarchar](100) NULL,
	[modifiedbyname] [nvarchar](100) NULL,
	[versionnumber] [bigint] NULL,
	[qm_externalcomments] [nvarchar](max) NULL,
	[modifiedbyyominame] [nvarchar](100) NULL,
	[timezoneruleversionnumber] [int] NULL,
	[tdg_templatenumber] [nvarchar](100) NULL,
	[owneridtype] [nvarchar](4000) NULL,
	[qm_questionidname] [nvarchar](300) NULL,
	[qm_violationdisplayfrenchlabel] [nvarchar](max) NULL,
	[owneridyominame] [nvarchar](100) NULL,
	[modifiedon] [datetime] NULL,
	[qm_syresultid] [uniqueidentifier] NULL,
	[qm_responseid] [nvarchar](4000) NULL,
	[modifiedonbehalfbyname] [nvarchar](100) NULL,
	[qm_enablingregulationname] [nvarchar](100) NULL,
	[modifiedonbehalfbyyominame] [nvarchar](100) NULL,
	[createdbyname] [nvarchar](100) NULL,
	[createdon] [datetime] NULL,
	[createdonbehalfbyname] [nvarchar](100) NULL,
	[qm_violationcount] [int] NULL,
	[qm_blobpath] [nvarchar](200) NULL,
	[tdg_certificatesectionnumber] [nvarchar](100) NULL,
	[qm_enablingactname] [nvarchar](100) NULL,
	[overriddencreatedon] [datetime] NULL,
	[qm_samplesize] [int] NULL,
 CONSTRAINT [EPK[dbo]].[STAGING__VIOLATIONS]]] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

	
END
--===================================================================================
--===================================================================================



--GET A TEMPORARY LIST OF INSPECTIONS FROM IIS DATA
--===================================================================================
--===================================================================================
BEGIN

	DROP TABLE IF EXISTS #TEMP_IIS_INSPECTIONS;

	--39446
	SELECT
		YD095.FILE_NUMBER_NUM,
		TD001.FILE_STATUS_ETXT,
		TD001.FILE_STATUS_FTXT,
		YD040.INSPECTION_DATE_DTE,
		YD040.ACTIVITY_ID,
		YD040.STAKEHOLDER_ID,
		TD038.INSPECTION_REASON_ETXT,
		TD038.INSPECTION_REASON_FTXT
	INTO #TEMP_IIS_INSPECTIONS
	FROM
		YD040_ACTIVITY YD040
		INNER JOIN YD095_STAKEHOLDER_FILE YD095 ON YD040.FILE_NUMBER_NUM = YD095.FILE_NUMBER_NUM
		INNER JOIN TD001_FILE_STATUS TD001 ON YD095.FILE_STATUS_CD = TD001.FILE_STATUS_CD
		LEFT JOIN YD041_INSPECTION YD041 ON YD040.ACTIVITY_ID = YD041.ACTIVITY_ID
		LEFT JOIN TD038_INSPECTION_REASON TD038 ON YD041.INSPECTION_REASON_CD = TD038.INSPECTION_REASON_CD
	WHERE
		YD040.DATE_DELETED_DTE IS NULL
		AND YD095.DATE_DELETED_DTE IS NULL
		AND YD041.DATE_DELETED_DTE IS NULL
	GROUP BY
		YD095.FILE_NUMBER_NUM,
		TD001.FILE_STATUS_ETXT,
		TD001.FILE_STATUS_FTXT,
		YD040.INSPECTION_DATE_DTE,
		YD040.ACTIVITY_ID,
		YD040.STAKEHOLDER_ID,
		TD038.INSPECTION_REASON_ETXT,
		TD038.INSPECTION_REASON_FTXT;

	--SELECT * FROM #TEMP_IIS_INSPECTIONS;

END
--===================================================================================
--===================================================================================



--GET A TEMPORARY LIST OF ACTIVITY CATEGORIES AND SUBCATEGORIES OF ACTIVIES FROM IIS
--===================================================================================
--===================================================================================
BEGIN

	DROP TABLE IF EXISTS #TEMP_INSPECTION_CATEGORIES;

	SELECT
	CAT.FILE_NUMBER_NUM,
	CAT.ACTIVITY_TYPE_CD,
	CAT.ACTIVITY_TYPE_ENM,
	ISNULL(SUBCAT.SUBACTIVITY_TYPE_CDS, 'N/A') SUBACTIVITY_TYPE_CDS,
	ISNULL(SUBCAT.SUBACTIVITY_TYPE_ENMS, 'N/A') SUBACTIVITY_TYPE_ENMS
	INTO #TEMP_INSPECTION_CATEGORIES
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
	) SUBCAT ON CAT.FILE_NUMBER_NUM = SUBCAT.FILE_NUMBER_NUM;

END
--===================================================================================
--===================================================================================


--GET TEMPORARY LIST OF VIOLATIONS FROM IIS
--===================================================================================
--===================================================================================
BEGIN

	DROP TABLE IF EXISTS #TEMP_VIOLATIONS;

	SELECT
		YD020.ACTIVITY_ID,
		YD020.VIOLATION_CD,
		YD020.VIOLATION_COMMENTS_TXT,
		YD021.MOC_SERIAL_NUMBER_NUM,
		YD021.MOC_TYPE_CD,
		YD021.MOC_VIOLATION_COMMENTS_TXT,
		YD021.TDG_SPECIFICATION_CD,
		YD021.UN_NUMBER_ID
		INTO #TEMP_VIOLATIONS
	FROM
		YD020_INSPECTION_VIOLATION YD020
		LEFT JOIN YD021_MOCLIST YD021 ON YD020.ACTIVITY_ID = YD021.ACTIVITY_ID AND YD020.VIOLATION_CD = YD021.VIOLATION_CD
	WHERE
		YD020.DATE_DELETED_DTE IS NULL;

END
--===================================================================================
--===================================================================================


--GET A TEMPORARY LIST OF VIOLATIONS THAT WERE MAPPED TO ROM VIA THE LEGISLATION MATCHING EXCEL SHEET DATA
--===================================================================================
--===================================================================================
BEGIN
	DROP TABLE IF EXISTS #TEMP_VIOLATIONS_MAPPED_TO_ROM;
	
	SELECT 

	CASE WHEN T4.LegislationId IS NULL THEN 0 ELSE 1 END MATCHED, 

	T1.STAKEHOLDER_ID, T1.ACTIVITY_ID, T1.FILE_NUMBER_NUM, T1.FILE_STATUS_ETXT, T1.INSPECTION_DATE_DTE, T1.INSPECTION_REASON_ETXT,
	T3.VIOLATION_CD, T3.VIOLATION_COMMENTS_TXT, T3.MOC_SERIAL_NUMBER_NUM, T3.MOC_TYPE_CD, T3.MOC_VIOLATION_COMMENTS_TXT, T3.TDG_SPECIFICATION_CD, T3.UN_NUMBER_ID,
	T4.Label, T4.[Legislation Type], T4.[Legislation Source], T4.LegislationId, T4.[Modified Label], T4.Name, T4.VIOLATION_REFERENCE_CD, T6.qm_enablingregulation, T6.qm_enablingprovision
	--,T2.ACTIVITY_TYPE_CD, T2.ACTIVITY_TYPE_ENM, T2.SUBACTIVITY_TYPE_CDS, T2.SUBACTIVITY_TYPE_ENMS

	INTO #TEMP_VIOLATIONS_MAPPED_TO_ROM
	FROM #TEMP_IIS_INSPECTIONS T1
	--JOIN #TEMP_INSPECTION_CATEGORIES T2 ON T1.FILE_NUMBER_NUM = T2.FILE_NUMBER_NUM
	JOIN #TEMP_VIOLATIONS T3 ON T1.ACTIVITY_ID = T3.ACTIVITY_ID
	JOIN TD070_VIOLATION T5 ON T3.VIOLATION_CD = T5.VIOLATION_CD
	LEFT JOIN SOURCE__LEGISLATION_MATCHING T4 ON T3.VIOLATION_CD = T4.VIOLATION_CD
	LEFT JOIN STAGING__tylegislation T6 ON T4.LegislationId = T6.qm_rclegislationid
	ORDER BY T4.LegislationId;
END
--===================================================================================
--===================================================================================


--LINK UP THE VIOLATIONS BACK TO THEIR WORK ORDER BY MATCHING THE IIS ACTIVITY ID WITH THE IIS ACTIVITY ID FIELD ON THE WORK ORDER, 
--===================================================================================
--===================================================================================
BEGIN
	INSERT INTO
	  [dbo].STAGING__VIOLATIONS (
		id,
		[qm_externalcomments],
		[qm_internalcomments],
		[qm_isviolation],
		[qm_name],
		[qm_rclegislationid],
		qm_enablingact,
		qm_enablingregulation,
		[qm_referenceid],
		[qm_violationcount],
		[qm_workorderid],
		qm_iisactivityid,
		qm_iisviolationcd
	  )

	--26051
	SELECT 
	  newid() id,

	  CASE
		WHEN MOC_VIOLATION_COMMENTS_TXT IS NULL
		OR TRIM(MOC_VIOLATION_COMMENTS_TXT) = '' THEN VIOLATION_COMMENTS_TXT
		ELSE CONCAT(
		  T1.VIOLATION_COMMENTS_TXT,
		  CHAR(13) + CHAR(10),
		  'MOC',
		  CHAR(13) + CHAR(10),
		  T1.MOC_VIOLATION_COMMENTS_TXT
		)
	  END [qm_externalcomments],

	  ----INTERNAL COMMENTS
	  --======================
	  CONCAT(
		CASE
		  WHEN MOC_SERIAL_NUMBER_NUM IS NULL THEN ''
		  ELSE CONCAT(
			'MOC_SERIAL_NUMBER_NUM=',
			MOC_SERIAL_NUMBER_NUM,
			';'
		  )
		END,
		CASE
		  WHEN MOC_TYPE_CD IS NULL THEN ''
		  ELSE CONCAT('MOC_TYPE_CD=', MOC_TYPE_CD, ';')
		END,
		CASE
		  WHEN TDG_SPECIFICATION_CD IS NULL THEN ''
		  ELSE CONCAT(
			'TDG_SPECIFICATION_CD=',
			TDG_SPECIFICATION_CD,
			';'
		  )
		END,
		CASE
		  WHEN UN_NUMBER_ID IS NULL THEN ''
		  ELSE CONCAT('UN_NUMBER_ID=', UN_NUMBER_ID, ';')
		END
	  ) [qm_internalcomments],
	  ----
	  --======================

	  1 [qm_isviolation],

	  CASE
		WHEN MOC_SERIAL_NUMBER_NUM IS NULL
		OR TRIM(MOC_SERIAL_NUMBER_NUM) = '' THEN TRIM([Label])
		ELSE CONCAT(TRIM(T1.Label), ' - ', MOC_SERIAL_NUMBER_NUM)
	  END [qm_name]

	  , LegislationId [qm_rclegislationid], qm_enablingprovision, qm_enablingregulation, MOC_SERIAL_NUMBER_NUM 
	  [qm_referenceid], 1 [qm_violationcount], msdyn_workorderid [qm_workorderid], T1.ACTIVITY_ID, T1.VIOLATION_CD

	FROM #TEMP_VIOLATIONS_MAPPED_TO_ROM T1
	JOIN STAGING__WORK_ORDERS T2	ON T1.ACTIVITY_ID = T2.ovs_iisactivityid
	JOIN [dbo].[TD070_VIOLATION] T3 ON T1.VIOLATION_CD = T3.VIOLATION_CD
	WHERE MATCHED = 1;

	UPDATE STAGING__VIOLATIONS SET [qm_syresultid] = Id;

	UPDATE STAGING__VIOLATIONS
	SET 
	OWNERID				= @CONST_TDGCORE_USERID,
	OWNERIDTYPE			= @CONST_OWNERIDTYPE_SYSTEMUSER,
	OWNINGBUSINESSUNIT	= @CONST_BUSINESSUNIT_TDG_ID,
	OWNINGUSER			= @CONST_TDGCORE_USERID;

END
--===================================================================================
--===================================================================================


--DATA COUNTS 
--===================================================================================
--===================================================================================
BEGIN

	--17808 VIOLATIONS MATCHED TO ROM
	--
	SELECT *, (CAST(COUNT_OF_VIOLATIONS_MATCHED_TO_WORKORDERS AS decimal) / COUNT_OF_VIOLATIONS_MAPPED_TO_ROM) MATCH_PRCNT
	FROM (
		SELECT 
		(
			SELECT 
			COUNT(*) 
			FROM #TEMP_VIOLATIONS_MAPPED_TO_ROM T1
			JOIN STAGING__WORK_ORDERS T2
			ON CAST(T1.ACTIVITY_ID AS nvarchar(MAX)) = CAST(T2.msdyn_workordersummary AS nvarchar(MAX))
		) COUNT_OF_VIOLATIONS_MATCHED_TO_WORKORDERS,
		(
			SELECT 
			COUNT(*) 
			FROM #TEMP_VIOLATIONS_MAPPED_TO_ROM T1
		) COUNT_OF_VIOLATIONS_MAPPED_TO_ROM
	) T;

	--17808 MATCHED
	--17217 NOT MATCHED
	SELECT 
	(SELECT COUNT(*) FROM #TEMP_VIOLATIONS_MAPPED_TO_ROM WHERE MATCHED = 1) COUNT_OF_VIOLATIONS_MATCHED_TO_ROM,
	(SELECT COUNT(*) FROM #TEMP_VIOLATIONS_MAPPED_TO_ROM WHERE MATCHED = 0) COUNT_OF_VIOLATIONS_NOT_MATCHED_TO_ROM;
		--35359
	SELECT COUNT(*) INSPECTION_VIOLATION_COUNT FROM #TEMP_VIOLATIONS;
		--39921
	SELECT COUNT(*) INSPECTION_CATEGORIES_COUNT FROM #TEMP_INSPECTION_CATEGORIES;
	--36478
	SELECT COUNT(*) SOURCE__IIS_INSPECTIONS_COUNT FROM SOURCE__IIS_INSPECTIONS;
	--39446
	SELECT COUNT(*) TEMP__IIS_INSPECTIONS_COUNT FROM #TEMP_IIS_INSPECTIONS;

	SELECT COUNT(*) CONFIRMATION_OF_COMPLIANCES_AS_OF_04_01_2020 FROM #TEMP_VIOLATIONS_MAPPED_TO_ROM
	WHERE MATCHED = 1 AND INSPECTION_DATE_DTE > CAST ('2020-04-01' AS DATETIME);

END
--===================================================================================
--===================================================================================

--QUERY TO USE IN SSIS PACKAGE
SELECT 
[qm_syresultid],
[qm_externalcomments],
[qm_internalcomments],
[qm_isviolation],
[qm_name],
[qm_rclegislationid],
qm_enablingact,
qm_enablingregulation,
[qm_referenceid],
[qm_violationcount],
[qm_workorderid],
qm_iisactivityid,
qm_iisviolationcd
FROM STAGING__VIOLATIONS;