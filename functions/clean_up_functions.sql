declare @max_i tinyint
declare @index tinyint = 1
declare @name varchar(50)
declare @function_list table ( i tinyint, name varchar(50) )


insert into @function_list 
select ROW_NUMBER() OVER(ORDER BY name) [i], name from sys.objects where (type='TF' or type='FN' type='FS' or type='FT')

set @max_i = (select max(i) from @function_list)

while (@index <= @max_i)
begin
    select @name = name from @function_list where i = @index
    set @index += 1
    exec ('drop function ' + @name)

end


