/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
T1.[STAKEHOLDER_ID]
,T2.STAKEHOLDER_NAME_FIRST_NM
,T2.STAKEHOLDER_NAME_FAMILY_NM
,T1.[INSPECTOR_CERT_NUM]
,T1.[INSPECTOR_BADGE_NUM]
,T1.[DATE_CREATED_DTE]
,T1.[DATE_LAST_UPDATE_DTE]
FROM [dbo].[YD074_INSPECTOR] T1
JOIN [dbo].[YD083_INDIVIDUAL_INFORMATION] T2 ON T1.STAKEHOLDER_ID = T2.STAKEHOLDER_ID
JOIN [dbo].[YD070_STAKEHOLDER] T3 ON T2.STAKEHOLDER_ID = T3.STAKEHOLDER_ID
WHERE T3.DATE_STOP_DTE IS NULL
AND T1.DATE_DELETED_DTE IS NULL AND T2.DATE_DELETED_DTE IS NULL 
AND INSPECTOR_CERT_NUM like '99%' 
order by STAKEHOLDER_NAME_FAMILY_NM;