CREATE OR REPLACE PROCEDURE edit_stanica
		    (p_id IN stanica.id%TYPE,
		     p_nazov IN stanica.nazov%TYPE
		    )
IS 
BEGIN 

IF p_id IS NOT NULL THEN

    IF p_nazov IS NOT NULL THEN
        UPDATE stanica SET nazov=p_nazov
	WHERE id=p_id;
    END IF;
    
END IF;
END;
/
	