IF ( OBJECT_ID( 'CreateAllProceduresForTable') IS NOT NULL )
    BEGIN DROP PROCEDURE CreateAllProceduresForTable END
GO

CREATE PROCEDURE CreateAllProceduresForTable

     @TABLE_NAME VARCHAR(50) --= 'Uye'
    ,@INCLUDE_DELETE     BIT    = 0
    ,@INCLUDE_INSERT     BIT    = 0
    ,@INCLUDE_TRIGGER    BIT    = 0
    ,@INCLUDE_UPDATE     BIT    = 0

AS
    DECLARE @QUERIES_DELETE TABLE ( QUERY VARCHAR(MAX) )
    DECLARE @QUERIES_INSERT TABLE ( QUERY VARCHAR(MAX) )
    DECLARE @QUERIES_TRIGGER TABLE ( QUERY VARCHAR(MAX) )
    DECLARE @QUERIES_UPDATE TABLE ( QUERY VARCHAR(MAX) )

    DECLARE @QUERIES TABLE ( QUERY VARCHAR(MAX) )


    --DECLARE @TABLE_NAME VARCHAR(50) = 'Uye'

    --DECLARE @TABLE_NAME VARCHAR(50) = 'Uye'
    DECLARE @TDATA_TYPES TABLE ( N TINYINT, COLUMN_NAME VARCHAR(MAX), DATA_TYPE VARCHAR(MAX) )


    INSERT INTO @TDATA_TYPES (N, COLUMN_NAME, DATA_TYPE)
    SELECT 
      ROW_NUMBER() OVER( ORDER BY COLUMN_NAME)[N]
      ,COLUMN_NAME
     ,DATA_TYPE
    FROM [DB_DATA_TYPES]
        WHERE TABLE_NAME = @TABLE_NAME

    --SELECT * FROM @TDATA_TYPES

    DECLARE @I INT = 1
    DECLARE @MAX INT = (SELECT MAX(N) FROM @TDATA_TYPES)


    --DECLARE @TABLE_NAME VARCHAR(50) = 'Uye'
    --DECLARE @PFIX VARCHAR(50) = 'Sil'
    --SELECT @PFIX

    --DECLARE @DEFINITION VARCHAR(MAX) = CHAR(13) + '--' + CHAR(13) + 'GO' + CHAR(13) +  
    --    'CREATE PROCEDURE ' + @TABLE_NAME + @PFIX + CHAR(13) + 
    --    '  AS' + CHAR(13)

    --SELECT @DEFINITION

    DECLARE @TEMP_COL       VARCHAR(50)
    DECLARE @TEMP_TYPE      VARCHAR(50)

    DECLARE @VARIABLE_DEFS  VARCHAR(MAX) = '  @ID           BIGINT,' + CHAR(13)
    DECLARE @COLUMNS        VARCHAR(MAX) = '(' + CHAR(13)
    DECLARE @VALUES         VARCHAR(MAX) = '(' + CHAR(13)
    DECLARE @UPDATE_VARS    VARCHAR(MAX) = ''

    --DECLARE @INSERT         VARCHAR(MAX) = 'INSERT INTO ' + @TABLE_NAME + '('
    --DECLARE @UPDATE         VARCHAR(MAX) = 'UPDATE ' + @TABLE_NAME
    --SELECT * FROM @TDATA_TYPES 


    WHILE ( @I < @MAX) 
    BEGIN
        SET @TEMP_COL = (SELECT COLUMN_NAME FROM @TDATA_TYPES WHERE N = @I)
        SET @TEMP_TYPE = (SELECT DATA_TYPE FROM @TDATA_TYPES WHERE N = @I)

        IF NOT ( @TEMP_COL = @TABLE_NAME + 'ID' OR @TEMP_COL = 'Silindi' )
            BEGIN

                SET @VARIABLE_DEFS += '    @' + @TEMP_COL + ' ' + @TEMP_TYPE + ',' + CHAR(13)
                SET @COLUMNS +='    ' + @TEMP_COL + ', ' + CHAR(13)
                SET @VALUES += '    @' + @TEMP_COL + ',' + CHAR(13)
                SET @UPDATE_VARS += '    ' + @TEMP_COL + ' = @' + @TEMP_COL + ',' + CHAR(13)

                --SELECT @VARIABLE_DEFS += '@' + COLUMN_NAME + ' ' + DATA_TYPE + ',' + CHAR(13)
                --    FROM @TDATA_TYPES
                --    WHERE N = @I
            
                --SELECT @COLUMNS += COLUMN_NAME + ', ' + CHAR(13)
                --    FROM @TDATA_TYPES
                --    WHERE N = @I

                --SELECT @VALUES += '@' + COLUMN_NAME + ',' + CHAR(13)
                --    FROM @TDATA_TYPES
                --    WHERE N = @I

            END

        --SELECT * FROM @TDATA_TYPES WHERE N = @I
        SET @I += 1
    END

    SELECT @VARIABLE_DEFS += '    @' + COLUMN_NAME + ' ' + DATA_TYPE + CHAR(13) + CHAR(13)   
        FROM @TDATA_TYPES 
        WHERE N = @MAX

    SELECT @COLUMNS += COLUMN_NAME +  CHAR(13) + ')' + CHAR(13)   
        FROM @TDATA_TYPES 
        WHERE N = @MAX

    SELECT @VALUES += '    @' + COLUMN_NAME +   CHAR(13) + ')' + CHAR(13)   
        FROM @TDATA_TYPES 
        WHERE N = @MAX

    SELECT @UPDATE_VARS += COLUMN_NAME  + ' = @'+ COLUMN_NAME    
        FROM @TDATA_TYPES 
        WHERE N = @MAX


    --SELECT @VARIABLE_DEFS   [VARIABLE DEFS]
    --SELECT @COLUMNS         [COLUMNS]
    --SELECT @VALUES          [VALUES]

    --SELECT '  @' + COLUMN_NAME + ' ' + DATA_TYPE + ',' [COLUMN_NAME] 
    --    FROM [DB_DATA_TYPES]
    --    WHERE TABLE_NAME = 'Uye'


    --SELECT dbo.CreateProcedureDefinition('Uye', 'Kayit') [Code]

    IF ( @INCLUDE_DELETE = 1)  
        BEGIN  
            INSERT INTO @QUERIES_DELETE (QUERY)
                SELECT dbo.CreateDeleteProcedure(@TABLE_NAME)
            INSERT INTO @QUERIES  SELECT * FROM @QUERIES_DELETE 
        END

    IF ( @INCLUDE_INSERT = 1)  
        BEGIN  
            INSERT INTO @QUERIES_INSERT (QUERY)
                SELECT dbo.CreateInsertProcedure(@TABLE_NAME, @VARIABLE_DEFS, @COLUMNS, @VALUES)[QUERY]
            INSERT INTO @QUERIES  SELECT * FROM @QUERIES_INSERT 
        END

    IF ( @INCLUDE_TRIGGER = 1)  
        BEGIN  
        INSERT INTO @QUERIES_TRIGGER (QUERY)
            SELECT dbo.CreateDeleteTrigger(@TABLE_NAME)
            INSERT INTO @QUERIES  SELECT * FROM @QUERIES_TRIGGER 
        END

    IF ( @INCLUDE_UPDATE = 1)  
        BEGIN
            INSERT INTO @QUERIES_UPDATE (QUERY)
                SELECT dbo.CreateUpdateProcedure(@TABLE_NAME, @VARIABLE_DEFS, @UPDATE_VARS)         
            INSERT INTO @QUERIES  SELECT * FROM @QUERIES_UPDATE 
        END

    --@INCLUDE_DELETE     BIT    = 0
    --@INCLUDE_INSERT     BIT    = 0
    --@INCLUDE_TRIGGER    BIT    = 0
    --@INCLUDE_UPDATE     BIT    = 0

    SELECT * FROM @QUERIES


GO
DECLARE @FOO TABLE (QUERY VARCHAR(MAX))

INSERT INTO @FOO 
EXEC CreateAllProceduresForTable 'FilmIndex',1,1,1,1

SELECT * FROM @FOO