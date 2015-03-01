ALTER FUNCTION dbo.CreateDeleteTrigger (
         @TABLE_NAME        VARCHAR(50)

    )
    RETURNS VARCHAR(MAX)
  AS
  BEGIN
    DECLARE @SUFFIX VARCHAR(10) = 'TriggerSil'
    DECLARE @CODE VARCHAR(MAX) = CHAR(13)
    DECLARE @PROCEDURE_NAME VARCHAR(100) = @TABLE_NAME + @SUFFIX

    --SET @CODE += 'IF (OBJECT_ID(''' + @PROCEDURE_NAME + ''') IS NOT NULL )' + CHAR(13)
    --SET @CODE += '    BEGIN DROP PROCEDURE ' + @PROCEDURE_NAME + ' END' + CHAR(13)
    SET @CODE += 'GO --' + CHAR(13)

    SET @CODE +=  'CREATE TRIGGER ' + @PROCEDURE_NAME + CHAR(13)
    SET @CODE += '    ON ' + @TABLE_NAME + CHAR(13)
    SET @CODE += ' INSTEAD OF DELETE' + CHAR(13)
    SET @CODE += '  AS' + CHAR(13) 
    SET @CODE += 'DECLARE @ID BIGINT' + CHAR(13)
    SET @CODE += 'SET @ID = (SELECT ' + @TABLE_NAME+'ID FROM DELETED) ' + CHAR(13)
    SET @CODE += 'UPDATE ' + @TABLE_NAME + ' SET Silindi = 1 WHERE ' + @TABLE_NAME + 'ID = @ID' +  CHAR(13)
    SET @CODE +=  '--------------------------------------------------'
        RETURN @CODE
    END


go
--SELECT dbo.CreateDeleteTrigger('Uye')
