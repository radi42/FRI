ttitle center 'Prehlad predpisanych liekov a materialu podla pacientov'
set colsep |
set underline *
SET PAGESIZE 60 
SET LINESIZE 123 
COLUMN id_pacienta HEADING "ID|pacienta" FORMAT 99999999
COLUMN meno HEADING "Meno" FORMAT A10 WORD_WRAP
COLUMN priezvisko HEADING "Priezvisko" FORMAT A15 WORD_WRAP
COLUMN naz_liek_a_mat HEADING "Nazov liekov a materialov" 

SELECT id_pacienta, meno, priezvisko, naz_liek_a_mat
FROM os_udaje_pac, spot_mat_a_liekov, zoz_liek_a_mat
WHERE meno LIKE '&meno' AND priezvisko LIKE '&priezvisko' AND
id_pacienta=os_udaje_p_id_pacienta AND id_liek_a_mat=zoz_l_a_m_id_liek_a_mat
/
