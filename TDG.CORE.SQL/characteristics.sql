	--=============================================DYNAMIC VALUES===========================================
	--these variables can change with the environment, so double check these match the environment you're syncing to
	--ROM-ACC-TDG-DATA VALUES
	DECLARE @CONST_TDGCORE_USERID                        VARCHAR(50) = 'ae39bb8b-4b92-eb11-b1ac-000d3ae85ba1';
	DECLARE @CONST_TDGCORE_DOMAINNAME                    VARCHAR(50) = 'tdg.core@034gc.onmicrosoft.com';
	DECLARE @CONST_TDG_TEAMID                            VARCHAR(50) = 'd5ddb27a-56b7-eb11-8236-000d3a84ec03';
	DECLARE @CONST_TDG_TEAMNAME                          VARCHAR(50) = 'Transportation of Dangerous Goods';
	DECLARE @CONST_TDG_BUSINESSUNITID                    VARCHAR(50) = '4E122E0C-73F3-EA11-A815-000D3AF3AC0D';
	DECLARE @CONST_PRICELISTID                           VARCHAR(50) = 'b92b6a16-7cf7-ea11-a815-000d3af3a7a7';

	--DEV
	-- DECLARE @CONST_TDGCORE_BOOKABLE_RESOURCE_ID       VARCHAR(50) = '2cfc9150-d6a3-eb11-b1ac-000d3ae8bee7';
	-- DECLARE @CONST_TDGCORE_USERID                     VARCHAR(50) = '15abdd9e-8edd-ea11-a814-000d3af3afe0';
	-- DECLARE @CONST_TDGCORE_DOMAINNAME                 VARCHAR(50) = 'tdg.core@034gc.onmicrosoft.com';
	-- DECLARE @CONST_TDG_TEAMID                         VARCHAR(50) = 'ed81d4e5-55b7-eb11-8236-0022483bc30f';
	-- DECLARE @CONST_TDG_TEAMNAME                       VARCHAR(50) = 'Transportation of Dangerous Goods';
	-- DECLARE @CONST_TDG_BUSINESSUNITID                 VARCHAR(50) = '4E122E0C-73F3-EA11-A815-000D3AF3AC0D';
	--===================================================================================================

	--===================================================================================================
	--CRM CONSTANTS
	DECLARE @CONST_OWNERIDTYPE_TEAM VARCHAR(50) = 'team';
	DECLARE @CONST_OWNERIDTYPE_SYSTEMUSER VARCHAR(50) = 'systemuser';
	--===================================================================================================


IF EXISTS (
	SELECT
		*
	FROM
		sys.objects
	WHERE
		object_id = OBJECT_ID('[dbo].[STAGING__MODES]')
		AND TYPE IN (N'U')
) DROP TABLE [dbo].[STAGING__MODES];

CREATE TABLE dbo.STAGING__MODES (
    [id] UNIQUEIDENTIFIER NULL,
	[ovs_name] VARCHAR(100) NULL,
    [ovs_englishlabel] VARCHAR(100) NULL,
    [ovs_frenchlabel] VARCHAR(100) NULL,
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
    [owneridname] VARCHAR(100) NULL,
    [owneridtype] VARCHAR(50) NULL,
    [owneridyominame] VARCHAR(100) NULL,
    [owningbusinessunit] VARCHAR(50) NULL,
    [owningteam] VARCHAR(50) NULL,
    [owninguser] VARCHAR(50) NULL,
    [statecode] INT NULL,
    [statuscode] INT NULL,
    [timezoneruleversionnumber] INT NULL,
    [utcconversiontimezonecode] INT NULL,
    [versionnumber] BIGINT NULL
);





DROP TABLE IF EXISTS #STAGING__MODES;


SELECT
	CAST(id AS uniqueidentifier) id,
	[ovs_name],
	[ovs_englishlabel],
	[ovs_frenchlabel]
	INTO #STAGING__MODES
FROM
	(
SELECT '2c324a5c-cd76-eb11-a812-000d3af3fc54' [id], 'Rail' [ovs_name], 'Rail' [ovs_englishlabel], 'Ferroviaire' [ovs_frenchlabel] UNION
SELECT '8005c3d4-3f78-eb11-a812-000d3af3fc54', 'Road', 'Road', 'Road' UNION
SELECT 'fee06d4d-4278-eb11-a812-000d3af3fc54', 'Air', 'Air', 'Air' UNION
SELECT '7350f37a-4278-eb11-a812-000d3af3fc54', 'Marine', 'Marine', 'Marine'
) T1;


INSERT INTO
	STAGING__MODES (
		[id],
		[ovs_name],
		[ovs_englishlabel],
		[ovs_frenchlabel],
		[ownerid],
		[owneridtype],
		[owningbusinessunit],
		[owninguser]
	)
SELECT
		[id],
		[ovs_name],
		[ovs_englishlabel],
		[ovs_frenchlabel],
		@CONST_TDGCORE_USERID			 [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER    [owneridtype],
		@CONST_TDG_BUSINESSUNITID		 [owningbusinessunit],
		@CONST_TDGCORE_USERID			 [owninguser]
FROM
	#STAGING__MODES 







	


IF EXISTS (
	SELECT
		*
	FROM
		sys.objects
	WHERE
		object_id = OBJECT_ID('[dbo].[STAGING__AIR_OPERATOR_TYPE]')
		AND TYPE IN (N'U')
) DROP TABLE [dbo].[STAGING__AIR_OPERATOR_TYPE];

CREATE TABLE dbo.STAGING__AIR_OPERATOR_TYPE (
    [id] UNIQUEIDENTIFIER NULL,
	[ovs_name] VARCHAR(100) NULL,
    [ovs_englishlabel] VARCHAR(100) NULL,
    [ovs_frenchlabel] VARCHAR(100) NULL,
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
    [owneridname] VARCHAR(100) NULL,
    [owneridtype] VARCHAR(50) NULL,
    [owneridyominame] VARCHAR(100) NULL,
    [owningbusinessunit] VARCHAR(50) NULL,
    [owningteam] VARCHAR(50) NULL,
    [owninguser] VARCHAR(50) NULL,
    [statecode] INT NULL,
    [statuscode] INT NULL,
    [timezoneruleversionnumber] INT NULL,
    [utcconversiontimezonecode] INT NULL,
    [versionnumber] BIGINT NULL
);





DROP TABLE IF EXISTS #STAGING__AIR_OPERATOR_TYPE;


SELECT
	CAST(id AS uniqueidentifier) id,
	[ovs_name],
	[ovs_englishlabel],
	[ovs_frenchlabel]
	INTO #STAGING__AIR_OPERATOR_TYPE
FROM
	(
SELECT '95fe3ecd-29a8-eb11-9442-000d3ae99322' [id], '604 Private Operator' [ovs_name], '604 Private Operator' [ovs_englishlabel], '604 Opérateur privé' [ovs_frenchlabel] UNION
SELECT 'dc355cf7-29a8-eb11-9442-000d3ae99322', '702 Aerial Work', '702 Aerial Work', '702 Travaux aériens' UNION
SELECT 'ad73771e-2aa8-eb11-9442-000d3ae99322', '703 Air Taxi', '703 Air Taxi', '703 Taxi aérien' UNION
SELECT 'cf82ac38-2aa8-eb11-9442-000d3ae99322', '704 Commuter Operations', '704 Commuter Operations', '704 Opérations de banlieue' UNION
SELECT '5b3aca57-2aa8-eb11-9442-000d3ae99322', '705 Airline Operations', '705 Airline Operations', '705 Opérations aériennes'
) T1;


INSERT INTO
	STAGING__AIR_OPERATOR_TYPE (
		[id],
		[ovs_name],
		[ovs_englishlabel],
		[ovs_frenchlabel],
		[ownerid],
		[owneridtype],
		[owningbusinessunit],
		[owninguser]
	)
SELECT
		[id],
		[ovs_name],
		[ovs_englishlabel],
		[ovs_frenchlabel],
		@CONST_TDGCORE_USERID			 [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER    [owneridtype],
		@CONST_TDG_BUSINESSUNITID		 [owningbusinessunit],
		@CONST_TDGCORE_USERID			 [owninguser]
FROM
	#STAGING__AIR_OPERATOR_TYPE 






IF EXISTS (
	SELECT
		*
	FROM
		sys.objects
	WHERE
		object_id = OBJECT_ID('[dbo].[STAGING__AIR_OPERATOR_FUNCTION]')
		AND TYPE IN (N'U')
) DROP TABLE [dbo].[STAGING__AIR_OPERATOR_FUNCTION];

CREATE TABLE dbo.STAGING__AIR_OPERATOR_FUNCTION (
    [id] UNIQUEIDENTIFIER NULL,
	[ovs_name] VARCHAR(100) NULL,
    [ovs_englishlabel] VARCHAR(100) NULL,
    [ovs_frenchlabel] VARCHAR(100) NULL,
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
    [owneridname] VARCHAR(100) NULL,
    [owneridtype] VARCHAR(50) NULL,
    [owneridyominame] VARCHAR(100) NULL,
    [owningbusinessunit] VARCHAR(50) NULL,
    [owningteam] VARCHAR(50) NULL,
    [owninguser] VARCHAR(50) NULL,
    [statecode] INT NULL,
    [statuscode] INT NULL,
    [timezoneruleversionnumber] INT NULL,
    [utcconversiontimezonecode] INT NULL,
    [versionnumber] BIGINT NULL
);





DROP TABLE IF EXISTS #STAGING__AIR_OPERATOR_FUNCTION;


SELECT
	CAST(id AS uniqueidentifier) id,
	[ovs_name],
	[ovs_englishlabel],
	[ovs_frenchlabel]
	INTO #STAGING__AIR_OPERATOR_FUNCTION
FROM
	(
SELECT 'd45874a9-6ba8-eb11-9442-000d3ae99322' [id], 'Ramp' [ovs_name], 'Ramp' [ovs_englishlabel], 'Rampe' [ovs_frenchlabel] UNION
SELECT 'c8677cb8-6ba8-eb11-9442-000d3ae99322', 'Crew', 'Crew', 'Équipage' UNION
SELECT '53e7aac4-6ba8-eb11-9442-000d3ae99322', 'Cargo Facility', 'Cargo Facility', 'Installation de fret' UNION
SELECT '0a591dd5-6ba8-eb11-9442-000d3ae99322', 'Passenger Terminal', 'Passenger Terminal', 'Terminal passagers' UNION
SELECT '777649e9-6ba8-eb11-9442-000d3ae99322', 'Aircraft Maintenance', 'Aircraft Maintenance', 'Maintenance des aéronefs'
) T1;


INSERT INTO
	STAGING__AIR_OPERATOR_FUNCTION (
		[id],
		[ovs_name],
		[ovs_englishlabel],
		[ovs_frenchlabel],
		[ownerid],
		[owneridtype],
		[owningbusinessunit],
		[owninguser]
	)
SELECT
		[id],
		[ovs_name],
		[ovs_englishlabel],
		[ovs_frenchlabel],
		@CONST_TDGCORE_USERID			 [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER    [owneridtype],
		@CONST_TDG_BUSINESSUNITID		 [owningbusinessunit],
		@CONST_TDGCORE_USERID			 [owninguser]
FROM
	#STAGING__AIR_OPERATOR_FUNCTION 





	


IF EXISTS (
	SELECT
		*
	FROM
		sys.objects
	WHERE
		object_id = OBJECT_ID('[dbo].[STAGING__AIRCRAFT_TYPE]')
		AND TYPE IN (N'U')
) DROP TABLE [dbo].[STAGING__AIRCRAFT_TYPE];

CREATE TABLE dbo.STAGING__AIRCRAFT_TYPE (
    [id] UNIQUEIDENTIFIER NULL,
	[ovs_name] VARCHAR(100) NULL,
    [ovs_englishlabel] VARCHAR(100) NULL,
    [ovs_frenchlabel] VARCHAR(100) NULL,
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
    [owneridname] VARCHAR(100) NULL,
    [owneridtype] VARCHAR(50) NULL,
    [owneridyominame] VARCHAR(100) NULL,
    [owningbusinessunit] VARCHAR(50) NULL,
    [owningteam] VARCHAR(50) NULL,
    [owninguser] VARCHAR(50) NULL,
    [statecode] INT NULL,
    [statuscode] INT NULL,
    [timezoneruleversionnumber] INT NULL,
    [utcconversiontimezonecode] INT NULL,
    [versionnumber] BIGINT NULL
);





DROP TABLE IF EXISTS #STAGING__AIRCRAFT_TYPE;


SELECT
	CAST(id AS uniqueidentifier) id,
	[ovs_name],
	[ovs_englishlabel],
	[ovs_frenchlabel]
	INTO #STAGING__AIRCRAFT_TYPE
FROM
	(
SELECT '34bc1bce-2aa8-eb11-9442-000d3ae99322' [id], 'Passenger Aircraft' [ovs_name], 'Passenger Aircraft' [ovs_englishlabel], 'Avion de passagers' [ovs_frenchlabel] UNION
SELECT 'e5c653e2-2aa8-eb11-9442-000d3ae99322', 'Cargo Aircraft', 'Cargo Aircraft', 'Avion cargo' UNION
SELECT '54a34e18-2ba8-eb11-9442-000d3ae99322', 'Combi Aircraft', 'Combi Aircraft', 'Avion Combi' 
) T1;


INSERT INTO
	STAGING__AIRCRAFT_TYPE (
		[id],
		[ovs_name],
		[ovs_englishlabel],
		[ovs_frenchlabel],
		[ownerid],
		[owneridtype],
		[owningbusinessunit],
		[owninguser]
	)
SELECT
		[id],
		[ovs_name],
		[ovs_englishlabel],
		[ovs_frenchlabel],
		@CONST_TDGCORE_USERID			 [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER    [owneridtype],
		@CONST_TDG_BUSINESSUNITID		 [owningbusinessunit],
		@CONST_TDGCORE_USERID			 [owninguser]
FROM
	#STAGING__AIRCRAFT_TYPE 



	


IF EXISTS (
	SELECT
		*
	FROM
		sys.objects
	WHERE
		object_id = OBJECT_ID('[dbo].[STAGING__MOC_TYPE]')
		AND TYPE IN (N'U')
) DROP TABLE [dbo].[STAGING__MOC_TYPE];

CREATE TABLE dbo.STAGING__MOC_TYPE (
    [id] UNIQUEIDENTIFIER NULL,
    [ovs_name] VARCHAR(100) NULL,
    [ovs_englishlabel] VARCHAR(100) NULL,
    [ovs_frenchlabel] VARCHAR(100) NULL,
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
    [owneridname] VARCHAR(100) NULL,
    [owneridtype] VARCHAR(50) NULL,
    [owneridyominame] VARCHAR(100) NULL,
    [owningbusinessunit] VARCHAR(50) NULL,
    [owningteam] VARCHAR(50) NULL,
    [owninguser] VARCHAR(50) NULL,
    [statecode] INT NULL,
    [statuscode] INT NULL,
    [timezoneruleversionnumber] INT NULL,
    [utcconversiontimezonecode] INT NULL,
    [versionnumber] BIGINT NULL
);





DROP TABLE IF EXISTS #STAGING__MOC_TYPE;


SELECT
	CAST(id AS uniqueidentifier) id,
	[ovs_name],
	[ovs_englishlabel],
	[ovs_frenchlabel]
	INTO #STAGING__MOC_TYPE
FROM
	(
SELECT 'e23e22b5-4278-eb11-a812-000d3af3fc54' [id], 'Cylinders, Spheres and Tubes' [ovs_name], 'Cylinders, Spheres and Tubes' [ovs_englishlabel], 'Bouteilles et tubes' [ovs_frenchlabel] UNION
SELECT '37acc996-4378-eb11-a812-000d3af3fc54', 'UN Intermediate Bulk Containers (IBCs)', 'UN Intermediate Bulk Containers (IBCs)', 'Grands récipients pour vrac (GRV) normalisés UN' UNION
SELECT '5884fdbb-4378-eb11-a812-000d3af3fc54', 'Infectious Substances Containers', 'Infectious Substances Containers', 'Contenants pour matières infectieuses' UNION
SELECT '4be1e2d4-4378-eb11-a812-000d3af3fc54', 'Railway Tank Cars', 'Railway Tank Cars', 'Wagons-citernes' UNION
SELECT '2bb706e9-4378-eb11-a812-000d3af3fc54', 'UN Standardized Small Containers for Liquids or Solids', 'UN Standardized Small Containers for Liquids or Solids', 'Petits contenants normalisés UN pour liquides ou solides' UNION
SELECT '8baba4f7-4378-eb11-a812-000d3af3fc54', 'Highway Tank', 'Highway Tank', 'Citernes routières' UNION
SELECT '245fe40a-4478-eb11-a812-000d3af3fc54', 'TC Portable Tanks', 'TC Portable Tanks', 'Citernes amovibles TC' UNION
SELECT '44ff6b21-4478-eb11-a812-000d3af3fc54', 'UN Portable Tanks (including tank containers)', 'UN Portable Tanks (including tank containers)', 'Citernes mobiles normalisées UN (y compris les conteneurs-citernes)' UNION
SELECT '6dfbef3c-4478-eb11-a812-000d3af3fc54', 'Aerosol Containers and Gas Cartridges', 'Aerosol Containers and Gas Cartridges', 'Bombes aérosol et cartouches à gaz' UNION
SELECT '9af6204f-4478-eb11-a812-000d3af3fc54', 'Ton Containers', 'Ton Containers', 'Contenants d''une tonne' UNION
SELECT 'c4d8385c-4478-eb11-a812-000d3af3fc54', 'Means of transport', 'Means of transport', 'Contenant un emballage' UNION
SELECT '3920246f-4478-eb11-a812-000d3af3fc54', 'Consolidation Bin', 'Consolidation Bin', 'Conteneur de groupage' UNION
SELECT '0c6af89b-5a78-eb11-a812-000d3af3fc54', 'Fumigated Unit', 'Fumigated Unit', 'Unité fumigée' UNION
SELECT 'ef855a81-5b78-eb11-a812-000d3af3fc54', 'Marine Pollutant DG', 'Marine Pollutant DG', 'DG des polluants marins'
) T1;


INSERT INTO
	STAGING__MOC_TYPE (
		[id],
		[ovs_name],
		[ovs_englishlabel],
		[ovs_frenchlabel],
		[ownerid],
		[owneridtype],
		[owningbusinessunit],
		[owninguser]
	)
SELECT
		[id],
		[ovs_name],
		[ovs_englishlabel],
		[ovs_frenchlabel],
		@CONST_TDGCORE_USERID			 [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER    [owneridtype],
		@CONST_TDG_BUSINESSUNITID		 [owningbusinessunit],
		@CONST_TDGCORE_USERID			 [owninguser]
FROM
	#STAGING__MOC_TYPE 



	


IF EXISTS (
	SELECT
		*
	FROM
		sys.objects
	WHERE
		object_id = OBJECT_ID('[dbo].[STAGING__MOC_FACILITY_TYPE]')
		AND TYPE IN (N'U')
) DROP TABLE [dbo].[STAGING__MOC_FACILITY_TYPE];

CREATE TABLE dbo.STAGING__MOC_FACILITY_TYPE (
    [id] UNIQUEIDENTIFIER NULL,
    [ovs_name] VARCHAR(100) NULL,
    [ovs_englishlabel] VARCHAR(100) NULL,
    [ovs_frenchlabel] VARCHAR(100) NULL,
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
    [owneridname] VARCHAR(100) NULL,
    [owneridtype] VARCHAR(50) NULL,
    [owneridyominame] VARCHAR(100) NULL,
    [owningbusinessunit] VARCHAR(50) NULL,
    [owningteam] VARCHAR(50) NULL,
    [owninguser] VARCHAR(50) NULL,
    [statecode] INT NULL,
    [statuscode] INT NULL,
    [timezoneruleversionnumber] INT NULL,
    [utcconversiontimezonecode] INT NULL,
    [versionnumber] BIGINT NULL
);





DROP TABLE IF EXISTS #STAGING__MOC_FACILITY_TYPE;


SELECT
	CAST(id AS uniqueidentifier) id,
	[ovs_name],
	[ovs_englishlabel],
	[ovs_frenchlabel]
	INTO #STAGING__MOC_FACILITY_TYPE
FROM
	(
SELECT '325695da-4278-eb11-a812-000d3af3fc54' [id], 'UN Cylinders, UN Tubes, UN cryogenic receptacles and MEGC''s' [ovs_name], 'UN Cylinders, UN Tubes, UN cryogenic receptacles and MEGC''s' [ovs_englishlabel], 'Bouteilles à gaz UN, tubes UN, récipients cryogéniques UN, et CGEM' [ovs_frenchlabel] UNION
SELECT 'af48d1ae-4878-eb11-a812-000d3af3fc54', 'Cylinder and tube requalifiers', 'Cylinder and tube requalifiers', 'Installations de requalification de bouteilles à gaz et de tubes' UNION
SELECT '94a540d0-4878-eb11-a812-000d3af3fc54', 'Cylinder and tube manufacturers', 'Cylinder and tube manufacturers', 'Fabricants de bouteilles à gaz et de tubes' UNION
SELECT '0785c5f7-4878-eb11-a812-000d3af3fc54', 'Independent Inspectors for cylinder and tube manufacturers', 'Independent Inspectors for cylinder and tube manufacturers', 'Inspecteurs indépendants d''usines de fabrication de bouteilles à gaz et de tubes' UNION
SELECT 'ccaef522-4978-eb11-a812-000d3af3fc54', 'UN Pressure Receptacle Periodic Inspection and Test Facilities', 'UN Pressure Receptacle Periodic Inspection and Test Facilities', 'Installations de requalification de bouteilles à gaz et de tubes' UNION
SELECT 'd40b1548-4978-eb11-a812-000d3af3fc54', 'UN Pressure Receptacle Manufacturers', 'UN Pressure Receptacle Manufacturers', 'Fabricants de récipients à pression UN' UNION
SELECT 'b344d46d-4978-eb11-a812-000d3af3fc54', 'Inspection Bodies for Manufacture of UN Pressure Receptacles', 'Inspection Bodies for Manufacture of UN Pressure Receptacles', 'Organisme d’inspection pour récipients à pression UN' UNION
SELECT '5d3dcdb7-4978-eb11-a812-000d3af3fc54', 'Design Review Agencies for UN Pressure Receptacle Manufacture', 'Design Review Agencies for UN Pressure Receptacle Manufacture', 'Organismes de revue de conception de la fabrication de récipients à pression UN' UNION
SELECT '5327cfc8-4978-eb11-a812-000d3af3fc54', 'Aerosol and Gas Cartridge Manufacturers', 'Aerosol and Gas Cartridge Manufacturers', 'Fabricants de bombes aérosol et de cartouches à gaz' UNION
SELECT '9fadc2e1-4978-eb11-a812-000d3af3fc54', 'Drum reconditioners', 'Drum reconditioners', 'Installations de reconditionnement des fûts' UNION
SELECT 'bd7a95f4-4978-eb11-a812-000d3af3fc54', 'IBC requalifiers (leak test and inspect)', 'IBC requalifiers (leak test and inspect)', 'Installations de requalification des grands contenants pour vrac (essais d''étanchéité et inspection)' UNION
SELECT '2f241b09-4a78-eb11-a812-000d3af3fc54', 'Railway Tank Car facilities', 'Railway Tank Car facilities', 'Installations pour wagons-citernes' UNION
SELECT '7ca58372-5a78-eb11-a812-000d3af3fc54', 'MOC Manufacturer', 'MOC Manufacturer', 'Fabricant petits contenants'
) T1;


INSERT INTO
	STAGING__MOC_FACILITY_TYPE (
		[id],
		[ovs_name],
		[ovs_englishlabel],
		[ovs_frenchlabel],
		[ownerid],
		[owneridtype],
		[owningbusinessunit],
		[owninguser]
	)
SELECT
		[id],
		[ovs_name],
		[ovs_englishlabel],
		[ovs_frenchlabel],
		@CONST_TDGCORE_USERID			 [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER    [owneridtype],
		@CONST_TDG_BUSINESSUNITID		 [owningbusinessunit],
		@CONST_TDGCORE_USERID			 [owninguser]
FROM
	#STAGING__MOC_FACILITY_TYPE 

