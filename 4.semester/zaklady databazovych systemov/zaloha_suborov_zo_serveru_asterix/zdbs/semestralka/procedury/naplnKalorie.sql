create or replace procedure naplnKalorie(p_id_jedla IN jedlo.id_jedla%type)
as
begin
update jedlo
 set kalorie_jedla=(
  select sum(surovina.kcal*zlozenie.pocet_gramov)
  from surovina 
  join zlozenie on (surovina.id_suroviny = zlozenie.id_suroviny)
  join jedlo on (jedlo.id_jedla = zlozenie.id_jedla)
  where zlozenie.id_jedla = p_id_jedla)
 where jedlo.id_jedla=p_id_jedla;
end;
/