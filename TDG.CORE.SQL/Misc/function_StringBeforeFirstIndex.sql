DROP FUNCTION IF EXISTS dbo.StringBeforeFirstIndex;
GO
CREATE FUNCTION dbo.StringBeforeFirstIndex(@source NVARCHAR(MAX), @pattern char)
RETURNS NVARCHAR(MAX) 
BEGIN  
	DECLARE @ret NVARCHAR(MAX);  
	DECLARE @lastindex int;  
	DECLARE @patternlength INT = LEN(@pattern);

	SELECT @lastindex = CHARINDEX(@pattern, @source, @patternlength);
	SELECT @ret = left(@source, len(@source) - @lastindex);

	RETURN @ret;
END;  
GO