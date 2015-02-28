

--CREATE PROCEDURE CreateProcedureDefinition
DECLARE    @TABLE_NAME VARCHAR(50) = 'Uye'

DECLARE @PFIX VARCHAR(50) = 'Sil'

DECLARE @DEFINITION VARCHAR(MAX) = CHAR(13) + '--' + CHAR(13) + 'GO' + CHAR(13) +  
    'CREATE PROCEDURE ' + @TABLE_NAME + @PFIX + CHAR(13) + 
    '  AS' + CHAR(13)

SELECT @DEFINITION

GO


ALTER FUNCTION dbo.CreateProcedureDefinition (
         @TABLE_NAME VARCHAR(50)
        ,@PFIX VARCHAR(50)
        --,@VARIABLE_DEFS  VARCHAR(MAX)
        --,@COLUMNS        VARCHAR(MAX)
        --,@VALUES         VARCHAR(MAX)

    )
  RETURNS VARCHAR(MAX)
  AS
    BEGIN
    --@TABLE_NAME VARCHAR(50) --= 'Uye'
    --@PFIX VARCHAR(50) --= 'Sil'

    DECLARE @DEFINITION VARCHAR(MAX)
    SET @DEFINITION = CHAR(13) + '--' + CHAR(13) + 'GO' + CHAR(13) +  
        'CREATE PROCEDURE ' + @TABLE_NAME + @PFIX + CHAR(13) + 
        '  AS' + CHAR(13)
        RETURN @DEFINITION
    END


SELECT dbo.CreateProcedureDefinition('Uye', 'Kayit') [Code]
SELECT dbo.CreateProcedureDefinition('Uye', 'Guncelle') [Code]

SELECT * FROM v_get_column_names


SELECT dbo.CreateProcedureDefinition('Uye', 'Kayit') [Code]


--DECLARE @DELETE         VARCHAR(MAX) = 'DELETE FROM ' + @TABLE_NAME + ' WHERE ' + @TABLE_NAME + 'ID = @ID' 
--SELECT @DELETE

---- CREATE TRIGGER FOR DELETE EVENTS
--/*
--CREATE TRIGGER @TABLE_NAME+ 'Sil'
--  ON @TABLE_NAME
--  INSTEAD OF DELETE
--  AS
--    DECLARE @ID INT
--    SELECT @ID = @TABLE_NAME + 'ID' FROM DELETED  
--    UPDATE @TABLE_NAME SET (Silindi = 1) WHERE @TABLE_NAME + 'ID = @ID' 
--*/


