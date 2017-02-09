commit;

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

--kontrola
SELECT os.meno, os.priezvisko, os.rod_cislo
FROM os_udaje os
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

--vsetko zapisalo tak, ako je v tabulke
rollback;