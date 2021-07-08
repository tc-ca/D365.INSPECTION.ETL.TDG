--UPDATE THE VIOLATION_CD AND VIOLATION_REFERENCE_CD VALUES BY MATCHING ON THE DISPLAY NAMES, UGLY I KNOW BUT NOT MUCH ELSE WE CAN DO HERE
--==============================================================================================
UPDATE SOURCE__LEGISLATION_MATCHING
SET 
VIOLATION_CD = T1.VIOLATION_CD,
VIOLATION_REFERENCE_CD = T1.VIOLATION_REFERENCE_CD

FROM (

  --JOIN BY FRENCH TEXT
  SELECT [LegislationId], T2.VIOLATION_CD, T2.VIOLATION_REFERENCE_CD
  FROM [dbo].SOURCE__LEGISLATION_MATCHING T1
  JOIN [TD070_VIOLATION] T2 ON dbo.fn_StripCharacters(T1.[Violation Display Text FR], '^a-z0-9') = dbo.fn_StripCharacters(T2.VIOLATION_FTXT, '^a-z0-9')
  WHERE 
  (([Violation Display Text EN] IS NOT NULL AND [Violation Display Text EN] <> '') OR 
  ([Violation Display Text FR] IS NOT NULL AND [Violation Display Text FR] <> ''))

  UNION

  --JOIN BY ENGLISH TEXT
  SELECT [LegislationId], T2.VIOLATION_CD, T2.VIOLATION_REFERENCE_CD
  FROM [dbo].SOURCE__LEGISLATION_MATCHING T1
  JOIN [TD070_VIOLATION] T2 ON dbo.fn_StripCharacters(T1.[Violation Display Text EN], '^a-z0-9') = dbo.fn_StripCharacters(T2.VIOLATION_ETXT, '^a-z0-9') 
  WHERE 
  (([Violation Display Text EN] IS NOT NULL AND [Violation Display Text EN] <> '') OR 
  ([Violation Display Text FR] IS NOT NULL AND [Violation Display Text FR] <> ''))

) T1
JOIN SOURCE__LEGISLATION_MATCHING T2 ON T1.LegislationId = T2.LegislationId;
--==============================================================================================



--UPDATE THE LEGISLATION IDS IN OUR MATCHING TABLE WITH THE LEGISLATION THAT HAVE BEEN STAGED
--==============================================================================================

UPDATE SOURCE__LEGISLATION_MATCHING SET LegislationId = NULL;

--MATCH ON ENGLISH DISPLAY NAME
--06/05/2021 COUNT = 291
UPDATE SOURCE__LEGISLATION_MATCHING
SET 
LegislationId = T2.qm_rclegislationid,
MATCHED_WITH_ROM = 1
--SELECT *
FROM SOURCE__LEGISLATION_MATCHING T1
JOIN STAGING__tylegislation T2 ON dbo.fn_StripCharacters(T1.[Violation Display Text EN], '^a-z0-9') = dbo.fn_StripCharacters(T2.qm_violationdisplaytexten, '^a-z0-9');


--MATCH ON FRENCH DISPLAY NAME
--06/05/2021 COUNT = 292
UPDATE SOURCE__LEGISLATION_MATCHING
SET 
LegislationId = T2.qm_rclegislationid,
MATCHED_WITH_ROM = 1
--SELECT *
FROM SOURCE__LEGISLATION_MATCHING T1
JOIN STAGING__tylegislation T2 ON dbo.fn_StripCharacters(T1.[Violation Display Text FR], '^a-z0-9') = dbo.fn_StripCharacters(T2.qm_violationdisplaytextfr, '^a-z0-9');


--NEED TO GET MATCH COUNT AS HIGH AS POSSIBLE
SELECT COUNT(*) MATCHED_WITH_ROM FROM SOURCE__LEGISLATION_MATCHING WHERE MATCHED_WITH_ROM = 1;
SELECT COUNT(*) NOT_MATCHED_WITH_ROM FROM SOURCE__LEGISLATION_MATCHING WHERE MATCHED_WITH_ROM = 0 OR MATCHED_WITH_ROM IS NULL;


--==============================================================================================





--COUNT THE NUMBER OF MATCHES AND NON MATCHES OF THE LEGISLATION CLIENT EXCEL DATA TO IIS
--==============================================================================================
DECLARE @NO_MATCH_COUNT INT = 0;
DECLARE @MATCH_COUNT INT = 0;

SELECT @NO_MATCH_COUNT = COUNT(*) FROM SOURCE__LEGISLATION_MATCHING
WHERE
(([Violation Display Text EN] IS NOT NULL AND [Violation Display Text EN] <> '') OR 
([Violation Display Text FR] IS NOT NULL AND [Violation Display Text FR] <> ''))
AND VIOLATION_CD IS NULL;

SELECT @MATCH_COUNT = COUNT(*) FROM SOURCE__LEGISLATION_MATCHING
WHERE
(([Violation Display Text EN] IS NOT NULL AND [Violation Display Text EN] <> '') OR 
([Violation Display Text FR] IS NOT NULL AND [Violation Display Text FR] <> ''))
AND VIOLATION_CD IS NOT NULL;

SELECT @NO_MATCH_COUNT NO_MATCH_COUNT, @MATCH_COUNT MATCH_COUNT;
--==============================================================================================