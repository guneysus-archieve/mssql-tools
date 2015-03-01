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
    DECLARE @SUFFIX VARCHAR(10) = 'Guncelle'
    DECLARE @PROCEDURE_NAME VARCHAR(100) = @TABLE_NAME + @SUFFIX
    DECLARE @CODE VARCHAR(MAX) =  CHAR(13)

    --SET @CODE += 'IF (OBJECT_ID(''' + @PROCEDURE_NAME + ''') IS NOT NULL )' + CHAR(13)
    --SET @CODE += '    BEGIN DROP PROCEDURE ' + @PROCEDURE_NAME + ' END' + CHAR(13)
    SET @CODE += 'GO --' + CHAR(13)

    SET @CODE +=  'CREATE PROCEDURE ' + @PROCEDURE_NAME + CHAR(13)
    SET @CODE += @VARIABLE_DEFS
    SET @CODE += '  AS' + CHAR(13) 
    SET @CODE += '    UPDATE ' + @TABLE_NAME + CHAR(13) + ' SET' + CHAR(13)
    SET @CODE += @UPDATE_VARS 
    SET @CODE += ' WHERE ' + @TABLE_NAME + 'ID = @ID' + CHAR(13)
    SET @CODE += '--------------------------------------------------'
        RETURN @CODE
    END
