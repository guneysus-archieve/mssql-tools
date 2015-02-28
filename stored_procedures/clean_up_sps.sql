declare @max_i tinyint
declare @index tinyint = 1
declare @name varchar(50)
declare @sp_list table ( i tinyint, name varchar(50) )

insert into @sp_list 
select ROW_NUMBER() OVER(ORDER BY name) [i], name from sys.procedures

set @max_i = (select max(i) from @sp_list)

while (@index <= @max_i)
begin
    select @name = name from @sp_list where i = @index
    set @index += 1
    exec ('drop procedure ' + @name)

end


