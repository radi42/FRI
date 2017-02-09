SET PAGESIZE 70;
SET LINESIZE 40;
clear col

TTITLE LEFT 'Pocet transakcii v mene euro';

COLUMN pocet HEADING 'Pocet';

SELECT count(*) AS pocet from transakcie
	JOIN bankovka on(bankovka.id_transakcie=transakcie.id_transakcie)
WHERE bankovka.mena = 'euro'
GROUP BY bankovka.mena;
