--pocet vlakov prechdzajucich cez stanicu za dane obdobie
--za prejazd pokladam vyjazd zo stanice
UNDEFINE STANICA;
UNDEFINE CAS_OD;
UNDEFINE CAS_DO;
SET VERIFY OFF;
SET FEEDBACK OFF;
CREATE TABLE prejazd
(id_vlaku NUMBER,
 pocet NUMBER);

INSERT INTO prejazd(
SELECT 	u.vl_cislo_vlaku,
	prejazd_vlaku(u.vl_cislo_vlaku,to_date('&CAS_OD','DD-MM-YYYY'),to_date('&CAS_DO','DD-MM-YYYY')) 
FROM 	usek u, stanica s
WHERE 	'&STANICA'=s.nazov
AND 	s.id=u.s_id
);

SELECT 	id_vlaku VLAK, pocet POCET
FROM 	prejazd;

SELECT 	SUM(pocet) SUMA
FROM	prejazd;

UNDEFINE STANICA;
UNDEFINE CAS_OD;
UNDEFINE CAS_DO;

drop table prejazd;