set serveroutput on

create or replace procedure dajDostupnostJedla(p_id_jedla IN jedlo.id_jedla%type)
as
temp surovina.dostupna%type;
vypis varchar2(100):='Jedlo je dostupne';

cursor surovinyJedla is 
select dostupna from surovina 
join zlozenie on (surovina.id_suroviny=zlozenie.id_suroviny)
where id_jedla = p_id_jedla;

begin
open surovinyJedla;
loop
fetch surovinyJedla into temp;
if temp='Nie' then
vypis:='Jedlo nie je dostupne';
end if;
exit when surovinyJedla%notfound;
end loop;
close surovinyJedla;
dbms_output.put_line(vypis);
end;
/

show err;