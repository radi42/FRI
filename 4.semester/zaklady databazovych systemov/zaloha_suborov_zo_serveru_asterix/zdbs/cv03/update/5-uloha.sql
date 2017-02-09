commit;

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
SET st.st_skupina = SUBSTR(st.st_skupina, 1, 4) || st.rocnik || SUBSTR(st.st_skupina, 6, 1)
WHERE TO_NUMBER(st.rocnik) <> TO_NUMBER(SUBSTR(st.st_skupina, 5, 1));

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

rollback;