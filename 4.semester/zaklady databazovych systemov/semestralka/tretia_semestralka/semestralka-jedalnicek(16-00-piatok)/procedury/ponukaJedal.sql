--ponuka jedal pre daneho uzivatela v dany den podla kalorii

set serveroutput on

CREATE OR REPLACE PROCEDURE ponukaJedal(
p_os_cislo osoba.os_cislo%TYPE,
p_datum stravnik.datum_cas%TYPE,
p_kategoria jedlo.kategoria%TYPE)
IS
--premenne
zvysneKalorieOsoby integer;

id jedlo.id_jedla%TYPE;
nazov jedlo.nazov_jedla%TYPE;
kalorie jedlo.kalorie_jedla%TYPE;
kateg jedlo.kategoria%TYPE;

cursor zoznamJedal is
 select id_jedla, nazov_jedla, kalorie_jedla, kategoria
 from jedlo
 where kalorie_jedla <= zvysneKalorieOsoby
 and kategoria = p_kategoria;

BEGIN

zvysneKalorieOsoby := zvysneKalorie(p_os_cislo, p_datum);

if (zvysneKalorieOsoby>0) then
 open zoznamJedal;
 loop
  fetch zoznamJedal into id, nazov, kalorie, kateg;
  exit when zoznamJedal%notfound;
  dbms_output.put_line(id || ' -- ' || nazov || ' -- ' || kalorie || ' -- ' || kateg);
 end loop;
 close zoznamJedal;
else
	dbms_output.put_line('uz nezer cica');
end if;



END;
/

show error;