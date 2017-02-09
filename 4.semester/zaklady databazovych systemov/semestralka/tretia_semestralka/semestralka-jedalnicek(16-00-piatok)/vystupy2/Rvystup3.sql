SET PAGESIZE 60;
SET LINESIZE 123;
clear col

TTITLE CENTER 'Zoznam prvych 10 jedla s najvacsim poctom kalorii';
BTITLE RIGHT SQL.PNO
COLUMN nazov HEADING 'Nazov jedla';
COLUMN kalorie HEADING 'Pocet kalorii'

select nazov_jedla nazov, kalorie_jedla kalorie from
(select * from jedlo order by kalorie_jedla desc)
where rownum < 11;

ttitle off;
btitle off;
