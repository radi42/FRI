--Lukas Kabat

create or replace procedure zmenOsobneUdaje(
p_os_cislo in osoba.os_cislo%type,
p_meno IN osoba.meno%type,
p_priezvisko IN osoba.priezvisko%type)
as
begin
update osoba
set meno = p_meno, priezvisko = p_priezvisko
where os_cislo = p_os_cislo;
end;
/

show err;