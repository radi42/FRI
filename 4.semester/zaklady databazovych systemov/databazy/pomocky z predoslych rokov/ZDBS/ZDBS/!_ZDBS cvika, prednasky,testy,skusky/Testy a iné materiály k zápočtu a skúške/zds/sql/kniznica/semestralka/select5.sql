--tatistický preh.ad výpo.i.iek .itate.ov za zadané obdobie 

SET PAGESIZE 50
SET LINESIZE 50

TTITLE CENTER 'Statisticky prehlad vypoziciek'
COLUMN meno HEADING 'Meno' FORMAT A20
COLUMN priezvisko HEADING 'Priezvisko' FORMAT A20
COLUMN pocet HEADING 'Pocet' FORMAT 9999

SELECT meno, priezvisko, count(*) pocet
FROM sem_pozicka, sem_citatel
WHERE sem_citatel.id_citatela=sem_pozicka.id_citatela
AND datum_pozicky BETWEEN '&od' AND '&do'
GROUP BY priezvisko, meno;
