SET PAGESIZE 100;
SET LINESIZE 100;
clear col

TTITLE CENTER 'Vypis bankomatov, ktorym treba doplnit hotovost';

COLUMN id_bankomatu HEADING 'ID bankomatu';
COLUMN gps_sirka HEADING 'Sirka';
COLUMN gps_dlzka HEADING 'Dlzka';


SELECT DISTINCT bankomat.id_bankomatu,bankomat.gps_sirka, bankomat.gps_dlzka, pocet_bank, hodnota, mena from bankomat
	JOIN transakcie ON (bankomat.id_bankomatu=transakcie.id_bankomatu)
	JOIN bankovky_v_bankomate ON(bankomat.id_bankomatu=bankovky_v_bankomate.id_bankomatu)
	where pocet_bank<20
	ORDER BY(id_bankomatu);
