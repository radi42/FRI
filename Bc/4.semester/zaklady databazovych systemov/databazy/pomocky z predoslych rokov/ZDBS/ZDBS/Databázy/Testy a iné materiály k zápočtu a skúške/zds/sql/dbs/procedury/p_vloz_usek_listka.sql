--vlozenie usek_listka
CREATE OR REPLACE PROCEDURE vloz_usek_listka
			    (p_us_id IN usek_listka.us_id%TYPE,
			     p_v_cislo_vagonu IN usek_listka.v_cislo_vagonu%TYPE,
			     p_l_id IN usek_listka.l_id%TYPE
			    )
IS 
    pocet NUMBER;
BEGIN 
    SELECT count(*) into pocet
    FROM usek_listka
    WHERE usek_listka.us_id=p_us_id
    AND usek_listka.v_cislo_vagonu=p_v_cislo_vagonu
    AND usek_listka.l_id=p_l_id;
    
    IF pocet >0
    THEN Raise_application_error(-20000,'Duplicitne zadany primarny kluc');
    END IF;
    
    SELECT count(*) into pocet
    FROM listky
    WHERE p_l_id=listky.id;
    
    IF pocet=0
    THEN Raise_application_error(-20000,'Neexistujuci listok');
    END IF;
        
    SELECT count(*) into pocet
    FROM vagon
    WHERE vagon.cislo_vagonu=p_v_cislo_vagonu;
    
    IF pocet=0
    THEN Raise_application_error(-20000,'Neexistujuci vagon');
    END IF;
    
    SELECT count(*) into pocet
    FROM usek
    WHERE usek.id=p_us_id;
    
    IF pocet=0
    THEN Raise_application_error(-20000,'Neexistujuci usek');
    END IF;
    
    INSERT INTO usek_listka VALUES(p_us_id, p_v_cislo_vagonu, p_l_id);    
END;
/
	