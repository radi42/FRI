ttitle center 'Stav chrupu pacienta'
set colsep |
set underline *
SET PAGESIZE 60 
SET LINESIZE 123 
COLUMN id_pacienta HEADING "ID|pacienta" FORMAT 99999999
COLUMN meno HEADING "Meno" FORMAT A10 WORD_WRAP
COLUMN priezvisko HEADING "Priezvisko" FORMAT A15 WORD_WRAP
COLUMN zub HEADING "Zub" FORMAT A4
COLUMN stav_zuba HEADING "Stav zuba"

SELECT id_pacienta, meno, priezvisko, zub, stav_zuba FROM zoz_zubov,
os_udaje_pac
WHERE meno LIKE '&meno' AND priezvisko
LIKE '&priezvisko' AND os_udaje_p_id_pacienta=id_pacienta
/
