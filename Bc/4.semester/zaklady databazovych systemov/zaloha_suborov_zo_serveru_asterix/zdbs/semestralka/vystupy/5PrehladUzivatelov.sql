-- Lukas Kabat

-- Uzivatel zada pohlavie, vek ,ciel uzivatelou a rozsah datumov v ktorych uzivatel nastupil a vypise uzivatelov ktroy splnaju zadane kriteria

-- A4
SET PAGESIZE 60
SET LINESIZE 123
TTITLE CENTER "Prehlad zlozenia uzívatelov"
BTITLE RIGHT SQL.PNO
COLUMN os_cislo HEADING 'Osobne|cislo'
COLUMN meno HEADING 'Meno' FORMAT A9 WORD_WRAP
COLUMN priezvisko HEADING  'Priezvisko' FORMAT A10 WORD_WRAP
COLUMN vaha_zaciatocna HEADING 'Vaha|zaciatocna' FORMAT 999 WORD_WRAP
COLUMN vaha_ciel HEADING 'Vaha|cielova'
COLUMN datum_nastupu HEADING 'Datum|nastupu' 
COLUMN datum_narodenia HEADING 'Datum|narodenia'
COLUMN pohlavie HEADING 'Po|hla|vie' FORMAT A3 
COLUMN tuky_ciel HEADING 'Cielove|tuky|(za den)' 
COLUMN sach_ciel HEADING 'Cielove|cukry|(za den)' 
COLUMN bielk_ciel HEADING 'Cielove|bielkoviny|(za den)' 
COLUMN kcal_ciel HEADING 'Cielove|kilokalorie|(za den)' 

Select * from osoba
where
pohlavie = '&pohlavie' and
TRUNC(MONTHS_BETWEEN(SYSDATE, datum_narodenia)/12) = &vek
and datum_nastupu between to_date('&datumOd','DD.MM.YYYY') and to_date('&datumDo','DD.MM.YYYY')
-- zistit ci chudnu alebo priberaju
and sign(vaha_ciel-vaha_zaciatocna)= decode('&ciel','chudnutie',-1,'vyvazene',0,'priberanie',1);


ttitle off;
btitle off;
clear columns;