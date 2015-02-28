ALTER FUNCTION dbo.CreateUpdateProcedure (
          @TABLE_NAME        VARCHAR(50)
         ,@VARIABLE_DEFS    VARCHAR(MAX)
         ,@UPDATE_VARS       VARCHAR(MAX)
    )
  RETURNS VARCHAR(MAX)
  AS
    BEGIN
    --@TABLE_NAME VARCHAR(50) --= 'Uye'
    --@PFIX VARCHAR(50) --= 'Sil'
    DECLARE @PFIX VARCHAR(10) = 'Guncelle'

    DECLARE @CODE VARCHAR(MAX) = ''
    SET @CODE += CHAR(13) + 'GO -- ' + CHAR(13)
    SET @CODE +=  'CREATE PROCEDURE ' + @TABLE_NAME + @PFIX + CHAR(13)
    SET @CODE += @VARIABLE_DEFS
    SET @CODE += '  AS' + CHAR(13) 
    SET @CODE += '    UPDATE ' + @TABLE_NAME + CHAR(13) + ' SET' + CHAR(13)
    SET @CODE += @UPDATE_VARS 
    SET @CODE += ' WHERE ' + @TABLE_NAME + 'ID = @ID'
    SET @CODE += CHAR(13) + '--------------------------------------------------'
        RETURN @CODE
    END

