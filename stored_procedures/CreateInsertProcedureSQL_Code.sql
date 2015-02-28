ALTER FUNCTION dbo.CreateInsertProcedure (
         @TABLE_NAME        VARCHAR(50)
        ,@VARIABLE_DEFS     VARCHAR(MAX)
        ,@COLUMNS           VARCHAR(MAX)
        ,@VALUES            VARCHAR(MAX)

    )
  RETURNS VARCHAR(MAX)
  AS
    BEGIN
    --@TABLE_NAME VARCHAR(50) --= 'Uye'
    --@PFIX VARCHAR(50) --= 'Sil'
    DECLARE @PFIX VARCHAR(10) = 'Kayit'

    DECLARE @CODE VARCHAR(MAX) = ''
    SET @CODE += CHAR(13) + 'GO --' + CHAR(13)
    SET @CODE +=  'CREATE PROCEDURE ' + @TABLE_NAME + @PFIX + CHAR(13)
    SET @CODE += @VARIABLE_DEFS
    SET @CODE += '  AS' + CHAR(13) 
    SET @CODE += 'INSERT INTO ' + @TABLE_NAME + CHAR(13) + ' '
    SET @CODE += @COLUMNS + ' VALUES ' + CHAR(13) 
    SET @CODE += @VALUES
    SET @CODE += '--------------------------------------------------'
        RETURN @CODE
    END