/*set serveroutput on

/*create or replace procedure naplnKalorie2(int IN integer)
as
temp jedlo.id_jedla%type;
cursor nevyplneneKalorie is 
select id_jedla from jedlo;
begin
open nevyplneneKalorie;
loop
fetch nevyplneneKalorie into temp;
naplnKalorie(temp);
exit when nevyplneneKalorie%notfound;
end loop;
close nevyplneneKalorie;
end;
/

show err;