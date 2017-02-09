ttitle center 'Prehlad platieb dodavatelom'
set colsep |
set underline *
SET PAGESIZE 60 
SET LINESIZE 123 
COLUMN id_prijemka HEADING "ID|prijemka" FORMAT A8
COLUMN dat_platby HEADING "Datum|platby"
COLUMN nazov HEADING "Meno dodavatela"
COLUMN zapl_suma HEADING "Zaplatena suma" FORMAT 999999.99

SELECT id_prijemka, TO_CHAR(dat_platby,'DD.MM.RRRR') dat_platby, nazov, zapl_suma FROM
prijemka_materialu, adresar_dodavatelov
WHERE TO_CHAR(dat_platby, 'DD.MM.RRRR') >= '&dat_platby1' AND
TO_CHAR(dat_platby, 'DD.MM.RRRR') <= '&dat_platby2' AND id_adresat = &id AND
id_adresat=adres_dod_id_adresat
/
