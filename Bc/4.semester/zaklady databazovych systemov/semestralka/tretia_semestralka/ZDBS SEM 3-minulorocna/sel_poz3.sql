SET PAGESIZE 70;
SET LINESIZE 40;
clear col

TTITLE CENTER 'Pocet bankomatov jednotlivych typov';

COLUMN typ_bankomatu HEADING 'Typ bankomatu' format A14;
COLUMN pocet HEADING 'Pocet';

SELECT typ_bankomatu, COUNT(*) AS pocet from typ_bankomatu
GROUP BY typ_bankomatu;
