declare
  p_meno os_udaje.meno%TYPE;
  p_priezv os_udaje.priezvisko%TYPE;
begin
  select meno, priezvisko into p_meno, p_priezv
  from os_udaje
  --vyhodi vynimku
  where rod_cislo = '3';
  --vypise meno a priezvisko studenta
  --where rod_cislo = '840821/8027';

  dbms_output.put_line(p_meno || ' ' || p_priezv);

  EXCEPTION
  WHEN no_data_found then
  dbms_output.put_line('404 - student nebol najdeny');

  WHEN others then
  dbms_output.put_line('ina chyba');
end;
/