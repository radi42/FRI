CREATE OR REPLACE TRIGGER tab_presun_ins
  BEFORE INSERT ON presun
  REFERENCING NEW AS novy
  FOR EACH ROW
BEGIN
  SELECT nvl(max(presun.cislo)+1,1) INTO :novy.cislo FROM presun;
  
  :novy.datum := nvl(:novy.datum,sysdate);
END;

/
