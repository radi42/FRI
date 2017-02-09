-- vrati integer s poctom volnych kalorii
create or replace function zvysneKalorie(
p_os_cislo osoba.os_cislo%TYPE
)
is

cielkalorie integer
kaloriejedlo integer;
kaloriesport integer;

begin

select kcal_ciel into cielkalorie
from osoba
where os_cislo=p_os_cislo;

select sum(kalorie_jedla) into kaloriejedlo
from jedlo
join stravnik on (stravnik.id_jedla=jedlo.id_jedla)
where trunc(sysdate) = trunc(datum_cas)
and stravnik.os_cislo=p_os_cislo;

select sum(spalene_kalorie) into kaloriesport
from sport
where os_cislo=p_os_cislo
and trunc(sysdate) = trunc(datum_cas);

return cielkalorie - kaloriejedlo + kaloriesport;

end;
/