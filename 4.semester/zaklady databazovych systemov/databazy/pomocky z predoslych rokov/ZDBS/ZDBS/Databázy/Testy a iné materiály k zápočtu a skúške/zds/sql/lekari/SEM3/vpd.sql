ttitle left 'Vykony podla druhu'
set colsep |
set underline *
SET PAGESIZE 60 
SET LINESIZE 123 
COLUMN id_ukonu HEADING "ID ukonu" FORMAT A8
COLUMN popis_ukonu HEADING "Nazov ukonu" 

SELECT id_ukonu, popis_ukonu FROM zoz_ukonov, vyk_ukony WHERE id_ukonu =
zoz_ukonov_id_ukonu
GROUP BY id_ukonu,popis_ukonu
/
