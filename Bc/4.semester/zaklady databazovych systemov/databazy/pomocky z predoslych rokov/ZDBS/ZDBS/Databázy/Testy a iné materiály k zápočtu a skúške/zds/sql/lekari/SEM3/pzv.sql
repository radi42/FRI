ttitle center 'Prijmy za vykony'
set colsep |
set underline *
SET PAGESIZE 60 
SET LINESIZE 123 
BREAK ON REPORT

COLUMN zoz_ukonov_id_ukonu HEADING "ID ukonu" A8
COLUMN popis_ukonu HEADING "Názov ukonu"
COLUMN spolu HEADING "Príjem | za ukon"

SELECT zoz_ukonov_id_ukonu, popis_ukonu, SUM(cena_ukonu) spolu
FROM zoz_ukonov, vyk_ukony
WHERE zoz_ukonov_id_ukonu = id_ukonu
GROUP BY zoz_ukonov_id_ukonu,popis_ukonu
ORDER BY zoz_ukonov_id_ukonu
/
