UPDATE [20_LEGISLATION_MATCHING]
SET 
VIOLATION_CD = T1.VIOLATION_CD,
VIOLATION_REFERENCE_CD = T1.VIOLATION_REFERENCE_CD

FROM (

  SELECT [LegislationId], T2.VIOLATION_CD, T2.VIOLATION_REFERENCE_CD
  FROM [dbo].[20_LEGISLATION_MATCHING] T1
  JOIN [TD070_VIOLATION] T2 ON dbo.fn_StripCharacters(T1.[Violation Display Text FR], '^a-z0-9') = dbo.fn_StripCharacters(T2.VIOLATION_FTXT, '^a-z0-9')
  WHERE 
  (([Violation Display Text EN] IS NOT NULL AND [Violation Display Text EN] <> '') OR 
  ([Violation Display Text FR] IS NOT NULL AND [Violation Display Text FR] <> ''))

  UNION

  SELECT [LegislationId], T2.VIOLATION_CD, T2.VIOLATION_REFERENCE_CD
  FROM [dbo].[20_LEGISLATION_MATCHING] T1
  JOIN [TD070_VIOLATION] T2 ON dbo.fn_StripCharacters(T1.[Violation Display Text EN], '^a-z0-9') = dbo.fn_StripCharacters(T2.VIOLATION_ETXT, '^a-z0-9') 
  WHERE 
  (([Violation Display Text EN] IS NOT NULL AND [Violation Display Text EN] <> '') OR 
  ([Violation Display Text FR] IS NOT NULL AND [Violation Display Text FR] <> ''))

) T1
JOIN [20_LEGISLATION_MATCHING] T2 ON T1.LegislationId = T2.LegislationId