CREATE OR REPLACE PROCEDURE edit_typ_vlaku
		    (p_id IN typ_vlaku.id%TYPE,
		     p_priplatok IN typ_vlaku.priplatok%TYPE,
		     p_nazov_typu IN typ_vlaku.nazov_typu%TYPE
		    )
IS 
BEGIN 

IF p_id IS NOT NULL THEN

    IF p_priplatok IS NOT NULL THEN
        UPDATE typ_vlaku SET priplatok=p_priplatok
	WHERE id=p_id;
    END IF;
    
    IF p_nazov_typu IS NOT NULL THEN
        UPDATE typ_vlaku SET nazov_typu=p_nazov_typu
	WHERE id=p_id;
    END IF;

END IF;
END;
/
	