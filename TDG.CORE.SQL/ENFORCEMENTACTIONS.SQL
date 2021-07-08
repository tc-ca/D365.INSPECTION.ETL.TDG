
--ROM
--Detention Notice						918640000
--Notice of Direction To Remedy			918640001
--Notice of Direction Not To Import		918640002
--Direction issued under Subsection 19	918640003
--Notice of Infraction					918640004
--Ticket								918640005
--Investigation							918640006

--EXCEL VALUES
--DN
--INV
--NDRNC
--NOI
--T


DELETE FROM SOURCE__ENFORCEMENT_ACTIONS WHERE [File Number] IS NULL OR [File Number] = 'Example';
GO

DROP TABLE IF EXISTS #TEMP__EA;
SELECT 
[File Number],
[Date Action Taken],
[Total Fine Charged],
[TDG Act Reference],
dbo.fn_StripCharacters([TDG Act Reference], '^a-z0-9') [TDG Act Reference Stripped],
[TDG Regulations Reference],
dbo.fn_StripCharacters([TDG Regulations Reference], '^a-z0-9') [TDG Regulations Reference Stripped],
[Enforcement Action Issued To],
[IIS ID Number],
[IIS Activity Number],
SPLIT__TYPE ACTION_TYPE_EXCEL,

CASE 
	WHEN SPLIT__TYPE = 'DN' THEN 918640000
	WHEN SPLIT__TYPE = 'NDRNC' THEN 918640001
	WHEN SPLIT__TYPE = 'NOI' THEN 918640004
	WHEN SPLIT__TYPE = 'T' THEN 918640005
	WHEN SPLIT__TYPE = 'INV' THEN 918640006
END ACTION_TYPE,

CASE 
WHEN [TDG Regulations Reference] IS NULL AND [Standards / IMDG Code / ICAO TI / 49 CFR] IS NULL THEN NULL
WHEN [TDG Regulations Reference] IS NOT NULL AND [Standards / IMDG Code / ICAO TI / 49 CFR] IS NULL THEN 
	CONCAT('TDG Regulations Reference: ', [TDG Regulations Reference])
WHEN [TDG Regulations Reference] IS NOT NULL AND [Standards / IMDG Code / ICAO TI / 49 CFR] IS NOT NULL THEN 
	CONCAT('TDG Regulations Reference: ', [TDG Regulations Reference], CHAR(13), CHAR(13), 'Standards / IMDG Code / ICAO TI / 49 CFR: ', [Standards / IMDG Code / ICAO TI / 49 CFR])
END [DESCRIPTION]

INTO #TEMP__EA
FROM
(
	--unpack concatonated value to extra rows
	SELECT *, TRIM(SPLIT.Value) [SPLIT__TYPE]
	FROM SOURCE__ENFORCEMENT_ACTIONS
	cross apply STRING_SPLIT ([Type of Enforcement Action], '&') SPLIT
) T;

--isnull([TDG Act Reference], [TDG Regulations Reference]) ACT_W_REG_RPLCMNT,
--isnull([TDG Act Reference], [TDG Regulations Reference]) ACT_W_REG_RPLCMNT,



--match on IIS IS Number for Site. If no IIS#, try off site name. If still nothing, flag.
select 
*
from 
STAGING__ACCOUNT T1
JOIN #TEMP__EA T2 ON T1.ovs_iisid = T2.[IIS ID Number]


select * from #TEMP__EA;