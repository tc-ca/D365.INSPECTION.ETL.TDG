DROP FUNCTION IF EXISTS [dbo].[ReplaceASCII];
GO

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


--Alphabetic only:

--SELECT dbo.fn_StripCharacters('a1!s2@d3#f4$', '^a-z')

--Numeric only:

--SELECT dbo.fn_StripCharacters('a1!s2@d3#f4$', '^0-9')

--Alphanumeric only:

--SELECT dbo.fn_StripCharacters('a1!s2@d3#f4$', '^a-z0-9')

--Non-alphanumeric:

--SELECT dbo.fn_StripCharacters('a1!s2@d3#f4$', 'a-z0-9')

CREATE FUNCTION [dbo].[fn_StripCharacters]
(
    @String NVARCHAR(MAX), 
    @MatchExpression VARCHAR(255)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    SET @MatchExpression =  '%['+@MatchExpression+']%'

    WHILE PatIndex(@MatchExpression, @String) > 0
        SET @String = Stuff(@String, PatIndex(@MatchExpression, @String), 1, '')

    RETURN @String

END