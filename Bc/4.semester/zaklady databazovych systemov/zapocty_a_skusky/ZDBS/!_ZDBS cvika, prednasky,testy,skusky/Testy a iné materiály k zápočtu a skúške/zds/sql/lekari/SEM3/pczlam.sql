ttitle center 'Prehlad cien za jednotlive druhy vykonov '
set colsep |
set underline *
SET PAGESIZE 60 
SET LINESIZE 123 
COLUMN id_ukonu HEADING "ID" FORMAT A6
COLUMN popis_ukonu HEADING "popis ukonu"
COLUMN cena_ukonu HEADING "cena ukonu" FORMAT 999999.99

SELECT id_ukonu, popis_ukonu, cena_ukonu FROM zoz_ukonov
/
