DECLARE @CONST_TDGCORE_DOMAINNAME  VARCHAR(50)  = 'tdg.core@034gc.onmicrosoft.com';
DECLARE @CONST_TDGCORE_USERID      VARCHAR(50)  = (SELECT systemuserid FROM CRM__SYSTEMUSER  where domainname = @CONST_TDGCORE_DOMAINNAME);
DECLARE @CONST_TEAM_TDG_ID          VARCHAR(500) = (SELECT teamid FROM CRM__TEAM WHERE name = 'Transportation of Dangerous Goods');
DECLARE @CONST_BUSINESSUNIT_TDG_ID VARCHAR(50)  = (SELECT businessunitid FROM CRM__BUSINESSUNIT WHERE name = 'Transportation of Dangerous Goods');
DECLARE @CONST_OWNERIDTYPE_TEAM VARCHAR(50)			= 'team';
DECLARE @CONST_OWNERIDTYPE_SYSTEMUSER VARCHAR(50)	= 'systemuser';

IF EXISTS (
	SELECT
		*
	FROM
		sys.objects
	WHERE
		object_id = OBJECT_ID('[dbo].[STAGING__UN_NUMBERS]')
		AND TYPE IN (N'U')
) DROP TABLE [dbo].[STAGING__UN_NUMBERS];

CREATE TABLE dbo.STAGING__UN_NUMBERS (
    [id] UNIQUEIDENTIFIER NULL,
	[tdg_name] VARCHAR(100)  NULL,
	[tdg_shippingnamedescriptiontxt] VARCHAR(MAX) NULL,
	[tdg_shippingnamedescriptionetxt] VARCHAR(MAX) NULL,
    [tdg_shippingnamedescriptionftxt] VARCHAR(MAX) NULL,
	[tdg_primaryclasscd] VARCHAR(500) NULL,
	[tdg_secondaryclasscd]   VARCHAR(500) NULL,
	[tdg_packinggroupcd] VARCHAR(500) NULL,
	[tdg_specialprovisionscd]  VARCHAR(500) NULL,
	[tdg_limitquantityindextxt] VARCHAR(100) NULL,
	[tdg_exceptedquantitiestxt] VARCHAR(500) NULL,
	[tdg_erapindextxt] VARCHAR(100) NULL,
	[tdg_carryingvesselindextxt] VARCHAR(100) NULL,
    [tdg_carryingroadrailindextxt] VARCHAR(100) NULL,
    [createdby] VARCHAR(50) NULL,
    [createdbyname] VARCHAR(100) NULL,
    [createdbyyominame] VARCHAR(100) NULL,
    [createdon] DATETIME NULL,
    [createdonbehalfby] VARCHAR(50) NULL,
    [createdonbehalfbyname] VARCHAR(100) NULL,
    [createdonbehalfbyyominame] VARCHAR(100) NULL,
    [importsequencenumber] INT NULL,
    [modifiedby] VARCHAR(50) NULL,
    [modifiedbyname] VARCHAR(100) NULL,
    [modifiedbyyominame] VARCHAR(100) NULL,
    [modifiedon] DATETIME NULL,
    [modifiedonbehalfby] VARCHAR(50) NULL,
    [modifiedonbehalfbyname] VARCHAR(100) NULL,
    [modifiedonbehalfbyyominame] VARCHAR(100) NULL,
    [overriddencreatedon] DATETIME NULL,
    [ownerid] VARCHAR(50) NULL,
    [owneridname] VARCHAR(100)  NULL,
    [owneridtype] VARCHAR(50)  NULL,
    [owneridyominame] VARCHAR(100)  NULL,
    [owningbusinessunit] VARCHAR(50) NULL,
    [owningteam] VARCHAR(50) NULL,
    [owninguser] VARCHAR(50) NULL,
    [statecode] INT NULL,
    [statuscode] INT NULL,
    [timezoneruleversionnumber] INT NULL,
    [utcconversiontimezonecode] INT NULL,
    [versionnumber] BIGINT NULL,
);



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
		NEWID() [id],
	    T1.[UN Number] [tdg_name], 
		CONCAT(T1.[English Shipping Name], '::', T1.[French Shipping Name]) [tdg_shippingnamedescriptiontxt], 
	    T1.[English Shipping Name] [tdg_shippingnamedescriptionetxt],
		T1.[French Shipping Name] [tdg_shippingnamedescriptionftxt],
		T1.[Primary Class] [tdg_primaryclasscd],
		T1.[Secondary Class] [tdg_secondaryclasscd],
		T1.[Packing Group] [tdg_packinggroupcd],
		T1.[Special Provisions] [tdg_specialprovisionscd],
		T1.[6 (a) Explosive Limit and Limited Quantity Index] [tdg_limitquantityindextxt],
	    T1.[6 (b) Excepted Quantities] [tdg_exceptedquantitiestxt],
		T1.[ERAP Index] [tdg_erapindextxt],
		T1.[Passenger Carrying Vessel Index] [tdg_carryingvesselindextxt],
		T1.[Road or Railway Passenger Carrying Vehicle Index] [tdg_carryingroadrailindextxt],
		@CONST_TDGCORE_USERID			 [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER    [owneridtype],
		@CONST_BUSINESSUNIT_TDG_ID		 [owningbusinessunit],
		@CONST_TDGCORE_USERID			 [owninguser]
FROM
SOURCE__UN_NUMBERS T1;

