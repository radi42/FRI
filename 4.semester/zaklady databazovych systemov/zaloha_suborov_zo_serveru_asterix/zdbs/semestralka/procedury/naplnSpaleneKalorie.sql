create or replace procedure naplnSpaleneKalorie(
 p_datum IN sport.datum_cas%TYPE,
 p_os_cislo IN sport.os_cislo%TYPE,
 p_id_druhSportu IN sport.id_druhSportu%type)
as
begin
update sport
 set sport.spalene_kalorie=(
  select (sport.trvanieVminutach * druhSportu.kalorieZaMinutu)
  from sport 
  join druhSportu on (druhSportu.id_druhSportu = sport.id_druhSportu)
  where sport.datum_cas = p_datum
  and sport.os_cislo = p_os_cislo
  and sport.id_druhSportu = p_id_druhSportu)
where sport.datum_cas = p_datum
and sport.os_cislo = p_os_cislo
and sport.id_druhSportu = p_id_druhSportu;
end;
/

show error;
