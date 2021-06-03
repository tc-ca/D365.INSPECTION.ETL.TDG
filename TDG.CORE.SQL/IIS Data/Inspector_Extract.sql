SELECT 
USER_ID,
STAKEHOLDER_NAME_FIRST_NM "First Name",
STAKEHOLDER_NAME_FAMILY_NM "Last Name",
STAKEHOLDER_NAME_FIRST_NM || ' ' || STAKEHOLDER_NAME_FAMILY_NM "Fullname",
EMAIL_TXT "Account_name", 
YD074.INSPECTOR_BADGE_NUM BADGE, 
YD074.INSPECTOR_CERT_NUM RIN,
'' "RegionCrmId",

CASE 

WHEN YD093.STAKEHOLDER_ENM = 'TDG ASDA' THEN 'HQ-ES'
WHEN YD093.STAKEHOLDER_ENM = 'TDG ASDB' THEN 'HQ-CR'
WHEN YD093.STAKEHOLDER_ENM = 'TDG ASDE' THEN 'HQ-CR'
WHEN YD093.STAKEHOLDER_ENM = 'TDG PRAIRIE AND NORTHERN REGION' THEN 'PNR'
WHEN YD093.STAKEHOLDER_ENM = 'TDG PACIFIC REGION' THEN 'PAC'
WHEN YD093.STAKEHOLDER_ENM = 'TDG ATLANTIC REGION' THEN 'ATL'
WHEN YD093.STAKEHOLDER_ENM = 'TDG QUEBEC REGION' THEN 'PQ'
WHEN YD093.STAKEHOLDER_ENM = 'TDG ONTARIO REGION' THEN 'ONT'
WHEN YD093.STAKEHOLDER_ENM = 'TDG HQ' THEN 'HQ-CR'

END "Region",

YD093.STAKEHOLDER_ENM "RegionEnm", 
YD093.STAKEHOLDER_FNM "RegionFnm"
FROM TC008_USER TC008
JOIN YD083_INDIVIDUAL_INFORMATION YD083 ON TC008.USER_STAKEHOLDER_ID = YD083.STAKEHOLDER_ID
JOIN YD074_INSPECTOR YD074 ON TC008.USER_STAKEHOLDER_ID = YD074.STAKEHOLDER_ID
JOIN YD092_STAKEHOLDER_ORG_PERS YD092 ON TC008.USER_STAKEHOLDER_ID = YD092.STAKEHOLDER_CONTACT_ID
JOIN YD093_STAKEHOLDER_ORG_NAME YD093 ON YD092.STAKEHOLDER_ID = YD093.STAKEHOLDER_ID
WHERE YD083.DATE_DELETED_DTE IS NULL and TC008.DATE_DELETED_DTE IS NULL AND TC008.DATE_STOP_DTE IS NULL
AND INSPECTOR_CERT_NUM like '99%';