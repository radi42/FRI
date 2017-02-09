--ovyh.adávanie predmetov pod.a autorov, názvov,
--vydavate.stva, konferencie z ktorej je zborník, k.ú.ových slov s mo.nos.ou
--zada. viaceré podmienky 

SET PAGESIZE 50
SET LINESIZE 120

TTITLE CENTER 'Vyhladvanie v predmetoch...'
COLUMN meno HEADING 'Priezvisko a Meno' FORMAT A30
COLUMN typ HEADING 'Typ' FORMAT A3
COLUMN nazov HEADING 'Nazov' FORMAT A20
COLUMN vydavatelstvo HEADING 'Vydavatelstvo' FORMAT A20;
COLUMN info HEADING 'Info' FORMAT A20
COLUMN klucove_slovo HEADING 'Klucove slovo' FORMAT A20

BREAK ON meno

SELECT nazov, typ, meno || ' ' || priezvisko meno, vydavatelstvo, info,
klucove_slovo
FROM sem_klucove_slova, sem_predmet, sem_autor, sem_predmet_autor
WHERE sem_klucove_slova.id_predmetu=sem_predmet.id_predmetu
AND sem_predmet.id_predmetu=sem_predmet_autor.id_predmetu
AND sem_predmet_autor.id_autor=sem_autor.id_autor
AND nazov LIKE NVL('%&nazov%','%')
AND typ LIKE NVL('%&typ%','%')
AND meno LIKE NVL('%&autor%','%')
AND vydavatelstvo LIKE NVL('%&vydavatelstvo%','%')
AND klucove_slovo LIKE NVL('%&klucove_slovo%','%');


