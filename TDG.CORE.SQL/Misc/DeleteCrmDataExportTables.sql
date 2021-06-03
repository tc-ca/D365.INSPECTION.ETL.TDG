-----------------------------------------------------------------
-- Provide the value for the following parameters
DECLARE @prefix nvarchar(32) ='tdgdata_'
DECLARE @schema nvarchar(32) ='dbo'
-----------------------------------------------------------------

DECLARE @sql nvarchar(max) = '';

SELECT @sql += 'DROP TABLE ' + QUOTENAME([TABLE_SCHEMA]) + '.' + QUOTENAME([TABLE_NAME]) + ';'
FROM [INFORMATION_SCHEMA].[TABLES]
WHERE [TABLE_TYPE] = 'BASE TABLE' AND [TABLE_NAME] like @prefix + '_%' AND [TABLE_SCHEMA]= @schema;

PRINT @sql
EXEC SP_EXECUTESQL @sql;

PRINT 'Finished dropping all tables. Starting to drop all stored procedures now.'

SELECT @sql='';
SELECT @sql += 'DROP PROCEDURE ' + QUOTENAME([ROUTINE_SCHEMA]) + '.' + QUOTENAME([ROUTINE_NAME]) + ';'
FROM [INFORMATION_SCHEMA].[ROUTINES]
WHERE [ROUTINE_TYPE] = 'PROCEDURE' AND [ROUTINE_NAME] like @prefix + '_%' AND [ROUTINE_SCHEMA]= @schema;
PRINT @sql
EXEC SP_EXECUTESQL @sql;

PRINT 'Finished dropping all stored procedures. Starting to drop all types now.'

SELECT @sql=''; 
SELECT @sql += 'DROP TYPE ' + QUOTENAME(SCHEMA_NAME([SCHEMA_ID])) + '.' +  QUOTENAME([NAME]) + ';'
FROM SYS.TYPES
WHERE is_user_defined = 1 AND [NAME] LIKE @prefix + '_%' AND [SCHEMA_ID]=SCHEMA_ID(@schema);

PRINT @sql
EXEC SP_EXECUTESQL @sql;