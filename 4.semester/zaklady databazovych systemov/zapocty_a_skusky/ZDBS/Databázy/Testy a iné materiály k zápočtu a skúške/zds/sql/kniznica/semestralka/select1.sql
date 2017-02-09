--preh.ad kníh, .asopisov, zborníkov a ich .lánkov, .lánkov
--mimo zborníkových, diplomových prác, CD príloh, CD zborníkov, ... (.alej
--budú nazývané - predmet) 

SET PAGESIZE 50
SET LINESIZE 67

TTITLE CENTER 'Prehlad predmetov'
COLUMN typ HEADING 'Typ' FORMAT A3
COLUMN nazov HEADING 'Nazov' FORMAT A20
COLUMN vydavatelstvo HEADING 'Vydavatelstvo' FORMAT A20
COLUMN info HEADING 'Info' FORMAT A20

BREAK ON typ SKIP 1

SELECT typ, nazov, vydavatelstvo, info FROM sem_predmet
GROUP BY typ,nazov,vydavatelstvo,info;
