CREATE OR REPLACE TRIGGER tab_zamestnanec_ins
  BEFORE INSERT ON zamestnanec
  REFERENCING NEW AS novy
  FOR EACH ROW
  DECLARE
    cis NUMBER;
BEGIN
  SELECT nvl(max(zamestnanec.id)+1,1)
    INTO :novy.id FROM zamestnanec;

  :novy.dat_nastupu := nvl(:novy.dat_nastupu,sysdate);
END;

/
