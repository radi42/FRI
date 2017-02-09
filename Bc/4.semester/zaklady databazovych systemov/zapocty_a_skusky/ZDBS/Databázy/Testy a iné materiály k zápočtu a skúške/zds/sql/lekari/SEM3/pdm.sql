ttitle center 'Prehlad dodaneho materialu'
set colsep |
set underline *
SET PAGESIZE 60 
SET LINESIZE 75 
COLUMN id_prijemka HEADING "ID |prijemka" FORMAT A8
COLUMN naz_liek_a_mat HEADING "Meno materialu a lieku"
COLUMN dat_prijatia HEADING "Datum |prijatia"
COLUMN mnozstvo HEADING "Mnozstvo" FORMAT 999999.99

SELECT id_prijemka, TO_CHAR(dat_prijatia,'DD.MM.RRRR') dat_prijatia, naz_liek_a_mat, mnozstvo
FROM zoz_liek_a_mat, zoz_prijat_mat, prijemka_materialu
WHERE TO_CHAR(dat_prijatia, 'DD.MM.RRRR') >= '&dat_prijatia1' AND
TO_CHAR(dat_prijatia, 'DD.MM.RRRR') <= '&dat_prijatia2'
AND id_liek_a_mat=zoz_l_a_m_id_liek_a_mat AND
id_prijemka=prijem_mat_id_prijemka
/
