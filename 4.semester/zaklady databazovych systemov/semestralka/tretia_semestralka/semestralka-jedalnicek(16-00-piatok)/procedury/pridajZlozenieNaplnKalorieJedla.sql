set serveroutput on

create or replace procedure pridajZlozenie(
idecko_jedla zlozenie.id_suroviny%TYPE,
idecko_suroviny zlozenie.id_suroviny%TYPE,
gramy zlozenie.pocet_gramov%TYPE)
is
begin
 insert into zlozenie values(idecko_jedla, idecko_suroviny, gramy);


 update jedlo
 set kalorie_jedla=(
  select sum(surovina.kcal*zlozenie.pocet_gramov)
  from surovina 
  join zlozenie on (surovina.id_suroviny = zlozenie.id_suroviny)
  join jedlo on (jedlo.id_jedla = zlozenie.id_jedla)
  where zlozenie.id_jedla = idecko_jedla)
 where jedlo.id_jedla=idecko_jedla;

/*
 update jedlo
 set kalorie_jedla=100
 where jedlo.id_jedla=1044;
*/


end;
/

show error;