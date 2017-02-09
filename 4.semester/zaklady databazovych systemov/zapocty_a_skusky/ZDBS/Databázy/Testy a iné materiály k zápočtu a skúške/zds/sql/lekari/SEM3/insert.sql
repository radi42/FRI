CREATE OR REPLACE PROCEDURE Vloz_do_zoz_poist
 (id IN ZOZ_POIST.ID_POISTOVNE%TYPE
 ,nazov IN ZOZ_POIST.NAZOV_POISTOVNE%TYPE
 )
IS
 pocet binary_integer;
BEGIN
select count(*) into pocet from zoz_poist where id_poistovne = id;
if pocet is not null then
  raise_application_error(-20000,'ERROR - Zadane ID POISTOVNE bolo
uz pouzite'); 
end if;
INSERT INTO ZOZ_POIST
VALUES (id,nazov);
END Vloz_do_zoz_poist;
/

CREATE OR REPLACE PROCEDURE Vloz_do_zoz_ukonov
 (id IN ZOZ_UKONOV.ID_UKONU%TYPE
 ,nazov IN ZOZ_UKONOV.POPIS_UKONU%TYPE
 ,cena IN ZOZ_UKONOV.CENA_UKONU%TYPE
 )
IS
 pocet binary_integer;
BEGIN
select count(*) into pocet from zoz_ukonov where id_ukonu = id;
if pocet is not null then
  raise_application_error(-20000,'ERROR - Zadane ID POISTOVNE bolo
uz pouzite');
end if;
INSERT INTO ZOZ_UKONOV
VALUES (id,nazov,cena);
END Vloz_do_zoz_ukonov;

/

CREATE OR REPLACE PROCEDURE Vloz_do_zoz_prijat_mat
 (mnozstvo IN ZOZ_PRIJAT_MAT.MNOZSTVO%TYPE
 ,id_lm IN ZOZ_PRIJAT_MAT.ZOZ_L_A_M_ID_LIEK_A_MAT%TYPE
 ,id_prij IN ZOZ_PRIJAT_MAT.PRIJEM_MAT_ID_PRIJEMKA%TYPE
 )
IS
 pocet binary_integer;
BEGIN
select count(*) into pocet from prijemka_materialu where id_prijemka = id_prij;

if pocet is null then
  raise_application_error(-20000,'ERROR - Prijemka so zadanym cislom
neexistuje');
end if;

select count(*) into pocet from zoz_liek_a_mat where ID_LIEK_A_MAT = id_lm;

if pocet is null then
  raise_application_error(-20000,'ERROR - Material so so zadanym cislom
neexistuje');
end if;

INSERT INTO ZOZ_PRIJAT_MAT
VALUES (mnozstvo,id_lm,id_prij);
END Vloz_do_zoz_prijat_mat;
/

CREATE OR REPLACE PROCEDURE Vloz_do_spot_mat_a_liekov
(datum IN SPOT_MAT_A_LIEKOV.DAT_SPOT%TYPE
 ,pocet IN SPOT_MAT_A_LIEKOV.POCET_JEDNOTIEK%TYPE
 ,id_pac IN SPOT_MAT_A_LIEKOV.OS_UDAJE_P_ID_PACIENTA%TYPE
 ,id_lm IN SPOT_MAT_A_LIEKOV.ZOZ_L_A_M_ID_LIEK_A_MAT%TYPE
 )
IS
BEGIN
INSERT INTO SPOT_MAT_A_LIEKOV
VALUES (datum,pocet,id_pac,id_lm);
END Vloz_do_spot_mat_a_liekov;
/

CREATE OR REPLACE PROCEDURE Vloz_do_zoz_liek_a_mat
 (id IN ZOZ_LIEK_A_MAT.ID_LIEK_A_MAT%TYPE
 ,cena IN ZOZ_LIEK_A_MAT.CENA_LIEK_A_MAT%TYPE
 ,mj IN ZOZ_LIEK_A_MAT.MJ_LIEK_A_MAT%TYPE
 ,nazov IN ZOZ_LIEK_A_MAT.NAZ_LIEK_A_MAT%TYPE
 )
IS
 pocet binary_integer :=0;
BEGIN
if SUBSTR(id,1,1) <> 'L' then
 if SUBSTR(id,1,1) <> 'M' then
    raise_application_error(-20000,'ERROR - Material zaciana
pismenom M a liek pismenom L');
 end if;
end if;

select count(*) into pocet from zoz_liek_a_mat where id_liek_a_mat = id;
if pocet <> 0 then
 raise_application_error(-20000,'ERROR - Material alebo liek so so zadanym
cislom uz existuje');
end if;

INSERT INTO ZOZ_LIEK_A_MAT
VALUES (id,cena,mj,nazov);
END Vloz_do_zoz_liek_a_mat;
/

CREATE OR REPLACE PROCEDURE Vloz_do_prijemka_materialu
 (dat IN PRIJEMKA_MATERIALU.DAT_PRIJATIA%TYPE
 ,id_prij IN PRIJEMKA_MATERIALU.ID_PRIJEMKA%TYPE
 ,dat_platby IN PRIJEMKA_MATERIALU.DAT_PLATBY%TYPE
 ,suma IN PRIJEMKA_MATERIALU.ZAPL_SUMA%TYPE
 ,id_adr IN PRIJEMKA_MATERIALU.ADRES_DOD_ID_ADRESAT%TYPE
 ,id_obj IN PRIJEMKA_MATERIALU.OBJED_MAT_ID_OBJEDNAVKA%TYPE
 )
IS
BEGIN
INSERT INTO PRIJEMKA_MATERIALU
VALUES (dat,id_prij,dat_platby,suma,id_adr,id_obj);
END Vloz_do_prijemka_materialu;
/

CREATE OR REPLACE PROCEDURE Vloz_do_zoz_objed_mat
 (pocet IN ZOZ_OBJED_MAT.MNOZSTVO%TYPE
 ,id_obj IN ZOZ_OBJED_MAT.OBJED_MAT_ID_OBJEDNAVKA%TYPE
 ,id_lm IN ZOZ_OBJED_MAT.ZOZ_L_A_M_ID_LIEK_A_MAT%TYPE
 )
IS
BEGIN
INSERT INTO ZOZ_OBJED_MAT
VALUES (pocet,id_obj,id_lm);
END Vloz_do_zoz_objed_mat;
/

CREATE OR REPLACE PROCEDURE Vloz_do_zoz_zubov
 (stav IN ZOZ_ZUBOV.STAV_ZUBA%TYPE
 ,zub IN ZOZ_ZUBOV.ZUB%TYPE
 ,id_pac IN ZOZ_ZUBOV.OS_UDAJE_P_ID_PACIENTA%TYPE
 )
IS
BEGIN
INSERT INTO ZOZ_ZUBOV
VALUES (stav,zub,id_pac);
END Vloz_do_zoz_zubov;
/

CREATE OR REPLACE PROCEDURE Vloz_do_vyk_ukony
 (dat_ukonu IN VYK_UKONY.DAT_VYKONU%TYPE
 ,dat_uhrady IN VYK_UKONY.DAT_UHRADY%TYPE
 ,id_pac IN VYK_UKONY.ZOZ_ZUBOOS_UDAJE_P_ID_PACIENTA%TYPE
 ,zuby IN VYK_UKONY.ZOZ_ZUBOV_ZUB%TYPE
 ,id IN VYK_UKONY.ZOZ_UKONOV_ID_UKONU%TYPE
 )
IS
 nazov zoz_ukonov.popis_ukonu%TYPE;
BEGIN
INSERT INTO VYK_UKONY
VALUES (dat_ukonu,dat_uhrady,id_pac,zuby,id);
if id = '1' then nazov := 'Vytrhnuty';
end if;
if id = '2' then nazov := 'Vypln';
end if;
if (id = '1') or (id = '2') then
 UPDATE ZOZ_ZUBOV
  SET STAV_ZUBA = nazov
   WHERE zub = zuby AND OS_UDAJE_P_ID_PACIENTA = id_pac;
else dbms_output.put_line('Nezabudni zmenit stav zuba');
end if;
END Vloz_do_vyk_ukony;
/

CREATE OR REPLACE PROCEDURE Vloz_do_vyk_ukony
 (dat_ukonu IN VYK_UKONY.DAT_VYKONU%TYPE
 ,dat_uhrady IN VYK_UKONY.DAT_UHRADY%TYPE
 ,id_pac IN VYK_UKONY.ZOZ_ZUBOOS_UDAJE_P_ID_PACIENTA%TYPE
 ,zub IN VYK_UKONY.ZOZ_ZUBOV_ZUB%TYPE
 ,id IN VYK_UKONY.ZOZ_UKONOV_ID_UKONU%TYPE
 )
IS
 nazov zoz_ukonov.popis_ukonu%TYPE;
BEGIN
INSERT INTO VYK_UKONY
VALUES (dat_ukonu,dat_uhrady,id_pac,zub,id);
select popis_ukonu into nazov from
zoz_ukonov where zoz_ukonov.id_ukonu = id;
if (id = '1') and (id = '2') then
 UPDATE ZOZ_ZUBOV
  SET STAV_ZUBA= nazov,zoz_zubov.ZUB = zub,OS_UDAJE_P_ID_PACIENTA=id_pac
   WHERE zoz_zubov.zub = zub AND OS_UDAJE_P_ID_PACIENTA = id_pac;
else dbms_output.put_line('ID poistovne nie je spravne');
end if;
END Vloz_do_vyk_ukony;
/

CREATE OR REPLACE PROCEDURE Vloz_do_adresar_dodavatelov
 (dic IN ADRESAR_DODAVATELOV.DIC%TYPE
 ,obec IN ADRESAR_DODAVATELOV.OBEC%TYPE
 ,tel IN ADRESAR_DODAVATELOV.TELEFON%TYPE
 ,ulica IN ADRESAR_DODAVATELOV.ULICA%TYPE
 ,ico IN ADRESAR_DODAVATELOV.ICO%TYPE
 ,id_adr IN ADRESAR_DODAVATELOV.ID_ADRESAT%TYPE
 ,nazov IN ADRESAR_DODAVATELOV.NAZOV%TYPE
 )
IS
BEGIN
INSERT INTO ADRESAR_DODAVATELOV
VALUES (dic,obec,tel,ulica,ico,id_adr,nazov);
END Vloz_do_adresar_dodavatelov;
/

CREATE OR REPLACE PROCEDURE Vloz_do_objed_pacienta
 (datum IN OBJED_PACIENTA.DAT_OBJEDNANIA%TYPE
 ,id_pac IN OBJED_PACIENTA.OS_UDAJE_P_ID_PACIENTA%TYPE
 ,id_ukonu IN OBJED_PACIENTA.ZOZ_UKONOV_ID_UKONU%TYPE
 )
IS
BEGIN
INSERT INTO OBJED_PACIENTA
VALUES (datum,id_pac,id_ukonu);
END Vloz_do_objed_pacienta;
/


CREATE OR REPLACE PROCEDURE Vloz_do_objednavka_materialu
 (datum IN OBJEDNAVKA_MATERIALU.DAT_OBJEDNAVKY%TYPE
 ,id_obj IN OBJEDNAVKA_MATERIALU.ID_OBJEDNAVKA%TYPE
 ,dat_dod IN OBJEDNAVKA_MATERIALU.DAT_DODANIA%TYPE
 ,id_adr IN OBJEDNAVKA_MATERIALU.ADRES_DOD_ID_ADRESAT%TYPE
 )
IS
BEGIN
INSERT INTO OBJEDNAVKA_MATERIALU
VALUES (datum,id_obj,dat_dod,id_adr);
END Vloz_do_objednavka_materialu;
/

CREATE OR REPLACE PROCEDURE Vloz_do_os_udaje_pac
 (nazov IN OS_UDAJE_PAC.MENO%TYPE
 ,dat_vyr IN OS_UDAJE_PAC.DAT_VYRADENIA%TYPE
 ,ulica IN OS_UDAJE_PAC.ADR_ULICA%TYPE
 ,mesto IN OS_UDAJE_PAC.OBEC%TYPE
 ,dat_prij IN OS_UDAJE_PAC.DAT_PRIJATIA%TYPE
 ,priez IN OS_UDAJE_PAC.PRIEZVISKO%TYPE
 ,cis_poist IN OS_UDAJE_PAC.CISLO_POISTKY%TYPE
 ,id_poist IN OS_UDAJE_PAC.ZOZ_POIST_ID_POISTOVNE%TYPE
 )
IS
 id_pac OS_UDAJE_PAC.ID_PACIENTA%TYPE:=0;
 pocet binary_integer:=0;
 e_poist EXCEPTION;
BEGIN

select max(id_pacienta) into id_pac from os_udaje_pac;
if id_pac = 0 then
  id_pac := 1;
end if;

select count(*) into pocet from zoz_poist where id_poistovne = id_poist;
if pocet = 0 then
 RAISE e_poist;
end if; 

INSERT INTO OS_UDAJE_PAC
VALUES
(nazov,id_pac+1,dat_vyr,ulica,mesto,dat_prij,priez,cis_poist,id_poist);

EXCEPTION
 WHEN e_poist THEN 
  dbms_output.put_line('ID poistovne nie je spravne');

END Vloz_do_os_udaje_pac;
/