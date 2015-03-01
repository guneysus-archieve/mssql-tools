GO
CREATE VIEW DB_GET_FUNCTIONS
/* from http://stackoverflow.com/a/468780/1766716 
    
   OR

   select * from sys.objects where (type='TF' or type='FN' or type='FS' or type='FT')

   or
   SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = 'FUNCTION'
*/

AS
SELECT *
FROM sys.objects
WHERE type IN ('FN', 'IF', 'TF') 

GO
select * from DB_GET_FUNCTIONS

