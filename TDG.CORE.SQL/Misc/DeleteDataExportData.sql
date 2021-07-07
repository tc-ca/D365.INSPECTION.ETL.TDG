-----------------------------------------------------------------
-- Provide the value for the following parameters
DECLARE @schema nvarchar(32) ='dbo'
-----------------------------------------------------------------

DECLARE @truncateSQL nvarchar(max) = '';

SELECT 
@truncateSQL += 'TRUNCATE TABLE ' + QUOTENAME([TABLE_SCHEMA]) + '.' + QUOTENAME([TABLE_NAME]) + ';' + CHAR(10)
FROM [INFORMATION_SCHEMA].[TABLES]
WHERE [TABLE_TYPE] = 'BASE TABLE' AND [TABLE_SCHEMA]= @schema
AND 
([TABLE_NAME] like 'tdgdata_' + '%');

PRINT @truncateSQL
EXEC SP_EXECUTESQL @truncateSQL; --WILL EXECUTE NO WARNING! LOL


DECLARE @countSQL nvarchar(max) = '';

SELECT 
@countSQL += 'SELECT COUNT(*) RECORD_COUNT FROM ' + QUOTENAME([TABLE_SCHEMA]) + '.' + QUOTENAME([TABLE_NAME]) + ' UNION' + CHAR(10)
FROM [INFORMATION_SCHEMA].[TABLES]
WHERE [TABLE_TYPE] = 'BASE TABLE' AND [TABLE_SCHEMA]= @schema
AND 
([TABLE_NAME] like 'tdgdata_' + '%')

DECLARE @outercountSQL nvarchar(max) = '';
SELECT @outercountSQL = 'SELECT SUM(RECORD_COUNT) RECORD_COUNT FROM (' + dbo.StringBeforeLastIndex(@countSQL, 'UNION') + ') RECORD_COUNTS';

PRINT @outercountSQL;
EXEC SP_EXECUTESQL @outercountSQL;