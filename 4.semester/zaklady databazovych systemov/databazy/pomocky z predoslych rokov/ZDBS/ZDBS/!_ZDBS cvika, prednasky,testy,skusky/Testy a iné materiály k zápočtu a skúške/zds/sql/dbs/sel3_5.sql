-- vypis vlakovych stanic na danej linke ak zrusime parameter vypise vsetky vlaky a ich rozpisy
UNDEFINE linka;
SET PAGESIZE 60;
SET LINESIZE 70;

COLUMN VLAK FORMAT 99999
COLUMN OD FORMAT A18;
COLUMN ODCHOD FORMAT A8;
COLUMN DO FORMAT A18; 
COLUMN PRICHOD FORMAT A8;
BREAK ON VLAK;

SELECT	usek.vl_cislo_vlaku VLAK,
	a.nazov OD,
	usek.us_start ODCHOD,
	b.nazov DO,
	usek.stop PRICHOD
FROM	usek,stanica a, stanica b
WHERE 	usek.s_id=a.id
AND 	usek.vl_cislo_vlaku=&LINKA
AND 	usek.s_id_konci_v=b.id
ORDER BY usek.vl_cislo_vlaku,usek.us_start
;
UNDEFINE linka;