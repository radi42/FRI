SET PAGESIZE 70;
SET LINESIZE 100;
clear col

TTITLE LEFT 'Udrzby bankomatu za rok 2013';
COLUMN pocet HEADING 'Pocet udrzieb';

SELECT count(*) AS pocet FROM servis 	
	WHERE to_char(datum_a_cas,'YYYY')='2013';