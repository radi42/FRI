set serveroutput on
CREATE OR REPLACE PROCEDURE procedure2
	(os_cislo_param IN integer)
IS
vypis_servis varchar2(255);
cursor servisy is SELECT servis.id_bankomatu||'        '|| servis.datum_a_cas ||'  '|| servis.popis FROM servis
	JOIN zamestnanec ON (servis.os_cislo_zam=zamestnanec.os_cislo_zam)
	JOIN osoba ON (osoba.rod_cislo=zamestnanec.rod_cislo)
	WHERE (zamestnanec.os_cislo_zam=os_cislo_param);
BEGIN    
  dbms_output.put_line('Zamestnanec s os.cislom '||os_cislo_param||' vykonal servis tychto bankomatov: ');
  dbms_output.put_line('ID Bankomatu | Datum | Popis');
  open servisy;
  loop
  fetch servisy into vypis_servis;
  exit when servisy%notfound;
  dbms_output.put_line(vypis_servis);
  end loop;
  close servisy;
END;
/ 

