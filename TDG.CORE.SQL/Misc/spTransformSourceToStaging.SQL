
--EXAMPLE:
--update tablename and primary key column name and call with exec which just runs raw string as sql, perfect for sql injection :)

--exec spTransformSourceToStaging @tableName = 'TYRATIONALE', @pkColumnName = 'ovs_tyrationalid';


DROP PROCEDURE IF EXISTS spTransformSourceToStaging;
GO
CREATE PROCEDURE spTransformSourceToStaging
@schema nvarchar(32) ='dbo',
@sourcePrefix nvarchar(32) = 'SOURCE__',
@stagingPrefix NVARCHAR(32) = 'STAGING__',
@tableName nvarchar(max) = '',
@pkColumnName NVARCHAR(250) = ''
AS
    BEGIN
		
		DECLARE @__SOURCE  NVARCHAR(MAX) = @sourcePrefix + @tableName;
		DECLARE @__STAGING NVARCHAR(MAX) = @stagingPrefix + @tableName;

		DECLARE @innerSQL NVARCHAR(MAX) = '';
		DECLARE @updateSQL nvarchar(max) = '';
		DECLARE @insertSQL NVARCHAR(MAX) = '';
		DECLARE @upsertSQL NVARCHAR(MAX) = '';

		SELECT 
		@innerSQL +=
		',' + QUOTENAME(C.COLUMN_NAME) + ' = T2.' + QUOTENAME(C.COLUMN_NAME) + CHAR(10)
		FROM [INFORMATION_SCHEMA].[TABLES] T
		JOIN [INFORMATION_SCHEMA].[COLUMNS] C ON T.TABLE_NAME = C.TABLE_NAME AND T.TABLE_SCHEMA = C.TABLE_SCHEMA AND T.TABLE_CATALOG = C.TABLE_CATALOG
		WHERE [TABLE_TYPE] = 'BASE TABLE' AND T.[TABLE_SCHEMA]= @schema and T.[TABLE_NAME] = @__STAGING;
	
		SELECT @innerSQL = RIGHT(@innerSQL, LEN(@innerSQL) - 1)

		SELECT @updateSQL = 'UPDATE ' + @__STAGING + ' WITH (UPDLOCK, SERIALIZABLE)' + CHAR(10) + ' SET ' + @innerSQL + ' FROM ' + @__SOURCE + ' T1 JOIN ' + @__STAGING + ' T2 ON T1.' + @pkColumnName + ' = T2.' + @pkColumnName;

		SELECT 
		@insertSQL += ',' + QUOTENAME(C.COLUMN_NAME) + CHAR(10)
		FROM [INFORMATION_SCHEMA].[TABLES] T
		JOIN [INFORMATION_SCHEMA].[COLUMNS] C ON T.TABLE_NAME = C.TABLE_NAME AND T.TABLE_SCHEMA = C.TABLE_SCHEMA AND T.TABLE_CATALOG = C.TABLE_CATALOG
		WHERE [TABLE_TYPE] = 'BASE TABLE' AND T.[TABLE_SCHEMA]= @schema and T.[TABLE_NAME] = @__STAGING;

		SELECT @insertSQL = 
		'INSERT INTO ' + @__STAGING + CHAR(10) + ' SELECT ' + RIGHT(@insertSQL, LEN(@insertSQL) - 1) + ' FROM ' + @__SOURCE;

		SELECT 
		@upsertSQL += @updateSQL + CHAR(10) + CHAR(10) + 'IF @@ROWCOUNT = 0 ' + CHAR(10) + 'BEGIN ' + CHAR(10) + @insertSQL + CHAR(10) + 'END';

	
		PRINT 
		'COLUMNS FOR UPDATE SQL' + CHAR(10) + 
		'=============================================' + CHAR(10) + 
		@innerSQL + 
		'=============================================' + CHAR(10);
	
		PRINT 
		'UPDATE SQL' + CHAR(10) + 
		'=============================================' + CHAR(10) + 
		@updateSQL +  CHAR(10) +
		'=============================================' + CHAR(10);

		PRINT 
		'INSERT SQL' + CHAR(10) + 
		'=============================================' + CHAR(10) + 
		@insertSQL +  CHAR(10) +
		'=============================================' + CHAR(10);

		PRINT 
		'UPSERT SQL' + CHAR(10) + 
		'=============================================' + CHAR(10) + 
		@upsertSQL +  CHAR(10) +
		'=============================================' + CHAR(10);

		EXECUTE sp_executesql @updateSQL;

		IF @@ROWCOUNT <= 0
		BEGIN 
			PRINT '0 EXISTING ROWS - INSERT';
			EXECUTE sp_executesql @insertSQL;
		END

		DECLARE @SELECTSQL NVARCHAR(MAX) = '';
		SELECT @SELECTSQL = 'SELECT * FROM ' + @__STAGING;
		EXECUTE sp_executesql @SELECTSQL;

	END