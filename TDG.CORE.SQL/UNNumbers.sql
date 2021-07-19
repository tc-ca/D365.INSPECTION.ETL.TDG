DECLARE @CONST_TDGCORE_DOMAINNAME  NVARCHAR(50)  = 'tdg.core@034gc.onmicrosoft.com';
DECLARE @CONST_TDGCORE_USERID      NVARCHAR(50)  = (SELECT systemuserid FROM CRM__SYSTEMUSER  where domainname = @CONST_TDGCORE_DOMAINNAME);
DECLARE @CONST_TEAM_TDG_ID          NVARCHAR(500) = (SELECT teamid FROM CRM__TEAM WHERE name = 'Transportation of Dangerous Goods');
DECLARE @CONST_BUSINESSUNIT_TDG_ID NVARCHAR(50)  = (SELECT businessunitid FROM CRM__BUSINESSUNIT WHERE name = 'Transportation of Dangerous Goods');
DECLARE @CONST_OWNERIDTYPE_TEAM NVARCHAR(50)			= 'team';
DECLARE @CONST_OWNERIDTYPE_SYSTEMUSER NVARCHAR(50)	= 'systemuser';

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('[dbo].[STAGING__UN_NUMBERS]') AND TYPE IN (N'U')) DROP TABLE [dbo].[STAGING__UN_NUMBERS];

--IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STAGING__UN_NUMBERS]') AND type in (N'U'))
CREATE TABLE dbo.STAGING__UN_NUMBERS (
    [id] UNIQUEIDENTIFIER NULL,
	[tdg_name] NVARCHAR(100)  NULL,
	[tdg_shippingnamedescriptiontxt] NVARCHAR(MAX) NULL,
	[tdg_shippingnamedescriptionetxt] NVARCHAR(MAX) NULL,
    [tdg_shippingnamedescriptionftxt] NVARCHAR(MAX) NULL,
	[tdg_primaryclasscd] NVARCHAR(500) NULL,
	[tdg_secondaryclasscd]   NVARCHAR(500) NULL,
	[tdg_packinggroupcd] NVARCHAR(500) NULL,
	[tdg_specialprovisionscd]  NVARCHAR(500) NULL,
	[tdg_limitquantityindextxt] NVARCHAR(100) NULL,
	[tdg_exceptedquantitiestxt] NVARCHAR(500) NULL,
	[tdg_erapindextxt] NVARCHAR(100) NULL,
	[tdg_carryingvesselindextxt] NVARCHAR(100) NULL,
    [tdg_carryingroadrailindextxt] NVARCHAR(100) NULL,
    [ownerid] NVARCHAR(50) NULL,
    [owneridtype] NVARCHAR(50)  NULL,
    [owningbusinessunit] NVARCHAR(50) NULL,
    [owningteam] NVARCHAR(50) NULL,
    [owninguser] NVARCHAR(50) NULL,
);


TRUNCATE TABLE STAGING__UN_NUMBERS;
INSERT INTO
	STAGING__UN_NUMBERS (
		[id],
		[tdg_name], 
		[tdg_shippingnamedescriptiontxt], 
		[tdg_shippingnamedescriptionetxt],
		[tdg_shippingnamedescriptionftxt],
		[tdg_primaryclasscd],
		[tdg_secondaryclasscd],
		[tdg_packinggroupcd],
		[tdg_specialprovisionscd],
		[tdg_limitquantityindextxt],
		[tdg_exceptedquantitiestxt],
		[tdg_erapindextxt],
		[tdg_carryingvesselindextxt],
		[tdg_carryingroadrailindextxt],
		[ownerid],
		[owneridtype],
		[owningbusinessunit],
		[owninguser]
	)
SELECT
		NEWID()                                                             [id],
	    T1.[UN Number]                                                   	[tdg_name], 
		CONCAT(T1.[English Shipping Name], '::', T1.[French Shipping Name]) [tdg_shippingnamedescriptiontxt], 
	    T1.[English Shipping Name] 											[tdg_shippingnamedescriptionetxt],
		T1.[French Shipping Name]     										[tdg_shippingnamedescriptionftxt],
		T1.[Primary Class]            										[tdg_primaryclasscd],
		REPLACE(T1.[Secondary Class], ' ', '')								[tdg_secondaryclasscd],
		T1.[Packing Group]            										[tdg_packinggroupcd],
		REPLACE(T1.[Special Provisions], ' ', '')                           [tdg_specialprovisionscd],
		T1.[6 (a) Explosive Limit and Limited Quantity Index] 				[tdg_limitquantityindextxt],
	    T1.[6 (b) Excepted Quantities]                     					[tdg_exceptedquantitiestxt],
		T1.[ERAP Index]                                       				[tdg_erapindextxt],
		T1.[Passenger Carrying Vessel Index]                  				[tdg_carryingvesselindextxt],
		T1.[Road or Railway Passenger Carrying Vehicle Index] 				[tdg_carryingroadrailindextxt],
		@CONST_TDGCORE_USERID			                              		[ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER                         				[owneridtype],
		@CONST_BUSINESSUNIT_TDG_ID		                          			[owningbusinessunit],
		@CONST_TDGCORE_USERID			                              		[owninguser]
FROM
[SOURCE__UN_NUMBERS] T1;


--UPDATE TO CORRECT TYPO IN UN1597
UPDATE STAGING__UN_NUMBERS SET tdg_specialprovisionscd = null, [tdg_limitquantityindextxt] = '0.1L', [tdg_exceptedquantitiestxt] = 'E4' WHERE TDG_NAME like '%UN1597%';





--NATURAL PK
--SELECT TDG_NAME, tdg_primaryclasscd, tdg_shippingnamedescriptionetxt FROM STAGING__UN_NUMBERS
--GROUP BY TDG_NAME, tdg_primaryclasscd, tdg_shippingnamedescriptionetxt
--HAVING COUNT(TDG_NAME) > 1;
