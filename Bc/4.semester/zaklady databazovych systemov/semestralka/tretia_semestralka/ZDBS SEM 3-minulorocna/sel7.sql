SET PAGESIZE 100;
SET LINESIZE 100;
clear col

TTITLE LEFT '     Mesta s najvacsim objemom vybranych penazi';

COLUMN nazov_kraj HEADING 'Kraj' format A20;
COLUMN nazov_mesto HEADING 'Mesto' format A20;
COLUMN suma HEADING 'Suma';


select nazov_kraj, nazov_mesto, suma from (
SELECT k.kod_kraj, nazov_kraj, nazov_mesto, sum(transakcie.suma_vyber) AS suma 
	FROM kraj k join okres on(k.kod_kraj=okres.kod_kraj) 
	JOIN mesto on(okres.kod_okres=mesto.kod_okres) 
	JOIN adresa on(mesto.kod_mesto=adresa.kod_mesto) 
	JOIN bankomat on(adresa.id_adresa=bankomat.id_adresa) 
	JOIN transakcie on(bankomat.id_bankomatu=transakcie.id_bankomatu)
GROUP BY k.nazov_kraj, okres.nazov_okres, mesto.nazov_mesto,  k.kod_kraj
having sum(transakcie.suma_vyber)=(
SELECT max(sum(transakcie.suma_vyber)) AS suma 
	FROM kraj k2 join okres on(k2.kod_kraj=okres.kod_kraj) 
	JOIN mesto on(okres.kod_okres=mesto.kod_okres) 
	JOIN adresa on(mesto.kod_mesto=adresa.kod_mesto) 
	JOIN bankomat on(adresa.id_adresa=bankomat.id_adresa) 
	JOIN transakcie on(bankomat.id_bankomatu=transakcie.id_bankomatu)
WHERE k2.kod_kraj = k.kod_kraj
GROUP BY k2.nazov_kraj, okres.nazov_okres, mesto.nazov_mesto,  k2.kod_kraj
)
order by suma desc
) 
;

