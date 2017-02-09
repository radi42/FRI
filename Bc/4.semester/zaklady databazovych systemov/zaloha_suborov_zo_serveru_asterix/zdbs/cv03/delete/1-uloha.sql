commit;

--predtym

SELECT zp.os_cislo, zp.cis_predm
FROM zap_predmety zp
WHERE zp.os_cislo LIKE 123;

--vymaz predmet be01 studentovi 123

DELETE FROM zap_predmety zp
WHERE zp.cis_predm LIKE 'BE01' AND zp.os_cislo = 123;

SELECT zp.os_cislo, zp.cis_predm
FROM zap_predmety zp
WHERE zp.os_cislo = 123;

rollback;