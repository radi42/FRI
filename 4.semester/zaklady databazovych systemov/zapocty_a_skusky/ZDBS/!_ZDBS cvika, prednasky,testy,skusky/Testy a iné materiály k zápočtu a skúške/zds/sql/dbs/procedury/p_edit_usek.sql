CREATE OR REPLACE PROCEDURE edit_usek
		    (p_id IN usek.id%TYPE,
		     p_s_id IN usek.s_id%TYPE,
		     p_s_id_konci_v IN usek.s_id_konci_v%TYPE,
		     p_vl_cislo_vlaku IN usek.vl_cislo_vlaku%TYPE,
		     p_stop IN usek.stop%TYPE,
		     p_us_start IN usek.us_start%TYPE
		    )
IS 
BEGIN 

IF p_id IS NOT NULL THEN

    IF p_s_id IS NOT NULL THEN
        UPDATE usek SET s_id=p_s_id
	WHERE id=p_id;
    END IF;
    
    IF p_s_id_konci_v IS NOT NULL THEN
        UPDATE usek SET s_id_konci_v=p_s_id_konci_v
	WHERE id=p_id;
    END IF;

    IF p_vl_cislo_vlaku IS NOT NULL THEN
        UPDATE usek SET vl_cislo_vlaku=p_vl_cislo_vlaku
	WHERE id=p_id;
    END IF;
    
    IF p_stop IS NOT NULL THEN
        UPDATE usek SET stop=p_stop
	WHERE id=p_id;
    END IF;
    
    IF p_us_start IS NOT NULL THEN
        UPDATE usek SET us_start=p_us_start
	WHERE id=p_id;
    END IF;
    
END IF;
END;
/
	