--vlozenie typu_vagonu
CREATE OR REPLACE PROCEDURE vloz_typ_vagonu
		    (p_ID_typ_vagonu IN typ_vagonu.id%TYPE,
		     p_priplatok IN typ_vagonu.priplatok%TYPE,
		     p_pocet_miest IN typ_vagonu.pocet_miest%TYPE,
		     p_nazov_typu IN typ_vagonu.nazov_typu%TYPE)
IS 
    pocet NUMBER;
BEGIN 
    SELECT count(*) into pocet
    FROM typ_vagonu
    WHERE typ_vagonu.id=p_ID_typ_vagonu;
    
    IF pocet >0
    THEN Raise_application_error(-20000,'Duplicitne zadany primarny kluc');
    END IF;
    
    
    INSERT INTO typ_vagonu VALUES(p_ID_typ_vagonu, p_priplatok,p_pocet_miest, p_nazov_typu);
END;
/
	