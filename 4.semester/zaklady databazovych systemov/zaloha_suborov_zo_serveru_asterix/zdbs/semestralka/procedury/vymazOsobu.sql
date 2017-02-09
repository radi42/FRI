-- Lukas Kabat

create or replace procedure vymazOsobu(
p_os_cislo IN osoba.os_cislo%type)
as
begin
delete from stravnik
where os_cislo = p_os_cislo;

delete from sport
where os_cislo = p_os_cislo;

delete from osoba
where os_cislo = p_os_cislo;
end;
/

show err;