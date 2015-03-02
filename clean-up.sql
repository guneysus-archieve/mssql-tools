DECLARE @OBJECTS TABLE (
     N tinyint NOT NULL IDENTITY(1,1) --Primary Key
    ,[Object Type] varchar(50)
    , [Name] varchar(50)
    , [Code] varchar(MAX)
  )
INSERT INTO @OBJECTS  ( [Object Type], [Name]) VALUES
     ('Function', 'CreateDeleteProcedure')
    ,('Function', 'CreateDeleteTrigger')
    ,('Function', 'CreateInsertProcedure')
    ,('Function', 'CreateUpdateProcedure')
    ,('Procedure', 'CreateAllProceduresForTable')
    ,('Procedure', 'DB_GET_COLUMN_TYPES_LENGTH')
    ,('Procedure', 'DB_GET_DATA_TYPES')
    ,('View',       'DB_DATA_TYPES')

DECLARE  @MAX_ID TINYINT = (SELECT MAX(N) FROM @OBJECTS)
DECLARE  @I      TINYINT = 1
DECLARE @CODE VARCHAR(MAX)
DECLARE @NAME VARCHAR(50)
DECLARE @TYPE VARCHAR(50)


WHILE ( @I <= @MAX_ID)
    BEGIN 
        SET @TYPE = (SELECT [Object Type] FROM @OBJECTS WHERE N = @I)
        SET @NAME = ( SELECT [Name] FROM @OBJECTS WHERE N = @I )

        SET @CODE = ''
        SET @CODE += 'IF ( OBJECT_ID ( ''' + @NAME + ''') IS NOT NULL )' + CHAR(13)
        SET @CODE += '    BEGIN ' + (SELECT 'DROP ' + [Object Type] + ' ' + [Name] FROM @OBJECTS WHERE N = @I) + ' END'
        SET @I += 1
        EXEC (@CODE)
    END
