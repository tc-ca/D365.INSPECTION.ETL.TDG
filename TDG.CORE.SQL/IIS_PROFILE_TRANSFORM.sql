--OHS CHECKLIST MIGRATION FROM IIS
SELECT [STAKEHOLDER_ID]
      ,[STKHLDR_HOTI_SEQ_NUM]
      ,[DATE_LAST_UPDATE_DTE]
      ,[OHS_COMMENT_TXT]
      ,[OHS_CHECKLIST_RDIMS_NUM]
  FROM [dbo].[YD030_STAKEHOLDER_HOTI] 
  WHERE DATE_DELETED_DTE IS NULL;


------MODES MIGRATION FROM IIS
SELECT 
[STAKEHOLDER_ID],
MODE,
STRING_AGG(SUPPLY_CHAIN_DIRECTION, ';') WITHIN GROUP (ORDER BY SUPPLY_CHAIN_DIRECTION) AS SUPPLY_CHAIN_DIRECTION

FROM 
(
	SELECT 

	[STAKEHOLDER_ID],

	CASE

		WHEN [TRANSPORT_MODE_CD] = 'SAIN' THEN 'AIR'
		WHEN [TRANSPORT_MODE_CD] = 'SAOUT' THEN 'AIR'

		WHEN [TRANSPORT_MODE_CD] = 'SHIN' THEN 'ROAD'
		WHEN [TRANSPORT_MODE_CD] = 'SHOUT' THEN 'ROAD'

		WHEN [TRANSPORT_MODE_CD] = 'SMIN' THEN 'MARINE'
		WHEN [TRANSPORT_MODE_CD] = 'SMOUT' THEN 'MARINE'

		WHEN [TRANSPORT_MODE_CD] = 'SRIN' THEN 'RAIL'
		WHEN [TRANSPORT_MODE_CD] = 'SROUT' THEN 'RAIL'

	END MODE, 

	CASE

		WHEN CHARINDEX('IN', [TRANSPORT_MODE_CD]) > 0	THEN 'Inbound'
		WHEN CHARINDEX('OUT', [TRANSPORT_MODE_CD]) > 0	THEN 'Outbound'

	END SUPPLY_CHAIN_DIRECTION

	--,[DATE_CREATED_DTE]
	--,[DATE_LAST_UPDATE_DTE]
	FROM [dbo].[YD032_STAKEHOLDER_MODE_PROFILE]
	WHERE DATE_DELETED_DTE IS NULL
) T
GROUP BY T.STAKEHOLDER_ID, T.MODE-- T.DATE_CREATED_DTE, T.DATE_LAST_UPDATE_DTE
ORDER BY STAKEHOLDER_ID;


--CLASS + SUPPLY CHAIN DIRECTION FROM IIS
SELECT STAKEHOLDER_ID, HAZARD_CLASS_DIVISION_CD, STRING_AGG(SUPPLY_CHAIN_DIRECTION, ';') WITHIN GROUP (ORDER BY SUPPLY_CHAIN_DIRECTION) AS SUPPLY_CHAIN_DIRECTION FROM 
(
	SELECT 
	DISTINCT
	[STAKEHOLDER_ID]
	,[HAZARD_CLASS_DIVISION_CD]
	,CASE

		WHEN CHARINDEX('IN', DG_PKG_TRANS_DIR_CD) > 0	THEN 'Inbound'
		WHEN CHARINDEX('OUT', DG_PKG_TRANS_DIR_CD) > 0	THEN 'Outbound'
	
	END SUPPLY_CHAIN_DIRECTION
	FROM [dbo].[YD033_STAKEHOLDER_CLASS_PROFIL]
	WHERE DATE_DELETED_DTE IS NULL
) T
GROUP BY STAKEHOLDER_ID, HAZARD_CLASS_DIVISION_CD
ORDER BY STAKEHOLDER_ID