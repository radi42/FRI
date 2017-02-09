ttitle center 'Prehlad predpisanych liekov a materialu za obdobie'
set colsep |
set underline *
SET PAGESIZE 60 
SET LINESIZE 123 
COLUMN id_liek_a_mat HEADING "ID" FORMAT A6
COLUMN naz_liek_a_mat HEADING "Meno lieku a materialu"
COLUMN dat_spot HEADING "Datum|spotreby"

SELECT id_liek_a_mat, naz_liek_a_mat, TO_CHAR(dat_spot,'DD.MM.RRRR')
dat_spot
FROM zoz_liek_a_mat, spot_mat_a_liekov
WHERE TO_CHAR(dat_spot, 'DD.MM.RRRR') >= '&dat_spot1' AND
TO_CHAR(dat_spot, 'DD.MM.RRRR') <=
'&dat_spot2' AND id_liek_a_mat = zoz_l_a_m_id_liek_a_mat
/
