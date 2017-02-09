--vlozenie stanice
CREATE OR REPLACE PROCEDURE vloz_stanicu
		    (p_ID_stanice IN stanica.id%TYPE,
		     p_nazov_stanice IN stanica.nazov%TYPE)
IS 
    pocet NUMBER;
BEGIN 
    SELECT count(*) into pocet
    FROM stanica
    WHERE stanica.id=p_ID_stanice;
    
    IF pocet >0
    THEN Raise_application_error(-20000,'Duplicitne zadany primarny kluc');
    END IF;
    
    SELECT count(*) into pocet
    FROM stanica
    WHERE stanica.nazov=p_nazov_stanice;
    
    IF pocet > 0
    THEN Raise_application_error(-2000,'Duplicitne meno stanice');
    END IF;
    
    INSERT INTO stanica VALUES(p_ID_stanice,p_nazov_stanice);
END;
/
	