SELECT count(os_cislo)
FROM zap_predmety
WHERE cis_predm IN (select cis_predm from predmet where nazov like '%databaz%');

--kod predmetu zistime z nazvu takto:
--select cis_predm from predmet where nazov like '%databaz%';