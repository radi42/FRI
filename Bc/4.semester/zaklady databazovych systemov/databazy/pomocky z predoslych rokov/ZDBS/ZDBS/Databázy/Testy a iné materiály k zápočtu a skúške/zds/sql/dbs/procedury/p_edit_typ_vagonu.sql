CREATE OR REPLACE PROCEDURE edit_typ_vagonu
		    (p_id IN typ_vagonu.id%TYPE,
		     p_priplatok IN typ_vagonu.priplatok%TYPE,
		     p_pocet_miest IN typ_vagonu.pocet_miest%TYPE,
		     p_nazov_typu IN typ_vagonu.nazov_typu%TYPE
		    )
IS 
BEGIN 

IF p_id IS NOT NULL THEN

    IF p_priplatok IS NOT NULL THEN
        UPDATE typ_vagonu SET priplatok=p_priplatok
	WHERE id=p_id;
    END IF;
    
    IF p_pocet_miest IS NOT NULL THEN
        UPDATE typ_vagonu SET pocet_miest=p_pocet_miest
	WHERE id=p_id;
    END IF;
    
    
    IF p_nazov_typu IS NOT NULL THEN
        UPDATE typ_vagonu SET nazov_typu=p_nazov_typu
	WHERE id=p_id;
    END IF;

END IF;
END;
/
	