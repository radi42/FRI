--cestovny poriadok
UNDEFINE STANICA_OD;
UNDEFINE STANICA_DO;
SET VERIFY OFF;
SET PAGESIZE 60;
SET LINESIZE 60;

COLUMN VLAK FORMAT 99999;
COLUMN ODCHOD FORMAT A8;
COLUMN PREMAVA FORMAT 9999999;
--BREAK ON VLAK;
select u.vl_cislo_vlaku VLAK,
     u.us_start ODCHOD,
     v.stop PRICHOD,
     vlak.chodi_v_dnoch PREMAVA
    from usek u, usek v,stanica,vlak
    where  
    u.vl_cislo_vlaku IN 
	(select usek.vl_cislo_vlaku
	    from usek,stanica
	    where usek.s_id=stanica.id 
	    and stanica.nazov='&&STANICA_OD'
	 group by usek.vl_cislo_vlaku    
	)
    and
    v.vl_cislo_vlaku IN
	(select usek.vl_cislo_vlaku
	    from usek,stanica
	    where usek.s_id_konci_v=stanica.id
	    and stanica.nazov='&&STANICA_DO'	
	 group by usek.vl_cislo_vlaku    
	)
    and u.vl_cislo_vlaku=v.vl_cislo_vlaku
    and u.stop<v.stop
    and v.s_id=(select stanica.id from stanica where stanica.nazov='&&STANICA_DO')
    and u.s_id=stanica.id
    and stanica.nazov='&&STANICA_OD'	
    and u.vl_cislo_vlaku=vlak.cislo_vlaku
group by u.vl_cislo_vlaku, u.us_start,v.stop,vlak.chodi_v_dnoch;
UNDEFINE STANICA_OD;
UNDEFINE STANICA_DO;



