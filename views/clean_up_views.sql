declare @max_i tinyint
declare @index tinyint = 1
declare @name varchar(50)
declare @view_list table ( i tinyint, name varchar(50) )

insert into @view_list 
select ROW_NUMBER() OVER(ORDER BY name) [i], name from sys.views

set @max_i = (select max(i) from @view_list)

while (@index <= @max_i)
begin
    select @name = name from @view_list where i = @index
    set @index += 1
    exec ('drop view ' + @name)

end

