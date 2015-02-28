ALTER FUNCTION dbo.CreateDeleteProcedure (
         @TABLE_NAME        VARCHAR(50)

    )
  RETURNS VARCHAR(MAX)
  AS
    BEGIN
    --@TABLE_NAME VARCHAR(50) --= 'Uye'
    --@PFIX VARCHAR(50) --= 'Sil'
    DECLARE @PFIX VARCHAR(10) = 'Sil'

    DECLARE @CODE VARCHAR(MAX) = ''
    SET @CODE += CHAR(13) + 'GO --' + CHAR(13)
    SET @CODE +=  'CREATE PROCEDURE ' + @TABLE_NAME + @PFIX + CHAR(13)
    SET @CODE += '    @ID  BIGINT' + CHAR(13)
    SET @CODE += '  AS' + CHAR(13) 
    SET @CODE += 'DELETE FROM ' + @TABLE_NAME + ' WHERE ' + @TABLE_NAME + 'ID = @ID'
    SET @CODE += CHAR(13) + '--------------------------------------------------'
        RETURN @CODE
    END

