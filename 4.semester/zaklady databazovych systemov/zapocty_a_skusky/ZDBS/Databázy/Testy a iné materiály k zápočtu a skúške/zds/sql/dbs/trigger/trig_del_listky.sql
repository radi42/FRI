--trigger na zrusenie listka
CREATE OR REPLACE TRIGGER trig_del_listky
    BEFORE DELETE 
    ON listky
    FOR EACH ROW
BEGIN
    DELETE FROM usek_listka
    WHERE usek_listka.l_id=:old.id;
    
END;
/