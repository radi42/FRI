create or replace procedure pridajSport(
oc in sport.os_cislo%TYPE,
id in sport.id_druhSportu%TYPE,
trvanie in sport.trvanieVminutach%TYPE)
is
begin
insert into sport values(sysdate, oc, id, trvanie, NULL);
end;
/