SELECT DISTINCT prednasajuci, cis_predm, meno, nazov
FROM zap_predmety

//importuj potrebne tabulky
JOIN ucitel
ON(ucitel.os_cislo = zap_predmety.prednasajuci)
JOIN predmet
ON(predmet.cis_predm = zap_predmety.cis_predm)