SET PAGESIZE 100;
SET LINESIZE 100;
clear col

TTITLE LEFT '     Prehlad o najcastejsie vydavanych bankovkach v jednotlivych bankomatoch';

COLUMN id_bankomatu HEADING 'ID bankomatu' ;
COLUMN mena HEADING 'Mena' format A10 ;
COLUMN hodnota HEADING 'Hodnota' ;
COLUMN pocet HEADING 'Pocet';


select id_bankomatu, mena, hodnota, pocet from (
SELECT b.id_bankomatu, typ_bankovky.mena, typ_bankovky.hodnota, count(*) AS pocet 
	FROM bankomat b join transakcie on(b.id_bankomatu=transakcie.id_bankomatu) 
	JOIN bankovka on(bankovka.id_transakcie=transakcie.id_transakcie) 
	JOIN typ_bankovky on(typ_bankovky.hodnota=bankovka.hodnota and typ_bankovky.mena=bankovka.mena) 
GROUP BY b.id_bankomatu, typ_bankovky.mena, typ_bankovky.hodnota
having count(*)=(
SELECT max(count(*)) AS pocet 
	FROM bankomat b2 join transakcie on(b2.id_bankomatu=transakcie.id_bankomatu) 
	JOIN bankovka on(bankovka.id_transakcie=transakcie.id_transakcie) 
	JOIN typ_bankovky on(typ_bankovky.hodnota=bankovka.hodnota and typ_bankovky.mena=bankovka.mena)
WHERE b2.id_bankomatu = b.id_bankomatu
GROUP BY b2.id_bankomatu, typ_bankovky.mena, typ_bankovky.hodnota
)
order by id_bankomatu
) 
;
