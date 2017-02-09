create or replace procedure naplnNutricneHodnoty1(p_id_jedla IN jedlo.id_jedla%type)
as
begin
update jedlo
 set jedlo.tuky=(
  select sum(surovina.tuky*zlozenie.pocet_gramov)
  from surovina 
  join zlozenie on (surovina.id_suroviny = zlozenie.id_suroviny)
  join jedlo on (jedlo.id_jedla = zlozenie.id_jedla)
  where zlozenie.id_jedla = p_id_jedla)
 where jedlo.id_jedla=p_id_jedla;

update jedlo
 set jedlo.bielkoviny=(
  select sum(surovina.bielkoviny*zlozenie.pocet_gramov)
  from surovina 
  join zlozenie on (surovina.id_suroviny = zlozenie.id_suroviny)
  join jedlo on (jedlo.id_jedla = zlozenie.id_jedla)
  where zlozenie.id_jedla = p_id_jedla)
 where jedlo.id_jedla=p_id_jedla;

update jedlo
 set jedlo.sacharidy=(
  select sum(surovina.sacharidy*zlozenie.pocet_gramov)
  from surovina 
  join zlozenie on (surovina.id_suroviny = zlozenie.id_suroviny)
  join jedlo on (jedlo.id_jedla = zlozenie.id_jedla)
  where zlozenie.id_jedla = p_id_jedla)
 where jedlo.id_jedla=p_id_jedla;

end;
/