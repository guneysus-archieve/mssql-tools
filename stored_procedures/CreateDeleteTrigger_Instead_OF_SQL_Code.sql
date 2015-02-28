ALTER FUNCTION dbo.CreateDeleteTrigger (
         @TABLE_NAME        VARCHAR(50)

    )
    RETURNS VARCHAR(MAX)
  AS
  BEGIN
    DECLARE @PFIX VARCHAR(10) = 'TriggerSil'
    DECLARE @CODE VARCHAR(MAX) = ''
    SET @CODE += CHAR(13) + 'GO --' + CHAR(13)
    SET @CODE +=  'CREATE TRIGGER ' + @TABLE_NAME + @PFIX + CHAR(13)
    SET @CODE += '    ON ' + @TABLE_NAME + CHAR(13)
    SET @CODE += ' INSTEAD OF DELETE' + CHAR(13)
    SET @CODE += '  AS' + CHAR(13) 
    SET @CODE += 'DECLARE @ID BIGINT' + CHAR(13)
    SET @CODE += 'SET @ID = (SELECT ' + @TABLE_NAME+'ID FROM DELETED) ' + CHAR(13)
    SET @CODE += 'UPDATE ' + @TABLE_NAME + ' SET Silindi = 1 WHERE ' + @TABLE_NAME + 'ID = @ID'
    SET @CODE += CHAR(13) + '--------------------------------------------------'
        RETURN @CODE
    END


go
--SELECT dbo.CreateDeleteTrigger('Uye')