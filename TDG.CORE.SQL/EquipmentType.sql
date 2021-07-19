	DECLARE @CONST_TDGCORE_DOMAINNAME  NVARCHAR(50)  = 'tdg.core@034gc.onmicrosoft.com';
	DECLARE @CONST_TDGCORE_USERID      NVARCHAR(50)  = (SELECT systemuserid FROM CRM__SYSTEMUSER  where domainname = 'tdg.core@034gc.onmicrosoft.com');
	DECLARE @CONST_TEAM_TDG_ID          NVARCHAR(500) = (SELECT teamid FROM CRM__TEAM WHERE name = 'Transportation of Dangerous Goods');
	DECLARE @CONST_BUSINESSUNIT_TDG_ID NVARCHAR(50)  = (SELECT businessunitid FROM CRM__BUSINESSUNIT WHERE name = 'Transportation of Dangerous Goods');
	DECLARE @CONST_PRICELISTID         NVARCHAR(50)  = (SELECT pricelevelid FROM CRM__pricelevel  WHERE NAME = 'Base Prices');
	DECLARE @CONST_TDGCORE_BOOKABLE_RESOURCE_ID NVARCHAR(50) = (SELECT bookableresourceid FROM CRM__BOOKABLERESOURCE WHERE msdyn_primaryemail = @CONST_TDGCORE_DOMAINNAME);
	
	--CRM CONSTANTS
	DECLARE @CONST_OWNERIDTYPE_TEAM NVARCHAR(50)			= 'team';
	DECLARE @CONST_OWNERIDTYPE_SYSTEMUSER NVARCHAR(50)	= 'systemuser';


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
    [ovs_name] NVARCHAR(500) NULL,
    [ovs_ohsequipmenttypeen] NVARCHAR(100) NULL,
    [ovs_ohsequipmenttypefr] NVARCHAR(250) NULL,
    [createdby] NVARCHAR(50) NULL,
    [createdbyname] NVARCHAR(100) NULL,
    [createdbyyominame] NVARCHAR(100) NULL,
    [createdon] DATETIME NULL,
    [createdonbehalfby] NVARCHAR(50) NULL,
    [createdonbehalfbyname] NVARCHAR(100) NULL,
    [createdonbehalfbyyominame] NVARCHAR(100) NULL,
    [importsequencenumber] INT NULL,
    [modifiedby] NVARCHAR(50) NULL,
    [modifiedbyname] NVARCHAR(100) NULL,
    [modifiedbyyominame] NVARCHAR(100) NULL,
    [modifiedon] DATETIME NULL,
    [modifiedonbehalfby] NVARCHAR(50) NULL,
    [modifiedonbehalfbyname] NVARCHAR(100) NULL,
    [modifiedonbehalfbyyominame] NVARCHAR(100) NULL,
    [overriddencreatedon] DATETIME NULL,
    [ownerid] NVARCHAR(50) NULL,
    [owneridname] NVARCHAR(100) NULL,
    [owneridtype] NVARCHAR(50) NULL,
    [owneridyominame] NVARCHAR(100) NULL,
    [owningbusinessunit] NVARCHAR(50) NULL,
    [owningteam] NVARCHAR(50) NULL,
    [owninguser] NVARCHAR(50) NULL,
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
		@CONST_BUSINESSUNIT_TDG_ID		 [owningbusinessunit],
		@CONST_TDGCORE_USERID			 [owninguser]
FROM
	#STAGING__EQUIPMENT_TYPE;

--LOCALIZATION SUPPORT

UPDATE
	STAGING__EQUIPMENT_TYPE
SET
	[ovs_name] = CONCAT(
		ovs_ohsequipmenttypeen,
		'::',
		ovs_ohsequipmenttypefr
	);


