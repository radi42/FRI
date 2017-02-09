CREATE OR REPLACE PROCEDURE zrus_usek
			(p_id IN usek.id%TYPE)
IS
BEGIN
    DELETE FROM usek
    WHERE usek.id=p_id;
END;			
/