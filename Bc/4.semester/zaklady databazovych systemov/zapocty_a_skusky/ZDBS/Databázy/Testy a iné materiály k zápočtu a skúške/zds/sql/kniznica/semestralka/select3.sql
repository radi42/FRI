--preh.ad vypo.i.aných predmetov, u ktorých vypr.ala výpo.i.ná doba 

SET PAGESIZE 50
SET LINESIZE 66

TTITLE CENTER 'Prehlad vypozicanych pred. po dobe'
COLUMN typ HEADING 'Typ' FORMAT A3
COLUMN nazov HEADING 'Nazov' FORMAT A20
COLUMN meno HEADING 'Meno' FORMAT A20
COLUMN priezvisko HEADING 'Priezvisko' FORMAT A20

BREAK ON typ SKIP 1

SELECT typ, nazov,meno, priezvisko FROM sem_predmet, sem_pozicka,
sem_citatel
WHERE sem_predmet.id_predmetu=sem_pozicka.id_predmetu
AND sem_citatel.id_citatela=sem_pozicka.id_citatela
AND datum_vratenia IS NULL
AND datum_pred_vratenia < SYSDATE
GROUP BY nazov, typ, priezvisko, meno;
