/*
funkcia vrati pocet kreditov studenta, ziskanych za cele studium.
*/

set serveroutput on

drop function pocet_kreditov;
create or replace function pocet_kreditov (p_oc IN student.os_cislo%TYPE)
  return number
IS
  p_kredity zap_predmety.ects%TYPE := 0;
BEGIN

  SELECT sum(nvl(ects,0)) INTO p_kredity
  FROM zap_predmety
  WHERE os_cislo = p_oc AND vysledok IN ('A', 'B', 'C', 'D', 'E', 'F');

  RETURN p_kredity;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      
      RETURN 0;

END pocet_kreditov;
/

show error;

/*
priklad pouzitia:
variable kredity number
variable oc number
execute :oc := 501381
execute :kredity := pocet_kreditov(:oc)
print kredity
*/