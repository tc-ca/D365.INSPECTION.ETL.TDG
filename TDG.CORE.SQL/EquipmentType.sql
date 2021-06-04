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

	select * from STAGING__EQUIPMENT_TYPE

IF EXISTS (
	SELECT
		*
	FROM
		sys.objects
	WHERE
		object_id = OBJECT_ID('[dbo].[STAGING__EQUIPMENT_TYPE]')
		AND TYPE IN (N'U')
) DROP TABLE [dbo].[STAGING__EQUIPMENT_TYPE];

CREATE TABLE dbo.STAGING__EQUIPMENT_TYPE (
    [id] UNIQUEIDENTIFIER NULL,
    [ovs_name] VARCHAR(100) NULL,
    [ovs_ohsequipmenttypeen] VARCHAR(100) NULL,
    [ovs_ohsequipmenttypefr] VARCHAR(250) NULL,
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
    [versionnumber] BIGINT NULL,
);





DROP TABLE IF EXISTS #STAGING__EQUIPMENT_TYPE;


SELECT
	CAST(id AS uniqueidentifier) id,
	[ovs_name],
	[ovs_ohsequipmenttypeen],
	[ovs_ohsequipmenttypefr]
	INTO #STAGING__EQUIPMENT_TYPE
FROM
	(
SELECT '907fa4d2-7499-eb11-b1ac-000d3ae87159' id, 'Appropriate clothing for weather conditions' [ovs_name], 'Appropriate clothing for weather conditions' [ovs_ohsequipmenttypeen], 'Vêtements adaptés aux conditions météorologiques' [ovs_ohsequipmenttypefr] UNION
SELECT '8a7fa4d2-7499-eb11-b1ac-000d3ae87159', 'Avon Protection NH15 CBRN Escape respirator', 'Avon Protection NH15 CBRN Escape respirator', 'Appareil de protection respiratoire d’évacuation CBRN NH15 de marque Avon Protection' UNION
SELECT '8c7fa4d2-7499-eb11-b1ac-000d3ae87159', 'BW Clip H2S Personal Gas Monitor', 'BW Clip H2S Personal Gas Monitor', 'Moniteur de gaz individuel pour le H2S, BW Clip' UNION
SELECT '9a7fa4d2-7499-eb11-b1ac-000d3ae87159', 'Communication devices', 'Communication devices', 'Appareils de communication' UNION
SELECT '8e7fa4d2-7499-eb11-b1ac-000d3ae87159', 'First Aid Kit- minimum type A', 'First Aid Kit- minimum type A', 'Trousse de premiers soins – au minimum de type A' UNION
SELECT '847fa4d2-7499-eb11-b1ac-000d3ae87159', 'Flame resistant (FR) apparel', 'Flame resistant (FR) apparel', 'Vêtements résistants à la flamme (RF)' UNION
SELECT 'a47fa4d2-7499-eb11-b1ac-000d3ae87159', 'Garbage bags (for soiled equipment/clothes)', 'Garbage bags (for soiled equipment/clothes)', 'Sacs à ordures (pour matériel/vêtements souillés)' UNION
SELECT '9c7fa4d2-7499-eb11-b1ac-000d3ae87159', 'GPS and/or recent maps and compass', 'GPS and/or recent maps and compass', 'GPS et/ou cartes récentes et compas' UNION
SELECT '7c7fa4d2-7499-eb11-b1ac-000d3ae87159', 'Hard Hat', 'Hard Hat', 'Casque de sécurité' UNION
SELECT '827fa4d2-7499-eb11-b1ac-000d3ae87159', 'Hearing Protection', 'Hearing Protection', 'Protection auditive' UNION
SELECT '807fa4d2-7499-eb11-b1ac-000d3ae87159', 'High Visibility Flame Resistant (FR) Safety Vest', 'High Visibility Flame Resistant (FR) Safety Vest', 'Gilet de sécurité haute visibilité, résistant à la flamme (RF)' UNION
SELECT '967fa4d2-7499-eb11-b1ac-000d3ae87159', 'Insect repellent with DEET', 'Insect repellent with DEET', 'Insectifuge contenant du DEET' UNION
SELECT '867fa4d2-7499-eb11-b1ac-000d3ae87159', 'Intrinsically safe flashlight', 'Intrinsically safe flashlight', 'Lampe de poche à sécurité intrinsèque' UNION
SELECT 'a07fa4d2-7499-eb11-b1ac-000d3ae87159', 'Over-boots (Disposable or reusable)', 'Over-boots (Disposable or reusable)', 'Couvre-bottes (jetables ou réutilisables)' UNION
SELECT '08389c62-7499-eb11-b1ac-000d3ae939bc', 'Safety boots', 'Safety boots', 'Chaussures de sécurité' UNION
SELECT '927fa4d2-7499-eb11-b1ac-000d3ae87159', 'Safety cones', 'Safety cones', 'Cônes de sécurité' UNION
SELECT '7e7fa4d2-7499-eb11-b1ac-000d3ae87159', 'Safety eyewear', 'Safety eyewear', 'Lunettes de sécurité' UNION
SELECT '9e7fa4d2-7499-eb11-b1ac-000d3ae87159', 'Single use coveralls', 'Single use coveralls', 'Combinaisons à usage unique' UNION
SELECT '947fa4d2-7499-eb11-b1ac-000d3ae87159', 'Sunscreen with a minimum SPF 30', 'Sunscreen with a minimum SPF 30', 'Écran solaire, FPS 30 ou plus' UNION
SELECT '987fa4d2-7499-eb11-b1ac-000d3ae87159', 'Tick removal device or kit', 'Tick removal device or kit', 'Dispositif ou trousse pour le retrait des tiques' UNION
SELECT 'a27fa4d2-7499-eb11-b1ac-000d3ae87159', 'Winter cleats', 'Winter cleats', 'Crampons à chaussures pour l’hiver' UNION
SELECT '887fa4d2-7499-eb11-b1ac-000d3ae87159', 'Work gloves', 'Work gloves', 'Gants de travail'
) T1;


INSERT INTO
	STAGING__EQUIPMENT_TYPE (
		[id],
		[ovs_name],
		[ovs_ohsequipmenttypeen],
		[ovs_ohsequipmenttypefr],
		[ownerid],
		[owneridtype],
		[owningbusinessunit],
		[owninguser]
	)
SELECT
		[id],
		[ovs_name],
		[ovs_ohsequipmenttypeen],
		[ovs_ohsequipmenttypefr],
		@CONST_TDGCORE_USERID			 [ownerid],
		@CONST_OWNERIDTYPE_SYSTEMUSER    [owneridtype],
		@CONST_TDG_BUSINESSUNITID		 [owningbusinessunit],
		@CONST_TDGCORE_USERID			 [owninguser]
FROM
	#STAGING__EQUIPMENT_TYPE 

