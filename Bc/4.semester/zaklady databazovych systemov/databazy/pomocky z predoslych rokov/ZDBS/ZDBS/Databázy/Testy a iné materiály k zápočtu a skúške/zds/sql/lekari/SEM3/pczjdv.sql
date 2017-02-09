ttitle left 'Prehlad cien za lieky a material'
set colsep |
set underline *
SET PAGESIZE 60 
SET LINESIZE 123 
COLUMN id_liek_a_mat HEADING "ID"
COLUMN naz_liek_a_mat HEADING "Nazov materialu"
COLUMN cena_liek_a_mat HEADING "Cena materialu" FORMAT 999999.99

SELECT id_liek_a_mat, naz_liek_a_mat, cena_liek_a_mat FROM zoz_liek_a_mat
/
