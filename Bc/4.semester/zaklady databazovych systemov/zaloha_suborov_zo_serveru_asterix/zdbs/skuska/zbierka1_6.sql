--Vypiste lety ktore boli vyuzite na menej ako 30%.
Select id_letu,t.kapacita,lt.kapacita
from l_triedy t 
join l_let l using(id_letu)
join l_lietadlo lt using(id_lietadla)
where t.kapacita<lt.kapacita*0.3;
