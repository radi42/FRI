CREATE OR REPLACE PROCEDURE edit_vlak
		    (p_cislo_vlaku IN vlak.cislo_vlaku%TYPE,
		     p_tvl_id IN vlak.tvl_id%TYPE,
		     p_chodi_v_dnoch IN vlak.chodi_v_dnoch%TYPE
		    )
IS 
BEGIN 

IF p_cislo_vlaku IS NOT NULL THEN

    IF p_tvl_id IS NOT NULL THEN
        UPDATE vlak SET tvl_id=p_tvl_id
	WHERE cislo_vlaku=p_cislo_vlaku;
    END IF;
    
    IF p_chodi_v_dnoch IS NOT NULL THEN
        UPDATE vlak SET chodi_v_dnoch=p_chodi_v_dnoch
	WHERE cislo_vlaku=p_cislo_vlaku;
    END IF;

END IF;
END;
/
	