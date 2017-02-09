--pocet rovnakych predmetov

SET PAGESIZE 50
SET LINESIZE 30

TTITLE LEFT 'Vypis rovnakych predmetov'
COLUMN nazov HEADING 'Nazov' FORMAT A20
COLUMN pocet HEADING 'Pocet' FORMAT 99

SELECT nazov, count(*) pocet FROM sem_predmet, sem_predmet_autor, sem_autor
WHERE sem_predmet.id_predmetu=sem_predmet_autor.id_predmetu
AND sem_predmet_autor.id_autor=sem_autor.id_autor
GROUP BY nazov, sem_autor.id_autor
HAVING count(*) > 1;