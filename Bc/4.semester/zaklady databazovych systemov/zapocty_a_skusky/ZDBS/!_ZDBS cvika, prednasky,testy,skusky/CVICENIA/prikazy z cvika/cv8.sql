/*
-- 1
SELECT meno,priezvisko, count(*)
	FROM os_udaje ou, student st, zap_predmety zp
	WHERE ou.rod_cislo = st.rod_cislo AND st.os_cislo = zp.os_cislo
	GROUP BY meno, priezvisko, st.os_cislo
	HAVING count(*)>4;

-- 2
SELECT meno, priezvisko
	FROM os_udaje ou, student st
	WHERE ou.rod_cislo = st.rod_cislo AND st.os_cislo NOT IN 
	(SELECT os_cislo FROM zap_predmety);

-- 2
SELECT meno,priezvisko 
	FROM student st,os_udaje ou
	WHERE ou.rod_cislo=st.rod_cislo AND NOT EXISTS
	(SELECT zp.os_cislo 
	FROM zap_predmety zp 
	WHERE zp.os_cislo=st.os_cislo);
*/
-- 3
SELECT meno, priezvisko, count (*)
	FROM student st, zap_predmety zp, os_udaje ou
	WHERE ou.rod_cislo = st.rod_cislo AND st.os_cislo = zp.os_cislo
	GROUP BY meno, priezvisko, zp.os_cislo,zp.cis_predm
	HAVING count(*)>1;
/*
-- 3
SELECT meno, priezvisko, zp1.skrok, zp2.skrok
	FROM os_udaje ou, student st, zap_predmety zp1, zap_predmety zp2
	WHERE ou.rod_cislo = st.rod_cislo AND st.os_cislo = zp1.os_cislo
		AND st.os_cislo = zp2.os_cislo AND zp1.skrok > zp2.skrok
		AND zp1.cis_predm = zp2.cis_predm; 

-- 4
SELECT meno, priezvisko,
	substr(rod_cislo,5,2) 
	|| '.' 
	|| decode(substr(rod_cislo,3,1),5,0,6,1,
	substr(rod_cislo,3,1))
	|| substr(rod_cislo,4,1) 
	|| '.' 
	|| '19'
	|| substr(rod_cislo,1,2)
	FROM os_udaje ;	

-- 5
SELECT meno, priezvisko, zp.cis_predm, zapocet, datum_sk, datum_sk - zapocet
	FROM zap_predmety zp, student st, os_udaje ou
	WHERE datum_sk IS NOT NULL AND zapocet IS NOT NULL and 
	ou.rod_cislo = st.rod_cislo AND st.os_cislo = zp. os_cislo;

-- 6
SELECT meno, priezvisko, zp.cis_predm, zapocet, datum_sk, datum_sk - zapocet
        FROM zap_predmety zp, student st, os_udaje ou
        WHERE datum_sk IS NOT NULL AND zapocet IS NOT NULL and
        ou.rod_cislo = st.rod_cislo AND st.os_cislo = zp.os_cislo AND (datum_sk - zapocet) > 30 ;

-- 7
SELECT meno, priezvisko, cis_predm
	FROM os_udaje ou, student st, zap_predmety zp
	WHERE zp.datum_sk IS NOT NULL AND 
	      ou.rod_cislo = st.rod_cislo AND
              st.os_cislo = zp.os_cislo AND
              (
      	           (to_char(datum_sk,'MM')BETWEEN 9 and 12 
	               AND to_char(datum_sk,'YYYY')!= zp.skrok)
         	OR (to_char(datum_sk,'MM')BETWEEN 1 and 6
                       AND to_char(datum_sk,'YYYY')= zp.skrok)
              );

*/	