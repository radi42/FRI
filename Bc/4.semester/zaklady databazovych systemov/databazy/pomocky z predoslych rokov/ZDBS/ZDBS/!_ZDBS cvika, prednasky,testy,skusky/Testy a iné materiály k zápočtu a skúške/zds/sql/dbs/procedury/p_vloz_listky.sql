--vlozenie listka
CREATE OR REPLACE PROCEDURE vloz_listky
		    (p_id IN listky.id%TYPE,
		     p_s_id IN listky.s_id%TYPE,
		     p_s_id_plati_po IN listky.s_id_plati_po%TYPE,
		     p_datum IN listky.datum%TYPE,
		     p_zaplatene IN listky.zaplatene%TYPE
		    )
IS 
    pocet NUMBER;
BEGIN 
    SELECT count(*) into pocet
    FROM listky
    WHERE listky.id=p_id;
    
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
    WHERE p_s_id_plati_po=stanica.id;
    
    IF pocet=0
    THEN Raise_application_error(-20000,'Neexistujuca stanica');
    END IF;
    
    INSERT INTO listky VALUES(p_id, p_s_id, p_s_id_plati_po, p_datum, p_zaplatene);    
END;
/
	