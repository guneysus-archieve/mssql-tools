declare @max_i tinyint
declare @index tinyint = 1
declare @name varchar(50)
declare @trigger_list table ( i tinyint, name varchar(50) )

insert into @trigger_list 
select ROW_NUMBER() OVER(ORDER BY name) [i], name from sys.triggers

set @max_i = (select max(i) from @trigger_list)

while (@index <= @max_i)
begin
    select @name = name from @trigger_list where i = @index
    set @index += 1
    exec ('drop trigger ' + @name)

end

