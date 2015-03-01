ALTER FUNCTION dbo.CreateDeleteProcedure (
         @TABLE_NAME        VARCHAR(50)

    )
  RETURNS VARCHAR(MAX)
  AS
    BEGIN
    --@TABLE_NAME VARCHAR(50) --= 'Uye'
    --@PFIX VARCHAR(50) --= 'Sil'
    DECLARE @SUFFIX VARCHAR(10) = 'Sil'
    DECLARE @PROCEDURE_NAME VARCHAR(100) = @TABLE_NAME + @SUFFIX

    DECLARE @CODE VARCHAR(MAX) = CHAR(13)

    --SET @CODE += 'IF (OBJECT_ID(''' + @PROCEDURE_NAME + ''') IS NOT NULL )' + CHAR(13)
    --SET @CODE += '    BEGIN DROP PROCEDURE ' + @PROCEDURE_NAME + ' END' + CHAR(13)
    SET @CODE += 'GO --' + CHAR(13)

    SET @CODE +=  'CREATE PROCEDURE ' + @PROCEDURE_NAME + CHAR(13)
    SET @CODE += '    @ID  BIGINT' + CHAR(13)
    SET @CODE += '  AS' + CHAR(13) 
    SET @CODE += 'DELETE FROM ' + @TABLE_NAME + ' WHERE ' + @TABLE_NAME + 'ID = @ID'
    SET @CODE += CHAR(13) + '--------------------------------------------------'
        RETURN @CODE
    END

