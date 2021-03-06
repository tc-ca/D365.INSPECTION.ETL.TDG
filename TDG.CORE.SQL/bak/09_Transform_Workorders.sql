
TRUNCATE TABLE [06_WORK_ORDERS];

INSERT INTO [dbo].[06_WORK_ORDERS]
(
	 [msdyn_workorderid]
	,[msdyn_workordertype]
	,[msdyn_name]
	,[msdyn_pricelist]
	,[msdyn_serviceaccount]
	,[ovs_iisid]
	,[msdyn_systemstatus]
	,[ovs_primaryinspector]
	,[ovs_secondaryinspector]
	,[ownerid]
	,[owneridtype]
	,[owningbusinessunit]
	,owninguser
	,[msdyn_workordersummary]
	,[ovs_fiscalquarter]
	,[ovs_fiscalquartername]
	,[ovs_fiscalyear]
	,[ovs_fiscalyearname]
	,[ovs_oversighttype]
	,[ovs_rational]

	--,[qm_reportcontactid]
	--,[statecode]
	--,[statuscode]
)

SELECT ID, WORK_ORDER_TYPE, WORK_ORDER_NUMBER, PRICE_LIST, accountid, ovs_iisid, WORK_ORDER_STATUS, PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID, SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID,[OWNER],
	   OWNER_TYPE, OWNING_BUSINESS_UNIT, owning_user, WORK_ORDER_SUMMARY, FQ.tc_tcfiscalquarterid, FY.tc_tcfiscalyearid, OVERSIGHT_TYPE, RATIONALE FROM
(

	SELECT
		newid() ID,																				--WORK ORDER ID
		'b1ee680a-7cf7-ea11-a815-000d3af3a7a7' WORK_ORDER_TYPE,									--work order type "Inspection"
		REPLACE(STR(ROW_NUMBER() OVER (ORDER BY ACTIVITY_ID),6),' ','0') WORK_ORDER_NUMBER,		--WO name, auto incremented number 1...x
		'b92b6a16-7cf7-ea11-a815-000d3af3a7a7' PRICE_LIST,										--default price list
		id accountid,																			--account id for service account linked by the iis id
		[ovs_iisid],																			--IIS STAKEHOLDER_ID
		'690970004' WORK_ORDER_STATUS,															--"Closed - Posted"
		FILE_STATUS_ETXT,
		PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,													--PRIMARY INSPECTOR
		SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID												--SECONDARY INSPECTOR
		,PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID owner											--'D0483132-B964-EB11-A812-000D3AF38846' [OWNER]	--OWNER = primary inspector
		,'systemuser' [OWNER_TYPE]																--OWNER TYPE = systemuser
		,'4E122E0C-73F3-EA11-A815-000D3AF3AC0D' [OWNING_BUSINESS_UNIT]							--TDG Business Unit
		,PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID [owning_user]
		--,'D0483132-B964-EB11-A812-000D3AF38846' [OWNING_TEAM]									--OWNING TEAM = TDG Team
		,ACTIVITY_ID	[WORK_ORDER_SUMMARY],	--WORK ORDER SUMMARY

		CASE 
			WHEN ([MONTH] >= 1 AND [MONTH] <=3)   THEN 'Q4'
			WHEN ([MONTH] >= 4 AND [MONTH] <=6)   THEN 'Q1'
			WHEN ([MONTH] >= 7 AND [MONTH] <=9)   THEN 'Q2'
			WHEN ([MONTH] >= 10 AND [MONTH] <=12) THEN 'Q3'
		END FISCAL_QUARTER,

		CASE 
			WHEN ([MONTH] >= 1 AND [MONTH] <=3) THEN 
				CONCAT(CONVERT(NVARCHAR(4), [YEAR] - 1),'-', CONVERT(NVARCHAR(4), [YEAR]))
			ELSE
				CONCAT(CONVERT(NVARCHAR(4), [YEAR]),'-', CONVERT(NVARCHAR(4), [YEAR] + 1))
		END FISCAL_YEAR,

		CASE 
			WHEN ACTIVITY_TYPE_ENM = 'Site Visit'							 THEN 'd5e56a32-65e9-ea11-a817-000d3af3ac0d'
			WHEN ACTIVITY_TYPE_ENM = 'MOC Facility Inspection (Planned)'	 THEN 'dd1a4a2c-65e9-ea11-a817-000d3af3ac0d'
			WHEN ACTIVITY_TYPE_ENM = 'General Compliance Inspection'		 THEN 'ffae4a26-65e9-ea11-a817-000d3af3ac0d'
			WHEN ACTIVITY_TYPE_ENM = 'Consignment'							 THEN 'c1d81014-65e9-ea11-a817-000d3af3ac0d'
			WHEN ACTIVITY_TYPE_ENM = 'MOC Facility Inspection - (Unplanned)' THEN 'dd1a4a2c-65e9-ea11-a817-000d3af3ac0d'
			WHEN ACTIVITY_TYPE_ENM = 'Document Review'						 THEN '39ee5859-65e9-ea11-a817-000d3af3ac0d'
		END OVERSIGHT_TYPE,

		CASE 
			WHEN ACTIVITY_TYPE_ENM = 'Site Visit'							 THEN '994c3ec1-c104-eb11-a813-000d3af3a7a7' --PLANNED
			WHEN ACTIVITY_TYPE_ENM = 'MOC Facility Inspection (Planned)'	 THEN '994c3ec1-c104-eb11-a813-000d3af3a7a7' --PLANNED
			WHEN ACTIVITY_TYPE_ENM = 'General Compliance Inspection'		 THEN '994c3ec1-c104-eb11-a813-000d3af3a7a7' --PLANNED
			WHEN ACTIVITY_TYPE_ENM = 'Consignment'							 THEN '47f438c7-c104-eb11-a813-000d3af3a7a7' --UNPLANNED
			WHEN ACTIVITY_TYPE_ENM = 'MOC Facility Inspection - (Unplanned)' THEN '47f438c7-c104-eb11-a813-000d3af3a7a7' --UNPLANNED
			WHEN ACTIVITY_TYPE_ENM = 'Document Review'						 THEN '47f438c7-c104-eb11-a813-000d3af3a7a7' --UNPLANNED
		END RATIONALE
	
	FROM [19_IIS_INSPECTIONS]

) T3

JOIN [dbo].[13_FISCAL_YEAR] FY ON FY.TC_NAME = T3.FISCAL_YEAR
JOIN [dbo].[14_FISCAL_QUARTER] FQ ON FQ.TC_NAME = T3.FISCAL_QUARTER AND FY.tc_tcfiscalyearid = FQ.tc_tcfiscalyearid;


--load the fiscal year, quarter and inspector names into the staging table, easier to look at the data
update [06_WORK_ORDERS] 
SET
	 [ovs_primaryinspectorname]		= BR.name
	,[ovs_secondaryinspectorname]	= BR2.name
	,[ovs_fiscalquartername]		= FQ.tc_name
	,[ovs_fiscalyearname]			= FY.tc_name
--SELECT 
--BR.name
--,BR2.name
--,FQ.tc_name
--,FY.tc_name
FROM 
[06_WORK_ORDERS] T1
JOIN [dbo].[13_FISCAL_YEAR] FY on T1.ovs_fiscalyear = FY.tc_tcfiscalyearid
JOIN [dbo].[14_FISCAL_QUARTER] FQ on T1.ovs_fiscalquarter = FQ.tc_tcfiscalquarterid
JOIN [dbo].[bookableresource] BR ON T1.ovs_primaryinspector = BR.bookableresourceid
LEFT JOIN [dbo].[bookableresource] BR2 ON T1.ovs_secondaryinspector = BR2.bookableresourceid


--UPDATE WORK ORDER ADDRESSES WITH ACCOUNT ADDRESSES 
UPDATE [06_WORK_ORDERS] 
SET 
msdyn_serviceterritory = A.territoryid, 
msdyn_address1 = A.address1_line1, 
msdyn_address2 = A.address1_line2, 
msdyn_address3 = A.address1_line3, 
msdyn_city = A.address1_city, 
msdyn_country = A.address1_country, 
msdyn_postalcode = A.address1_postalcode, 
msdyn_stateorprovince = A.address1_stateorprovince
FROM [06_WORK_ORDERS] WO
JOIN [04_ACCOUNT] A on WO.msdyn_serviceaccount = A.id;


--WHERE THE PRIMARY HASNT BEEN SET BECAUSE THE INSPECTOR DOES NOT HAVE AN ACCOUNT YET, THEN SET IT TO THE "TDG.CORE" user so we can at least get them in
UPDATE [06_WORK_ORDERS] 
SET 
[ovs_primaryinspector] = '2B0EFFB4-179B-EB11-B1AC-000D3AE8665A' --TDG CORE BOOKABLE RESOURCE ID
,ownerid ='53275569-D460-EB11-A812-000D3AE947A6' -- tdg core system user
,owninguser = '53275569-D460-EB11-A812-000D3AE947A6' -- tdg core system user
FROM [06_WORK_ORDERS] WO
WHERE WO.ovs_primaryinspector IS NULL;


