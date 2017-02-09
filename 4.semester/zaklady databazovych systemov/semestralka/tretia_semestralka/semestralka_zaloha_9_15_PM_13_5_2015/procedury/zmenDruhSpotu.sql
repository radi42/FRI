create or replace procedure zmenDruhSportu(
nazov IN druhSportu.nazov_sportu%type,
kalorie IN druhSportu.kalorieZaMinutu%type,
inten IN druhSportu.intenzita%type)
as
begin
update druhSportu
set nazov_sportu = nazov, kalorieZaMinutu = kalorie, intenzita = inten
where id_druhSportu = id;
end;
/

show err;