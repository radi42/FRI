--vypis najaktivnejcish autorov

SET PAGESIZE 50
SET LINESIZE 50

TTITLE LEFT 'Vypis najaktivnejsich autorov'
COLUMN nazov HEADING 'Nazov' FORMAT A20
COLUMN pocet HEADING 'Pocet' FORMAT 99

SELECT priezvisko || ' ' || meno meno , count(*) pocet
FROM sem_predmet, sem_predmet_autor, sem_autor
WHERE sem_predmet.id_predmetu=sem_predmet_autor.id_predmetu
AND sem_predmet_autor.id_autor=sem_autor.id_autor
GROUP BY priezvisko, meno
ORDER BY pocet DESC;