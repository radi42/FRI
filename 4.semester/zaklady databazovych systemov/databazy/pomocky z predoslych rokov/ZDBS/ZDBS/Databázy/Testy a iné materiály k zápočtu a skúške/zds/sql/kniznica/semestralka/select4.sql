--opreh.ad .itate.ov, pod.a vypo.i.aných a vrátených predmetov - vrátane
--minulosti 

SET PAGESIZE 50
SET LINESIZE 100

TTITLE CENTER 'Prehlad vypozicanych pred. po dobe'
COLUMN typ HEADING 'Typ' FORMAT A3
COLUMN nazov HEADING 'Nazov' FORMAT A20
COLUMN meno HEADING 'Meno' FORMAT A20
COLUMN priezvisko HEADING 'Priezvisko' FORMAT A20
COLUMN datum_pozicky HEADING 'Datum|pozicky'
COLUMN datum_vratenia HEADING 'Datum|vratenia'

SELECT meno, priezvisko, typ, nazov,datum_pozicky, datum_vratenia
FROM sem_predmet, sem_pozicka, sem_citatel
WHERE sem_predmet.id_predmetu=sem_pozicka.id_predmetu
AND sem_citatel.id_citatela=sem_pozicka.id_citatela
GROUP BY priezvisko, meno, nazov, typ, datum_pozicky, datum_vratenia;
