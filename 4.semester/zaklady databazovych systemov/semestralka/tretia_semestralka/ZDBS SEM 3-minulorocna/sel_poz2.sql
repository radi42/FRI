SET PAGESIZE 70;
SET LINESIZE 100;
clear col

TTITLE LEFT 'Zamestnanci s trvalym pobytom v ZA';

COLUMN rownum HEADING 'Poradie';
COLUMN meno HEADING 'Meno';
COLUMN priezvisko HEADING 'Priezvisko';

SELECT rownum,meno,priezvisko from osoba 
	JOIN zamestnanec on(osoba.rod_cislo=zamestnanec.rod_cislo)
	JOIN adresa on(adresa.id_adresa=osoba.id_adresa)
	JOIN mesto on(mesto.kod_mesto=adresa.kod_mesto)
WHERE mesto.nazov_mesto = 'Zilina';