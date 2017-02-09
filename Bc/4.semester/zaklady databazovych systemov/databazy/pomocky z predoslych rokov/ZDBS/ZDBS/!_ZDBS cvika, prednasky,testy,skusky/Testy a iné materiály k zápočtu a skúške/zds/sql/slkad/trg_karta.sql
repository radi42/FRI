CREATE OR REPLACE TRIGGER tab_karta_ins
  BEFORE INSERT ON karta
  REFERENCING NEW AS novy
  FOR EACH ROW
BEGIN
  SELECT nvl(max(karta.cislo)+1,1) INTO :novy.cislo FROM karta;
  
  :novy.zasoba := nvl(:novy.zasoba,0);
  :novy.cena_jednotky := nvl(:novy.cena_jednotky,0);
  :novy.ocenenie := nvl(:novy.ocenenie,'VAP');
END;

/
