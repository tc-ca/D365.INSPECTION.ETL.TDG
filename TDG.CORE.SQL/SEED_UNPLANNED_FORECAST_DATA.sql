IF EXISTS (
	SELECT
		*
	FROM
		sys.objects
	WHERE
		object_id = OBJECT_ID('[dbo].[STAGING__UNPLANNED_FORECAST]')
		AND TYPE IN (N'U')
) DROP TABLE [dbo].[STAGING__UNPLANNED_FORECAST];


CREATE TABLE [dbo].[STAGING__UNPLANNED_FORECAST](
	[Id] [uniqueidentifier] NOT NULL,
	[IdStr] nvarchar(50) NOT NULL,
	[SinkCreatedOn] [datetime] NULL,
	[SinkModifiedOn] [datetime] NULL,
	[statecode] [int] NULL,
	[statuscode] [int] NULL,
	[ovs_oversighttype] [uniqueidentifier] NULL,
	[ovs_oversighttype_entitytype] [nvarchar](128) NULL,
	[owninguser] [uniqueidentifier] NULL,
	[owninguser_entitytype] [nvarchar](128) NULL,
	[createdonbehalfby] [uniqueidentifier] NULL,
	[createdonbehalfby_entitytype] [nvarchar](128) NULL,
	[ovs_region] [uniqueidentifier] NULL,
	[ovs_region_entitytype] [nvarchar](128) NULL,
	[owningbusinessunit] [uniqueidentifier] NULL,
	[owningbusinessunit_entitytype] [nvarchar](128) NULL,
	[owningteam] [uniqueidentifier] NULL,
	[owningteam_entitytype] [nvarchar](128) NULL,
	[modifiedby] [uniqueidentifier] NULL,
	[modifiedby_entitytype] [nvarchar](128) NULL,
	[createdby] [uniqueidentifier] NULL,
	[createdby_entitytype] [nvarchar](128) NULL,
	[ovs_fiscalyear] [uniqueidentifier] NULL,
	[ovs_fiscalyear_entitytype] [nvarchar](128) NULL,
	[modifiedonbehalfby] [uniqueidentifier] NULL,
	[modifiedonbehalfby_entitytype] [nvarchar](128) NULL,
	[ownerid] [uniqueidentifier] NULL,
	[ownerid_entitytype] [nvarchar](128) NULL,
	[createdonbehalfbyyominame] [nvarchar](100) NULL,
	[ovs_q2] [int] NULL,
	[ovs_q1] [int] NULL,
	[owneridname] [nvarchar](100) NULL,
	[ovs_q4] [int] NULL,
	[overriddencreatedon] [datetime] NULL,
	[ovs_fiscalyearname] [nvarchar](100) NULL,
	[ovs_q3] [int] NULL,
	[ovs_oversighttypename] [nvarchar](100) NULL,
	[importsequencenumber] [int] NULL,
	[ovs_unplannedforecastid] [uniqueidentifier] NULL,
	[utcconversiontimezonecode] [int] NULL,
	[createdbyyominame] [nvarchar](100) NULL,
	[modifiedbyname] [nvarchar](100) NULL,
	[modifiedbyyominame] [nvarchar](100) NULL,
	[timezoneruleversionnumber] [int] NULL,
	[owneridtype] [nvarchar](4000) NULL,
	[owneridyominame] [nvarchar](100) NULL,
	[modifiedon] [datetime] NULL,
	[modifiedonbehalfbyyominame] [nvarchar](100) NULL,
	[createdbyname] [nvarchar](100) NULL,
	[createdon] [datetime] NULL,
	[ovs_forecast] [int] NULL,
	[createdonbehalfbyname] [nvarchar](100) NULL,
	[modifiedonbehalfbyname] [nvarchar](100) NULL,
	[versionnumber] [bigint] NULL,
	[ovs_name] [nvarchar](100) NULL,
	[ovs_regionname] [nvarchar](200) NULL,
	CONSTRAINT [[dbo]].[SOURCE__UNPLANNED_FORECAST]]] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (
		STATISTICS_NORECOMPUTE = OFF,
		IGNORE_DUP_KEY = OFF,
		OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
	) ON [PRIMARY]
) ON [PRIMARY];


DROP TABLE IF EXISTS #SOURCE__UNPLANNED_FORECAST;
SELECT
	CAST(id AS uniqueidentifier) id,
	[ovs_name],
	[ovs_regionname],
	[ovs_fiscalyearname] [ovs_fiscalyearname],
	[ovs_oversighttypename],
	CAST([ovs_q1] AS int) [ovs_q1],
	CAST([ovs_q2] AS int) [ovs_q2],
	CAST([ovs_q3] AS int) [ovs_q3],
	CAST([ovs_q4] AS int) [ovs_q4],
	CAST([ovs_forecast] AS int) [ovs_forecast] INTO #SOURCE__UNPLANNED_FORECAST
FROM
	(
		SELECT
			'73cd786d-b0c3-eb11-bacc-000d3ae864fc' id,
			'Atlantic-2020-2021-GC Triggered' ovs_name,
			'Atlantic' ovs_regionname,
			'2020-2021' [ovs_fiscalyearname],
			'GC Triggered' [ovs_oversighttypename],
			'0' ovs_q1,
			'0' ovs_q2,
			'0' ovs_q3,
			'0' ovs_q4,
			'0' ovs_forecast
		UNION
		SELECT
			'74cd786d-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2020-2021-GC Opportunity',
			'Atlantic',
			'2020-2021',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'3ee5876f-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2020-2021-GC Consignment',
			'Atlantic',
			'2020-2021',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'3fe5876f-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2020-2021-GC Undeclared/ Misdeclared',
			'Atlantic',
			'2020-2021',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'40e5876f-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2020-2021-MOC Facility Triggered',
			'Atlantic',
			'2020-2021',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'41e5876f-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2020-2021-MOC Facility Opportunity',
			'Atlantic',
			'2020-2021',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'42e5876f-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2020-2021-Civil Aviation Document Review',
			'Atlantic',
			'2020-2021',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'deaf4967-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2021-2022-GC Consignment',
			'Atlantic',
			'2021-2022',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e1af4967-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2021-2022-MOC Facility Triggered',
			'Atlantic',
			'2021-2022',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e2af4967-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2021-2022-MOC Facility Opportunity',
			'Atlantic',
			'2021-2022',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'eeaf4967-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2021-2022-Civil Aviation Document Review',
			'Atlantic',
			'2021-2022',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'b0cb1163-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2021-2022-GC Triggered',
			'Atlantic',
			'2021-2022',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'b1cb1163-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2021-2022-GC Opportunity',
			'Atlantic',
			'2021-2022',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'b5cb1163-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2021-2022-GC Undeclared/ Misdeclared',
			'Atlantic',
			'2021-2022',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8dc69c5a-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2022-2023-GC Consignment',
			'Atlantic',
			'2022-2023',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8ec69c5a-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2022-2023-GC Undeclared/ Misdeclared',
			'Atlantic',
			'2022-2023',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'b45ce160-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2022-2023-MOC Facility Opportunity',
			'Atlantic',
			'2022-2023',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'b85ce160-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2022-2023-Civil Aviation Document Review',
			'Atlantic',
			'2022-2023',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'903a515c-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2022-2023-GC Triggered',
			'Atlantic',
			'2022-2023',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'923a515c-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2022-2023-GC Opportunity',
			'Atlantic',
			'2022-2023',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'993a515c-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2022-2023-MOC Facility Triggered',
			'Atlantic',
			'2022-2023',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'58bf2354-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2023-2024-GC Triggered',
			'Atlantic',
			'2023-2024',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'5abf2354-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2023-2024-GC Opportunity',
			'Atlantic',
			'2023-2024',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'64c69c5a-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2023-2024-GC Undeclared/ Misdeclared',
			'Atlantic',
			'2023-2024',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'66c69c5a-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2023-2024-MOC Facility Triggered',
			'Atlantic',
			'2023-2024',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'69c69c5a-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2023-2024-Civil Aviation Document Review',
			'Atlantic',
			'2023-2024',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e5ef5856-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2023-2024-GC Consignment',
			'Atlantic',
			'2023-2024',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e7ef5856-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2023-2024-MOC Facility Opportunity',
			'Atlantic',
			'2023-2024',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'64cd786d-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2024-2025-GC Triggered',
			'Atlantic',
			'2024-2025',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'6bcd786d-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2024-2025-GC Undeclared/ Misdeclared',
			'Atlantic',
			'2024-2025',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'70cd786d-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2024-2025-MOC Facility Triggered',
			'Atlantic',
			'2024-2025',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'71cd786d-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2024-2025-MOC Facility Opportunity',
			'Atlantic',
			'2024-2025',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f3ed2169-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2024-2025-GC Opportunity',
			'Atlantic',
			'2024-2025',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'30e5876f-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2024-2025-GC Consignment',
			'Atlantic',
			'2024-2025',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'38e5876f-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2024-2025-Civil Aviation Document Review',
			'Atlantic',
			'2024-2025',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'53bf2354-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2025-2026-MOC Facility Triggered',
			'Atlantic',
			'2025-2026',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'54bf2354-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2025-2026-MOC Facility Opportunity',
			'Atlantic',
			'2025-2026',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'daef5856-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2025-2026-GC Triggered',
			'Atlantic',
			'2025-2026',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'dbef5856-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2025-2026-GC Opportunity',
			'Atlantic',
			'2025-2026',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'dfef5856-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2025-2026-GC Consignment',
			'Atlantic',
			'2025-2026',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e0ef5856-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2025-2026-GC Undeclared/ Misdeclared',
			'Atlantic',
			'2025-2026',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e1ef5856-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2025-2026-Civil Aviation Document Review',
			'Atlantic',
			'2025-2026',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7dc69c5a-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2026-2027-GC Undeclared/ Misdeclared',
			'Atlantic',
			'2026-2027',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8bc69c5a-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2026-2027-Civil Aviation Document Review',
			'Atlantic',
			'2026-2027',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7e3a515c-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2026-2027-GC Triggered',
			'Atlantic',
			'2026-2027',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'823a515c-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2026-2027-GC Opportunity',
			'Atlantic',
			'2026-2027',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'843a515c-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2026-2027-GC Consignment',
			'Atlantic',
			'2026-2027',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'893a515c-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2026-2027-MOC Facility Triggered',
			'Atlantic',
			'2026-2027',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8e3a515c-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2026-2027-MOC Facility Opportunity',
			'Atlantic',
			'2026-2027',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'da5ce160-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2027-2028-GC Triggered',
			'Atlantic',
			'2027-2028',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f35ce160-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2027-2028-MOC Facility Triggered',
			'Atlantic',
			'2027-2028',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'9dcb1163-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2027-2028-GC Opportunity',
			'Atlantic',
			'2027-2028',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'9ecb1163-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2027-2028-GC Consignment',
			'Atlantic',
			'2027-2028',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'a2cb1163-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2027-2028-GC Undeclared/ Misdeclared',
			'Atlantic',
			'2027-2028',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'a6cb1163-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2027-2028-MOC Facility Opportunity',
			'Atlantic',
			'2027-2028',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'a7cb1163-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2027-2028-Civil Aviation Document Review',
			'Atlantic',
			'2027-2028',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'be5ce160-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2028-2029-GC Opportunity',
			'Atlantic',
			'2028-2029',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd25ce160-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2028-2029-MOC Facility Triggered',
			'Atlantic',
			'2028-2029',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'9e3a515c-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2028-2029-GC Triggered',
			'Atlantic',
			'2028-2029',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8acb1163-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2028-2029-GC Consignment',
			'Atlantic',
			'2028-2029',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8dcb1163-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2028-2029-GC Undeclared/ Misdeclared',
			'Atlantic',
			'2028-2029',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'97cb1163-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2028-2029-MOC Facility Opportunity',
			'Atlantic',
			'2028-2029',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'99cb1163-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2028-2029-Civil Aviation Document Review',
			'Atlantic',
			'2028-2029',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'eb780c4e-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2029-2030-GC Triggered',
			'Atlantic',
			'2029-2030',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f1780c4e-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2029-2030-GC Opportunity',
			'Atlantic',
			'2029-2030',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'1b38914f-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2029-2030-GC Consignment',
			'Atlantic',
			'2029-2030',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'1c38914f-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2029-2030-GC Undeclared/ Misdeclared',
			'Atlantic',
			'2029-2030',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'1d38914f-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2029-2030-MOC Facility Triggered',
			'Atlantic',
			'2029-2030',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'2038914f-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2029-2030-MOC Facility Opportunity',
			'Atlantic',
			'2029-2030',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'2238914f-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2029-2030-Civil Aviation Document Review',
			'Atlantic',
			'2029-2030',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'feaf4967-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2030-2031-GC Opportunity',
			'Atlantic',
			'2030-2031',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'0bb04967-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2030-2031-GC Consignment',
			'Atlantic',
			'2030-2031',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'0cb04967-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2030-2031-GC Undeclared/ Misdeclared',
			'Atlantic',
			'2030-2031',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'61cd786d-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2030-2031-MOC Facility Triggered',
			'Atlantic',
			'2030-2031',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'62cd786d-b0c3-eb11-bacc-000d3ae864fc',
			'Atlantic-2030-2031-Civil Aviation Document Review',
			'Atlantic',
			'2030-2031',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'deed2169-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2030-2031-GC Triggered',
			'Atlantic',
			'2030-2031',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e1ed2169-b0c3-eb11-bacc-000d3ae868f0',
			'Atlantic-2030-2031-MOC Facility Opportunity',
			'Atlantic',
			'2030-2031',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd2780c4e-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2020-2021-GC Opportunity',
			'HQ-CR',
			'2020-2021',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd3780c4e-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2020-2021-GC Consignment',
			'HQ-CR',
			'2020-2021',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e0780c4e-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2020-2021-MOC Facility Opportunity',
			'HQ-CR',
			'2020-2021',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'fb37914f-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2020-2021-GC Triggered',
			'HQ-CR',
			'2020-2021',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'0338914f-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2020-2021-GC Undeclared/ Misdeclared',
			'HQ-CR',
			'2020-2021',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'0438914f-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2020-2021-MOC Facility Triggered',
			'HQ-CR',
			'2020-2021',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'0638914f-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2020-2021-Civil Aviation Document Review',
			'HQ-CR',
			'2020-2021',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'891d0148-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2021-2022-GC Opportunity',
			'HQ-CR',
			'2021-2022',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'911d0148-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2021-2022-GC Consignment',
			'HQ-CR',
			'2021-2022',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'bd1d0148-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2021-2022-MOC Facility Triggered',
			'HQ-CR',
			'2021-2022',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c21d0148-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2021-2022-MOC Facility Opportunity',
			'HQ-CR',
			'2021-2022',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c51d0148-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2021-2022-Civil Aviation Document Review',
			'HQ-CR',
			'2021-2022',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'cdf38f43-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2021-2022-GC Triggered',
			'HQ-CR',
			'2021-2022',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e9289449-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2021-2022-GC Undeclared/ Misdeclared',
			'HQ-CR',
			'2021-2022',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'9535113b-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2022-2023-GC Consignment',
			'HQ-CR',
			'2022-2023',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'9635113b-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2022-2023-GC Undeclared/ Misdeclared',
			'HQ-CR',
			'2022-2023',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'61a58541-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2022-2023-MOC Facility Opportunity',
			'HQ-CR',
			'2022-2023',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'ffe5923d-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2022-2023-GC Triggered',
			'HQ-CR',
			'2022-2023',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'00e6923d-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2022-2023-GC Opportunity',
			'HQ-CR',
			'2022-2023',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'05e6923d-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2022-2023-MOC Facility Triggered',
			'HQ-CR',
			'2022-2023',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'0ce6923d-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2022-2023-Civil Aviation Document Review',
			'HQ-CR',
			'2022-2023',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'cb62f034-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2023-2024-GC Triggered',
			'HQ-CR',
			'2023-2024',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'ce62f034-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2023-2024-GC Consignment',
			'HQ-CR',
			'2023-2024',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'edee8937-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2023-2024-GC Opportunity',
			'HQ-CR',
			'2023-2024',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'eeee8937-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2023-2024-GC Undeclared/ Misdeclared',
			'HQ-CR',
			'2023-2024',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'efee8937-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2023-2024-MOC Facility Triggered',
			'HQ-CR',
			'2023-2024',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f1ee8937-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2023-2024-MOC Facility Opportunity',
			'HQ-CR',
			'2023-2024',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f2ee8937-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2023-2024-Civil Aviation Document Review',
			'HQ-CR',
			'2023-2024',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'cb780c4e-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2024-2025-GC Consignment',
			'HQ-CR',
			'2024-2025',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'cc780c4e-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2024-2025-GC Undeclared/ Misdeclared',
			'HQ-CR',
			'2024-2025',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'ce780c4e-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2024-2025-Civil Aviation Document Review',
			'HQ-CR',
			'2024-2025',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'fb289449-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2024-2025-GC Triggered',
			'HQ-CR',
			'2024-2025',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'fd289449-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2024-2025-GC Opportunity',
			'HQ-CR',
			'2024-2025',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'03299449-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2024-2025-MOC Facility Triggered',
			'HQ-CR',
			'2024-2025',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f437914f-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2024-2025-MOC Facility Opportunity',
			'HQ-CR',
			'2024-2025',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c762f034-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2025-2026-GC Triggered',
			'HQ-CR',
			'2025-2026',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c862f034-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2025-2026-GC Consignment',
			'HQ-CR',
			'2025-2026',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c962f034-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2025-2026-MOC Facility Triggered',
			'HQ-CR',
			'2025-2026',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'ca62f034-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2025-2026-MOC Facility Opportunity',
			'HQ-CR',
			'2025-2026',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e7ee8937-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2025-2026-GC Opportunity',
			'HQ-CR',
			'2025-2026',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e9ee8937-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2025-2026-GC Undeclared/ Misdeclared',
			'HQ-CR',
			'2025-2026',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'eaee8937-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2025-2026-Civil Aviation Document Review',
			'HQ-CR',
			'2025-2026',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8635113b-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2026-2027-GC Triggered',
			'HQ-CR',
			'2026-2027',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8735113b-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2026-2027-GC Consignment',
			'HQ-CR',
			'2026-2027',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8935113b-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2026-2027-GC Undeclared/ Misdeclared',
			'HQ-CR',
			'2026-2027',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8a35113b-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2026-2027-MOC Facility Triggered',
			'HQ-CR',
			'2026-2027',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8b35113b-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2026-2027-Civil Aviation Document Review',
			'HQ-CR',
			'2026-2027',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f3ee8937-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2026-2027-GC Opportunity',
			'HQ-CR',
			'2026-2027',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'fee5923d-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2026-2027-MOC Facility Opportunity',
			'HQ-CR',
			'2026-2027',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'6ea58541-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2027-2028-GC Triggered',
			'HQ-CR',
			'2027-2028',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'6fa58541-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2027-2028-GC Opportunity',
			'HQ-CR',
			'2027-2028',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'74a58541-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2027-2028-MOC Facility Triggered',
			'HQ-CR',
			'2027-2028',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'77a58541-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2027-2028-MOC Facility Opportunity',
			'HQ-CR',
			'2027-2028',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c6f38f43-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2027-2028-GC Consignment',
			'HQ-CR',
			'2027-2028',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c7f38f43-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2027-2028-GC Undeclared/ Misdeclared',
			'HQ-CR',
			'2027-2028',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'caf38f43-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2027-2028-Civil Aviation Document Review',
			'HQ-CR',
			'2027-2028',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'67a58541-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2028-2029-GC Consignment',
			'HQ-CR',
			'2028-2029',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'6aa58541-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2028-2029-Civil Aviation Document Review',
			'HQ-CR',
			'2028-2029',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'11e6923d-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2028-2029-GC Triggered',
			'HQ-CR',
			'2028-2029',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'12e6923d-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2028-2029-GC Opportunity',
			'HQ-CR',
			'2028-2029',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'bff38f43-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2028-2029-GC Undeclared/ Misdeclared',
			'HQ-CR',
			'2028-2029',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c1f38f43-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2028-2029-MOC Facility Triggered',
			'HQ-CR',
			'2028-2029',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c4f38f43-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2028-2029-MOC Facility Opportunity',
			'HQ-CR',
			'2028-2029',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'2ececa2e-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2029-2030-GC Triggered',
			'HQ-CR',
			'2029-2030',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'2fceca2e-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2029-2030-GC Opportunity',
			'HQ-CR',
			'2029-2030',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c362f034-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2029-2030-GC Undeclared/ Misdeclared',
			'HQ-CR',
			'2029-2030',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'dde8f130-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2029-2030-GC Consignment',
			'HQ-CR',
			'2029-2030',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e1e8f130-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2029-2030-MOC Facility Triggered',
			'HQ-CR',
			'2029-2030',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e4e8f130-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2029-2030-MOC Facility Opportunity',
			'HQ-CR',
			'2029-2030',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e5e8f130-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2029-2030-Civil Aviation Document Review',
			'HQ-CR',
			'2029-2030',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd21d0148-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2030-2031-GC Triggered',
			'HQ-CR',
			'2030-2031',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd31d0148-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2030-2031-GC Opportunity',
			'HQ-CR',
			'2030-2031',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd61d0148-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2030-2031-GC Consignment',
			'HQ-CR',
			'2030-2031',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'de1d0148-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2030-2031-MOC Facility Triggered',
			'HQ-CR',
			'2030-2031',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e91d0148-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-CR-2030-2031-Civil Aviation Document Review',
			'HQ-CR',
			'2030-2031',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'ec289449-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2030-2031-GC Undeclared/ Misdeclared',
			'HQ-CR',
			'2030-2031',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'ef289449-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-CR-2030-2031-MOC Facility Opportunity',
			'HQ-CR',
			'2030-2031',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'24ceca2e-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2020-2021-GC Triggered',
			'HQ-ES',
			'2020-2021',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'27ceca2e-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2020-2021-MOC Facility Triggered',
			'HQ-ES',
			'2020-2021',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'28ceca2e-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2020-2021-MOC Facility Opportunity',
			'HQ-ES',
			'2020-2021',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'29ceca2e-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2020-2021-Civil Aviation Document Review',
			'HQ-ES',
			'2020-2021',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'0415f02a-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2020-2021-GC Opportunity',
			'HQ-ES',
			'2020-2021',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd1e8f130-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2020-2021-GC Consignment',
			'HQ-ES',
			'2020-2021',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd2e8f130-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2020-2021-GC Undeclared/ Misdeclared',
			'HQ-ES',
			'2020-2021',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'10c2bc28-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2021-2022-GC Opportunity',
			'HQ-ES',
			'2021-2022',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'11c2bc28-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2021-2022-GC Undeclared/ Misdeclared',
			'HQ-ES',
			'2021-2022',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'15c2bc28-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2021-2022-Civil Aviation Document Review',
			'HQ-ES',
			'2021-2022',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'6582ab24-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2021-2022-GC Triggered',
			'HQ-ES',
			'2021-2022',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'6882ab24-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2021-2022-GC Consignment',
			'HQ-ES',
			'2021-2022',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'6a82ab24-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2021-2022-MOC Facility Triggered',
			'HQ-ES',
			'2021-2022',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'6c82ab24-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2021-2022-MOC Facility Opportunity',
			'HQ-ES',
			'2021-2022',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f8ce741b-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2022-2023-GC Triggered',
			'HQ-ES',
			'2022-2023',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'34c77d21-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2022-2023-GC Opportunity',
			'HQ-ES',
			'2022-2023',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'3bc77d21-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2022-2023-MOC Facility Opportunity',
			'HQ-ES',
			'2022-2023',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8c8aa21e-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2022-2023-GC Consignment',
			'HQ-ES',
			'2022-2023',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8e8aa21e-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2022-2023-GC Undeclared/ Misdeclared',
			'HQ-ES',
			'2022-2023',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'938aa21e-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2022-2023-MOC Facility Triggered',
			'HQ-ES',
			'2022-2023',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'9b8aa21e-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2022-2023-Civil Aviation Document Review',
			'HQ-ES',
			'2022-2023',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd2ce741b-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2023-2024-GC Triggered',
			'HQ-ES',
			'2023-2024',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd9ce741b-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2023-2024-GC Opportunity',
			'HQ-ES',
			'2023-2024',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'dcce741b-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2023-2024-MOC Facility Opportunity',
			'HQ-ES',
			'2023-2024',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'9ddea718-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2023-2024-GC Consignment',
			'HQ-ES',
			'2023-2024',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'a4dea718-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2023-2024-GC Undeclared/ Misdeclared',
			'HQ-ES',
			'2023-2024',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'aadea718-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2023-2024-MOC Facility Triggered',
			'HQ-ES',
			'2023-2024',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'cedea718-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2023-2024-Civil Aviation Document Review',
			'HQ-ES',
			'2023-2024',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'2cc2bc28-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2024-2025-GC Undeclared/ Misdeclared',
			'HQ-ES',
			'2024-2025',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'2dc2bc28-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2024-2025-MOC Facility Triggered',
			'HQ-ES',
			'2024-2025',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'20ceca2e-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2024-2025-MOC Facility Opportunity',
			'HQ-ES',
			'2024-2025',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f314f02a-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2024-2025-GC Triggered',
			'HQ-ES',
			'2024-2025',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f514f02a-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2024-2025-GC Opportunity',
			'HQ-ES',
			'2024-2025',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f614f02a-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2024-2025-GC Consignment',
			'HQ-ES',
			'2024-2025',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'fb14f02a-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2024-2025-Civil Aviation Document Review',
			'HQ-ES',
			'2024-2025',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'81af7715-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2025-2026-GC Consignment',
			'HQ-ES',
			'2025-2026',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'96af7715-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2025-2026-Civil Aviation Document Review',
			'HQ-ES',
			'2025-2026',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'72dea718-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2025-2026-GC Triggered',
			'HQ-ES',
			'2025-2026',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'73dea718-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2025-2026-GC Opportunity',
			'HQ-ES',
			'2025-2026',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'75dea718-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2025-2026-GC Undeclared/ Misdeclared',
			'HQ-ES',
			'2025-2026',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'78dea718-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2025-2026-MOC Facility Triggered',
			'HQ-ES',
			'2025-2026',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'79dea718-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2025-2026-MOC Facility Opportunity',
			'HQ-ES',
			'2025-2026',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e1ce741b-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2026-2027-GC Triggered',
			'HQ-ES',
			'2026-2027',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e4ce741b-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2026-2027-GC Consignment',
			'HQ-ES',
			'2026-2027',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'eace741b-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2026-2027-MOC Facility Triggered',
			'HQ-ES',
			'2026-2027',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'efce741b-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2026-2027-MOC Facility Opportunity',
			'HQ-ES',
			'2026-2027',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f1ce741b-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2026-2027-Civil Aviation Document Review',
			'HQ-ES',
			'2026-2027',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'498aa21e-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2026-2027-GC Opportunity',
			'HQ-ES',
			'2026-2027',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'598aa21e-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2026-2027-GC Undeclared/ Misdeclared',
			'HQ-ES',
			'2026-2027',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'47c77d21-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2027-2028-GC Consignment',
			'HQ-ES',
			'2027-2028',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'48c77d21-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2027-2028-MOC Facility Opportunity',
			'HQ-ES',
			'2027-2028',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'3682ab24-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2027-2028-GC Triggered',
			'HQ-ES',
			'2027-2028',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'4782ab24-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2027-2028-GC Opportunity',
			'HQ-ES',
			'2027-2028',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'5382ab24-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2027-2028-GC Undeclared/ Misdeclared',
			'HQ-ES',
			'2027-2028',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'5782ab24-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2027-2028-MOC Facility Triggered',
			'HQ-ES',
			'2027-2028',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'6282ab24-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2027-2028-Civil Aviation Document Review',
			'HQ-ES',
			'2027-2028',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'3cc77d21-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2028-2029-GC Opportunity',
			'HQ-ES',
			'2028-2029',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'3dc77d21-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2028-2029-GC Consignment',
			'HQ-ES',
			'2028-2029',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'3ec77d21-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2028-2029-GC Undeclared/ Misdeclared',
			'HQ-ES',
			'2028-2029',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'3fc77d21-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2028-2029-MOC Facility Triggered',
			'HQ-ES',
			'2028-2029',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'40c77d21-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2028-2029-MOC Facility Opportunity',
			'HQ-ES',
			'2028-2029',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'41c77d21-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2028-2029-Civil Aviation Document Review',
			'HQ-ES',
			'2028-2029',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'a48aa21e-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2028-2029-GC Triggered',
			'HQ-ES',
			'2028-2029',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'75af7715-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2029-2030-GC Consignment',
			'HQ-ES',
			'2029-2030',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'76af7715-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2029-2030-GC Undeclared/ Misdeclared',
			'HQ-ES',
			'2029-2030',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'77af7715-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2029-2030-MOC Facility Triggered',
			'HQ-ES',
			'2029-2030',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'4d883f12-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2029-2030-GC Triggered',
			'HQ-ES',
			'2029-2030',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'5a883f12-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2029-2030-GC Opportunity',
			'HQ-ES',
			'2029-2030',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'66883f12-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2029-2030-MOC Facility Opportunity',
			'HQ-ES',
			'2029-2030',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'71dea718-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2029-2030-Civil Aviation Document Review',
			'HQ-ES',
			'2029-2030',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'1ec2bc28-b0c3-eb11-bacc-000d3ae864fc',
			'HQ-ES-2030-2031-Civil Aviation Document Review',
			'HQ-ES',
			'2030-2031',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e714f02a-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2030-2031-GC Triggered',
			'HQ-ES',
			'2030-2031',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'ea14f02a-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2030-2031-GC Opportunity',
			'HQ-ES',
			'2030-2031',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'ec14f02a-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2030-2031-GC Consignment',
			'HQ-ES',
			'2030-2031',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'ee14f02a-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2030-2031-GC Undeclared/ Misdeclared',
			'HQ-ES',
			'2030-2031',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'ef14f02a-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2030-2031-MOC Facility Triggered',
			'HQ-ES',
			'2030-2031',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f214f02a-b0c3-eb11-bacc-000d3ae868f0',
			'HQ-ES-2030-2031-MOC Facility Opportunity',
			'HQ-ES',
			'2030-2031',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f4bbc6e7-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2020-2021-GC Opportunity',
			'Ontario',
			'2020-2021',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f9bbc6e7-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2020-2021-MOC Facility Triggered',
			'Ontario',
			'2020-2021',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'fabbc6e7-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2020-2021-MOC Facility Opportunity',
			'Ontario',
			'2020-2021',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'fcbbc6e7-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2020-2021-Civil Aviation Document Review',
			'Ontario',
			'2020-2021',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd53ccfeb-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2020-2021-GC Triggered',
			'Ontario',
			'2020-2021',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd63ccfeb-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2020-2021-GC Consignment',
			'Ontario',
			'2020-2021',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd73ccfeb-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2020-2021-GC Undeclared/ Misdeclared',
			'Ontario',
			'2020-2021',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'789cb6e1-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2021-2022-GC Consignment',
			'Ontario',
			'2021-2022',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7a9cb6e1-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2021-2022-GC Undeclared/ Misdeclared',
			'Ontario',
			'2021-2022',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'db489edf-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2021-2022-GC Triggered',
			'Ontario',
			'2021-2022',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'34e0c3e5-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2021-2022-GC Opportunity',
			'Ontario',
			'2021-2022',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'35e0c3e5-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2021-2022-MOC Facility Triggered',
			'Ontario',
			'2021-2022',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'36e0c3e5-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2021-2022-MOC Facility Opportunity',
			'Ontario',
			'2021-2022',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'37e0c3e5-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2021-2022-Civil Aviation Document Review',
			'Ontario',
			'2021-2022',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'3043a6db-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2022-2023-GC Triggered',
			'Ontario',
			'2022-2023',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'3943a6db-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2022-2023-GC Consignment',
			'Ontario',
			'2022-2023',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'4043a6db-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2022-2023-GC Undeclared/ Misdeclared',
			'Ontario',
			'2022-2023',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'5143a6db-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2022-2023-Civil Aviation Document Review',
			'Ontario',
			'2022-2023',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'6bfd67d9-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2022-2023-GC Opportunity',
			'Ontario',
			'2022-2023',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'6cfd67d9-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2022-2023-MOC Facility Triggered',
			'Ontario',
			'2022-2023',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'6dfd67d9-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2022-2023-MOC Facility Opportunity',
			'Ontario',
			'2022-2023',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'411264d5-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2023-2024-GC Opportunity',
			'Ontario',
			'2023-2024',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'451264d5-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2023-2024-Civil Aviation Document Review',
			'Ontario',
			'2023-2024',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'16ee6ad3-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2023-2024-GC Triggered',
			'Ontario',
			'2023-2024',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'1aee6ad3-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2023-2024-GC Consignment',
			'Ontario',
			'2023-2024',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'1bee6ad3-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2023-2024-GC Undeclared/ Misdeclared',
			'Ontario',
			'2023-2024',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'1fee6ad3-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2023-2024-MOC Facility Triggered',
			'Ontario',
			'2023-2024',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'22ee6ad3-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2023-2024-MOC Facility Opportunity',
			'Ontario',
			'2023-2024',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f3bbc6e7-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2024-2025-MOC Facility Triggered',
			'Ontario',
			'2024-2025',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'43e0c3e5-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2024-2025-GC Triggered',
			'Ontario',
			'2024-2025',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'44e0c3e5-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2024-2025-GC Opportunity',
			'Ontario',
			'2024-2025',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'45e0c3e5-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2024-2025-GC Consignment',
			'Ontario',
			'2024-2025',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'46e0c3e5-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2024-2025-GC Undeclared/ Misdeclared',
			'Ontario',
			'2024-2025',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'47e0c3e5-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2024-2025-MOC Facility Opportunity',
			'Ontario',
			'2024-2025',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'49e0c3e5-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2024-2025-Civil Aviation Document Review',
			'Ontario',
			'2024-2025',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'9cbbfbce-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2025-2026-GC Consignment',
			'Ontario',
			'2025-2026',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'3b1264d5-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2025-2026-GC Undeclared/ Misdeclared',
			'Ontario',
			'2025-2026',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'3c1264d5-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2025-2026-MOC Facility Triggered',
			'Ontario',
			'2025-2026',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'3f1264d5-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2025-2026-Civil Aviation Document Review',
			'Ontario',
			'2025-2026',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd6ed6ad3-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2025-2026-GC Triggered',
			'Ontario',
			'2025-2026',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd7ed6ad3-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2025-2026-GC Opportunity',
			'Ontario',
			'2025-2026',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'faed6ad3-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2025-2026-MOC Facility Opportunity',
			'Ontario',
			'2025-2026',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'471264d5-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2026-2027-GC Opportunity',
			'Ontario',
			'2026-2027',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'4a1264d5-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2026-2027-GC Consignment',
			'Ontario',
			'2026-2027',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'4b1264d5-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2026-2027-GC Undeclared/ Misdeclared',
			'Ontario',
			'2026-2027',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'2543a6db-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2026-2027-MOC Facility Opportunity',
			'Ontario',
			'2026-2027',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'50fd67d9-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2026-2027-GC Triggered',
			'Ontario',
			'2026-2027',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'66fd67d9-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2026-2027-MOC Facility Triggered',
			'Ontario',
			'2026-2027',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'6afd67d9-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2026-2027-Civil Aviation Document Review',
			'Ontario',
			'2026-2027',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'729cb6e1-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2027-2028-GC Opportunity',
			'Ontario',
			'2027-2028',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'739cb6e1-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2027-2028-GC Consignment',
			'Ontario',
			'2027-2028',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'759cb6e1-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2027-2028-MOC Facility Triggered',
			'Ontario',
			'2027-2028',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'769cb6e1-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2027-2028-MOC Facility Opportunity',
			'Ontario',
			'2027-2028',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd7489edf-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2027-2028-GC Triggered',
			'Ontario',
			'2027-2028',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd8489edf-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2027-2028-GC Undeclared/ Misdeclared',
			'Ontario',
			'2027-2028',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'da489edf-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2027-2028-Civil Aviation Document Review',
			'Ontario',
			'2027-2028',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7443a6db-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2028-2029-GC Opportunity',
			'Ontario',
			'2028-2029',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7543a6db-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2028-2029-GC Consignment',
			'Ontario',
			'2028-2029',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7643a6db-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2028-2029-GC Undeclared/ Misdeclared',
			'Ontario',
			'2028-2029',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7743a6db-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2028-2029-MOC Facility Opportunity',
			'Ontario',
			'2028-2029',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'71fd67d9-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2028-2029-GC Triggered',
			'Ontario',
			'2028-2029',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'cd489edf-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2028-2029-MOC Facility Triggered',
			'Ontario',
			'2028-2029',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'ce489edf-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2028-2029-Civil Aviation Document Review',
			'Ontario',
			'2028-2029',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8fbbfbce-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2029-2030-GC Triggered',
			'Ontario',
			'2029-2030',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'96bbfbce-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2029-2030-MOC Facility Triggered',
			'Ontario',
			'2029-2030',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'98bbfbce-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2029-2030-MOC Facility Opportunity',
			'Ontario',
			'2029-2030',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7d5264cd-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2029-2030-GC Opportunity',
			'Ontario',
			'2029-2030',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7e5264cd-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2029-2030-GC Consignment',
			'Ontario',
			'2029-2030',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7f5264cd-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2029-2030-GC Undeclared/ Misdeclared',
			'Ontario',
			'2029-2030',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd5ed6ad3-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2029-2030-Civil Aviation Document Review',
			'Ontario',
			'2029-2030',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7d9cb6e1-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2030-2031-GC Triggered',
			'Ontario',
			'2030-2031',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e6bbc6e7-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2030-2031-GC Opportunity',
			'Ontario',
			'2030-2031',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e7bbc6e7-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2030-2031-GC Consignment',
			'Ontario',
			'2030-2031',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e8bbc6e7-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2030-2031-MOC Facility Triggered',
			'Ontario',
			'2030-2031',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'eabbc6e7-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2030-2031-MOC Facility Opportunity',
			'Ontario',
			'2030-2031',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'ebbbc6e7-b0c3-eb11-bacc-000d3ae864fc',
			'Ontario-2030-2031-Civil Aviation Document Review',
			'Ontario',
			'2030-2031',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'42e0c3e5-b0c3-eb11-bacc-000d3ae868f0',
			'Ontario-2030-2031-GC Undeclared/ Misdeclared',
			'Ontario',
			'2030-2031',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'a3c3eeaf-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2020-2021-GC Triggered',
			'Pacific',
			'2020-2021',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'a5c3eeaf-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2020-2021-MOC Facility Triggered',
			'Pacific',
			'2020-2021',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'a7c3eeaf-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2020-2021-Civil Aviation Document Review',
			'Pacific',
			'2020-2021',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'fc97b6ae-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2020-2021-GC Opportunity',
			'Pacific',
			'2020-2021',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'0798b6ae-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2020-2021-GC Consignment',
			'Pacific',
			'2020-2021',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'0b98b6ae-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2020-2021-GC Undeclared/ Misdeclared',
			'Pacific',
			'2020-2021',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'1d98b6ae-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2020-2021-MOC Facility Opportunity',
			'Pacific',
			'2020-2021',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'245ce6a3-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2021-2022-GC Triggered',
			'Pacific',
			'2021-2022',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'285ce6a3-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2021-2022-GC Undeclared/ Misdeclared',
			'Pacific',
			'2021-2022',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'2c5ce6a3-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2021-2022-MOC Facility Opportunity',
			'Pacific',
			'2021-2022',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'2d5ce6a3-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2021-2022-Civil Aviation Document Review',
			'Pacific',
			'2021-2022',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'510569a2-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2021-2022-GC Opportunity',
			'Pacific',
			'2021-2022',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'550569a2-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2021-2022-GC Consignment',
			'Pacific',
			'2021-2022',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c62698a8-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2021-2022-MOC Facility Triggered',
			'Pacific',
			'2021-2022',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'eb64c59d-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2022-2023-GC Opportunity',
			'Pacific',
			'2022-2023',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'ee64c59d-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2022-2023-MOC Facility Triggered',
			'Pacific',
			'2022-2023',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f064c59d-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2022-2023-Civil Aviation Document Review',
			'Pacific',
			'2022-2023',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7f840c9c-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2022-2023-GC Triggered',
			'Pacific',
			'2022-2023',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'80840c9c-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2022-2023-GC Consignment',
			'Pacific',
			'2022-2023',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'81840c9c-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2022-2023-GC Undeclared/ Misdeclared',
			'Pacific',
			'2022-2023',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'82840c9c-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2022-2023-MOC Facility Opportunity',
			'Pacific',
			'2022-2023',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd85bbc97-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2023-2024-GC Triggered',
			'Pacific',
			'2023-2024',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'dd5bbc97-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2023-2024-MOC Facility Triggered',
			'Pacific',
			'2023-2024',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'eb13cf95-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2023-2024-GC Opportunity',
			'Pacific',
			'2023-2024',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'ec13cf95-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2023-2024-GC Consignment',
			'Pacific',
			'2023-2024',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'ed13cf95-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2023-2024-GC Undeclared/ Misdeclared',
			'Pacific',
			'2023-2024',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'6d840c9c-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2023-2024-MOC Facility Opportunity',
			'Pacific',
			'2023-2024',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'6e840c9c-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2023-2024-Civil Aviation Document Review',
			'Pacific',
			'2023-2024',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c9f6eca9-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2024-2025-GC Triggered',
			'Pacific',
			'2024-2025',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'caf6eca9-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2024-2025-GC Opportunity',
			'Pacific',
			'2024-2025',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'cef6eca9-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2024-2025-GC Undeclared/ Misdeclared',
			'Pacific',
			'2024-2025',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd2f6eca9-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2024-2025-MOC Facility Opportunity',
			'Pacific',
			'2024-2025',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'9fc3eeaf-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2024-2025-Civil Aviation Document Review',
			'Pacific',
			'2024-2025',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd22698a8-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2024-2025-GC Consignment',
			'Pacific',
			'2024-2025',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'9997b6ae-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2024-2025-MOC Facility Triggered',
			'Pacific',
			'2024-2025',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'79047391-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2025-2026-GC Triggered',
			'Pacific',
			'2025-2026',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'cc5bbc97-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2025-2026-MOC Facility Triggered',
			'Pacific',
			'2025-2026',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'd05bbc97-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2025-2026-Civil Aviation Document Review',
			'Pacific',
			'2025-2026',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e513cf95-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2025-2026-GC Opportunity',
			'Pacific',
			'2025-2026',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e613cf95-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2025-2026-GC Consignment',
			'Pacific',
			'2025-2026',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e713cf95-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2025-2026-GC Undeclared/ Misdeclared',
			'Pacific',
			'2025-2026',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e813cf95-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2025-2026-MOC Facility Opportunity',
			'Pacific',
			'2025-2026',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e164c59d-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2026-2027-GC Undeclared/ Misdeclared',
			'Pacific',
			'2026-2027',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e664c59d-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2026-2027-Civil Aviation Document Review',
			'Pacific',
			'2026-2027',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'70840c9c-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2026-2027-GC Triggered',
			'Pacific',
			'2026-2027',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'77840c9c-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2026-2027-GC Opportunity',
			'Pacific',
			'2026-2027',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'78840c9c-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2026-2027-GC Consignment',
			'Pacific',
			'2026-2027',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7a840c9c-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2026-2027-MOC Facility Triggered',
			'Pacific',
			'2026-2027',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7c840c9c-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2026-2027-MOC Facility Opportunity',
			'Pacific',
			'2026-2027',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'1b5ce6a3-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2027-2028-GC Consignment',
			'Pacific',
			'2027-2028',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'1f5ce6a3-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2027-2028-GC Undeclared/ Misdeclared',
			'Pacific',
			'2027-2028',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'215ce6a3-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2027-2028-MOC Facility Triggered',
			'Pacific',
			'2027-2028',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'235ce6a3-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2027-2028-Civil Aviation Document Review',
			'Pacific',
			'2027-2028',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'480569a2-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2027-2028-GC Triggered',
			'Pacific',
			'2027-2028',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'490569a2-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2027-2028-GC Opportunity',
			'Pacific',
			'2027-2028',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'4a0569a2-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2027-2028-MOC Facility Opportunity',
			'Pacific',
			'2027-2028',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f464c59d-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2028-2029-GC Opportunity',
			'Pacific',
			'2028-2029',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f564c59d-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2028-2029-GC Undeclared/ Misdeclared',
			'Pacific',
			'2028-2029',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'1a5ce6a3-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2028-2029-Civil Aviation Document Review',
			'Pacific',
			'2028-2029',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'410569a2-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2028-2029-GC Triggered',
			'Pacific',
			'2028-2029',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'420569a2-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2028-2029-GC Consignment',
			'Pacific',
			'2028-2029',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'440569a2-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2028-2029-MOC Facility Triggered',
			'Pacific',
			'2028-2029',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'450569a2-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2028-2029-MOC Facility Opportunity',
			'Pacific',
			'2028-2029',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'69047391-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2029-2030-GC Consignment',
			'Pacific',
			'2029-2030',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'6a047391-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2029-2030-GC Undeclared/ Misdeclared',
			'Pacific',
			'2029-2030',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'6c047391-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2029-2030-MOC Facility Triggered',
			'Pacific',
			'2029-2030',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'78047391-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2029-2030-Civil Aviation Document Review',
			'Pacific',
			'2029-2030',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'ceea948e-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2029-2030-GC Triggered',
			'Pacific',
			'2029-2030',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'cfea948e-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2029-2030-GC Opportunity',
			'Pacific',
			'2029-2030',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e013cf95-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2029-2030-MOC Facility Opportunity',
			'Pacific',
			'2029-2030',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'bdf6eca9-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2030-2031-GC Triggered',
			'Pacific',
			'2030-2031',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'bef6eca9-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2030-2031-GC Opportunity',
			'Pacific',
			'2030-2031',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'bff6eca9-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2030-2031-GC Consignment',
			'Pacific',
			'2030-2031',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c0f6eca9-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2030-2031-GC Undeclared/ Misdeclared',
			'Pacific',
			'2030-2031',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c4f6eca9-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2030-2031-MOC Facility Opportunity',
			'Pacific',
			'2030-2031',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c5f6eca9-b0c3-eb11-bacc-000d3ae864fc',
			'Pacific-2030-2031-Civil Aviation Document Review',
			'Pacific',
			'2030-2031',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'cc2698a8-b0c3-eb11-bacc-000d3ae868f0',
			'Pacific-2030-2031-MOC Facility Triggered',
			'Pacific',
			'2030-2031',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'85bbfbce-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2020-2021-GC Consignment',
			'Prairie and Northern',
			'2020-2021',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'88bbfbce-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2020-2021-MOC Facility Triggered',
			'Prairie and Northern',
			'2020-2021',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8abbfbce-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2020-2021-MOC Facility Opportunity',
			'Prairie and Northern',
			'2020-2021',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'725264cd-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2020-2021-GC Triggered',
			'Prairie and Northern',
			'2020-2021',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'735264cd-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2020-2021-GC Opportunity',
			'Prairie and Northern',
			'2020-2021',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'745264cd-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2020-2021-GC Undeclared/ Misdeclared',
			'Prairie and Northern',
			'2020-2021',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7a5264cd-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2020-2021-Civil Aviation Document Review',
			'Prairie and Northern',
			'2020-2021',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8239e9c8-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2021-2022-GC Opportunity',
			'Prairie and Northern',
			'2021-2022',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8539e9c8-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2021-2022-MOC Facility Opportunity',
			'Prairie and Northern',
			'2021-2022',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8739e9c8-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2021-2022-Civil Aviation Document Review',
			'Prairie and Northern',
			'2021-2022',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e2076cc7-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2021-2022-GC Triggered',
			'Prairie and Northern',
			'2021-2022',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e3076cc7-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2021-2022-GC Consignment',
			'Prairie and Northern',
			'2021-2022',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'e6076cc7-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2021-2022-GC Undeclared/ Misdeclared',
			'Prairie and Northern',
			'2021-2022',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'f0076cc7-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2021-2022-MOC Facility Triggered',
			'Prairie and Northern',
			'2021-2022',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'5f8c18bc-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2022-2023-GC Triggered',
			'Prairie and Northern',
			'2022-2023',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'711bbac2-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2022-2023-MOC Facility Opportunity',
			'Prairie and Northern',
			'2022-2023',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'721bbac2-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2022-2023-Civil Aviation Document Review',
			'Prairie and Northern',
			'2022-2023',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'83fb30c1-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2022-2023-GC Opportunity',
			'Prairie and Northern',
			'2022-2023',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'86fb30c1-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2022-2023-GC Consignment',
			'Prairie and Northern',
			'2022-2023',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8dfb30c1-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2022-2023-GC Undeclared/ Misdeclared',
			'Prairie and Northern',
			'2022-2023',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8ffb30c1-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2022-2023-MOC Facility Triggered',
			'Prairie and Northern',
			'2022-2023',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'33f611b6-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2023-2024-GC Triggered',
			'Prairie and Northern',
			'2023-2024',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'428c18bc-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2023-2024-MOC Facility Opportunity',
			'Prairie and Northern',
			'2023-2024',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'448c18bc-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2023-2024-Civil Aviation Document Review',
			'Prairie and Northern',
			'2023-2024',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'78d920bb-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2023-2024-GC Opportunity',
			'Prairie and Northern',
			'2023-2024',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'79d920bb-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2023-2024-GC Consignment',
			'Prairie and Northern',
			'2023-2024',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7bd920bb-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2023-2024-GC Undeclared/ Misdeclared',
			'Prairie and Northern',
			'2023-2024',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7cd920bb-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2023-2024-MOC Facility Triggered',
			'Prairie and Northern',
			'2023-2024',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'a439e9c8-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2024-2025-MOC Facility Triggered',
			'Prairie and Northern',
			'2024-2025',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'a539e9c8-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2024-2025-MOC Facility Opportunity',
			'Prairie and Northern',
			'2024-2025',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'81bbfbce-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2024-2025-Civil Aviation Document Review',
			'Prairie and Northern',
			'2024-2025',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'665264cd-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2024-2025-GC Triggered',
			'Prairie and Northern',
			'2024-2025',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'675264cd-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2024-2025-GC Opportunity',
			'Prairie and Northern',
			'2024-2025',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'685264cd-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2024-2025-GC Consignment',
			'Prairie and Northern',
			'2024-2025',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'695264cd-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2024-2025-GC Undeclared/ Misdeclared',
			'Prairie and Northern',
			'2024-2025',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'22f611b6-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2025-2026-GC Opportunity',
			'Prairie and Northern',
			'2025-2026',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'23f611b6-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2025-2026-GC Consignment',
			'Prairie and Northern',
			'2025-2026',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'26f611b6-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2025-2026-MOC Facility Triggered',
			'Prairie and Northern',
			'2025-2026',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'cb30bdb4-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2025-2026-GC Triggered',
			'Prairie and Northern',
			'2025-2026',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'cc30bdb4-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2025-2026-GC Undeclared/ Misdeclared',
			'Prairie and Northern',
			'2025-2026',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'cd30bdb4-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2025-2026-MOC Facility Opportunity',
			'Prairie and Northern',
			'2025-2026',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'ce30bdb4-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2025-2026-Civil Aviation Document Review',
			'Prairie and Northern',
			'2025-2026',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'548c18bc-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2026-2027-GC Triggered',
			'Prairie and Northern',
			'2026-2027',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'558c18bc-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2026-2027-GC Opportunity',
			'Prairie and Northern',
			'2026-2027',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'588c18bc-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2026-2027-GC Undeclared/ Misdeclared',
			'Prairie and Northern',
			'2026-2027',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'5a8c18bc-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2026-2027-MOC Facility Triggered',
			'Prairie and Northern',
			'2026-2027',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'5d8c18bc-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2026-2027-Civil Aviation Document Review',
			'Prairie and Northern',
			'2026-2027',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'82d920bb-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2026-2027-GC Consignment',
			'Prairie and Northern',
			'2026-2027',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8dd920bb-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2026-2027-MOC Facility Opportunity',
			'Prairie and Northern',
			'2026-2027',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'821bbac2-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2027-2028-GC Triggered',
			'Prairie and Northern',
			'2027-2028',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8c1bbac2-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2027-2028-GC Opportunity',
			'Prairie and Northern',
			'2027-2028',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8f1bbac2-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2027-2028-GC Consignment',
			'Prairie and Northern',
			'2027-2028',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'901bbac2-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2027-2028-GC Undeclared/ Misdeclared',
			'Prairie and Northern',
			'2027-2028',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'911bbac2-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2027-2028-MOC Facility Opportunity',
			'Prairie and Northern',
			'2027-2028',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'a8fb30c1-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2027-2028-MOC Facility Triggered',
			'Prairie and Northern',
			'2027-2028',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'df076cc7-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2027-2028-Civil Aviation Document Review',
			'Prairie and Northern',
			'2027-2028',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'751bbac2-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2028-2029-GC Triggered',
			'Prairie and Northern',
			'2028-2029',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'761bbac2-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2028-2029-GC Opportunity',
			'Prairie and Northern',
			'2028-2029',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7f1bbac2-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2028-2029-GC Undeclared/ Misdeclared',
			'Prairie and Northern',
			'2028-2029',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'94fb30c1-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2028-2029-GC Consignment',
			'Prairie and Northern',
			'2028-2029',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'95fb30c1-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2028-2029-MOC Facility Triggered',
			'Prairie and Northern',
			'2028-2029',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'96fb30c1-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2028-2029-MOC Facility Opportunity',
			'Prairie and Northern',
			'2028-2029',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'97fb30c1-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2028-2029-Civil Aviation Document Review',
			'Prairie and Northern',
			'2028-2029',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'17f611b6-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2029-2030-GC Opportunity',
			'Prairie and Northern',
			'2029-2030',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'18f611b6-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2029-2030-GC Consignment',
			'Prairie and Northern',
			'2029-2030',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'1af611b6-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2029-2030-Civil Aviation Document Review',
			'Prairie and Northern',
			'2029-2030',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c530bdb4-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2029-2030-GC Triggered',
			'Prairie and Northern',
			'2029-2030',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c730bdb4-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2029-2030-GC Undeclared/ Misdeclared',
			'Prairie and Northern',
			'2029-2030',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c830bdb4-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2029-2030-MOC Facility Triggered',
			'Prairie and Northern',
			'2029-2030',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c930bdb4-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2029-2030-MOC Facility Opportunity',
			'Prairie and Northern',
			'2029-2030',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8f39e9c8-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2030-2031-GC Opportunity',
			'Prairie and Northern',
			'2030-2031',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'9139e9c8-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2030-2031-GC Undeclared/ Misdeclared',
			'Prairie and Northern',
			'2030-2031',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'9b39e9c8-b0c3-eb11-bacc-000d3ae864fc',
			'Prairie and Northern-2030-2031-Civil Aviation Document Review',
			'Prairie and Northern',
			'2030-2031',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'01086cc7-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2030-2031-GC Triggered',
			'Prairie and Northern',
			'2030-2031',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'02086cc7-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2030-2031-GC Consignment',
			'Prairie and Northern',
			'2030-2031',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'03086cc7-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2030-2031-MOC Facility Triggered',
			'Prairie and Northern',
			'2030-2031',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'04086cc7-b0c3-eb11-bacc-000d3ae868f0',
			'Prairie and Northern-2030-2031-MOC Facility Opportunity',
			'Prairie and Northern',
			'2030-2031',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'4c047391-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2020-2021-GC Consignment',
			'Quebec',
			'2020-2021',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'4e047391-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2020-2021-GC Undeclared/ Misdeclared',
			'Quebec',
			'2020-2021',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'4f047391-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2020-2021-MOC Facility Triggered',
			'Quebec',
			'2020-2021',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'57047391-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2020-2021-MOC Facility Opportunity',
			'Quebec',
			'2020-2021',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'59047391-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2020-2021-Civil Aviation Document Review',
			'Quebec',
			'2020-2021',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c2ea948e-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2020-2021-GC Triggered',
			'Quebec',
			'2020-2021',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'c6ea948e-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2020-2021-GC Opportunity',
			'Quebec',
			'2020-2021',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'03b17d85-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2021-2022-GC Opportunity',
			'Quebec',
			'2021-2022',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'04b17d85-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2021-2022-MOC Facility Opportunity',
			'Quebec',
			'2021-2022',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'05b17d85-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2021-2022-Civil Aviation Document Review',
			'Quebec',
			'2021-2022',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'a6936182-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2021-2022-GC Triggered',
			'Quebec',
			'2021-2022',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'a8936182-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2021-2022-GC Consignment',
			'Quebec',
			'2021-2022',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'a9936182-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2021-2022-GC Undeclared/ Misdeclared',
			'Quebec',
			'2021-2022',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'89c88488-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2021-2022-MOC Facility Triggered',
			'Quebec',
			'2021-2022',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'2ce07b7f-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2022-2023-GC Triggered',
			'Quebec',
			'2022-2023',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'2de07b7f-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2022-2023-GC Consignment',
			'Quebec',
			'2022-2023',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'2ee07b7f-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2022-2023-GC Undeclared/ Misdeclared',
			'Quebec',
			'2022-2023',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'30e07b7f-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2022-2023-MOC Facility Opportunity',
			'Quebec',
			'2022-2023',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'6400fe7b-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2022-2023-GC Opportunity',
			'Quebec',
			'2022-2023',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'6900fe7b-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2022-2023-MOC Facility Triggered',
			'Quebec',
			'2022-2023',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8f936182-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2022-2023-Civil Aviation Document Review',
			'Quebec',
			'2022-2023',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7d998379-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2023-2024-GC Triggered',
			'Quebec',
			'2023-2024',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'7e998379-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2023-2024-GC Opportunity',
			'Quebec',
			'2023-2024',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'89998379-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2023-2024-GC Consignment',
			'Quebec',
			'2023-2024',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8a998379-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2023-2024-GC Undeclared/ Misdeclared',
			'Quebec',
			'2023-2024',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'90998379-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2023-2024-MOC Facility Triggered',
			'Quebec',
			'2023-2024',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'91998379-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2023-2024-MOC Facility Opportunity',
			'Quebec',
			'2023-2024',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'93998379-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2023-2024-Civil Aviation Document Review',
			'Quebec',
			'2023-2024',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'b0f8758b-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2024-2025-GC Triggered',
			'Quebec',
			'2024-2025',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'b2f8758b-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2024-2025-GC Opportunity',
			'Quebec',
			'2024-2025',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'b5f8758b-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2024-2025-GC Consignment',
			'Quebec',
			'2024-2025',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'baf8758b-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2024-2025-MOC Facility Triggered',
			'Quebec',
			'2024-2025',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'9bc88488-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2024-2025-GC Undeclared/ Misdeclared',
			'Quebec',
			'2024-2025',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'9cc88488-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2024-2025-MOC Facility Opportunity',
			'Quebec',
			'2024-2025',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'9dc88488-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2024-2025-Civil Aviation Document Review',
			'Quebec',
			'2024-2025',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'b4c68173-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2025-2026-GC Triggered',
			'Quebec',
			'2025-2026',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'b9c68173-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2025-2026-MOC Facility Opportunity',
			'Quebec',
			'2025-2026',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'bac68173-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2025-2026-Civil Aviation Document Review',
			'Quebec',
			'2025-2026',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'872fbe75-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2025-2026-GC Opportunity',
			'Quebec',
			'2025-2026',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'892fbe75-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2025-2026-GC Consignment',
			'Quebec',
			'2025-2026',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8c2fbe75-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2025-2026-GC Undeclared/ Misdeclared',
			'Quebec',
			'2025-2026',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'902fbe75-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2025-2026-MOC Facility Triggered',
			'Quebec',
			'2025-2026',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'95998379-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2026-2027-GC Triggered',
			'Quebec',
			'2026-2027',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'99998379-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2026-2027-GC Opportunity',
			'Quebec',
			'2026-2027',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'a1998379-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2026-2027-GC Undeclared/ Misdeclared',
			'Quebec',
			'2026-2027',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'15e07b7f-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2026-2027-MOC Facility Triggered',
			'Quebec',
			'2026-2027',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'18e07b7f-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2026-2027-MOC Facility Opportunity',
			'Quebec',
			'2026-2027',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'5300fe7b-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2026-2027-GC Consignment',
			'Quebec',
			'2026-2027',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'5d00fe7b-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2026-2027-Civil Aviation Document Review',
			'Quebec',
			'2026-2027',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'3ae07b7f-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2027-2028-GC Triggered',
			'Quebec',
			'2027-2028',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'feb07d85-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2027-2028-GC Opportunity',
			'Quebec',
			'2027-2028',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'ffb07d85-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2027-2028-GC Consignment',
			'Quebec',
			'2027-2028',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'00b17d85-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2027-2028-MOC Facility Triggered',
			'Quebec',
			'2027-2028',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'01b17d85-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2027-2028-MOC Facility Opportunity',
			'Quebec',
			'2027-2028',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'9f936182-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2027-2028-GC Undeclared/ Misdeclared',
			'Quebec',
			'2027-2028',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'a3936182-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2027-2028-Civil Aviation Document Review',
			'Quebec',
			'2027-2028',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'33e07b7f-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2028-2029-GC Triggered',
			'Quebec',
			'2028-2029',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'34e07b7f-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2028-2029-GC Opportunity',
			'Quebec',
			'2028-2029',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'35e07b7f-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2028-2029-GC Undeclared/ Misdeclared',
			'Quebec',
			'2028-2029',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'37e07b7f-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2028-2029-MOC Facility Triggered',
			'Quebec',
			'2028-2029',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'38e07b7f-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2028-2029-MOC Facility Opportunity',
			'Quebec',
			'2028-2029',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'97936182-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2028-2029-GC Consignment',
			'Quebec',
			'2028-2029',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'9b936182-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2028-2029-Civil Aviation Document Review',
			'Quebec',
			'2028-2029',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'a8c68173-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2029-2030-GC Triggered',
			'Quebec',
			'2029-2030',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'adc68173-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2029-2030-GC Undeclared/ Misdeclared',
			'Quebec',
			'2029-2030',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'4ee5876f-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2029-2030-GC Opportunity',
			'Quebec',
			'2029-2030',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'4fe5876f-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2029-2030-GC Consignment',
			'Quebec',
			'2029-2030',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'53e5876f-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2029-2030-MOC Facility Triggered',
			'Quebec',
			'2029-2030',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'822fbe75-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2029-2030-MOC Facility Opportunity',
			'Quebec',
			'2029-2030',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'832fbe75-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2029-2030-Civil Aviation Document Review',
			'Quebec',
			'2029-2030',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'08b17d85-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2030-2031-GC Triggered',
			'Quebec',
			'2030-2031',
			'GC Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'0ab17d85-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2030-2031-GC Consignment',
			'Quebec',
			'2030-2031',
			'GC Consignment',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'0bb17d85-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2030-2031-GC Undeclared/ Misdeclared',
			'Quebec',
			'2030-2031',
			'GC Undeclared/ Misdeclared',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'0cb17d85-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2030-2031-MOC Facility Triggered',
			'Quebec',
			'2030-2031',
			'MOC Facility Triggered',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'aef8758b-b0c3-eb11-bacc-000d3ae864fc',
			'Quebec-2030-2031-Civil Aviation Document Review',
			'Quebec',
			'2030-2031',
			'Civil Aviation Document Review',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'8cc88488-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2030-2031-GC Opportunity',
			'Quebec',
			'2030-2031',
			'GC Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
		UNION
		SELECT
			'90c88488-b0c3-eb11-bacc-000d3ae868f0',
			'Quebec-2030-2031-MOC Facility Opportunity',
			'Quebec',
			'2030-2031',
			'MOC Facility Opportunity',
			'0',
			'0',
			'0',
			'0',
			'0'
	) T1;


--JOIN TO FISCAL YEAR AND REGION SOURCE TABLES TO GET THEIR IDS
SELECT
	*
FROM
	#SOURCE__UNPLANNED_FORECAST UF
	JOIN SOURCE__FISCAL_YEAR FY ON UF.ovs_fiscalyearname = FY.tc_name
	JOIN STAGING__TERRITORY region ON uf.ovs_regionname = region.ovs_territorynameenglish;


--insert massaged records into the staging table
INSERT INTO
	STAGING__UNPLANNED_FORECAST (
		id,
		[ovs_name],
		[ovs_regionname],
		[ovs_fiscalyearname],
		[ovs_oversighttype],
		[ovs_q1],
		[ovs_q2],
		[ovs_q3],
		[ovs_q4],
		[ovs_forecast]
	)
SELECT
		cast(UF.id as uniqueidentifier),
		[ovs_name],
		[ovs_regionname],
		[ovs_fiscalyearname],
		[ovs_oversighttype],
		[ovs_q1],
		[ovs_q2],
		[ovs_q3],
		[ovs_q4],
		[ovs_forecast]
FROM
	#SOURCE__UNPLANNED_FORECAST UF
	JOIN SOURCE__FISCAL_YEAR FY ON UF.ovs_fiscalyearname = FY.tc_name
	JOIN STAGING__TERRITORY region ON uf.ovs_regionname = region.ovs_territorynameenglish;
