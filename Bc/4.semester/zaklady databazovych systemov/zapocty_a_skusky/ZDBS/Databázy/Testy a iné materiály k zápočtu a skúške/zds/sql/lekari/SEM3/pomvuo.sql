ttitle left 'Prehlad objednaneho materialu v urcitom obdobi'
set colsep |
set underline *
SET PAGESIZE 60 
SET LINESIZE 123 
COLUMN id_objednavka HEADING "ID" FORMAT A6
COLUMN dat_objednavky HEADING "Datum|objednavky"
COLUMN naz_liek_a_mat HEADING "Meno materialu a lieku"
COLUMN mnozstvo HEADING "Mnozstvo" FORMAT 999999.99

SELECT id_objednavka, dat_objednavky, naz_liek_a_mat, mnozstvo
FROM zoz_liek_a_mat, zoz_objed_mat, objednavka_materialu
WHERE TO_CHAR(dat_objednavky, 'DD.MM.RRRR') >= '&dat_objednavky1' AND
TO_CHAR(dat_objednavky, 'DD.MM.RRRR') <= '&dat_objednavky2'
AND id_liek_a_mat=zoz_l_a_m_id_liek_a_mat AND
objed_mat_id_objednavka=id_objednavka
/
