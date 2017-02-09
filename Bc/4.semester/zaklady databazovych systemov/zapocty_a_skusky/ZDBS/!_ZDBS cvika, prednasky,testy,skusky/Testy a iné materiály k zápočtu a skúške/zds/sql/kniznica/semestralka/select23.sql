--vypis rezervovanych predmetov

SET PAGESIZE 50
SET LINESIZE 30

TTITLE LEFT 'Vypis rezervovanych predmetov'
COLUMN nazov HEADING 'Nazov' FORMAT A20

SELECT nazov, typ FROM sem_rezervacia, sem_predmet
WHERE sem_rezervacia.id_predmetu=sem_predmet.id_predmetu
AND SYSDATE BETWEEN datum_rezervacie AND datum_konca_rez;
