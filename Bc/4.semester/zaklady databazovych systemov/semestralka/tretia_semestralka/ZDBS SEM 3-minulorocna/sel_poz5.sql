SET PAGESIZE 70;
SET LINESIZE 100;
clear col

TTITLE LEFT 'Zoznam zakaznikov, ktori pouzili bankomat typu inside1';

COLUMN meno HEADING 'Meno' format A20;
COLUMN priezvisko HEADING 'Priezvisko' format A20;

SELECT meno,priezvisko from osoba
	JOIN transakcie on(transakcie.rod_cislo=osoba.rod_cislo)
	JOIN bankomat on(bankomat.id_bankomatu=transakcie.id_bankomatu)
	JOIN typ_bankomatu on(typ_bankomatu.typ_bankomatu=bankomat.typ_bankomatu)
WHERE typ_bankomatu.typ_bankomatu = 'inside1';