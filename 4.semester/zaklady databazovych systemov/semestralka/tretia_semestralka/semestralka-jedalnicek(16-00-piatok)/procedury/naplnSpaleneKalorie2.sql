set serveroutput on

create or replace procedure naplnSpaleneKalorie2(int IN integer)
as
temp1 sport.datum_cas%type;
temp2 sport.os_cislo%type;
temp3 sport.id_druhSportu%type;

cursor nevyplneneSpaleneKalorie is
select datum_cas, os_cislo, id_druhSportu from sport;

begin
open nevyplneneSpaleneKalorie;
loop
fetch nevyplneneSpaleneKalorie into temp1, temp2, temp3;
naplnSpaleneKalorie(temp1, temp2, temp3);
exit when nevyplneneSpaleneKalorie%notfound;
end loop;
close nevyplneneSpaleneKalorie;
end;
/

show err;