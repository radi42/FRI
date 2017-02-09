SELECT pr.cis_predm, pr.nazov, min(zp.vysledok) AS min_znamka, max(zp.vysledok) AS max_znamka, count(st.os_cislo) AS pocet_studentov
FROM predmet pr
JOIN zap_predmety zp ON (zp.cis_predm= pr.cis_predm)
JOIN student st ON (st.os_cislo= zp.os_cislo)
GROUP BY pr.cis_predm, pr.nazov; 

--tie stlpce, ktore nie su agregacnej funkcii, musia byt v group by