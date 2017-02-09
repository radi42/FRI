SET PAGESIZE 60;
SET LINESIZE 123;
clear col

TTITLE CENTER 'Zoznam obedov ktore obsahuju zemiak';
BTITLE RIGHT SQL.PNO
COLUMN nazov HEADING 'Nazov jedla';

Select nazov_jedla as nazov
from jedlo je join zlozenie zl ON (je.id_jedla = zl.id_jedla)
where je.kategoria = 'obed'
and (zl.id_suroviny = 333 or zl.id_suroviny = 334 or zl.id_suroviny = 335);

ttitle off;
btitle off;
