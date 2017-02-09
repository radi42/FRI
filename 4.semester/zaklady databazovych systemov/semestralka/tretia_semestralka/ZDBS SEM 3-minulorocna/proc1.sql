set serveroutput on
CREATE OR REPLACE PROCEDURE procedure1
	(mena_param IN varchar2, 
	hodnota_param IN integer)
IS
vypis_bankomat varchar2(255);
cursor bankomaty is SELECT DISTINCT bankomat.id_bankomatu||'  '|| mesto.nazov_mesto||'  '|| bankomat.gps_sirka||'  '|| bankomat.gps_dlzka FROM bankomat
	JOIN adresa ON (bankomat.id_adresa=adresa.id_adresa)
	JOIN mesto ON (adresa.kod_mesto=mesto.kod_mesto)
	JOIN bankovky_v_bankomate ON (bankovky_v_bankomate.id_bankomatu=bankomat.id_bankomatu)
	WHERE (bankovky_v_bankomate.mena=mena_param 
	AND bankovky_v_bankomate.hodnota=hodnota_param);
BEGIN    
  dbms_output.put_line('Bankomaty, v ktorych sa nachadza bankovka : '||mena_param||' '||hodnota_param||'');
  dbms_output.put_line('ID Bankomatu | Mesto | GPS sirka | GPS dlzka');
  open bankomaty;
  loop
  fetch bankomaty into vypis_bankomat;
  exit when bankomaty%notfound;
  dbms_output.put_line(vypis_bankomat);
  end loop;
  close bankomaty;
END;
/ 
