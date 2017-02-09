BREAK ON VLAK;
SELECT 	vlak.cislo_vlaku VLAK,
	vagon.radenie RADENIE, 
	typ_vagonu.nazov_typu TYP
FROM 	vlak, vagon, typ_vagonu
WHERE 	vlak.cislo_vlaku=vagon.vl_cislo_vlaku
AND	vagon.tv_id=typ_vagonu.id
ORDER BY vlak.cislo_vlaku,vagon.radenie;
