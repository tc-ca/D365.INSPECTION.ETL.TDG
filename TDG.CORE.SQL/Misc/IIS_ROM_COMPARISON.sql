--Number of active sites (by regions)
--12386
--==========================================================================
select COUNT(*) [STAGING__ACCOUNT] FROM [STAGING__ACCOUNT]
WHERE customertypecode = 948010001;
--==========================================================================

--number of rows in the data consolidation excel file
--==========================================================================
SELECT COUNT(*) DATA_CONSOLIDATION from [dbo].[SOURCE__DATA_CONSOLIDATION];
--==========================================================================


--GET LIST OF COMPANIES FROM IIS, EXCLUDING NON-COMPANY TYPES
--STAKEHOLDER TYPES
--1		TC Individual
--2		External Individual
--3		TC Organization
--4		External Organization
--5		Special Interest Group
--6		Branch Office
--7		Division
--8		Headquarter
--9		Owner
--10	Regional Office
--11	SIG Member
--12	Subsidiary
--13	Company Contact
--14	Inspection Contact
--TOTAL 19661
--==========================================================================
SELECT COUNT(*) YD070_STAKEHOLDER FROM YD070_STAKEHOLDER
where STAKEHOLDER_TYPE_CD
NOT IN (
	1,	--TC Individual
	2,	--External Individual
	3,	--TC Organization
	13, --Company Contact
	14  --Inspection Contact
)
AND date_deleted_dte is null and FILE_STATUS_CD = 'ACTIVE';
--==========================================================================

--ENSURE THERE ARE 0 COMPANIES MISSING FROM ROM 
--==========================================================================
SELECT STAKEHOLDER_ID
INTO #TEMP_IIS_IDS
FROM YD070_STAKEHOLDER
where STAKEHOLDER_TYPE_CD
NOT IN (
	1,	--TC Individual
	2,	--External Individual
	3,	--TC Organization
	13, --Company Contact
	14  --Inspection Contact
)
AND date_deleted_dte is null and FILE_STATUS_CD = 'ACTIVE';


SELECT COUNT(*) missingSites 
FROM #TEMP_IIS_IDS
WHERE 
STAKEHOLDER_ID
not in
(
	SELECT ovs_iisid FROM [STAGING__ACCOUNT]
	WHERE customertypecode = 948010001
);
--==========================================================================


--COUNTS OF WORKORDERS BY OVERSIGHT TYPE
--==========================================================================
SELECT * FROM
(
	SELECT t2.ovs_name, count(t2.ovs_name) RecordCount
	FROM STAGING__WORK_ORDERS T1
	JOIN STAGING__OVERSIGHTTYPE T2 ON T2.Id = T1.ovs_oversighttype
	GROUP BY t1.ovs_oversighttype, t2.ovs_name
) T
ORDER BY RecordCount DESC;

SELECT COUNT(*) TOTAL_WORKORDERS FROM STAGING__WORK_ORDERS;
--==========================================================================



--19616

--numbers from seans email
--Atlantic	2258
--CR		68
--Ontario	5076
--Pacific	3251
--PNR		4828
--Quebec	2474
--Unknown	2

--Grand Total	17957


--exclude US - based on provided code by Roger
--include MOC - nothing special here
--Identify Alberta sites based on business category 
----Set region = PNR, Inspector Type = Alberta


--Number of active sites (by regions)

--Number of inspections completed (by region - YTD, 2021-2022)

--Number of inspections completed (by type - YTD, 2021-2022)

--Number of civil aviation document reviews (YTD, 2021-2022)

--Number of non-compliances (YTD, 2021-2022)
 
--Number of inspection report reviews (by region, 2021-2022)


--Get Enforcement Actions Done
--Send email to everyone at Jeffs Group and Sebastien 
--Heres the mapping used to convert from the excel sheet
