SET PAGESIZE 70;
SET LINESIZE 180;
clear col
TTITLE CENTER 'Informacie o bankomatoch';
COLUMN id_bankomatu HEADING 'ID bankomatu';
COLUMN typ_bankomatu HEADING 'Typ' format A10;
COLUMN ulica HEADING 'Ulica' format A15;
COLUMN nazov_mesto HEADING 'Mesto' format A20;
COLUMN psc HEADING 'PSC';
COLUMN nazov_okres HEADING 'Okres' format A20;
COLUMN nazov_kraj HEADING 'Kraj' format A20;
COLUMN nazov_stat HEADING 'Stat' format A15;


SELECT bankomat.id_bankomatu,
	bankomat.typ_bankomatu,
	adresa.ulica,
	mesto.nazov_mesto,
	adresa.psc,
	okres.nazov_okres,
	kraj.nazov_kraj,
	stat.nazov_stat
from bankomat
	JOIN adresa on(adresa.id_adresa=bankomat.id_adresa)
	JOIN mesto on(mesto.kod_mesto=adresa.kod_mesto)
	JOIN okres on(okres.kod_okres=mesto.kod_okres)
	JOIN kraj on(kraj.kod_kraj=okres.kod_kraj)
	JOIN stat on(stat.kod_stat=kraj.kod_stat); 