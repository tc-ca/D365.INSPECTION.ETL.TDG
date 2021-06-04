

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

	
--INSPECTIONS
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

	--36478
	SELECT COUNT(*) SOURCE__IIS_INSPECTIONS_COUNT FROM SOURCE__IIS_INSPECTIONS;
	--39446
	SELECT COUNT(*) TEMP__IIS_INSPECTIONS_COUNT FROM #TEMP_IIS_INSPECTIONS;

	--SELECT * FROM #TEMP_IIS_INSPECTIONS;

END
--===================================================================================
--===================================================================================



--GET ACTIVITY CATEGORIES AND SUBCATEGORIES OF ACTIVIES FROM IIS
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

	--39921
	SELECT COUNT(*) INSPECTION_CATEGORIES_COUNT FROM #TEMP_INSPECTION_CATEGORIES;

END
--===================================================================================
--===================================================================================


--VIOLATIONS
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

	--35359
	SELECT COUNT(*) INSPECTION_VIOLATION_COUNT FROM #TEMP_VIOLATIONS;

END
--===================================================================================
--===================================================================================


--PUT IT ALL TOGETHER
--===================================================================================
--===================================================================================
BEGIN
	DROP TABLE IF EXISTS #TEMP_VIOLATIONS_MAPPED_TO_ROM;

	SELECT 

	CASE WHEN T4.LegislationId IS NULL THEN 0 ELSE 1 END MATCHED, 

	T1.STAKEHOLDER_ID, T1.ACTIVITY_ID, T1.FILE_NUMBER_NUM, T1.FILE_STATUS_ETXT, T1.INSPECTION_DATE_DTE, T1.INSPECTION_REASON_ETXT,
	T3.VIOLATION_CD, T3.VIOLATION_COMMENTS_TXT, T3.MOC_SERIAL_NUMBER_NUM, T3.MOC_TYPE_CD, T3.MOC_VIOLATION_COMMENTS_TXT, T3.TDG_SPECIFICATION_CD, T3.UN_NUMBER_ID,
	T4.Label, T4.[Legislation Type], T4.[Legislation Source], T4.LegislationId, T4.[Modified Label], T4.Name, T4.VIOLATION_REFERENCE_CD
	--,T2.ACTIVITY_TYPE_CD, T2.ACTIVITY_TYPE_ENM, T2.SUBACTIVITY_TYPE_CDS, T2.SUBACTIVITY_TYPE_ENMS

	INTO #TEMP_VIOLATIONS_MAPPED_TO_ROM
	FROM #TEMP_IIS_INSPECTIONS T1
	--JOIN #TEMP_INSPECTION_CATEGORIES T2 ON T1.FILE_NUMBER_NUM = T2.FILE_NUMBER_NUM
	JOIN #TEMP_VIOLATIONS T3 ON T1.ACTIVITY_ID = T3.ACTIVITY_ID
	JOIN TD070_VIOLATION T5 ON T3.VIOLATION_CD = T5.VIOLATION_CD
	LEFT JOIN SOURCE__LEGISLATION_MATCHING T4 ON T3.VIOLATION_CD = T4.VIOLATION_CD
	ORDER BY T4.LegislationId;



	--17808 MATCHED
	--17217 NOT MATCHED
	SELECT 
	(SELECT COUNT(*) FROM #TEMP_VIOLATIONS_MAPPED_TO_ROM WHERE MATCHED = 1) COUNT_OF_VIOLATIONS_MATCHED_TO_ROM,
	(SELECT COUNT(*) FROM #TEMP_VIOLATIONS_MAPPED_TO_ROM WHERE MATCHED = 0) COUNT_OF_VIOLATIONS_NOT_MATCHED_TO_ROM;

END
--===================================================================================
--===================================================================================


--LINK UP THE VIOLATIONS BACK TO THEIR WORK ORDER BY MATCHING THE IIS ACTIVITY ID WITH THE IIS ACTIVITY ID VALUE PLACED INTO THE SUMMARY OF THE WORK ORDER, 

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


--DROP TABLE IF EXISTS #TEMP_STAGING_VIOLATIONS;

--SELECT
--  ACTIVITY_ID,
--  STAKEHOLDER_ID,
--  T3.LegislationId,
--  T3.Label,
--  T3.Name,
--  T3.[English Text],
--  T1.VIOLATION_CD,
--  T1.VIOLATION_COMMENTS_TXT,
--  T1.MOC_SERIAL_NUMBER_NUM,
--  T1.MOC_TYPE_CD,
--  T1.MOC_VIOLATION_COMMENTS_TXT,
--  T1.TDG_SPECIFICATION_CD,
--  T1.UN_NUMBER_ID,
--  T2.VIOLATION_REFERENCE_CD,
--  T4.msdyn_workorderid,
--  CAST(T4.msdyn_workordersummary AS nvarchar(4000)) msdyn_workordersummary,
--  T4.msdyn_address1,
--  T4.msdyn_address2,
--  T4.msdyn_address3,
--  T4.msdyn_addressname,
--  T4.msdyn_name,
--  T4.msdyn_postalcode,
--  T4.msdyn_serviceaccount,
--  T4.msdyn_serviceterritory,
--  T4.ovs_iisid,
--  T4.qm_reportcontactid INTO #TEMP_STAGING_VIOLATIONS
  --#TEMP_IIS_INSPECTIONS T1
  --JOIN STAGING__WORK_ORDERS T4 ON CAST(T4.msdyn_workordersummary AS nvarchar(MAX)) = CAST(T1.ACTIVITY_ID AS nvarchar(MAX))
  --JOIN [dbo].[TD070_VIOLATION] T2 ON T1.ACTIVITY_ID = T2.VIOLATION_CD;



SELECT 
* 
FROM #TEMP_VIOLATIONS_MAPPED_TO_ROM T1
JOIN STAGING__WORK_ORDERS T2
ON T1.ACTIVITY_ID = T2.ovs_iisactivityid
JOIN [dbo].[TD070_VIOLATION] T3 ON T1.VIOLATION_CD = T3.VIOLATION_CD;


INSERT INTO
  [dbo].STAGING__VIOLATIONS (
    [qm_syresultid],
    [qm_externalcomments],
    [qm_internalcomments],
    [qm_isviolation],
    [qm_name],
    [qm_rclegislationid],
    [qm_referenceid],
    [qm_violationcount],
    [qm_workorderid],
	qm_iisactivityid,
	qm_iisviolationcd
  )

--26051
SELECT 
  newid() [qm_syresultid],

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

  , LegislationId [qm_rclegislationid],
  
  MOC_SERIAL_NUMBER_NUM [qm_referenceid],
  
  1 [qm_violationcount],
  
  msdyn_workorderid [qm_workorderid],
  
  T1.ACTIVITY_ID,
  T1.VIOLATION_CD

FROM #TEMP_VIOLATIONS_MAPPED_TO_ROM T1
JOIN STAGING__WORK_ORDERS T2
ON T1.ACTIVITY_ID = T2.ovs_iisactivityid
JOIN [dbo].[TD070_VIOLATION] T3 ON T1.VIOLATION_CD = T3.VIOLATION_CD;


SELECT * FROM STAGING__VIOLATIONS;
--26051
SELECT COUNT(*) FROM STAGING__VIOLATIONS;


INSERT INTO [dbo].[tdgdata__ovs_confirmationofcompliance]
           ([Id]
           ,[statecode]
           ,[statuscode]
           ,[ovs_violation]
           ,[owningteam]
           ,[regardingobjectid]
           ,[regardingobjectid_entitytype]
           ,[owninguser]
           ,[owningbusinessunit]
           ,[ownerid]
           ,[ownerid_entitytype]
           ,[ovs_justificationtxt]
           ,[activityid]
           ,[ovs_blobpath]
           ,[scheduledstart]
           ,[actualstart]
           ,[subject]
           ,[ovs_daterequested]
           ,[activitytypecode]
           ,[description]
           ,[owneridtype]
           ,[actualend]
           ,[ovs_violationname])
     
	 SELECT * FROM 


           (
		   <Id, uniqueidentifier,> ,<statecode, int,> ,<statuscode, int,> ,<ovs_violation, uniqueidentifier,> ,<owningteam, uniqueidentifier,> ,<regardingobjectid, uniqueidentifier,> ,<regardingobjectid_entitytype, nvarchar(128),> ,<owninguser, uniqueidentifier,>
           ,<owningbusinessunit, uniqueidentifier,>,<ownerid, uniqueidentifier,>,<ownerid_entitytype, nvarchar(128),>,<ovs_justificationtxt, nvarchar(max),>,<activityid, uniqueidentifier,>,<ovs_blobpath, nvarchar(300),>,<scheduledstart, datetime,>,
           <actualstart, datetime,>,<subject, nvarchar(100),>,<ovs_daterequested, datetime,>,<activitytypecode, nvarchar(4000),>,<description, nvarchar(max),>,<owneridtype, nvarchar(4000),>,<actualend, datetime,>,<ovs_violationname, nvarchar(300),>
           )

SELECT 
NEWID() ID, 

CASE WHEN T2.FOLLOW_UP_TYPE_CD = 2 THEN 'CONFIRMATION RECEIVED - ON TIME'
	 WHEN T2.FOLLOW_UP_TYPE_CD = 3 THEN 'CLOSED - UNRESOLVED'
	 WHEN T2.FOLLOW_UP_TYPE_CD = 4 THEN 'CONFIRMATION ON-SITE'
	 WHEN T2.FOLLOW_UP_TYPE_CD = 1 THEN 'ACTIVE'
END statecode,

CASE WHEN T2.FOLLOW_UP_TYPE_CD = 2 THEN 'CONFIRMATION RECEIVED - ON TIME'
	 WHEN T2.FOLLOW_UP_TYPE_CD = 3 THEN 'CLOSED - UNRESOLVED'
	 WHEN T2.FOLLOW_UP_TYPE_CD = 4 THEN 'CONFIRMATION ON-SITE'
	 WHEN T2.FOLLOW_UP_TYPE_CD = 1 THEN 'ACTIVE'
END ROM_COC_TYPE,
	 T2.FOLLOW_UP_TYPE_CD, T5.FOLLOW_UP_TYPE_ELBL, T5.FOLLOW_UP_TYPE_IND, 
INSPECTION_JUSTIFICATION_TXT, T2.ACTIVITY_ID SOURCE_ACTIVITYID, T1.qm_iisactivityid STAGE_ACTIVITYID, T2.VIOLATION_CD SOURCE_VIOLATIONCD, T1.qm_iisviolationcd STAGE_VIOLATIONCD
FROM STAGING__VIOLATIONS T1
LEFT JOIN [YD082_INSPECTION_VIOLATION] T2 ON T1.qm_iisviolationcd = t2.VIOLATION_CD AND T1.qm_iisactivityid = T2.ACTIVITY_ID
JOIN TD005_FOLLOW_UP_TYPE T5 ON T2.FOLLOW_UP_TYPE_CD = T5.FOLLOW_UP_TYPE_CD
--JOIN TD005_FOLLOW_UP_TYPE T3 ON 
WHERE T2.DATE_DELETED_DTE IS NULL;




  --@CONST_TDGCORE_USERID [ownerid],
  --@CONST_OWNERIDTYPE_SYSTEMUSER [owneridtype],
  --@CONST_TDG_BUSINESSUNITID [owningbusinessunit],
  --@CONST_TDGCORE_USERID [owninguser],
  --  [ownerid],
  --  [owneridtype],
  --  [owningbusinessunit],
  --  [owninguser]

--COC ONLY CREATED FROM >= APRIL 1 2020

--COC TO BE PROVIDED IN 30 DAYS - ACTIVE, ACTIVE
--VIOLATION RESOLVED = CLOSED, CONFIRMATION RECIEVED ON TIME
--COC NOT RECEIVED = CLOSED, CLOSED - UNRESOLVED
--COC NOT REQUESTED BY INSPECTOR = CLOSED, CONFIRMATION ON-SITE


