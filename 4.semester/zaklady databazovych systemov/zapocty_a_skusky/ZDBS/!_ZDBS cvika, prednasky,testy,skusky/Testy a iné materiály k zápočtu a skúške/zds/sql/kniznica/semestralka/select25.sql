--celkovy cas pozicania

SET PAGESIZE 50
SET LINESIZE 20

COLUMN cas HEADING 'Celkovy cas v dnoch'

SELECT SUM(NVL(datum_vratenia,SYSDATE) - datum_pozicky) cas
FROM sem_pozicka;