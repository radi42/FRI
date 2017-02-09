ttitle center 'Zoznam pacientov'
set colsep |
set underline *
SET PAGESIZE 60 
SET LINESIZE 123 
COLUMN id_pacienta HEADING "ID" FORMAT 999999
COLUMN meno HEADING "Meno | pacienta" FORMAT A10 WORD_WRAP
COLUMN priezvisko HEADING "Priezvisko" FORMAT A15 WORD_WRAP
COLUMN adr_ulica HEADING "Adresa" FORMAT A15 WORD_WRAP
COLUMN obec HEADING "Obec" FORMAT A10 WORD_WRAP
COLUMN datum HEADING "Datum|prijatia" 

SELECT
id_pacienta, meno, priezvisko,adr_ulica, obec,
TO_CHAR(dat_prijatia,'DD.MM.RRRR')datum FROM os_udaje_pac
WHERE dat_vyradenia IS NULL
ORDER BY priezvisko,meno
/
