USE [filmDukkaniDB_master]
GO

/****** Object:  View [dbo].[v_get_column_names]    Script Date: 1.3.2015 00:32:17 ******/
DROP VIEW [dbo].[v_get_column_names]
GO

/****** Object:  View [dbo].[v_get_column_names]    Script Date: 1.3.2015 00:32:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_get_column_names] 
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


