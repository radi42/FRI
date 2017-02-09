
/*
select kcal_ciel
from osoba
where os_cislo=26;
*/

/*
select sum(kalorie_jedla)
from jedlo
join stravnik on (stravnik.id_jedla=jedlo.id_jedla)
where to_date('09-01-2015','dd-mm-yyyy') = trunc(datum_cas)
and stravnik.os_cislo=25;
*/


select sum(spalene_kalorie)
from sport
where os_cislo=26
and trunc(sysdate) = trunc(datum_cas);
