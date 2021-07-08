-----------------------------------------------------------------
-- Provide the value for the following parameters
DECLARE @schema nvarchar(32) ='dbo'
-----------------------------------------------------------------

DECLARE @truncateSQL nvarchar(max) = '';
DECLARE @countSQL nvarchar(max) = '';

SELECT 
@truncateSQL += 'TRUNCATE TABLE ' + QUOTENAME([TABLE_SCHEMA]) + '.' + QUOTENAME([TABLE_NAME]) + ';' + CHAR(10),
@countSQL += 'SELECT COUNT(*) RECORD_COUNT FROM ' + QUOTENAME([TABLE_SCHEMA]) + '.' + QUOTENAME([TABLE_NAME]) + ' UNION;' + CHAR(10)
FROM [INFORMATION_SCHEMA].[TABLES]
WHERE [TABLE_TYPE] = 'BASE TABLE' AND [TABLE_SCHEMA]= @schema
AND 
([TABLE_NAME] like 'ERRORS_' + '%' OR
 [TABLE_NAME] like 'SSIS_' + '%' OR
 [TABLE_NAME] like 'CRM_' + '%' OR
 [TABLE_NAME] like 'STAGING_' + '%');

PRINT @truncateSQL
EXEC SP_EXECUTESQL @truncateSQL; --WILL EXECUTE NO WARNING! LOL