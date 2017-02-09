ttitle left 'Prijmy podla obdobia'
set colsep |
set underline *
SET PAGESIZE 60
SET LINESIZE 123
BREAK ON REPORT
COLUMN spolu HEADING "Prijmy" FORMAT 999999.99

SELECT SUM(cena_ukonu*Count(*)) spolu FROM zoz_ukonov, vyk_ukony
WHERE TO_CHAR(dat_uhrady, 'DD.MM.RRRR') >= '&dat_uhrady1' AND
TO_CHAR(dat_uhrady, 'DD.MM.RRRR') <=
'&dat_uhrady2' AND zoz_ukonov_id_ukonu = id_ukonu
GROUP BY cena_ukonu
/
