--vlozenie usek
CREATE OR REPLACE PROCEDURE vloz_usek
			    (p_id IN usek.id%TYPE,
			     p_s_id IN usek.s_id%TYPE,
			     p_s_id_konci_v IN usek.s_id_konci_v%TYPE,
			     p_vl_cislo_vlaku IN usek.vl_cislo_vlaku%TYPE,
			     p_km IN usek.km%TYPE,
			     p_stop IN usek.stop%TYPE,
			     p_us_start IN usek.us_start%TYPE
			    )
IS 
    pocet NUMBER;
BEGIN 
    SELECT count(*) into pocet
    FROM usek
    WHERE usek.id=p_id;
    
    IF pocet >0
    THEN Raise_application_error(-20000,'Duplicitne zadany primarny kluc');
    END IF;
    
    SELECT count(*) into pocet
    FROM stanica
    WHERE p_s_id=stanica.id;
    
    IF pocet=0
    THEN Raise_application_error(-20000,'Neexistujuca stanica');
    END IF;


    SELECT count(*) into pocet
    FROM stanica
    WHERE p_s_id_konci_v=stanica.id;
    
    IF pocet=0
    THEN Raise_application_error(-20000,'Neexistujuca stanica');
    END IF;
        
    SELECT count(*) into pocet
    FROM vlak
    WHERE vlak.cislo_vlaku=p_vl_cislo_vlaku;
    
    IF pocet=0
    THEN Raise_application_error(-20000,'Neexistujuci vlak');
    END IF;
    
    IF p_stop<p_us_start
    THEN Raise_application_error(-20000,'Abnormalita casu');
    END IF;

    INSERT INTO usek VALUES(p_id,p_s_id,p_s_id_konci_v, p_vl_cislo_vlaku, p_km, p_stop, p_us_start);    
END;
/
	