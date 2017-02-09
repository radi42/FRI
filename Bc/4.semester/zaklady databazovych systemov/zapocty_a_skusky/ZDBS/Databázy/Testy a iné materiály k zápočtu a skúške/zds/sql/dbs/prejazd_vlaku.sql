--zisti pocet jazd vlaku za dane obdobie
CREATE OR REPLACE FUNCTION prejazd_vlaku(
			    id_vlaku IN NUMBER,
			    cas_od IN DATE,
			    cas_do IN DATE)
RETURN NUMBER			    
IS
    rozdiel NUMBER;
    pocet NUMBER;
    pom_od DATE;
-- chodi_v_dnoch
    chvd NUMBER;    
-- pom_cislo_dna_v_tyzdni    
    pom_cdvt NUMBER;
    i NUMBER;
BEGIN
    pocet:=0;
    rozdiel:=abs(to_date(cas_do)-to_date(cas_od))+1;
    pom_od:=cas_od;
    
    SELECT 	vlak.chodi_v_dnoch INTO chvd
    FROM 	vlak
    WHERE	vlak.cislo_vlaku=id_vlaku;
    
    FOR i IN 1..rozdiel LOOP
	pom_cdvt:=to_char(pom_od,'D');
	IF substr(chvd,pom_cdvt,1)=1
	THEN pocet:=pocet+1;
	END IF;
	pom_od:=pom_od+1;
    END LOOP;
    
    RETURN pocet;
END prejazd_vlaku;

/