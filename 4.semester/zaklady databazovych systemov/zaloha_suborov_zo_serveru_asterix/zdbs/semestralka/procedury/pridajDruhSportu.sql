create or replace procedure pridajDruhSportu(
nazov in druhSportu.nazov_sportu%TYPE,
kalorie in druhSportu.kalorieZaMinutu%TYPE,
inten in druhSportu.intenzita%TYPE)
is
begin
insert into druhSportu values(NULL, nazov, kalorie, inten);
end;
/