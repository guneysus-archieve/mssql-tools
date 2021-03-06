USE [filmDukkaniDB_master]
GO
/****** Object:  StoredProcedure [dbo].[get_column_names]    Script Date: 28.2.2015 18:56:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[get_column_names] 
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
FROM filmDukkaniDB_master.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @TABLO_AD
    ORDER BY TABLE_NAME



GO
ALTER VIEW [dbo].[v_get_column_names] 
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
FROM filmDukkaniDB_master.INFORMATION_SCHEMA.COLUMNS
    --ORDER BY DATA_TYPE
--WHERE TABLE_NAME = @TABLO_AD
    --ORDER BY TABLE_NAME
GO
SELECT * FROM [v_get_column_names]


SELECT CONVERT(varchar, CHARACTER_MAXIMUM_LENGTH) FROM v_get_column_names


select CAST (
            CASE 
                WHEN CHARACTER_MAXIMUM_LENGTH IS NULL THEN '' 
                WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL THEN 'FOO'
            END AS varchar) AS [FOO]

from v_get_column_names


GO
ALTER PROCEDURE get_data_types_of_table
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
 FROM v_get_column_names
 WHERE TABLE_NAME = @TABLE_NAME 

GO
EXEC get_data_types_of_table Uye
 


DECLARE @SUTUN_ADLARI TABLE ( ad varchar(MAX))
INSERT INTO @SUTUN_ADLARI (AD) VALUES ('ASD'), ('ASD')


SELECT '  @' + COLUMN_NAME + ' ' + DATA_TYPE + ',' [COLUMN_NAME] 
    FROM [v_get_column_names]
    WHERE TABLE_NAME = 'Uye'





SELECT 'CREATE PROCEDURE FOO_BAZ' + CHAR(13) + '  AS' + CHAR(13) + '    SELECT * FROM SYS.TABLES'