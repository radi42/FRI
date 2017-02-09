ttitle center 'Vykony podla pacienta'
set colsep |
set underline *
SET PAGESIZE 60 
SET LINESIZE 123 
COLUMN id_pacienta HEADING "ID" FORMAT 999999 
COLUMN meno HEADING "Meno" FORMAT A10 WORD_WRAP 
COLUMN priezvisko HEADING "Priezvisko" FORMAT A15 WORD_WRAP
COLUMN popis_ukonu HEADING "Nazov ukonu" 
COLUMN datum HEADING "Datum|ukonu"

SELECT id_ukonu, TO_CHAR(dat_vykonu,'DD.MM.RRRR') datum,  meno, priezvisko,
popis_ukonu FROM zoz_ukonov, vyk_ukony,zoz_zubov, os_udaje_pac
WHERE meno LIKE '&meno' AND priezvisko LIKE '&priezvisko' AND
zoz_zuboos_udaje_p_id_pacienta=id_pacienta AND id_ukonu=zoz_ukonov_id_ukonu
/
