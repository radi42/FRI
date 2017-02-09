set serveroutput on
CREATE OR REPLACE PROCEDURE select3
	(od_param IN varchar2, 
	do_param IN varchar2)
IS
vypis_bankomat varchar2(300);
cursor bankomaty is SELECT stat.nazov_stat||'  '|| kraj.nazov_kraj||'  '|| okres.nazov_okres||'  '|| mesto.nazov_mesto||'  '|| to_char(count(*)) ||'  '|| to_char(sum(suma_vyber)) FROM stat 
	JOIN kraj ON (stat.kod_stat=kraj.kod_stat)
	JOIN okres ON (kraj.kod_kraj=okres.kod_kraj)
	JOIN mesto ON (mesto.kod_okres=okres.kod_okres)
	JOIN adresa ON (mesto.kod_mesto=adresa.kod_mesto)
	JOIN bankomat ON (adresa.id_adresa=bankomat.id_adresa)
	JOIN transakcie ON (transakcie.id_bankomatu=bankomat.id_bankomatu)
	WHERE (transakcie.datum_a_cas>=to_date(od_param,'dd/mm/yyyy') AND transakcie.datum_a_cas<=to_date(do_param,'dd/mm/yyyy')) 
	GROUP BY stat.nazov_stat, kraj.nazov_kraj, okres.nazov_okres, mesto.nazov_mesto;
	
BEGIN 
  dbms_output.put_line('Prehlad o vyberoch z bankomatov v obdobi od '||od_param||' do ' || do_param||' : ');
  dbms_output.put_line('STAT | KRAJ | OKRES | MESTO | POCET BANKOMATOV | POCET');
  open bankomaty;
  loop
  fetch bankomaty into vypis_bankomat;
  exit when bankomaty%notfound;
  dbms_output.put_line(vypis_bankomat);
  end loop;
  close bankomaty;
END;
/ 
	