commit;

select * from st_odbory;

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

SELECT * FROM os_udaje
WHERE meno = 'Karol';

rollback;