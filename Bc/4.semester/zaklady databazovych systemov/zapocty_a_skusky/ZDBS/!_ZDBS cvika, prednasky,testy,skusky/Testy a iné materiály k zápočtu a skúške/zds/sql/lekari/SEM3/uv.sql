ttitle center 'Uhrada vykonov'
set colsep |
set underline *
SET PAGESIZE 60 
SET LINESIZE 123 
COLUMN id_pacienta HEADING "ID | pacienta" FORMAT 99999999
COLUMN meno HEADING "Meno" FORMAT A10 WORD_WRAP
COLUMN priezvisko HEADING "Priezvisko" FORMAT A15 WORD_WRAP
COLUMN dat_vykonu HEADING "Datum | vykonu"
COLUMN popis_ukonu HEADING "Meno ukonu" FORMAT A15 WORD_WRAP
COLUMN dat_uhrady HEADING "Datum | uhrady"

SELECT
id_pacienta, meno, priezvisko, TO_CHAR(dat_vykonu,'DD.MM.RRRR') dat_vykonu,
popis_ukonu, TO_CHAR(dat_uhrady,'DD.MM.RRRR'), cena_ukonu
FROM os_udaje_pac, vyk_ukony, zoz_ukonov
WHERE meno LIKE '&meno' AND priezvisko
LIKE '&priezvisko' AND zoz_zuboos_udaje_p_id_pacienta=id_pacienta AND
id_ukonu=zoz_ukonov_id_ukonu AND dat_uhrady is NOT NULL
/
