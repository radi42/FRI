
-- -------------------------- triggre ------------------------------
-- 1a
ALTER TABLE
	  zap_predmety
	ADD
	(
	  uzivatel varchar2(20) NULL,
	  datum date NULL
	);

-- 1b
CREATE OR REPLACE TRIGGER trig_up_zp
	BEFORE update on zap_predmety
	referencing new as novy
	for each row
	BEGIN
	   SELECT user, sysdate into 
	   :novy.uzivatel, :novy.datum from dual;
	END;
/

UPDATE zap_predmety 
	SET uzivatel='vajsova' , datum = sysdate - 10;

SELECT DISTINCT uzivatel, datum from zap_predmety;

-- 2
CREATE OR REPLACE TRIGGER trig_opakovanie
	BEFORE insert  on zap_predmety
	for each row
	declare 
		pocet integer;
	BEGIN
	  select count(*) into pocet from zap_predmety
	  where os_cislo = :new.os_cislo AND cis_predm = :new.cis_predm;
	  IF (pocet>=2) then
		raise_application_error(-20000,'ERROR - NEMOZES OPAKOVAT');
	  END IF;
	END;
/


-- 3
CREATE OR REPLACE TRIGGER trig_cast
	AFTER update of os_cislo on student
	for each row
	begin
	  update zap_predmety
		set os_cislo = :new.os_cislo
		where os_cislo = :old.os_cislo;
	end;
/


-- 4
CREATE TABLE log_table 
(
	kto VARCHAR2(20),
	datum DATE,
	operacia CHAR(1),
	os_cislo NUMBER(6) NOT NULL,
	skrok NUMBER(4) NOT NULL,
	cis_predm CHAR(5) NOT NULL
);

ALTER TABLE log_table
	ADD( PRIMARY KEY (kto, datum, operacia, os_cislo, skrok, cis_predm) );


CREATE OR REPLACE TRIGGER trig_log_table_i
	BEFORE  insert on zap_predmety
	for each row
	BEGIN
	  INSERT into log_table VALUES(USER, SYSDATE, 'I', 
	  :new.os_cislo, :new.skrok, :new.cis_predm);
	END;
/ 

CREATE OR REPLACE TRIGGER trig_log_table_u
        BEFORE  update on zap_predmety
        for each row
        BEGIN
          INSERT into log_table VALUES(USER, SYSDATE, 'U',
          :old.os_cislo, :old.skrok, :old.cis_predm);
        END;
/

CREATE OR REPLACE TRIGGER trig_log_table_d
        BEFORE  delete on zap_predmety
        for each row
        BEGIN
          INSERT into log_table VALUES(USER, SYSDATE, 'D',
          :old.os_cislo, :old.skrok, :old.cis_predm);
        END;
/

-- test
insert into zap_predmety (os_cislo, skrok, cis_predm, prednasajuci)
	values(550123,3333,'BI01','KMM02');

update zap_predmety
	set skrok=4444
	where skrok=3333;

delete from zap_predmety
	where skrok=4444;

-- Kapitola 9.2 procedury a funkcie


-- 1

CREATE OR REPLACE PROCEDURE vyskladaj_skupinu
  (
    pracovisko IN CHAR,
    odbor IN NUMBER,
    zameranie IN NUMBER,
    rocnik IN NUMBER,
    kruzok IN CHAR,
    st_skupina OUT VARCHAR
  )
  IS
    odbor_skratka CHAR(1);
  BEGIN
    SELECT sk_odbor 
      INTO odbor_skratka
      FROM priklad_db2.st_odbory
      WHERE c_st_odboru = odbor;
    st_skupina := 5 || pracovisko || odbor_skratka || zameranie || rocnik || kruzok;
  END;
/



-- 1 - testovanie
VARIABLE skupina VARCHAR2(6);
EXECUTE vyskladaj_skupinu('Z', 100, 0, 1, 2, :skupina);
PRINT skupina;

-- 2

CREATE OR REPLACE FUNCTION f_vyskladaj_skupinu
  (
    pracovisko IN CHAR,
    odbor IN NUMBER,
    zameranie IN NUMBER,
    rocnik IN NUMBER,
    kruzok IN CHAR
  )
  RETURN VARCHAR
  IS
    odbor_skratka CHAR(1);
    st_skupina VARCHAR(15);
  BEGIN
    SELECT sk_odbor
      INTO odbor_skratka
      FROM priklad_db2.st_odbory
      WHERE c_st_odboru = odbor;
    st_skupina := 5 || pracovisko || odbor_skratka || zameranie || rocnik || kruzok;

    RETURN st_skupina;														
  END;
/


-- 2 - testovanie

VARIABLE skupina VARCHAR2(15)
EXECUTE :skupina := f_vyskladaj_skupinu('Z', 100, 0, 1, 2)
PRINT skupina


-- 3
SELECT os_cislo
  FROM student
  WHERE st_skupina = f_vyskladaj_skupinu('Z', 100, 0, 1, 2);

*/
-- 4
CREATE OR REPLACE PROCEDURE vloz_predmet
  (
	cis_predm IN CHAR DEFAULT NULL,
	garant IN CHAR DEFAULT NULL,
	nazov IN VARCHAR2 DEFAULT NULL
  )
  IS
  BEGIN
	INSERT INTO predmet VALUES(cis_predm, garant, nazov, NULL);
	EXCEPTION
		WHEN  DUP_VAL_ON_INDEX THEN
		  dbms_output.put_line('Poruseny PK');
		WHEN OTHERS THEN
		  dbms_output.put_line('Ina chyba');
  END;
/

execute vloz_predmet('BI14','KI003');
