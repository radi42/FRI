set serveroutput on

CREATE OR REPLACE FUNCTION zvysneKalorie(
p_os_cislo osoba.os_cislo%TYPE,
p_datum stravnik.datum_cas%type)
RETURN integer
IS
cielkalorie integer;
kaloriejedlo integer;
kaloriesport integer;
vysledok integer;

BEGIN

cielkalorie := 0;
kaloriejedlo := 0;
kaloriesport := 0;
vysledok := 0;

select kcal_ciel into cielkalorie
from osoba
where os_cislo=p_os_cislo;

--dbms_output.put_line(cielkalorie || ' - ' || kaloriejedlo || ' - ' || kaloriesport || ' - ' || vysledok);

select sum(kalorie_jedla) into kaloriejedlo
from jedlo
join stravnik on (stravnik.id_jedla=jedlo.id_jedla)
where trunc(p_datum) = trunc(datum_cas)
and stravnik.os_cislo=p_os_cislo;

if (kaloriejedlo is null) then
kaloriejedlo := 0;
end if;

select sum(spalene_kalorie) into kaloriesport
from sport
where os_cislo=p_os_cislo
and trunc(p_datum) = trunc(datum_cas);

if (kaloriesport is null) then
kaloriesport := 0;
end if;

vysledok := cielkalorie - kaloriejedlo + kaloriesport;
--dbms_output.put_line(cielkalorie || ' - ' || kaloriejedlo || ' - ' || kaloriesport || ' - ' || vysledok);
return vysledok;

END;
/

show error;