set serveroutput on

declare
  p_meno os_udaje.meno%TYPE;
  p_priezvisko os_udaje.priezvisko%TYPE;
  pocet integer;
begin
  SELECT meno, priezvisko, count(*) INTO p_meno, p_priezvisko, pocet
  FROM os_udaje ou
  JOIN student st ON (st.rod_cislo = ou.rod_cislo)
  LEFT JOIN zap_predmety zp ON (zp.os_cislo = st.os_cislo)
  WHERE zp.os_cislo = 550807
  GROUP BY meno, priezvisko;

  dbms_output.put_line(
	'Pocet predmetov studenta ' || p_meno ||  ' ' || p_priezvisko || 
         ' je ' || pocet);
end;
/
