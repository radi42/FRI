
CREATE OR REPLACE TRIGGER cena_vlaku
	BEFORE INSERT ON vlaky
FOR EACH ROW
BEGIN
	SELECT SUM(VOZEN_TYP.voze_prevadzka_cena) INTO :new.vlak_prevadzka_cena FROM VOZEN_TYP, VOZEN_RADENIE
		WHERE VOZEN_RADENIE.voze_vozen_typ_id=VOZEN_TYP.voze_id
		AND VOZEN_RADENIE.voze_vlak_typ_id=:new.vlak_vlak_typ_id;
END;
/

CREATE OR REPLACE TRIGGER cena_listku
	BEFORE INSERT ON listok
FOR EACH ROW
DECLARE
	cena_miesta	INT;
BEGIN
	SELECT TYP_MIESTA.typ__cena INTO cena_miesta FROM TYP_MIESTA, VOZEN_TYP_MIESTO
		WHERE VOZEN_TYP_MIESTO.voze_id=:new.list_vozen_typ__id
		AND TYP_MIESTA.typ__id=VOZEN_TYP_MIESTO.voze_typ_miesta_id;
	SELECT vzdi_vzdialenost*cena_miesta INTO :new.list_cena FROM VZDIALENOSTI
		WHERE vzdi_stanica1=:new.list_odkial AND vzdi_stanica2=:new.list_kam;
END;
/



TTITLE 'Typy vlakov (radenie voznov)';
SET PAGESIZE 60
SET LINESIZE 123
CREATE OR REPLACE VIEW typy_vlakov AS
	SELECT VLAK_TYP.vlak_id, VLAK_TYP.vlak_nazov, VOZEN_TYP.voze_typ, VOZEN_RADENIE.voze_radenie
		FROM VLAK_TYP, VOZEN_RADENIE, VOZEN_TYP
		WHERE VOZEN_RADENIE.voze_vlak_typ_id=VLAK_TYP.vlak_id
			AND VOZEN_TYP.voze_id=VOZEN_RADENIE.voze_vozen_typ_id
		ORDER BY VLAK_TYP.vlak_id, VOZEN_RADENIE.voze_radenie;



TTITLE 'Cestovny poriadok';
SET PAGESIZE 60
SET LINESIZE 123
COLUMN datum FORMAT A16;
CREATE OR REPLACE VIEW cest_poriadok AS
	SELECT VLAKY.vlak_id,
			VLAK_TYP.vlak_nazov,
			STANICE.stan_nazov,
			TO_CHAR(VLAKY.vlak_cas_startu+DECODE((
				SELECT SUM((SELECT vzdi_cas FROM VZDIALENOSTI
						WHERE vzdi_stanica2=(
							SELECT b.vlak_stanice_id FROM VLAK_TYP_STANICA b
								WHERE b.vlak_vlak_typ_id=VLAKY.vlak_vlak_typ_id
									AND b.vlak_poradie=a.vlak_poradie-1)
							AND vzdi_stanica1=a.vlak_stanice_id
						)) AS vzd
					FROM VLAK_TYP_STANICA a
					WHERE a.vlak_vlak_typ_id=VLAKY.vlak_vlak_typ_id
						AND a.vlak_poradie>=1 AND a.vlak_poradie<=VLAK_TYP_STANICA.vlak_poradie
			), NULL, 0, (
				SELECT SUM((SELECT vzdi_cas FROM VZDIALENOSTI
						WHERE vzdi_stanica2=(
							SELECT b.vlak_stanice_id FROM VLAK_TYP_STANICA b
								WHERE b.vlak_vlak_typ_id=VLAKY.vlak_vlak_typ_id
									AND b.vlak_poradie=a.vlak_poradie-1)
							AND vzdi_stanica1=a.vlak_stanice_id
						)) AS vzd
					FROM VLAK_TYP_STANICA a
					WHERE a.vlak_vlak_typ_id=VLAKY.vlak_vlak_typ_id
						AND a.vlak_poradie>=1 AND a.vlak_poradie<=VLAK_TYP_STANICA.vlak_poradie
			))/1440,'DD.MM.YYYY HH24:MI') datum
		FROM VLAKY, VLAK_TYP, VLAK_TYP_STANICA, STANICE
		WHERE VLAK_TYP.vlak_id=VLAKY.vlak_vlak_typ_id
			AND VLAK_TYP_STANICA.vlak_vlak_typ_id=VLAKY.vlak_vlak_typ_id
			AND STANICE.stan_id=VLAK_TYP_STANICA.vlak_stanice_id
		ORDER BY VLAKY.vlak_cas_startu, VLAK_TYP_STANICA.vlak_poradie;




TTITLE 'Prijem za sluzby'
SET PAGESIZE 60
SET LINESIZE 123
CREATE OR REPLACE VIEW prijem AS
	SELECT SUM(list_cena) prijem from LISTOK;







CREATE OR REPLACE FUNCTION obsadene
(v_vlak_id IN listok.list_vlaky_id%TYPE, v_vozen_rade_id IN listok.list_vozen_rade_id%TYPE, v_vozen_typ_id IN listok.list_vozen_typ__id%TYPE)
RETURN VARCHAR
IS
vysledok VARCHAR(255);
obs_listok listok%ROWTYPE;
CURSOR obs_listky IS
	SELECT * FROM listok
		WHERE list_vozen_typ__id=v_vozen_typ_id
			AND list_vozen_rade_id=v_vozen_rade_id
			AND list_vlaky_id=v_vlak_id;
BEGIN
	OPEN obs_listky;
	LOOP
		FETCH obs_listky INTO obs_listok;
		EXIT WHEN (obs_listky%NOTFOUND);
		vysledok:=CONCAT(vysledok,obs_listok.list_id);
		vysledok:=CONCAT(vysledok, ' ');
	END LOOP;
	RETURN vysledok;
END obsadene;
/


TTITLE 'Obsadenost vlakov'
SET PAGESIZE 60
SET LINESIZE 123
COLUMN stav FORMAT A10;
COLUMN vlak_nazov FORMAT A10;
COLUMN radenie FORMAT 00000;
COLUMN vozen_typ FORMAT A12;
COLUMN typ_sed FORMAT A7;
COLUMN v_id FORMAT 000;
COLUMN lr_id FORMAT 000;
COLUMN lvt_id FORMAT 000;
CREATE OR REPLACE VIEW obsadenost AS
	SELECT VLAKY.vlak_id, VLAK_TYP.vlak_nazov vlak_nazov, VLAKY.vlak_cas_startu, VOZEN_RADENIE.voze_radenie radenie, VOZEN_TYP.voze_typ vozen_typ,
		VOZEN_TYP_MIESTO.voze_cislo_miesta c_miesta, TYP_MIESTA.typ__nazov typ_sed,
			DECODE(obsadene(VLAKY.vlak_id, VOZEN_RADENIE.voze_id, VOZEN_TYP_MIESTO.voze_id),
			NULL, 'prazdne', obsadene(VLAKY.vlak_id, VOZEN_RADENIE.voze_id, VOZEN_TYP_MIESTO.voze_id)
			) stav, VLAKY.vlak_id v_id, VOZEN_RADENIE.voze_id lr_id, VOZEN_TYP_MIESTO.voze_id lvt_id
		FROM VLAKY, VLAK_TYP, VOZEN_RADENIE, VOZEN_TYP, VOZEN_TYP_MIESTO, TYP_MIESTA
		WHERE VLAK_TYP.vlak_id=VLAKY.vlak_vlak_typ_id
			AND VOZEN_RADENIE.voze_vlak_typ_id=VLAKY.vlak_vlak_typ_id
			AND VOZEN_TYP.voze_id=VOZEN_RADENIE.voze_vozen_typ_id
			AND VOZEN_TYP_MIESTO.voze_vozen_typ_id=VOZEN_TYP.voze_id
			AND TYP_MIESTA.typ__id=VOZEN_TYP_MIESTO.voze_typ_miesta_id
		ORDER BY VLAKY.vlak_cas_startu, VOZEN_RADENIE.voze_radenie, VOZEN_TYP_MIESTO.voze_cislo_miesta;








TTITLE 'Vytazenost vlakov'
SET PAGESIZE 60
SET LINESIZE 123
COLUMN vlak_nazov FORMAT A10;
COLUMN vytazeny FORMAT 00.0;
CREATE OR REPLACE VIEW vytazenost AS
	SELECT VLAKY.vlak_id, VLAK_TYP.vlak_nazov vlak_nazov, VLAKY.vlak_cas_startu, (
			SELECT COUNT(VOZEN_TYP_MIESTO2.voze_id) pocet
				FROM VLAKY VLAKY2, VOZEN_RADENIE VOZEN_RADENIE2, VOZEN_TYP VOZEN_TYP2, VOZEN_TYP_MIESTO VOZEN_TYP_MIESTO2, LISTOK
				WHERE VOZEN_RADENIE2.voze_vlak_typ_id=VLAKY2.vlak_vlak_typ_id
					AND VOZEN_TYP2.voze_id=VOZEN_RADENIE2.voze_vozen_typ_id
					AND VOZEN_TYP_MIESTO2.voze_vozen_typ_id=VOZEN_TYP2.voze_id
					AND LISTOK.list_vozen_typ__id=VOZEN_TYP_MIESTO2.voze_id
					AND LISTOK.list_vozen_rade_id=VOZEN_RADENIE2.voze_id
					AND LISTOK.list_vlaky_id=VLAKY2.vlak_id
					AND VLAKY2.vlak_id=VLAKY.vlak_id
			)/(
			SELECT COUNT(VOZEN_TYP_MIESTO2.voze_id) pocet
				FROM VLAKY VLAKY2, VOZEN_RADENIE VOZEN_RADENIE2, VOZEN_TYP VOZEN_TYP2, VOZEN_TYP_MIESTO VOZEN_TYP_MIESTO2
				WHERE VOZEN_RADENIE2.voze_vlak_typ_id=VLAKY2.vlak_vlak_typ_id
					AND VOZEN_TYP2.voze_id=VOZEN_RADENIE2.voze_vozen_typ_id
					AND VOZEN_TYP_MIESTO2.voze_vozen_typ_id=VOZEN_TYP2.voze_id
					AND VLAKY2.vlak_id=VLAKY.vlak_id
			)*100 vytazeny
		FROM VLAKY, VLAK_TYP
		WHERE VLAK_TYP.vlak_id=VLAKY.vlak_vlak_typ_id
		ORDER BY VLAKY.vlak_id;









CREATE SEQUENCE vlaky_seq INCREMENT BY 1 START WITH 1;

CREATE OR REPLACE PROCEDURE add_vlak
(v_vlak_typ_id IN vlaky.vlak_vlak_typ_id%TYPE, v_vlak_cas_startu IN vlaky.vlak_cas_startu%TYPE)
IS
BEGIN
	INSERT INTO vlaky (vlak_id, vlak_vlak_typ_id, vlak_cas_startu, vlak_prevadzka_cena)
		VALUES (vlaky_seq.NEXTVAL, v_vlak_typ_id, v_vlak_cas_startu, 0);
END;
/







CREATE SEQUENCE listky_seq INCREMENT BY 1 START WITH 1;

CREATE OR REPLACE PROCEDURE add_listok
(v_vlaky_id IN listok.list_vlaky_id%TYPE, v_vozen_rade_id IN listok.list_vozen_rade_id%TYPE, v_vozen_typ_id listok.list_vozen_typ__id%TYPE,
v_odkial IN listok.list_odkial%TYPE, v_kam IN listok.list_kam%TYPE)
IS
BEGIN
	INSERT INTO listok (list_id, list_vozen_typ__id, list_vozen_rade_id, list_vlaky_id, list_odkial, list_kam)
		VALUES (listky_seq.NEXTVAL, v_vozen_typ_id, v_vozen_rade_id, v_vlaky_id, v_odkial, v_kam);
END;
/


