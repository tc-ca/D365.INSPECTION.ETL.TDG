--DEFAULT MASTER DATA
BEGIN
	DECLARE @CONST_WORKORDERTYPE_INSPECTION           VARCHAR(50) = 'b1ee680a-7cf7-ea11-a815-000d3af3a7a7';
	DECLARE @CONST_OVERSIGHTTYPE_GCTARGETED           VARCHAR(50) = '50D0BDF1-269E-EB11-B1AC-000D3AE924D1';
	DECLARE @CONST_OVERSIGHTTYPE_MOCTARGETED          VARCHAR(50) = '864BAA27-279E-EB11-B1AC-000D3AE924D1';
	DECLARE @CONST_OVERSIGHTTYPE_GCCONSIGNMENT        VARCHAR(50) = '460B6C2A-5F9C-EB11-B1AC-000D3AE92708';
	DECLARE @CONST_OVERSIGHTTYPE_MOCOPPORTUNITY       VARCHAR(50) = 'F6A0B96E-5F9C-EB11-B1AC-000D3AE92708';
	DECLARE @CONST_OVERSIGHTTYPE_CIVDOCREVIEW         VARCHAR(50) = 'A4965081-5F9C-EB11-B1AC-000D3AE92708';
	DECLARE @CONST_OVERSIGHTTYPE_RATIONALE_PLANNED    VARCHAR(50) = '994c3ec1-c104-eb11-a813-000d3af3a7a7';
	DECLARE @CONST_OVERSIGHTTYPE_RATIONALE_UNPLANNED  VARCHAR(50) = '47f438c7-c104-eb11-a813-000d3af3a7a7';
	DECLARE @CONST_TDGCORE_BOOKABLE_RESOURCE_ID       VARCHAR(50) = '2cfc9150-d6a3-eb11-b1ac-000d3ae8bee7';
	DECLARE @CONST_TDGCORE_USERID                     VARCHAR(50) = '53275569-d460-eb11-a812-000d3ae947a6';
	DECLARE @CONST_TDGCORE_DOMAINNAME                 VARCHAR(50) = 'tdg.core@034gc.onmicrosoft.com';
	DECLARE @CONST_TDG_TEAMID                         VARCHAR(50) = 'd0483132-b964-eb11-a812-000d3af38846';
	DECLARE @CONST_TDG_TEAMNAME                       VARCHAR(50) = 'Transportation of Dangerous Goods';
	DECLARE @CONST_TDG_BUSINESSUNITID                 VARCHAR(50) = '4E122E0C-73F3-EA11-A815-000D3AF3AC0D';
	DECLARE @CONST_PRICELISTID                        VARCHAR(50) = 'B92B6A16-7CF7-EA11-A815-000D3AF3A7A7'; 
	DECLARE @CONST_RATIONALE_PLANNED                  VARCHAR(50) = '994C3EC1-C104-EB11-A813-000D3AF3A7A7';
	DECLARE @CONST_RATIONALE_UNPLANNED                VARCHAR(50) = '47F438C7-C104-EB11-A813-000D3AF3A7A7';
END


--no workorders with non-existing bookableresources
SELECT systemuserid, fullname, T1.bookableresourceid, T1.statecode, T1.statuscode
FROM systemuser
LEFT JOIN [12_BOOKABLE_RESOURCE] T1 ON systemuser.systemuserid = T1.userid
WHERE systemuserid IN
(
	SELECT T1.ownerid 
	FROM [06_WORK_ORDERS] T1
	where T1.ovs_primaryinspector not in 
	(
		SELECT bookableresourceid FROM [12_BOOKABLE_RESOURCE]
	)
) 

SELECT bookableresourceid, userid, name FROM [12_BOOKABLE_RESOURCE] ORDER BY name;
SELECT [USER_ID], [First Name], [Last Name], Fullname, Account_name FROM dbo.[16_IIS_INSPECTORS] ORDER BY Fullname;
SELECT bookableresourceid, userid, name FROM dbo.bookableresource ORDER BY name;
SELECT systemuserid, fullname, domainname FROM dbo.systemuser ORDER BY fullname;
SELECT * FROM dbo.[19_IIS_INSPECTIONS];

--records should only be owned by the tdg team or the primary inspector
SELECT * 
FROM [06_WORK_ORDERS] T1
where T1.[ownerid] not in 
(
	SELECT userid FROM [12_BOOKABLE_RESOURCE]
)
AND T1.ownerid <> @CONST_TDG_TEAMID;

--no inspections for sites that dont exists
SELECT * 
FROM [06_WORK_ORDERS] T1
where T1.msdyn_serviceaccount not in 
(
	SELECT accountid FROM dbo.[04_ACCOUNT]
)

--no contacts linked to sites that dont exists
SELECT * 
FROM dbo.[11_CONTACT] T1
where T1.company not in 
(
	SELECT accountid FROM dbo.[04_ACCOUNT]
)

--staging data check; tables should no longer be empty
SELECT COUNT(*) [02_REGULATED_ENTITIES]     FROM [dbo].[02_REGULATED_ENTITIES];
SELECT COUNT(*) [03_SITES]        FROM [dbo].[03_SITES];
SELECT COUNT(*) [04_ACCOUNT]       FROM [dbo].[04_ACCOUNT];
SELECT COUNT(*) [06_WORK_ORDERS]      FROM [dbo].[06_WORK_ORDERS];
SELECT COUNT(*) [07_VIOLATIONS]       FROM [dbo].[07_VIOLATIONS];
SELECT COUNT(*) [11_CONTACT]       FROM [dbo].[11_CONTACT];
SELECT COUNT(*) [12_BOOKABLE_RESOURCE]     FROM [dbo].[12_BOOKABLE_RESOURCE];
SELECT COUNT(*) [18_BOOKABLE_RESOURCE_CATEGORY_ASSN] FROM [dbo].[18_BOOKABLE_RESOURCE_CATEGORY_ASSN];

--how many accounts were migrated
SELECT COUNT(*) accounts FROM 
[dbo].[account] T1
JOIN [dbo].[04_ACCOUNT] T2 ON T1.accountid = T2.id

--how many contacts were assigned to sites
SELECT COUNT(*) contacts FROM 
[dbo].[account] T1 
JOIN [dbo].[11_CONTACT] T2 ON T1.accountid = T2.accountid
WHERE T1.customertypecode <> 948010000;   

--how many contacts were migrated
SELECT COUNT(*) [11_CONTACT] FROM 
[dbo].[11_CONTACT] T1
JOIN [dbo].[contact] T2 ON T1.accountid = T2.parentcustomerid;

--match work order staging table to replicated crm work order table to see how many work order were created in crm
SELECT COUNT(*) [06_WORK_ORDERS] FROM  
[dbo].[06_WORK_ORDERS] T1
JOIN [dbo].msdyn_workorder T2 ON T1.msdyn_workorderid = T2.msdyn_workorderid;

--no workorders in staging table with a null rational or oversight type
SELECT COUNT(*) [WORK_ORDERS_W_NO_OVERSIGHT_TYPE_OR_RATIONALE] FROM 
[dbo].[06_WORK_ORDERS] T1
WHERE T1.ovs_rational IS NULL OR T1.ovs_oversighttype IS NULL;

--match violation staging table to replicated crm violation table to see how many violations were created in crm
SELECT * FROM 
[dbo].[07_VIOLATIONS] T1
JOIN [dbo].[qm_syresult] T2 ON T1.qm_syresultid = T2.qm_syresultid;
--=========================================================================================================
--=========================================================================================================

