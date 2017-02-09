SET PAGESIZE 100;
SET LINESIZE 180;
clear col

TTITLE CENTER 'Informacie o zakaznikoch';

COLUMN os_cislo_zak HEADING 'OC zakaznika';
COLUMN rod_cislo HEADING 'RC' format A11;
COLUMN MENO HEADING 'Meno' format A10;
COLUMN PRIEZVISKO HEADING 'Priezvisko' format A15;

COLUMN ulica HEADING 'Ulica' format A15;
COLUMN cislo_domu HEADING 'Cislo domu' ;
COLUMN nazov_mesto HEADING 'Mesto' format A20;
COLUMN psc HEADING 'PSC' ;
COLUMN nazov_okres HEADING 'Okres' format A20;
COLUMN nazov_kraj HEADING 'Kraj' format A15;
COLUMN nazov_stat HEADING 'Stat' format A15;


SELECT zakaznik.os_cislo_zak, 
	osoba.rod_cislo, 
	OSOBA.MENO, 
	OSOBA.PRIEZVISKO, 
	adresa.ulica, 
	adresa.cislo_domu,
	mesto.nazov_mesto,
	adresa.psc,
	okres.nazov_okres,
	kraj.nazov_kraj,
	stat.nazov_stat  
from zakaznik join osoba on(zakaznik.rod_cislo = osoba.rod_cislo) 
	join adresa on(osoba.id_adresa = adresa.id_adresa) 
	JOIN mesto on(mesto.kod_mesto=adresa.kod_mesto)
	JOIN okres on(okres.kod_okres=mesto.kod_okres)
	JOIN kraj on(kraj.kod_kraj=okres.kod_kraj)
	JOIN stat on(stat.kod_stat=kraj.kod_stat); 