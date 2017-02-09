set serveroutput on

CREATE OR REPLACE FUNCTION spaleneKalorie(
p_os_cislo osoba.os_cislo%TYPE,
p_datum sport.datum_cas%type)
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

select sum(spalene_kalorie) into kaloriesport
from sport
where os_cislo=p_os_cislo
and trunc(p_datum) = trunc(datum_cas);

if (kaloriesport is null) then
kaloriesport := 0;
end if;

vysledok := kaloriesport;
--dbms_output.put_line(cielkalorie || ' - ' || kaloriejedlo || ' - ' || kaloriesport || ' - ' || vysledok);
return vysledok;

END;
/

show error;