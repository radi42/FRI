ttitle center 'Prehlad dodavatelov'
set colsep |
set underline *
SET PAGESIZE 60 
SET LINESIZE 120 
COLUMN id_adresat HEADING "ID" FORMAT 999999
COLUMN nazov HEADING "Meno" FORMAT A15 WORD_WRAP
COLUMN ulica HEADING "Adresa" FORMAT A15 WORD_WRAP
COLUMN obec HEADING "Obec" FORMAT A10 WORD_WRAP
COLUMN ICO HEADING "ICO" FORMAT A10
COLUMN DIC HEADING "DIC" FORMAT A15
COLUMN telefon HEADING "Telefon" FORMAT A15

SELECT id_adresat, nazov, ulica, obec, ICO, DIC, telefon
FROM adresar_dodavatelov
/
