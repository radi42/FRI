SET PAGESIZE 70;
SET LINESIZE 180;
clear col

TTITLE CENTER 'Prehlad bankomatov podla uzemia';

COLUMN nazov_stat HEADING 'Stat' format A15;
COLUMN nazov_kraj HEADING 'Kraj' format A20;
COLUMN nazov_okres HEADING 'Okres' format A20;
COLUMN nazov_mesto HEADING 'Mesto' format A20;
COLUMN pocet HEADING 'Pocet';

SELECT stat.nazov_stat, kraj.nazov_kraj, okres.nazov_okres, mesto.nazov_mesto, count(*) AS pocet 
from bankomat join adresa on(adresa.id_adresa=bankomat.id_adresa)
	JOIN mesto on(mesto.kod_mesto=adresa.kod_mesto)
	JOIN okres on(okres.kod_okres=mesto.kod_okres)
	JOIN kraj on(kraj.kod_kraj=okres.kod_kraj)
	JOIN stat on(stat.kod_stat=kraj.kod_stat)
group by stat.nazov_stat, kraj.nazov_kraj, okres.nazov_okres, mesto.nazov_mesto;