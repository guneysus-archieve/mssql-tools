-- USE [filmDukkaniDB_master]
GO
/****** Object:  UserDefinedFunction [dbo].[CreateDeleteProcedure]    Script Date: 1.3.2015 17:54:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CreateDeleteProcedure] (
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


GO
/****** Object:  UserDefinedFunction [dbo].[CreateDeleteTrigger]    Script Date: 1.3.2015 17:54:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CreateDeleteTrigger] (
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



GO
/****** Object:  UserDefinedFunction [dbo].[CreateInsertProcedure]    Script Date: 1.3.2015 17:54:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CreateInsertProcedure] (
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
    DECLARE @SUFFIX VARCHAR(10) = 'Kayit'
    DECLARE @PROCEDURE_NAME VARCHAR(100) = @TABLE_NAME + @SUFFIX

    DECLARE @CODE VARCHAR(MAX) = CHAR(13)

    --SET @CODE += 'IF (OBJECT_ID(''' + @PROCEDURE_NAME + ''') IS NOT NULL )' + CHAR(13)
    --SET @CODE += '    BEGIN DROP PROCEDURE ' + @PROCEDURE_NAME + ' END' + CHAR(13)
    SET @CODE += 'GO --' + CHAR(13)

    SET @CODE +=  'CREATE PROCEDURE ' + @PROCEDURE_NAME + CHAR(13)
    SET @CODE += @VARIABLE_DEFS
    SET @CODE += '  AS' + CHAR(13) 
    SET @CODE += 'INSERT INTO ' + @TABLE_NAME + CHAR(13) + ' '
    SET @CODE += @COLUMNS + ' VALUES ' + CHAR(13) 
    SET @CODE += @VALUES
    SET @CODE += '--------------------------------------------------'
        RETURN @CODE
    END
GO
/****** Object:  UserDefinedFunction [dbo].[CreateUpdateProcedure]    Script Date: 1.3.2015 17:54:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CreateUpdateProcedure] (
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

GO
/****** Object:  View [dbo].[DB_DATA_TYPES]    Script Date: 1.3.2015 17:54:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[DB_DATA_TYPES] 
--@TABLO_AD varchar(MAX)
AS
SELECT
    TABLE_NAME
    ,COLUMN_NAME
    --,DATA_TYPE
    --,CHARACTER_MAXIMUM_LENGTH
    --,CAST ( CASE 
    --    WHEN CHARACTER_MAXIMUM_LENGTH = -1 THEN CONVERT(VARCHAR, DATA_TYPE)
    --    --WHEN CHARACTER_MAXIMUM_LENGTH > 9999 THEN CONVERT(VARCHAR, DATA_TYPE)
    --    ELSE CONVERT(VARCHAR, DATA_TYPE) + '(' + CONVERT(VARCHAR, CHARACTER_MAXIMUM_LENGTH) + ')'
    --END AS VARCHAR) [DATA_TYPE]
    , CAST (
        CASE 
            WHEN CHARACTER_MAXIMUM_LENGTH >  99999 THEN DATA_TYPE
            WHEN ISNULL(CHARACTER_MAXIMUM_LENGTH,-1) = -1 THEN DATA_TYPE
            ELSE DATA_TYPE + '(' + CAST(CHARACTER_MAXIMUM_LENGTH AS varchar) + ')'
                --WHEN ISNULL(CHARACTER_MAXIMUM_LENGTH, 0) = 0 THEN 0
            END AS nvarchar) AS DATA_TYPE -- CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
    --ORDER BY DATA_TYPE
--WHERE TABLE_NAME = @TABLO_AD
    --ORDER BY TABLE_NAME


GO
/****** Object:  StoredProcedure [dbo].[CreateAllProceduresForTable]    Script Date: 1.3.2015 17:54:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateAllProceduresForTable]

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
/****** Object:  StoredProcedure [dbo].[DB_GET_COLUMN_TYPES_LENGTH]    Script Date: 1.3.2015 17:54:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DB_GET_COLUMN_TYPES_LENGTH] 
@TABLO_AD varchar(MAX)
AS
SELECT
    TABLE_NAME + '.' + COLUMN_NAME[Tablo.Sutun]
    , DATA_TYPE
    , CHARACTER_MAXIMUM_LENGTH = 
        CASE 
            WHEN CHARACTER_MAXIMUM_LENGTH >  99999 THEN NULL
            WHEN ISNULL(CHARACTER_MAXIMUM_LENGTH,-1) = -1 THEN NULL
            ELSE CHARACTER_MAXIMUM_LENGTH
            --WHEN ISNULL(CHARACTER_MAXIMUM_LENGTH, 0) = 0 THEN 0
        END
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @TABLO_AD
    ORDER BY TABLE_NAME



GO
/****** Object:  StoredProcedure [dbo].[DB_GET_DATA_TYPES]    Script Date: 1.3.2015 17:54:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DB_GET_DATA_TYPES]
  @TABLE_NAME VARCHAR(50)
AS
SELECT 
     TABLE_NAME
    ,COLUMN_NAME
    ,DATA_TYPE
    --, CASE 
    --    WHEN CHARACTER_MAXIMUM_LENGTH = '' THEN DATA_TYPE
    --    ELSE DATA_TYPE + '(' + CHARACTER_MAXIMUM_LENGTH + ')'
    --END [DATA_TYPE]
 FROM DB_DATA_TYPES
 WHERE TABLE_NAME = @TABLE_NAME 
