ttitle center 'Prehlad pacientov podla poistovni'
set colsep |
set underline *
SET PAGESIZE 60 
SET LINESIZE 123 
COLUMN nazov_poistovne HEADING "Meno poistovne"
COLUMN meno HEADING "Meno pacienta" 
COLUMN priezvisko HEADING "Priezvisko | pacienta"
COLUMN id_poistovne HEADING "ID"

SELECT id_poistovne, nazov_poistovne, meno, priezvisko
FROM os_udaje_pac, zoz_poist
WHERE id_poistovne = zoz_poist_id_poistovne
ORDER BY zoz_poist_id_poistovne
/
