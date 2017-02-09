CREATE OR REPLACE FUNCTION sel_sklad_id 
(par_sku_id IN number)
RETURN number

IS
v_pom_id skupina.id%TYPE;
v_pom_sku_id skupina.sku_id%TYPE;
v_next BOOLEAN;
v_new_id skupina.id%TYPE;
v_skl_id skupina.skl_id%TYPE;	

BEGIN

  v_pom_id := par_sku_id;
 
  SELECT sku_id INTO v_pom_sku_id FROM skupina
    WHERE id = v_pom_id;
  
  IF v_pom_sku_id IS NULL THEN
    v_next := FALSE;
  ELSE
    v_next := TRUE;
  END IF;
  
  dbms_output.put_line(v_pom_sku_id);
  
  WHILE v_next = TRUE LOOP
    SELECT b.id INTO v_new_id FROM skupina a, skupina b
      WHERE a.id = v_pom_id AND a.sku_id = b.id;
    
    v_pom_id := v_new_id;
    
    SELECT sku_id INTO v_pom_sku_id FROM skupina
      WHERE id = v_pom_id;
      
    IF v_pom_sku_id IS NULL THEN
      v_next := FALSE;
    END IF;
    
    dbms_output.put_line(v_pom_sku_id);
  END LOOP;
  
  SELECT skl_id INTO v_skl_id FROM skupina
    WHERE id = v_pom_id;
 
  RETURN v_skl_id;

END sel_sklad_id;
/