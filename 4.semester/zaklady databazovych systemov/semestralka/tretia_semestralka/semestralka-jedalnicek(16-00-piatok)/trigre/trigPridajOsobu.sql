-- Lukas Kabat

create or replace trigger t_pridajOsobu
before insert on osoba
for each row
begin
select s_os_cislo.NEXTVAL,sysdate
into   :new.os_cislo,:new.datum_nastupu
from  dual;
end;
/

show err;