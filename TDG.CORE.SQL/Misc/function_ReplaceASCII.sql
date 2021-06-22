CREATE FUNCTION [dbo].[ReplaceASCII](@inputString VARCHAR(8000))
returns varchar(50) as
begin

	declare @i int = 1;  -- must start from 1, as SubString is 1-based
	declare @OriginalString varchar(100) = @inputString Collate SQL_Latin1_General_CP1253_CI_AI;
	declare @ModifiedString varchar(100) = '';

	while @i <= Len(@OriginalString)
	begin
	if SubString(@OriginalString, @i, 1) like '[a-Z]' or SubString(@OriginalString, @i, 1) like ' '
	begin
		set @ModifiedString = @ModifiedString + SubString(@OriginalString, @i, 1);
	end
	set @i = @i + 1;
	end

	return @ModifiedString

end