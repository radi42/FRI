ttitle left 'Vykony podla casoveho obdobia'
set colsep |
set underline *
SET PAGESIZE 60 
SET LINESIZE 123 
COLUMN id_ukonu HEADING "ID ukonu" FORMAT A8
COLUMN popis_ukonu HEADING "Nazov ukonu"
COLUMN dat_vykonu HEADING "Datum"

SELECT id_ukonu, popis_ukonu, dat_vykonu FROM vyk_ukony, zoz_ukonov
WHERE TO_CHAR(dat_vykonu,'DD.MM.RRRR') >= '&dat_od' AND TO_CHAR(dat_vykonu,'DD.MM.RRRR') <= '&dat_do' AND
zoz_ukonov_id_ukonu=id_ukonu
/
