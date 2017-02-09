set serveroutput on

create or replace procedure naplnNutricneHodnoty2(int IN integer)
as
temp jedlo.id_jedla%type;
cursor nevyplneneTuky is 
select id_jedla from jedlo;
begin
open nevyplneneTuky;
loop
fetch nevyplneneTuky into temp;
naplnNutricneHodnoty1(temp);
exit when nevyplneneTuky%notfound;
end loop;
close nevyplneneTuky;
end;
/

show err;