--trigger na zrusenie jedneho z vlakov
CREATE OR REPLACE TRIGGER trig_del_vlak
    BEFORE DELETE 
    ON vlak
    FOR EACH ROW
BEGIN
    
    DELETE FROM usek
    WHERE usek.vl_cislo_vlaku=:old.cislo_vlaku;
    
    DELETE FROM vagon
    WHERE vagon.vl_cislo_vlaku=:old.cislo_vlaku;

--zaznamy z "usek_listka" vyhodi trigger trig_usek
END;
/