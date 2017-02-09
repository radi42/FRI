--evidencia osobných údajov .itate.ov a kontaktov (mobil, email,...) 

SET PAGESIZE 50
SET LINESIZE 100

TTITLE CENTER 'Evidencia osobnych udajov'
COLUMN meno HEADING 'Priezvisko a meno' FORMAT A40
COLUMN typ_kontaktu HEADING 'Typ|kontaktu' FORMAT A18
COLUMN kontakt HEADING 'Kontakt' FORMAT A20

BREAK ON meno

SELECT priezvisko || ' ' || meno meno, typ_kontaktu, kontakt
FROM sem_citatel, sem_kontakt
WHERE sem_citatel.id_citatela=sem_kontakt.id_citatela
GROUP BY priezvisko, meno, typ_kontaktu, kontakt;
