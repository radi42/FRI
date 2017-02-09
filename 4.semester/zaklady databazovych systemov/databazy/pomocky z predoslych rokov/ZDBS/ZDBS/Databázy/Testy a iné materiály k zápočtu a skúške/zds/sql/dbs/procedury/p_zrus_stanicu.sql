CREATE OR REPLACE PROCEDURE zrus_stanicu
			(p_id IN stanica.id%TYPE
			)
IS
BEGIN
    DELETE FROM stanica
    WHERE stanica.id=p_id;
END;			
/