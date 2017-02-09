set serveroutput on
CREATE OR REPLACE PROCEDURE nazov
(id_bankomatu_param IN integer)
IS
vypis_bankomat varchar2(255);
cursor bankomaty is SELECT bankovka.mena||'  '||bankovka.hodnota||'  '|| to_char(count(*)) AS pocet FROM bankomat 
	JOIN transakcie ON (bankomat.id_bankomatu=transakcie.id_bankomatu)
	JOIN bankovka ON (transakcie.id_transakcie=bankovka.id_transakcie)
	WHERE bankomat.id_bankomatu=id_bankomatu_param
	GROUP BY bankovka.mena, bankovka.hodnota
	ORDER BY pocet desc;
	
BEGIN    
  dbms_output.put_line('Prehlad o pocte vydanych typov bankoviek v '||id_bankomatu_param||' : ');
  dbms_output.put_line('MENA | HODNOTA | POCET  ');
  open bankomaty;
  loop
  fetch bankomaty into vypis_bankomat;
  exit when bankomaty%notfound;
  dbms_output.put_line(vypis_bankomat);
  end loop;
  close bankomaty;
END;
/ 
