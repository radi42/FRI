-- vypis vyradenych knih

SET PAGESIZE 50
SET LINESIZE 25

TTITLE CENTER 'Vypis vyradenych knih'
COLUMN nazov HEADING 'Nazov' FORMAT A20

SELECT nazov FROM sem_predmet
WHERE vyradeny LIKE '1'
AND typ LIKE 'kni';
