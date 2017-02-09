commit;

select * from st_odbory;



--uloha 1
--prvy riadok tabulky

INSERT INTO os_udaje(rod_cislo, meno, priezvisko)
VALUES('121212/1212', 'Karol', 'Novy');



INSERT INTO student(rod_cislo, os_cislo, rocnik, st_odbor, st_zameranie, st_skupina)
VALUES ('121212/1212', 123, '1', 100, 0, '5ZI012');



INSERT INTO zap_predmety(os_cislo, cis_predm, skrok, prednasajuci, ects)
SELECT 123, cis_predm, skrok, garant, ects
FROM predmet_bod
WHERE cis_predm = 'BI11' AND skrok = 2008;

INSERT INTO zap_predmety(os_cislo, cis_predm, skrok, prednasajuci, ects)
SELECT 123, cis_predm, skrok, garant, ects
FROM predmet_bod
WHERE cis_predm = 'BI02' AND skrok = 2008;

INSERT INTO zap_predmety(os_cislo, cis_predm, skrok, prednasajuci, ects)
SELECT 123, cis_predm, skrok, garant, ects
FROM predmet_bod
WHERE cis_predm = 'BE01' AND skrok = 2003;

SELECT zap_predmety.cis_predm
FROM zap_predmety
WHERE zap_predmety.os_cislo = 123;



--druhy riadok tabulky

INSERT INTO os_udaje(rod_cislo, meno, priezvisko)
VALUES('232323/2323', 'Karol', 'Novsi');



INSERT INTO student(rod_cislo, os_cislo, rocnik, st_odbor, st_zameranie, st_skupina)
VALUES ('232323/2323', 90, '2', 200, 0, '5ZSA21');


INSERT INTO zap_predmety(os_cislo, cis_predm, skrok, prednasajuci, ects)
SELECT 90, cis_predm, skrok, garant, ects
FROM predmet_bod
WHERE cis_predm = 'II08' AND skrok = 2006;

INSERT INTO zap_predmety(os_cislo, cis_predm, skrok, prednasajuci, ects)
SELECT 90, cis_predm, skrok, garant, ects
FROM predmet_bod
WHERE cis_predm = 'II07' AND skrok = 2007;

SELECT zap_predmety.cis_predm
FROM zap_predmety
WHERE zap_predmety.os_cislo = 90;



--uloha 2

--b

INSERT INTO os_udaje(rod_cislo, meno, priezvisko)
SELECT rod_cislo, meno, priezvisko
FROM valentik.osoba;

--c

INSERT INTO student(rod_cislo, os_cislo, rocnik, st_skupina, st_odbor, st_zameranie)
SELECT rod_cislo, os_cislo, rocnik, st_skupina, st_odbor, st_zameranie
FROM valentik.osoba;

--d

INSERT INTO zap_predmety(os_cislo, cis_predm, skrok, prednasajuci, ects)
SELECT  os_cislo, cis_predm, skrok, garant, ects
FROM valentik.skusky
JOIN predmet_bod USING(cis_predm, skrok);

--kontrola, ci je vsetko zapisalo tak, ako je v tabulke
SELECT *
FROM os_udaje
WHERE meno = 'Karol';

SELECT st.rod_cislo, st.os_cislo, st.rocnik, st.st_skupina, st.st_odbor, st.st_zameranie
FROM student st
JOIN os_udaje os
ON(os.rod_cislo = st.rod_cislo)
WHERE os.meno = 'Karol';

SELECT zp.os_cislo, zp.cis_predm, zp.skrok, zp.prednasajuci, zp.ects
FROM zap_predmety zp
JOIN student st ON(st.os_cislo = zp.os_cislo)
JOIN os_udaje os ON(os.rod_cislo = st.rod_cislo)
WHERE os.meno = 'Karol';

rollback;