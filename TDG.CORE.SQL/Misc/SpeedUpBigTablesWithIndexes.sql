--SELECT * FROM (

--	SELECT 
--		t.NAME AS TableName,
--		p.rows AS RowCounts,
--		SUM(a.total_pages) AS TotalPages, 
--		SUM(a.used_pages) AS UsedPages, 
--		(SUM(a.total_pages) - SUM(a.used_pages)) AS UnusedPages
--	FROM 
--		sys.tables t
--	INNER JOIN      
--		sys.indexes i ON t.OBJECT_ID = i.object_id
--	INNER JOIN 
--		sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
--	INNER JOIN 
--		sys.allocation_units a ON p.partition_id = a.container_id
--	WHERE t.is_ms_shipped = 0
--		AND i.OBJECT_ID > 255 
--	GROUP BY 
--		t.Name, p.Rows
--) T
--ORDER BY TotalPages DESC, TableName;

--ADD UNIQUE INDEX ON YD041
--=============================================================
ALTER TABLE
  dbo.YD041_INSPECTION
ALTER COLUMN
  ACTIVITY_ID 
    DECIMAL(29,0) NOT NULL;
GO

ALTER TABLE dbo.YD041_INSPECTION
    DROP CONSTRAINT IF EXISTS YD041_INSPECTION_ACTIVITYID;
GO

ALTER TABLE dbo.YD041_INSPECTION
    ADD CONSTRAINT YD041_INSPECTION_ACTIVITYID 
	   PRIMARY KEY NONCLUSTERED(ACTIVITY_ID);
--=============================================================

--TD002_DANGEROUS_GOOD_PK
--=============================================================
ALTER TABLE
  dbo.TD002_DANGEROUS_GOOD
ALTER COLUMN
  UN_NUMBER_ID 
    varchar(7) NOT NULL;
GO

ALTER TABLE
  dbo.TD002_DANGEROUS_GOOD
ALTER COLUMN
  UN_SEQ_NUM 
    DECIMAL(29,0) NOT NULL;
GO

ALTER TABLE dbo.TD002_DANGEROUS_GOOD
    DROP CONSTRAINT TD002_DANGEROUS_GOOD_PK 
GO

ALTER TABLE dbo.TD002_DANGEROUS_GOOD
    ADD CONSTRAINT TD002_DANGEROUS_GOOD_PK 
	   PRIMARY KEY NONCLUSTERED (UN_NUMBER_ID, UN_SEQ_NUM);
GO

ALTER TABLE TD002_DANGEROUS_GOOD
	ADD CONSTRAINT TD002_DANGEROUS_GOOD_AK 
		UNIQUE (UN_NUMBER_ID, UN_SEQ_NUM);
GO
--=============================================================


--YD031_STAKEHOLDER_DG_PROFILE
--=============================================================
ALTER TABLE
  dbo.YD031_STAKEHOLDER_DG_PROFILE
ALTER COLUMN
  STKHLDR_DG_PROFILE_SEQ_NUM
    DECIMAL(29,0) NOT NULL;
GO

ALTER TABLE dbo.YD031_STAKEHOLDER_DG_PROFILE
    DROP CONSTRAINT IF EXISTS YD031_STAKEHOLDER_DG_PROFILE_PK 
GO

ALTER TABLE dbo.YD031_STAKEHOLDER_DG_PROFILE
    ADD CONSTRAINT YD031_STAKEHOLDER_DG_PROFILE_PK 
	   PRIMARY KEY NONCLUSTERED (STKHLDR_DG_PROFILE_SEQ_NUM);
GO

ALTER TABLE dbo.YD031_STAKEHOLDER_DG_PROFILE
    DROP CONSTRAINT IF EXISTS YD031_STAKEHOLDER_DG_PROFILE_AK 
GO

ALTER TABLE YD031_STAKEHOLDER_DG_PROFILE
	ADD CONSTRAINT YD031_STAKEHOLDER_DG_PROFILE_AK 
		UNIQUE (STKHLDR_DG_PROFILE_SEQ_NUM);
GO

DROP INDEX IF EXISTS  IX_YD031_STAKEHOLDER_DG_PROFILE_UN_NUMBER_ID ON YD031_STAKEHOLDER_DG_PROFILE;
GO
CREATE INDEX IX_YD031_STAKEHOLDER_DG_PROFILE_UN_NUMBER_ID
    ON dbo.YD031_STAKEHOLDER_DG_PROFILE(UN_NUMBER_ID);
GO

DROP INDEX IF EXISTS  IX_YD031_STAKEHOLDER_DG_PROFILE ON YD031_STAKEHOLDER_DG_PROFILE;
GO
CREATE CLUSTERED INDEX IX_YD031_STAKEHOLDER_DG_PROFILE
    ON dbo.YD031_STAKEHOLDER_DG_PROFILE(STAKEHOLDER_ID,UN_NUMBER_ID,MOC_TYPE_CD,DG_RANK_NUM,DATE_DELETED_DTE);
GO

DROP INDEX IF EXISTS  IX_YD031_STAKEHOLDER_DG_PROFILE_STAKEHOLDER_ID ON YD031_STAKEHOLDER_DG_PROFILE;
GO
CREATE INDEX IX_YD031_STAKEHOLDER_DG_PROFILE_STAKEHOLDER_ID
    ON dbo.YD031_STAKEHOLDER_DG_PROFILE(STAKEHOLDER_ID);
GO
--=============================================================

--ADD INDEX TO STAGING__ACCOUNT
DROP INDEX IF EXISTS IX_STAGING__ACCOUNT_OVS_IISID ON STAGING__ACCOUNT;
GO
CREATE CLUSTERED INDEX IX_STAGING__ACCOUNT_OVS_IISID
    ON dbo.STAGING__ACCOUNT(OVS_IISID);
GO

--ADD INDEX TO STAGING_UN_NUMBERS
DROP INDEX IF EXISTS IX_STAGING_UN_NUMBERS_TDG_NAME ON STAGING_UN_NUMBERS;
GO
CREATE CLUSTERED INDEX IX_STAGING_UN_NUMBERS_TDG_NAME
    ON dbo.STAGING_UN_NUMBERS(TDG_NAME);
GO