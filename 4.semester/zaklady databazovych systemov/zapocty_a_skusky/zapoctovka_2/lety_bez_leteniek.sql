/*
--column part of USING clause cannot have qualifier

select id_letu
from l_let join l_letenka using(id_letu)
where l_letenka.id_letu is null;
*/


/*
--no rows selected

select id_letu from l_let
where not exists(select 'x' from l_letenka);
*/


/*
--nejaka chyba

select id_letu
from l_let
where id_letu not in l_letenka;
*/


/*
--no rows selected - TOTO je spravne

select l_let.id_letu
from l_let right join l_letenka lenka on(lenka.id_letu = ll.id_letu)
where lenka.id_letu is null;
*/