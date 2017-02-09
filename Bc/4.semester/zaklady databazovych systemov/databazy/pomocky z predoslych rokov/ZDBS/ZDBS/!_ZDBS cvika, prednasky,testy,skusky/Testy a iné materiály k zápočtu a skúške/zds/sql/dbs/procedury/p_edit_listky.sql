CREATE OR REPLACE PROCEDURE edit_listky
		    (p_id IN listky.id%TYPE,
		     p_s_id IN listky.s_id%TYPE,
		     p_s_id_plati_po IN listky.s_id_plati_po%TYPE,
		     p_datum IN listky.datum%TYPE,
		     p_zaplatene IN listky.zaplatene%TYPE
		    )
IS 
BEGIN 

IF p_id IS NOT NULL THEN

    IF p_s_id IS NOT NULL THEN
        UPDATE listky SET s_id=p_s_id
	WHERE id=p_id;
    END IF;
    
    IF p_s_id_plati_po IS NOT NULL THEN
        UPDATE listky SET s_id_plati_po=p_s_id_plati_po
	WHERE id=p_id;
    END IF;
    
    IF p_datum IS NOT NULL THEN
        UPDATE listky SET datum=p_datum
	WHERE id=p_id;
    END IF;
    
    IF p_zaplatene IS NOT NULL THEN
        UPDATE listky SET zaplatene=p_zaplatene
	WHERE id=p_id;
    END IF;
    
    
    
END IF;
END;
/
	