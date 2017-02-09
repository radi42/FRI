CREATE OR REPLACE TRIGGER tab_pohyb_ins
  BEFORE INSERT ON pohyb
  REFERENCING NEW AS novy
  FOR EACH ROW
BEGIN
  SELECT nvl(max(pohyb.cislo)+1,1) INTO :novy.cislo FROM pohyb;
  
  :novy.datum := nvl(:novy.datum,sysdate);
END;

/
