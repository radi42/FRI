-- prehlad vlakov a miest v nich za dane obdobie 

SET VERIFY OFF;
SET FEEDBACK OFF;
BREAK ON VLAK;
SELECT 	vlak.cislo_vlaku VLAK,
	typ_vagonu.nazov_typu TYP,
	SUM(typ_vagonu.pocet_miest) KAPACITA,
	prejazd_vlaku(vlak.cislo_vlaku,to_date('&CAS_OD','DD-MM-YYYY'),to_date('&CAS_DO','DD-MM-YYYY'))	POCET  
FROM 	typ_vagonu,vagon,vlak
WHERE	vlak.cislo_vlaku=vagon.vl_cislo_vlaku
AND	vagon.tv_id=typ_vagonu.id
GROUP BY vlak.cislo_vlaku,typ_vagonu.nazov_typu;

UNDEFINE CAS_OD;
UNDEFINE CAS_DO;