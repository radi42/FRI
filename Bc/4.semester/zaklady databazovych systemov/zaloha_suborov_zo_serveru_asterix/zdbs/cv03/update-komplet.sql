commit;

--ULOHA 1

SELECT * FROM os_udaje
WHERE meno = 'Karol';

UPDATE os_udaje
SET priezvisko = 'Stary'
WHERE meno = 'Karol' AND priezvisko = 'Novy';

SELECT * FROM os_udaje
WHERE meno = 'Karol';






--ULOHA 2

--pred apdejtom

SELECT os.meno, os.priezvisko, st.os_cislo
FROM os_udaje os
JOIN student st ON(st.rod_cislo = os.rod_cislo)
WHERE st.os_cislo = 8;



--studentovi, ktory ma osobne cislo 8 zmen meno na Carlos

UPDATE os_udaje
SET meno = 'Carlos'
WHERE os_udaje.rod_cislo IN(	SELECT student.rod_cislo FROM student
					WHERE os_cislo = 8);
--Poznamka:
--ak chcem apdejtnut atribut v jednej tabulke na zaklade udajov v inej tabulke
--musim za klauzulov WHERE uviest taky atribut, ktory maju obidve tabulky rovnaky;
--v nasom pripade je to rodne cislo



--kontrola

SELECT os.meno, os.priezvisko, st.os_cislo
FROM os_udaje os
JOIN student st ON(st.rod_cislo = os.rod_cislo)
WHERE st.os_cislo = 8;





--ULOHA 3

--pred vykonanim apdejtu

SELECT os.meno, os.priezvisko, zp.cis_predm, st.rocnik 
FROM zap_predmety zp
JOIN student st ON(st.os_cislo = zp.os_cislo)
JOIN os_udaje os ON(os.rod_cislo = st.rod_cislo)
WHERE (zp.cis_predm = 'BI11' OR zp.cis_predm = 'BI01') AND st.rocnik = '1';

--zmen vsetkym prvakom predmet 'BI11' na 'BI01'

UPDATE zap_predmety
SET cis_predm = 'BI01'
WHERE cis_predm = 'BI11'
AND zap_predmety.os_cislo IN (	SELECT student.os_cislo FROM student
					WHERE rocnik = '1');

--po vykonani apdejtu

SELECT os.meno, os.priezvisko, zp.cis_predm, st.rocnik 
FROM zap_predmety zp
JOIN student st ON(st.os_cislo = zp.os_cislo)
JOIN os_udaje os ON(os.rod_cislo = st.rod_cislo)
WHERE (zp.cis_predm = 'BI11' OR zp.cis_predm = 'BI01') AND st.rocnik = '1';





--ULOHA 4

--pred apdejtom

SELECT meno, priezvisko, stav
FROM student
JOIN os_udaje ON(os_udaje.rod_cislo = student.rod_cislo)
WHERE stav IS NULL;



--vsetci studenti, ktori nemaju definovany stav, zmen stav na 'S'

UPDATE student
SET stav = 'S'
WHERE stav IS NULL;



--kontrola, ci sa stav studentov zmenil

SELECT meno, priezvisko, stav
FROM student
JOIN os_udaje ON(os_udaje.rod_cislo = student.rod_cislo)
WHERE stav IS NULL;

SELECT os.meno, os.priezvisko, st.stav
FROM os_udaje os
JOIN student st
ON(st.rod_cislo = os.rod_cislo);





--ULOHA 5

SELECT os.meno, os.priezvisko, st.stav, st.rocnik, st.st_odbor, st.st_skupina
FROM os_udaje os
JOIN student st ON(st.rod_cislo = os.rod_cislo)
WHERE st.stav = 'S' AND st.rocnik != '3' AND st.st_odbor >= 100 AND st.st_odbor <= 199
OR st.stav = 'S' AND st.rocnik != '2' AND st.st_odbor >= 200 AND st.st_odbor <= 299;



--zvys vsetkym studentom, ktori maju stav 'S' a este nie su v poslednom rocniku, rocnik o jedna (aj v cisle studijnej skupiny). Tyka sa to aj bakalarov, aj inzinierov

UPDATE student st
SET st.rocnik = TO_CHAR(TO_NUMBER(st.rocnik)+1)
WHERE st.stav = 'S' AND st.rocnik != '3' AND st.st_odbor >= 100 AND st.st_odbor <= 199
OR st.stav = 'S' AND st.rocnik != '2' AND st.st_odbor >= 200 AND st.st_odbor <= 299;

--uprav rocnik v studijnej skupine tak, aby sa zhodoval so stlpcom rocnik

UPDATE student st
SET st.st_skupina = SUBSTR(st.st_skupina, 1, 4) || TO_CHAR(TO_NUMBER(SUBSTR(st.st_skupina, 5, 1)+1)) || SUBSTR(st.st_skupina, 6, 1)
WHERE TO_NUMBER(st.rocnik) > TO_NUMBER(SUBSTR(st.st_skupina, 5, 1));

--uprav rocnik v studijnej skupine na zhodny v stlpci rocnik v tabulke student

UPDATE student st
SET st_skupina = SUBSTR(st.st_skupina, 1, 4) || TO_CHAR(TO_NUMBER(SUBSTR(st.st_skupina, 5, 1)+1)) || SUBSTR(st.st_skupina, 6, 1)
WHERE st.rocnik NOT LIKE SUBSTR(st.st_skupina, 5, 1) AND st.stav = 'S';




--kontrola

SELECT os.meno, os.priezvisko, st.os_cislo, st.stav, st.rocnik, st.st_odbor, st.st_skupina
FROM os_udaje os
JOIN student st ON(st.rod_cislo = os.rod_cislo);

SELECT st.os_cislo, st.rocnik, st.st_skupina, st.stav
FROM student st
WHERE st.os_cislo = 550945;

UPDATE student st
SET st.st_skupina = '5ZI020'
WHERE st.os_cislo = 550945;

SELECT st.os_cislo, st.rocnik, st.st_skupina, st.stav
FROM student st
WHERE st.os_cislo = 550945;


commit;