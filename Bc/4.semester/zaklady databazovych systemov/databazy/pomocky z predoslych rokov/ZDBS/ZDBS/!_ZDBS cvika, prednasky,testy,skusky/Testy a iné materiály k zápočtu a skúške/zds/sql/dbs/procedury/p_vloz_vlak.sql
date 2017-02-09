--vlozenie vlaku
CREATE OR REPLACE PROCEDURE vloz_vlak
		    (p_cislo_vlaku IN vlak.cislo_vlaku%TYPE,
		     p_tvl_id IN vlak.tvl_id%TYPE,
		     p_chodi_v_dnoch IN vlak.chodi_v_dnoch%TYPE)
IS 
    pocet NUMBER;
BEGIN 
    SELECT count(*) into pocet
    FROM vlak
    WHERE vlak.cislo_vlaku=p_cislo_vlaku;
    
    IF pocet >0
    THEN Raise_application_error(-20000,'Duplicitne zadany primarny kluc');
    END IF;
    
    SELECT count(*) into pocet
    FROM typ_vlaku
    WHERE typ_vlaku.id=p_tvl_id;
    
    IF pocet=0
    THEN Raise_application_error(-20000,'Neexistujuci typ vlaku');
    END IF;
    
    INSERT INTO vlak VALUES(p_cislo_vlaku, p_tvl_id ,p_chodi_v_dnoch);
END;
/
	