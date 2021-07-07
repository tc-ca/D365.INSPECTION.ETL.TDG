--=============================================DYNAMIC VALUES===========================================
DECLARE @CONST_TDGCORE_DOMAINNAME  VARCHAR(50)  = 'tdg.core@034gc.onmicrosoft.com';
DECLARE @CONST_TDGCORE_USERID      VARCHAR(50)  = (SELECT systemuserid FROM CRM__SYSTEMUSER  where domainname = 'tdg.core@034gc.onmicrosoft.com');
DECLARE @CONST_TEAM_TDG_ID          VARCHAR(500) = (SELECT teamid FROM CRM__TEAM WHERE name = 'Transportation of Dangerous Goods');
DECLARE @CONST_BUSINESSUNIT_TDG_ID VARCHAR(50)  = (SELECT businessunitid FROM CRM__BUSINESSUNIT WHERE name = 'Transportation of Dangerous Goods');
DECLARE @CONST_PRICELISTID         VARCHAR(50)  = (SELECT pricelevelid FROM CRM__pricelevel  WHERE NAME = 'Base Prices');
DECLARE @CONST_TDGCORE_BOOKABLE_RESOURCE_ID VARCHAR(50) = (SELECT bookableresourceid FROM STAGING__BOOKABLE_RESOURCE WHERE msdyn_primaryemail = @CONST_TDGCORE_DOMAINNAME);
	

--CRM CONSTANTS
DECLARE @CONST_OWNERIDTYPE_TEAM VARCHAR(50)			= 'team';
DECLARE @CONST_OWNERIDTYPE_SYSTEMUSER VARCHAR(50)	= 'systemuser';
--===================================================================================================

DROP TABLE IF EXISTS #TEMP_IIS_INSPECTIONS;
DROP TABLE if exists #TEMP_VIOLATIONS_MAPPED_TO_ROM;
DROP TABLE IF EXISTS #TEMP_VIOLATIONS;

--GET A TEMPORARY LIST OF INSPECTIONS FROM IIS DATA
--===================================================================================
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

--===================================================================================


--GET TEMPORARY LIST OF VIOLATIONS FROM IIS
--===================================================================================
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
--===================================================================================


--GET A TEMPORARY LIST OF VIOLATIONS THAT WERE MAPPED TO ROM VIA THE LEGISLATION MATCHING EXCEL SHEET DATA
--===================================================================================

--SELECT * 
--  FROM [dbo].SOURCE__LEGISLATION_MATCHING T1
--  JOIN [TD070_VIOLATION] T2 ON dbo.fn_StripCharacters(T1.[Violation Display Text FR], '^a-z0-9') = dbo.fn_StripCharacters(T2.VIOLATION_FTXT, '^a-z0-9')


SELECT 
DISTINCT
CAST(T2.qm_enablingprovision AS VARCHAR(4000)) qm_enablingprovision, 
CAST(T2.qm_enablingregulation AS VARCHAR(4000)) qm_enablingregulation, 
CAST(T2.qm_englishname AS VARCHAR(4000)) qm_englishname, 
CAST(T2.qm_frenchname AS VARCHAR(4000)) qm_frenchname, 
CAST(T2.qm_legislationetxt AS VARCHAR(4000)) qm_legislationetxt, 
CAST(T2.qm_legislationftxt AS VARCHAR(4000)) qm_legislationftxt, 
CAST(T2.qm_legislationlbl AS VARCHAR(4000)) qm_legislationlbl, 
CAST(T2.qm_name AS VARCHAR(4000)) qm_name,
T2.qm_ordernbr, 
T2.qm_rclegislationid, 
T2.qm_tylegislationsourceid, 
T2.qm_tylegislationtypeid, 
CAST(T2.qm_violationdisplaytext AS VARCHAR(4000)) qm_violationdisplaytext,
CAST(T2.qm_violationdisplaytexten AS VARCHAR(4000)) qm_violationdisplaytexten,
CAST(T2.qm_violationdisplaytextfr AS VARCHAR(4000)) qm_violationdisplaytextfr,
CAST(T2.qm_violationtext AS VARCHAR(4000)) qm_violationtext,

T1.[Enabling Provision], 
T1.[English Text], 
T1.[French Text], 
T1.Label, 
T1.[Legislation Source], 
T1.[Legislation Type], 
T1.LegislationId, 
T1.MATCHED_WITH_ROM, 
T1.[Modified Label], 
T1.Name, 
T1.[Order] EXCEL_ORDER, 
T1.[Violation Display Text EN], 
T1.[Violation Display Text FR],
T1.VIOLATION_CD, 
T1.VIOLATION_REFERENCE_CD
--INTO #MATCHED_LEGISLATION

, T3.*
FROM 
STAGING__tylegislation T2 
LEFT JOIN SOURCE__LEGISLATION_MATCHING T1 ON dbo.fn_StripCharacters(T2.[qm_legislationetxt], '^a-z0-9') = dbo.fn_StripCharacters(T1.[English Text], '^a-z0-9') --TRIM(UPPER(cast(T1.[English Text] as varchar(5000)))) = TRIM(UPPER(cast(T2.qm_legislationetxt as varchar(5000))))
LEFT JOIN [dbo].[TD070_VIOLATION] T3 ON T3.VIOLATION_CD = T1.VIOLATION_CD

--WHERE ([English Text] IS NOT NULL AND [English Text] <> '') AND VIOLATION_CD IS NOT NULL
ORDER BY NAME
--===================================================================================

DROP TABLE IF EXISTS #IIS_TO_ROM_MATCHES;
SELECT 
T1.*, T2.*
INTO #IIS_TO_ROM_MATCHES
FROM [TD070_VIOLATION] t1
LEFT JOIN STAGING__tylegislation T2 ON dbo.fn_StripCharacters(T1.VIOLATION_REFERENCE_CD, '^a-z0-9') = dbo.fn_StripCharacters(T2.qm_legislationlbl, '^a-z0-9')
WHERE VIOLATION_CD IN
(
	SELECT DISTINCT VIOLATION_CD FROM YD020_INSPECTION_VIOLATION 
);


DROP TABLE IF EXISTS #TEMP__IIS_TO_ROM_BY_ETXT;
SELECT * 
INTO #TEMP__IIS_TO_ROM_BY_ETXT
FROM [TD070_VIOLATION] t1
JOIN STAGING__tylegislation T2 ON dbo.fn_StripCharacters(T1.VIOLATION_ETXT, '^a-z0-9') = dbo.fn_StripCharacters(T2.qm_violationdisplaytexten, '^a-z0-9');

--DROP TABLE IF EXISTS #UPDATEQUERY;
--CREATE TABLE #UPDATEQUERY
--(
--    UPDATEQUERY NVARCHAR(1000) NOT NULL,
--    [ORDER] int NULL
--);

--for the lazy, will create an update statement with the columns of the temp table
--declare @LINE1 varchar(100), @LINE2 VARCHAR(5000), @LINE3 VARCHAR(1000), @UPDATE_STATEMENT VARCHAR(8000);  
--SELECT @LINE1 = 'UPDATE #IIS_TO_ROM_MATCHES SET ' + CHAR(10);
--SELECT @LINE2 = (SELECT STRING_AGG(CONCAT([name], ' = T2.', [name]), ',' + CHAR(10)) updateQuery FROM tempdb.sys.columns WHERE object_id = Object_id('tempdb..#IIS_TO_ROM_MATCHES'));
--SELECT @LINE3 = CHAR(10) + ' FROM #IIS_TO_ROM_MATCHES T1 JOIN #TEMP__IIS_TO_ROM_BY_ETXT T2 ON T1.VIOLATION_CD = T2.VIOLATION_CD WHERE T1.qm_rclegislationid IS NULL';
--SELECT @UPDATE_STATEMENT = @LINE1+@LINE2+@LINE3;
--PRINT @UPDATE_STATEMENT;

UPDATE #IIS_TO_ROM_MATCHES SET 
qm_enablingprovision = T2.qm_enablingprovision,
qm_enablingprovisionname = T2.qm_enablingprovisionname,
qm_enablingregulation = T2.qm_enablingregulation,
qm_enablingregulationname = T2.qm_enablingregulationname,
qm_englishname = T2.qm_englishname,
qm_frenchname = T2.qm_frenchname,
qm_legislationetxt = T2.qm_legislationetxt,
qm_legislationftxt = T2.qm_legislationftxt,
qm_legislationlbl = T2.qm_legislationlbl,
qm_name = T2.qm_name,
qm_ordernbr = T2.qm_ordernbr,
qm_rclegislationid = T2.qm_rclegislationid,
qm_rcparentlegislationid = T2.qm_rcparentlegislationid,
qm_rcparentlegislationidname = T2.qm_rcparentlegislationidname,
qm_tylegislationsourceid = T2.qm_tylegislationsourceid,
qm_tylegislationsourceidname = T2.qm_tylegislationsourceidname,
qm_tylegislationtypeid = T2.qm_tylegislationtypeid,
qm_tylegislationtypeidname = T2.qm_tylegislationtypeidname,
qm_violationdisplaytext = T2.qm_violationdisplaytext,
qm_violationdisplaytexten = T2.qm_violationdisplaytexten,
qm_violationdisplaytextfr = T2.qm_violationdisplaytextfr,
qm_violationtext = T2.qm_violationtext
 FROM #IIS_TO_ROM_MATCHES T1 JOIN #TEMP__IIS_TO_ROM_BY_ETXT T2 ON T1.VIOLATION_CD = T2.VIOLATION_CD WHERE T1.qm_rclegislationid IS NULL


SELECT 
VIOLATION_FTXT	
,VIOLATION_ETXT	
,VIOLATION_CD	
,VIOLATION_SOURCE_CD	
,CASE WHEN VIOLATION_SOURCE_CD = 1 THEN 'ACT' ELSE 'REG' END SOURCE_NAME	
,VIOLATION_REFERENCE_CD	
,' ' SEPERATOR	
,qm_legislationlbl	
,qm_englishname	
,qm_frenchname	
,qm_rclegislationid	
,qm_violationdisplaytexten	
,qm_legislationetxt	
,qm_violationdisplaytextfr	
,qm_legislationftxt
FROM 
#IIS_TO_ROM_MATCHES;


SELECT 
TRIM(qm_legislationlbl) qm_legislationlbl	
,qm_englishname	
,qm_frenchname	
,qm_violationdisplaytexten	
,qm_violationdisplaytextfr	
,qm_legislationetxt	
,qm_legislationftxt
,qm_rclegislationid	
FROM STAGING__tylegislation
WHERE TRIM(qm_legislationlbl) NOT LIKE 'CS%' AND TRIM(qm_legislationlbl) NOT LIKE 'CG%'
ORDER BY TRIM(qm_legislationlbl);
