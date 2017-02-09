--vlozenie typu_vlaku
CREATE OR REPLACE PROCEDURE vloz_typ_vlaku
		    (p_ID_typu_vlaku IN typ_vlaku.id%TYPE,
		     p_priplatok IN typ_vlaku.priplatok%TYPE,
		     p_nazov_typu IN typ_vlaku.nazov_typu%TYPE)
IS 
    pocet NUMBER;
BEGIN 
    SELECT count(*) into pocet
    FROM typ_vlaku
    WHERE typ_vlaku.id=p_ID_typu_vlaku;
    
    IF pocet >0
    THEN Raise_application_error(-20000,'Duplicitne zadany primarny kluc');
    END IF;
    
    
    INSERT INTO typ_vlaku VALUES(p_ID_typu_vlaku, p_priplatok, p_nazov_typu);
END;
/
	