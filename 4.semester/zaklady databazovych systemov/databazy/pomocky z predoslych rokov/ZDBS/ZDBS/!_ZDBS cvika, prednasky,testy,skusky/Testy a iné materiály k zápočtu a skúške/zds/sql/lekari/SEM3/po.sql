ttitle center 'Prehlad objednani'
set colsep |
set underline *
SET PAGESIZE 60 
SET LINESIZE 90 
COLUMN id_pacienta HEADING "ID|pacienta" FORMAT 99999999
COLUMN meno HEADING "Meno" FORMAT A10 WORD_WRAP
COLUMN priezvisko HEADING "Priezvisko" FORMAT A15 WORD_WRAP
COLUMN popis_ukonu HEADING "Názov ukonu"
COLUMN dat_objednania HEADING "Dátum|objednania"

SELECT id_pacienta, meno, priezvisko, To_Char(dat_objednania,'DD.MM.RRRR')
dat_objednania, popis_ukonu FROM
os_udaje_pac, objed_pacienta, zoz_ukonov
WHERE meno LIKE '&meno' AND priezvisko
LIKE '&priezvisko' AND id_pacienta=os_udaje_p_id_pacienta AND
zoz_ukonov_id_ukonu=id_ukonu
/
