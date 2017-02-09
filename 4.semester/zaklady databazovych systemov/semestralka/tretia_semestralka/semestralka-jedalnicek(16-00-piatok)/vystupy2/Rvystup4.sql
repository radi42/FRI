SET PAGESIZE 60;
SET LINESIZE 123;
clear col

TTITLE Center 'Pocet tukov, bielkovin, sacharidov zo suroviny vajce';
COLUMN tuky HEADING 'Tuky';
COLUMN bielkoviny HEADING 'Bielkoviny';
COLUMN sacharidy HEADING 'Sacharidy';
COLUMN tuky Format 0.99;
COLUMN bielkoviny Format 0.99;
COLUMN sacharidy Format 0.999;

btitle right sql.pno; 

select tuky, bielkoviny, sacharidy from surovina
where nazov_suroviny = 'vajce';


btitle off;
ttitle off;