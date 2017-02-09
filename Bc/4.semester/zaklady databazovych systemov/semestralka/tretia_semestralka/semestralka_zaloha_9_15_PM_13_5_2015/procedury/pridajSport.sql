create or replace procedure pridajSport(
datum in sport.datum_cas%TYPE,
oc in sport.os_cislo%TYPE,
id in sport.id_druhSportu%TYPE,
trvanie in sport.trvanieVminutach%TYPE)
is
begin
insert into sport values(datum, oc, id, trvanie, NULL);
end;
/