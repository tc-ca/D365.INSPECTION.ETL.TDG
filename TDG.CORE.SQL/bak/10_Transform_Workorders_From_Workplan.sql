
--SELECT * FROM [06_WORK_ORDERS] WHERE ovs_fiscalyearname = '2021-2022'

--Open - Unscheduled	690970000
--Open - Scheduled		690970001
--Open - In Progress	690970002
--Open - Completed		690970003
--Closed - Posted		690970004
--Closed - Canceled		690970005

--ANY Inspections from this years workplan that exist in IIS lets set to Open-Completed, hard to know if they're fully done or not
UPDATE [06_WORK_ORDERS]
SET [msdyn_systemstatus] = '690970003' --Open-Completed
WHERE ovs_fiscalyearname = '2021-2022';

--INSERT planned inspections for this fiscal year that havnt been started in IIS
INSERT INTO [dbo].[06_WORK_ORDERS]
(
	 [msdyn_workorderid]
	,[msdyn_workordertype]
	,[msdyn_name]
	,[msdyn_pricelist]
	,[msdyn_serviceaccount]
	,[ovs_iisid]
	,[msdyn_systemstatus]
	--,[ovs_primaryinspector]
	--,[ovs_secondaryinspector]
	,[ownerid]
	,[owneridtype]
	,[owningbusinessunit]
	--,owninguser
	,owningteam
	,[msdyn_workordersummary]

	,[ovs_fiscalquarter]
	,[ovs_fiscalquartername]
	,[ovs_fiscalyear]
	,[ovs_fiscalyearname]

	,[ovs_oversighttype]
	,[ovs_rational]
)

SELECT
	newid()																				[msdyn_workorderid],	--WORK ORDER ID
	'b1ee680a-7cf7-ea11-a815-000d3af3a7a7'												WORK_ORDER_TYPE,		--work order type "Inspection"
	CONCAT([YEAR], REPLACE(STR(ROW_NUMBER() OVER (ORDER BY import_number),6),' ','0') )	WORK_ORDER_NUMBER,		--WO name, 2021 + auto incremented number 1...x
	'b92b6a16-7cf7-ea11-a815-000d3af3a7a7'												PRICE_LIST,				--default price list
	accountid																			accountid,				--account id for service account linked by the iis id
	IIS_ID																				IIS_ID,					--IIS STAKEHOLDER_ID
	'690970000'																			WORK_ORDER_STATUS,		--"Unscheduled"
	--PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,											--PRIMARY INSPECTOR		--SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID																
	'D0483132-B964-EB11-A812-000D3AF38846'												[OWNER]					--OWNER = primary inspector
	--,PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID											[owner]					--'D0483132-B964-EB11-A812-000D3AF38846' [OWNER]
	,'systemuser'																		[OWNER_TYPE]			--OWNER TYPE = systemuser
	,'4E122E0C-73F3-EA11-A815-000D3AF3AC0D'												[OWNING_BUSINESS_UNIT]	--TDG Business Unit
	--,PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID											[owning_user]			--owning user is the primary inspector
	,'D0483132-B964-EB11-A812-000D3AF38846'												[OWNING_TEAM]			--OWNING TEAM = TDG Team
	,CONCAT('Work Order converted from 2021/2022 Workplan for IIS_ID = ', IIS_ID)		[WORK_ORDER_SUMMARY],	--WORK ORDER SUMMARY
	[tc_tcfiscalquarterid],
	[ovs_fiscalquartername],
	[tc_tcfiscalyearid],
	[ovs_fiscalyearname],

	CASE 
		WHEN [TYPE] = 'MOC'		THEN 'dd1a4a2c-65e9-ea11-a817-000d3af3ac0d'
		WHEN [TYPE] = 'GC'		THEN 'ffae4a26-65e9-ea11-a817-000d3af3ac0d'
		WHEN [TYPE] = 'HUBS'	THEN 'ffae4a26-65e9-ea11-a817-000d3af3ac0d'
	END																					OVERSIGHT_TYPE,

	'994c3ec1-c104-eb11-a813-000d3af3a7a7'												RATIONALE --ALL WORK PLAN INSPECTIONS ARE PLANNED

FROM
(
	SELECT 
		WP.*, 
		ACCOUNTS.ID accountid,
		FQ.[tc_tcfiscalquarterid],
		FQ.[tc_name] [ovs_fiscalquartername],
		FY.[tc_tcfiscalyearid],
		FY.[tc_name] [ovs_fiscalyearname]
	FROM 
	(
		Select 
		
		CASE
			WHEN QUARTER_1 = '1' THEN 'Q1'
			WHEN QUARTER_2 = '1' THEN 'Q2'
			WHEN QUARTER_3 = '1' THEN 'Q3'
			WHEN QUARTER_4 = '1' THEN 'Q4'
		END [QUARTER],
		
		CASE
			WHEN QUARTER_1 = '1' OR QUARTER_2 = '1' OR QUARTER_3 = '1' THEN '2021'
			WHEN QUARTER_4 = '1' THEN '2022'
		END [YEAR]

		,CASE 
			WHEN Charindex(',', CURRENT_INSPECTOR) = 0 THEN 'TDG'
			ELSE Substring(CURRENT_INSPECTOR, 1,Charindex(',', CURRENT_INSPECTOR)-1)
		END [InspectorFirstName],
		
		CASE 
			WHEN Charindex(',', CURRENT_INSPECTOR) = 0 THEN 'CORE'
			ELSE Substring(CURRENT_INSPECTOR, Charindex(',', CURRENT_INSPECTOR)+1, LEN(CURRENT_INSPECTOR))
		END [InspectorLastName]
		
		,*	
		
		from [09_WORKPLAN_IMPORT] WP
		WHERE 
		CURRENTLY_PLANNED = '1' and fiscal_year = '2021-2022' AND
		CURRENT_INSPECTOR <> '' and CURRENT_INSPECTOR IS NOT NULL
	) WP
	--[dbo].[bookableresource] BR ON UPPER(TRIM(CONCAT(CONCAT(YD083.STAKEHOLDER_NAME_FIRST_NM, ' '), YD083.STAKEHOLDER_NAME_FAMILY_NM))) = UPPER([dbo].[ReplaceASCII](name))
	JOIN [04_ACCOUNT] ACCOUNTS ON WP.IIS_ID = ACCOUNTS.ovs_iisid
	JOIN [dbo].[13_FISCAL_YEAR] FY on WP.[YEAR] = FY.tc_fiscalyearnum
	JOIN [dbo].[14_FISCAL_QUARTER] FQ on FQ.tc_name = WP.[QUARTER] AND FQ.tc_tcfiscalyearidname = WP.fiscal_year
	AND import_number NOT IN
	(
		--WORKPLAN INSPECTIONS CREATED IN IIS ALREADY
		--IGNORE TO PREVENT DOUBLES
		SELECT import_number
		FROM
		(
			SELECT *, 

			CASE
				WHEN QUARTER_1 = '1' THEN 'Q1'
				WHEN QUARTER_2 = '1' THEN 'Q2'
				WHEN QUARTER_3 = '1' THEN 'Q3'
				WHEN QUARTER_4 = '1' THEN 'Q4'
			END [QUARTER]

			FROM [dbo].[09_WORKPLAN_IMPORT] 
		) WP
		JOIN [06_WORK_ORDERS] WO ON WP.IIS_ID = WO.ovs_iisid AND WP.fiscal_year = WO.ovs_fiscalyearname AND WP.QUARTER = WO.ovs_fiscalquartername
		where WP.fiscal_year = '2021-2022'
	)

) CURRENT_WORKPLAN;


--SELECT 
--     *
--  FROM [dbo].[06_WORK_ORDERS]
--  where ovs_fiscalyearname = '2021-2022'

