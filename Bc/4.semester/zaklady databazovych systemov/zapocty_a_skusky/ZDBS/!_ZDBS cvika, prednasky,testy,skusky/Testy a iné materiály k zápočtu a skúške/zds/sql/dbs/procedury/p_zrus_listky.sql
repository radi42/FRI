CREATE OR REPLACE PROCEDURE zrus_listky
			(p_id IN listky.id%TYPE
			)
IS
BEGIN
    DELETE FROM listky
    WHERE listky.id=p_id;
END;			
/