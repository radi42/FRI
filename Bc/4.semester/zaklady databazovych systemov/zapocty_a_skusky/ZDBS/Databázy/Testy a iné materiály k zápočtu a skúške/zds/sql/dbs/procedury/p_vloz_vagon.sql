--vlozenie vagona
CREATE OR REPLACE PROCEDURE vloz_vagon
		    (p_cislo_vagonu IN vagon.cislo_vagonu%TYPE,
		     p_tv_id IN vagon.tv_id%TYPE,
		     p_radenie IN vagon.radenie%TYPE,
		     p_vl_cislo_vlaku IN vagon.vl_cislo_vlaku%TYPE)
IS 
    pocet NUMBER;
BEGIN 
    SELECT count(*) into pocet
    FROM vagon
    WHERE vagon.cislo_vagonu=p_cislo_vagonu;
    
    IF pocet >0
    THEN Raise_application_error(-20000,'Duplicitne zadany primarny kluc');
    END IF;
    
    SELECT count(*) into pocet
    FROM vlak
    WHERE vlak.cislo_vlaku=p_vl_cislo_vlaku;
    
    IF pocet=0
    THEN Raise_application_error(-20000,'Neexistujuci vlaku');
    END IF;
    
    INSERT INTO vagon VALUES(p_cislo_vagonu, p_tv_id ,p_radenie, p_vl_cislo_vlaku);
END;
/
	