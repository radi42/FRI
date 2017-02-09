-- Lukas Kabat

create or replace procedure pridajStravnika(
p_os_cislo IN stravnik.os_cislo%type,
p_id_jedla IN stravnik.id_jedla%type,
p_vahaPriebezna IN stravnik.vahaPriebezna%type
)
as
begin
insert into stravnik
values(
sysdate,
p_os_cislo,
p_id_jedla,
p_vahaPriebezna
);
end;
/

show err;