commit;

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

rollback;