SELECT DISTINCT zap_predmety.prednasajuci, zap_predmety.cis_predm, ucitel.meno, predmet.nazov
FROM zap_predmety
JOIN ucitel
ON (zap_predmety.prednasajuci = ucitel.os_cislo)
JOIN predmet
ON (zap_predmety.cis_predm = predmet.cis_predm);