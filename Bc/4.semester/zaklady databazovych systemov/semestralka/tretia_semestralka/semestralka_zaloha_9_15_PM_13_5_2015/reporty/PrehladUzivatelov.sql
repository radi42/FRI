-- Lukas Kabat

-- A4
SET PAGESIZE 60
SET LINESIZE 123
TTITLE CENTER "Prehlad zlozenia uzívatelov"
BTITLE RIGHT SQL.PNO
COLUMN meno FORMAT A9 WORD_WRAP
COLUMN priezvisko FORMAT A9 WORD_WRAP
COLUMN vaha_zaciatocna FORMAT 999 WORD_WRAP

declare var volba:='&zoradit_podla_(pohlavie, vek, typ cie¾a (chudnutie, udržovanie váhy, pribratie) )';
Select * from osoba

;