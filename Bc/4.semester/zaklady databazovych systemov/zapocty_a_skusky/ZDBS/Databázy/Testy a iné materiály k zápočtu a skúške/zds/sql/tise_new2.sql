
CREATE TABLE TYP_UBYT (
       ID                   INTEGER NOT NULL,
       POPIS                INTEGER NULL
);


ALTER TABLE TYP_UBYT
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE STAT (
       NAZOV                VARCHAR2(240) NOT NULL,
       ID                   INTEGER NOT NULL,
       SKRATKA              VARCHAR2(3) NOT NULL
);


ALTER TABLE STAT
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE KRAJ (
       ID                   INTEGER NOT NULL,
       SKRATKA              VARCHAR2(3) NOT NULL,
       NAZOV                VARCHAR2(240) NOT NULL,
       STAT_ID              INTEGER NOT NULL
);


ALTER TABLE KRAJ
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE OKRES (
       SKRATKA              VARCHAR2(3) NOT NULL,
       NAZOV                VARCHAR2(240) NOT NULL,
       ID                   INTEGER NOT NULL,
       KRA_ID               INTEGER NOT NULL
);


ALTER TABLE OKRES
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE OBEC (
       ERB                  LONG RAW NULL,
       ID                   INTEGER NOT NULL,
       KONTAKT              VARCHAR2(20) NULL,
       POPIS                INTEGER NULL,
       PSC                  VARCHAR2(6) NOT NULL,
       TLAC_INFO            INTEGER NULL,
       NAZOV                VARCHAR2(30) NOT NULL,
       OKRES_ID             INTEGER NOT NULL
);


ALTER TABLE OBEC
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE SIDLISKO (
       SKRATKA              VARCHAR2(3) NOT NULL,
       POCET_OBYV           INTEGER NOT NULL,
       NAZOV                VARCHAR2(30) NOT NULL,
       ID                   INTEGER NOT NULL,
       OBE_ID               INTEGER NOT NULL
);


ALTER TABLE SIDLISKO
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE STREDISKO (
       POPIS                INTEGER NOT NULL,
       ID                   INTEGER NOT NULL,
       MAPA                 INTEGER NULL,
       SIDLISKO_ID          INTEGER NOT NULL
);


ALTER TABLE STREDISKO
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE UBYTOVANIE (
       ID                   INTEGER NOT NULL,
       CENA_1               NUMBER(10,2) NOT NULL,
       RANAJKY              INTEGER NOT NULL,
       POC_LOZOK            INTEGER NOT NULL,
       MAPA                 INTEGER NULL,
       POPIS                INTEGER NULL,
       CENA_2               NUMBER(10,2) NOT NULL,
       TUB_ID               INTEGER NOT NULL,
       SIDLISKO_ID          INTEGER NOT NULL,
       STRD_ID              INTEGER NOT NULL
);


ALTER TABLE UBYTOVANIE
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE RESTAURACIA (
       MAPA                 INTEGER NULL,
       POPIS                INTEGER NULL,
       NAZOV                VARCHAR2(20) NOT NULL,
       ID                   INTEGER NOT NULL,
       KAPACITA             INTEGER NOT NULL,
       KUCHYNA              INTEGER NULL,
       STRD_ID              INTEGER NOT NULL,
       UBYT_ID              INTEGER NOT NULL
);


ALTER TABLE RESTAURACIA
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE ZARIADENIE (
       ID                   INTEGER NOT NULL,
       POPIS                INTEGER NOT NULL,
       STRD_ID              INTEGER NOT NULL,
       UBYT_ID              INTEGER NOT NULL,
       OBE_ID               INTEGER NOT NULL,
       REST_ID              INTEGER NOT NULL
);


ALTER TABLE ZARIADENIE
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE TYP_SLUZBY (
       POPIS                INTEGER NULL,
       ID                   INTEGER NOT NULL,
       NAZOV                INTEGER NOT NULL
);


ALTER TABLE TYP_SLUZBY
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE SLUZBY (
       MAPA                 INTEGER NULL,
       ID                   INTEGER NOT NULL,
       POPIS                INTEGER NOT NULL,
       SIDLISKO_ID          INTEGER NOT NULL,
       TSL_ID               INTEGER NOT NULL
);


ALTER TABLE SLUZBY
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE OBCHOD (
       OBCH_ID              INTEGER NOT NULL,
       ID                   NUMBER(10,0) NOT NULL,
       MAPA                 INTEGER NULL,
       NAZOV                VARCHAR2(20) NOT NULL,
       POPIS                INTEGER NULL,
       SIDLISKO_ID          INTEGER NOT NULL
);


ALTER TABLE OBCHOD
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE NAR_PARK (
       TYP                  VARCHAR2(20) NULL,
       POPIS                INTEGER NULL,
       MAPA                 INTEGER NULL,
       ID                   INTEGER NOT NULL
);


ALTER TABLE NAR_PARK
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE TYP_KULT_ZAR (
       POPIS                INTEGER NULL,
       ID                   INTEGER NOT NULL
);


ALTER TABLE TYP_KULT_ZAR
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE GAL_MUZEUM (
       EXPOZICIA            INTEGER NULL,
       ID                   INTEGER NOT NULL,
       MAPA                 INTEGER NULL,
       POPIS                INTEGER NULL,
       TKZ_ID               INTEGER NOT NULL,
       SIDLISKO_ID          INTEGER NOT NULL
);


ALTER TABLE GAL_MUZEUM
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE KONTAKTY (
       ID                   INTEGER NOT NULL,
       EMAIL                VARCHAR2(30) NULL,
       ADRESA               VARCHAR2(50) NULL,
       TELEFON              VARCHAR2(20) NULL,
       WWW                  VARCHAR2(50) NULL,
       KONTAKT              VARCHAR2(50) NULL,
       MOBIL                VARCHAR2(20) NULL,
       SURADNICA_Y          NUMBER NULL,
       SURADNICA_X          NUMBER NULL,
       SL_ID                INTEGER NOT NULL,
       UBYT_ID              INTEGER NOT NULL,
       OBE_ID               INTEGER NOT NULL,
       GM_ID                INTEGER NOT NULL,
       NP_ID                INTEGER NOT NULL,
       OBC_ID               NUMBER(10,0) NOT NULL,
       REST_ID              INTEGER NOT NULL,
       ZAR_ID               INTEGER NOT NULL
);


ALTER TABLE KONTAKTY
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE MAPY (
       POZNAMKA             INTEGER NULL,
       MAPA                 LONG RAW NOT NULL,
       ID                   INTEGER NOT NULL,
       OBE_ID               INTEGER NOT NULL
);


ALTER TABLE MAPY
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE MAPY_KONTAKTY (
       ID                   INTEGER NOT NULL
);

CREATE UNIQUE INDEX XPKMAPY_KONTAKTY ON MAPY_KONTAKTY
(
       ID                             ASC
);


ALTER TABLE MAPY_KONTAKTY
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE Texty (
       id                   NUMBER NOT NULL,
       jazyk                CHAR(1) NOT NULL,
       text                 VARCHAR2(240) NULL
);


ALTER TABLE Texty
       ADD  ( PRIMARY KEY (id, jazyk) ) ;


CREATE TABLE WWW (
       POPIS                INTEGER NULL,
       LINKA                VARCHAR2(50) NOT NULL,
       NAZOV                INTEGER NOT NULL,
       KON_ID               INTEGER NOT NULL
);


ALTER TABLE WWW
       ADD  ( PRIMARY KEY (LINKA) ) ;


CREATE TABLE PIKTOGRAMY (
       POPIS                INTEGER NULL,
       OBRAZOK              LONG RAW NOT NULL,
       ID                   INTEGER NOT NULL
);


ALTER TABLE PIKTOGRAMY
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE GALERIA (
       OBRAZOK              LONG RAW NOT NULL,
       POPIS                INTEGER NULL,
       KON_ID               INTEGER NULL,
       ID                   NUMBER NOT NULL
);


ALTER TABLE GALERIA
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE OBEC_NP (
       ID                   NUMBER(10,0) NOT NULL,
       OBE_ID               INTEGER NOT NULL,
       NP_ID                INTEGER NOT NULL
);


ALTER TABLE OBEC_NP
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE CENNIK (
       SEZONA               VARCHAR2(10) NULL,
       ID                   INTEGER NOT NULL,
       SUMA                 NUMBER(10,2) NOT NULL,
       POPIS                INTEGER NULL,
       MENA                 VARCHAR2(3) NOT NULL,
       GM_ID                INTEGER NOT NULL,
       ZAR_ID               INTEGER NOT NULL
);


ALTER TABLE CENNIK
       ADD  ( PRIMARY KEY (ID, GM_ID) ) ;


CREATE TABLE DOPR_BOD (
       POPIS                INTEGER NULL,
       MAPA                 INTEGER NULL,
       TYP                  VARCHAR2(10) NOT NULL,
       ID                   INTEGER NOT NULL,
       SIDLISKO_ID          INTEGER NOT NULL
);


ALTER TABLE DOPR_BOD
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE KALENDAR (
       DEN                  INTEGER NOT NULL,
       VOLNE                INTEGER NOT NULL,
       POPIS                INTEGER NULL,
       OBSADENE             INTEGER NOT NULL,
       MESIAC               INTEGER NOT NULL,
       ROK                  INTEGER NOT NULL,
       UBYT_ID              INTEGER NOT NULL,
       GM_ID                INTEGER NOT NULL,
       STRD_ID              INTEGER NOT NULL,
       REST_ID              INTEGER NOT NULL,
       NP_ID                INTEGER NOT NULL
);


ALTER TABLE KALENDAR
       ADD  ( PRIMARY KEY (DEN, UBYT_ID, MESIAC, ROK) ) ;


CREATE TABLE NASTENKA (
       ID                   INTEGER NOT NULL,
       POPIS                INTEGER NOT NULL,
       NAZOV                INTEGER NOT NULL,
       KON_ID               INTEGER NOT NULL
);


ALTER TABLE NASTENKA
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE CEST_PORIADOK (
       CIEL                 VARCHAR2(20) NOT NULL,
       HOD                  INTEGER NOT NULL,
       CP_MIN               INTEGER NOT NULL,
       SPOJ                 INTEGER NOT NULL,
       POZNAMKA             INTEGER NULL,
       DB_ID                INTEGER NOT NULL
);


ALTER TABLE CEST_PORIADOK
       ADD  ( PRIMARY KEY (SPOJ, HOD, CP_MIN, DB_ID) ) ;


CREATE TABLE ZAR_PIKT (
       ID                   NUMBER(10,0) NOT NULL,
       DB_ID                INTEGER NOT NULL,
       GM_ID                INTEGER NOT NULL,
       UBYT_ID              INTEGER NOT NULL,
       REST_ID              INTEGER NOT NULL,
       PIKT_ID              INTEGER NOT NULL,
       ZAR_ID               INTEGER NOT NULL,
       NP_ID                INTEGER NOT NULL
);


ALTER TABLE ZAR_PIKT
       ADD  ( PRIMARY KEY (ID) ) ;


CREATE TABLE REZERVACIA (
       POZIADAVKY           VARCHAR2(100) NULL,
       TELEFON              VARCHAR2(20) NULL,
       POCET_D              INTEGER NOT NULL,
       ID_REZ               INTEGER NOT NULL,
       ZAVAZNOST            VARCHAR2(1) NULL,
       FAX                  VARCHAR2(20) NULL,
       MOBIL                VARCHAR2(20) NULL,
       ODKEDY               DATE NOT NULL,
       POZNAMKA             VARCHAR2(100) NULL,
       POCET                INTEGER NOT NULL,
       ADRESA               VARCHAR2(50) NULL,
       DATUM                DATE NOT NULL,
       DOKEDY               DATE NULL,
       STRAVA               VARCHAR2(1) NULL,
       EMAIL                VARCHAR2(30) NULL,
       UZIV                 VARCHAR2(20) NOT NULL,
       UBYT_ID              INTEGER NOT NULL
);


ALTER TABLE REZERVACIA
       ADD  ( PRIMARY KEY (ID_REZ) ) ;


ALTER TABLE KRAJ
       ADD  ( FOREIGN KEY (STAT_ID)
                             REFERENCES STAT ) ;


ALTER TABLE OKRES
       ADD  ( FOREIGN KEY (KRA_ID)
                             REFERENCES KRAJ ) ;


ALTER TABLE OBEC
       ADD  ( FOREIGN KEY (OKRES_ID)
                             REFERENCES OKRES ) ;


ALTER TABLE SIDLISKO
       ADD  ( FOREIGN KEY (OBE_ID)
                             REFERENCES OBEC ) ;


ALTER TABLE STREDISKO
       ADD  ( FOREIGN KEY (SIDLISKO_ID)
                             REFERENCES SIDLISKO ) ;


ALTER TABLE UBYTOVANIE
       ADD  ( FOREIGN KEY (TUB_ID)
                             REFERENCES TYP_UBYT ) ;


ALTER TABLE UBYTOVANIE
       ADD  ( FOREIGN KEY (SIDLISKO_ID)
                             REFERENCES SIDLISKO ) ;


ALTER TABLE UBYTOVANIE
       ADD  ( FOREIGN KEY (STRD_ID)
                             REFERENCES STREDISKO ) ;


ALTER TABLE RESTAURACIA
       ADD  ( FOREIGN KEY (UBYT_ID)
                             REFERENCES UBYTOVANIE ) ;


ALTER TABLE RESTAURACIA
       ADD  ( FOREIGN KEY (STRD_ID)
                             REFERENCES STREDISKO ) ;


ALTER TABLE ZARIADENIE
       ADD  ( FOREIGN KEY (UBYT_ID)
                             REFERENCES UBYTOVANIE ) ;


ALTER TABLE ZARIADENIE
       ADD  ( FOREIGN KEY (REST_ID)
                             REFERENCES RESTAURACIA ) ;


ALTER TABLE ZARIADENIE
       ADD  ( FOREIGN KEY (OBE_ID)
                             REFERENCES OBEC ) ;


ALTER TABLE ZARIADENIE
       ADD  ( FOREIGN KEY (STRD_ID)
                             REFERENCES STREDISKO ) ;


ALTER TABLE SLUZBY
       ADD  ( FOREIGN KEY (TSL_ID)
                             REFERENCES TYP_SLUZBY ) ;


ALTER TABLE SLUZBY
       ADD  ( FOREIGN KEY (SIDLISKO_ID)
                             REFERENCES SIDLISKO ) ;


ALTER TABLE OBCHOD
       ADD  ( FOREIGN KEY (SIDLISKO_ID)
                             REFERENCES SIDLISKO ) ;


ALTER TABLE GAL_MUZEUM
       ADD  ( FOREIGN KEY (SIDLISKO_ID)
                             REFERENCES SIDLISKO ) ;


ALTER TABLE GAL_MUZEUM
       ADD  ( FOREIGN KEY (TKZ_ID)
                             REFERENCES TYP_KULT_ZAR ) ;


ALTER TABLE KONTAKTY
       ADD  ( FOREIGN KEY (ZAR_ID)
                             REFERENCES ZARIADENIE ) ;


ALTER TABLE KONTAKTY
       ADD  ( FOREIGN KEY (SL_ID)
                             REFERENCES SLUZBY ) ;


ALTER TABLE KONTAKTY
       ADD  ( FOREIGN KEY (OBE_ID)
                             REFERENCES OBEC ) ;


ALTER TABLE KONTAKTY
       ADD  ( FOREIGN KEY (UBYT_ID)
                             REFERENCES UBYTOVANIE ) ;


ALTER TABLE KONTAKTY
       ADD  ( FOREIGN KEY (OBC_ID)
                             REFERENCES OBCHOD ) ;


ALTER TABLE KONTAKTY
       ADD  ( FOREIGN KEY (NP_ID)
                             REFERENCES NAR_PARK ) ;


ALTER TABLE KONTAKTY
       ADD  ( FOREIGN KEY (REST_ID)
                             REFERENCES RESTAURACIA ) ;


ALTER TABLE KONTAKTY
       ADD  ( FOREIGN KEY (GM_ID)
                             REFERENCES GAL_MUZEUM ) ;


ALTER TABLE MAPY
       ADD  ( FOREIGN KEY (OBE_ID)
                             REFERENCES OBEC ) ;


ALTER TABLE MAPY_KONTAKTY
       ADD  ( FOREIGN KEY (ID)
                             REFERENCES KONTAKTY ) ;


ALTER TABLE MAPY_KONTAKTY
       ADD  ( FOREIGN KEY (ID)
                             REFERENCES MAPY ) ;


ALTER TABLE WWW
       ADD  ( FOREIGN KEY (KON_ID)
                             REFERENCES KONTAKTY ) ;


ALTER TABLE GALERIA
       ADD  ( FOREIGN KEY (KON_ID)
                             REFERENCES KONTAKTY ) ;


ALTER TABLE OBEC_NP
       ADD  ( FOREIGN KEY (OBE_ID)
                             REFERENCES OBEC ) ;


ALTER TABLE OBEC_NP
       ADD  ( FOREIGN KEY (NP_ID)
                             REFERENCES NAR_PARK ) ;


ALTER TABLE CENNIK
       ADD  ( FOREIGN KEY (ZAR_ID)
                             REFERENCES ZARIADENIE ) ;


ALTER TABLE CENNIK
       ADD  ( FOREIGN KEY (GM_ID)
                             REFERENCES GAL_MUZEUM ) ;


ALTER TABLE DOPR_BOD
       ADD  ( FOREIGN KEY (SIDLISKO_ID)
                             REFERENCES SIDLISKO ) ;


ALTER TABLE KALENDAR
       ADD  ( FOREIGN KEY (REST_ID)
                             REFERENCES RESTAURACIA ) ;


ALTER TABLE KALENDAR
       ADD  ( FOREIGN KEY (NP_ID)
                             REFERENCES NAR_PARK ) ;


ALTER TABLE KALENDAR
       ADD  ( FOREIGN KEY (UBYT_ID)
                             REFERENCES UBYTOVANIE ) ;


ALTER TABLE KALENDAR
       ADD  ( FOREIGN KEY (GM_ID)
                             REFERENCES GAL_MUZEUM ) ;


ALTER TABLE KALENDAR
       ADD  ( FOREIGN KEY (STRD_ID)
                             REFERENCES STREDISKO ) ;


ALTER TABLE NASTENKA
       ADD  ( FOREIGN KEY (KON_ID)
                             REFERENCES KONTAKTY ) ;


ALTER TABLE CEST_PORIADOK
       ADD  ( FOREIGN KEY (DB_ID)
                             REFERENCES DOPR_BOD ) ;


ALTER TABLE ZAR_PIKT
       ADD  ( FOREIGN KEY (GM_ID)
                             REFERENCES GAL_MUZEUM ) ;


ALTER TABLE ZAR_PIKT
       ADD  ( FOREIGN KEY (DB_ID)
                             REFERENCES DOPR_BOD ) ;


ALTER TABLE ZAR_PIKT
       ADD  ( FOREIGN KEY (NP_ID)
                             REFERENCES NAR_PARK ) ;


ALTER TABLE ZAR_PIKT
       ADD  ( FOREIGN KEY (REST_ID)
                             REFERENCES RESTAURACIA ) ;


ALTER TABLE ZAR_PIKT
       ADD  ( FOREIGN KEY (ZAR_ID)
                             REFERENCES ZARIADENIE ) ;


ALTER TABLE ZAR_PIKT
       ADD  ( FOREIGN KEY (UBYT_ID)
                             REFERENCES UBYTOVANIE ) ;


ALTER TABLE ZAR_PIKT
       ADD  ( FOREIGN KEY (PIKT_ID)
                             REFERENCES PIKTOGRAMY ) ;


ALTER TABLE REZERVACIA
       ADD  ( FOREIGN KEY (UBYT_ID)
                             REFERENCES UBYTOVANIE ) ;




create trigger tD_TYP_UBYT
  AFTER DELETE
  on TYP_UBYT
  
  for each row
DECLARE
numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* TYP_UBYT UBYT_TUB_FK UBYTOVANIE ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from UBYTOVANIE
      where
        /*  %JoinFKPK(UBYTOVANIE,:%Old," = "," and") */
        UBYTOVANIE.TUB_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE TYP_UBYT because UBYTOVANIE exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 15:23:13 2004
end

create trigger tD_STAT
  AFTER DELETE
  on STAT
  
  for each row
DECLARE
numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* STAT KRA_STAT_FK KRAJ ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from KRAJ
      where
        /*  %JoinFKPK(KRAJ,:%Old," = "," and") */
        KRAJ.STAT_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE STAT because KRAJ exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 15:23:13 2004
end

create trigger tD_KRAJ
  AFTER DELETE
  on KRAJ
  
  for each row
DECLARE
numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* KRAJ OKRES_KRA_FK OKRES ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from OKRES
      where
        /*  %JoinFKPK(OKRES,:%Old," = "," and") */
        OKRES.KRA_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE KRAJ because OKRES exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 15:23:13 2004
end

create trigger tD_OKRES
  AFTER DELETE
  on OKRES
  
  for each row
DECLARE
numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* OKRES OBE_OKRES_FK OBEC ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from OBEC
      where
        /*  %JoinFKPK(OBEC,:%Old," = "," and") */
        OBEC.OKRES_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE OKRES because OBEC exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 15:23:13 2004
end

create trigger tD_OBEC
  AFTER DELETE
  on OBEC
  
  for each row
DECLARE
numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* OBEC ONP_OBE_FK OBEC_NP ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from OBEC_NP
      where
        /*  %JoinFKPK(OBEC_NP,:%Old," = "," and") */
        OBEC_NP.OBE_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE OBEC because OBEC_NP exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* OBEC KON_OBE_FK KONTAKTY ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from KONTAKTY
      where
        /*  %JoinFKPK(KONTAKTY,:%Old," = "," and") */
        KONTAKTY.OBE_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE OBEC because KONTAKTY exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* OBEC MP_OBE_FK MAPY ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from MAPY
      where
        /*  %JoinFKPK(MAPY,:%Old," = "," and") */
        MAPY.OBE_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE OBEC because MAPY exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* OBEC ZAR_OBE_FK ZARIADENIE ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from ZARIADENIE
      where
        /*  %JoinFKPK(ZARIADENIE,:%Old," = "," and") */
        ZARIADENIE.OBE_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE OBEC because ZARIADENIE exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* OBEC SIDLISKO_OBE_FK SIDLISKO ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from SIDLISKO
      where
        /*  %JoinFKPK(SIDLISKO,:%Old," = "," and") */
        SIDLISKO.OBE_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE OBEC because SIDLISKO exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 15:23:13 2004
end

create trigger tD_SIDLISKO
  AFTER DELETE
  on SIDLISKO
  
  for each row
DECLARE
numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* SIDLISKO SL_SIDLISKO_FK SLUZBY ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from SLUZBY
      where
        /*  %JoinFKPK(SLUZBY,:%Old," = "," and") */
        SLUZBY.SIDLISKO_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE SIDLISKO because SLUZBY exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* SIDLISKO DB_SIDLISKO_FK DOPR_BOD ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from DOPR_BOD
      where
        /*  %JoinFKPK(DOPR_BOD,:%Old," = "," and") */
        DOPR_BOD.SIDLISKO_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE SIDLISKO because DOPR_BOD exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* SIDLISKO STRD_SIDLISKO_FK STREDISKO ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from STREDISKO
      where
        /*  %JoinFKPK(STREDISKO,:%Old," = "," and") */
        STREDISKO.SIDLISKO_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE SIDLISKO because STREDISKO exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* SIDLISKO GM_SIDLISKO_FK GAL_MUZEUM ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from GAL_MUZEUM
      where
        /*  %JoinFKPK(GAL_MUZEUM,:%Old," = "," and") */
        GAL_MUZEUM.SIDLISKO_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE SIDLISKO because GAL_MUZEUM exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* SIDLISKO UBYT_SIDLISKO_FK UBYTOVANIE ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from UBYTOVANIE
      where
        /*  %JoinFKPK(UBYTOVANIE,:%Old," = "," and") */
        UBYTOVANIE.SIDLISKO_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE SIDLISKO because UBYTOVANIE exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* SIDLISKO OBC_SIDLISKO_FK OBCHOD ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from OBCHOD
      where
        /*  %JoinFKPK(OBCHOD,:%Old," = "," and") */
        OBCHOD.SIDLISKO_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE SIDLISKO because OBCHOD exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 15:23:13 2004
end

create trigger tI_SIDLISKO after INSERT on SIDLISKO for each row
-- ERwin Builtin Thu Feb 05 16:50:53 2004
-- INSERT trigger on SIDLISKO 
declare numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 16:50:53 2004 */
    /* SIDLISKO  DOPR_BOD ON PARENT INSERT RESTRICT */
    select count(*) into numrows from DOPR_BOD
      where
        /* %JoinFKPK(DOPR_BOD,:%New," = "," and") */
        DOPR_BOD.SIDLISKO_ID = :new.ID;
    if (numrows = 0)
    then
      raise_application_error(
        -20011,
        'Cannot INSERT SIDLISKO because DOPR_BOD does not.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 16:50:53 2004
end;
/

create trigger tD_STREDISKO
  AFTER DELETE
  on STREDISKO
  
  for each row
DECLARE
numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* STREDISKO KAL_STRD_FK KALENDAR ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from KALENDAR
      where
        /*  %JoinFKPK(KALENDAR,:%Old," = "," and") */
        KALENDAR.STRD_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE STREDISKO because KALENDAR exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* STREDISKO UBYT_STRD_FK UBYTOVANIE ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from UBYTOVANIE
      where
        /*  %JoinFKPK(UBYTOVANIE,:%Old," = "," and") */
        UBYTOVANIE.STRD_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE STREDISKO because UBYTOVANIE exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* STREDISKO REST_STRD_FK RESTAURACIA ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from RESTAURACIA
      where
        /*  %JoinFKPK(RESTAURACIA,:%Old," = "," and") */
        RESTAURACIA.STRD_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE STREDISKO because RESTAURACIA exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* STREDISKO ZAR_STRD_FK ZARIADENIE ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from ZARIADENIE
      where
        /*  %JoinFKPK(ZARIADENIE,:%Old," = "," and") */
        ZARIADENIE.STRD_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE STREDISKO because ZARIADENIE exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 15:23:13 2004
end

create trigger tD_UBYTOVANIE
  AFTER DELETE
  on UBYTOVANIE
  
  for each row
DECLARE
numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* UBYTOVANIE KON_UBYT_FK KONTAKTY ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from KONTAKTY
      where
        /*  %JoinFKPK(KONTAKTY,:%Old," = "," and") */
        KONTAKTY.UBYT_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE UBYTOVANIE because KONTAKTY exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* UBYTOVANIE KAL_UBYT_FK KALENDAR ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from KALENDAR
      where
        /*  %JoinFKPK(KALENDAR,:%Old," = "," and") */
        KALENDAR.UBYT_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE UBYTOVANIE because KALENDAR exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* UBYTOVANIE ZP_UBYT_FK ZAR_PIKT ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from ZAR_PIKT
      where
        /*  %JoinFKPK(ZAR_PIKT,:%Old," = "," and") */
        ZAR_PIKT.UBYT_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE UBYTOVANIE because ZAR_PIKT exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* UBYTOVANIE REZ_UBYT_FK REZERVACIA ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from REZERVACIA
      where
        /*  %JoinFKPK(REZERVACIA,:%Old," = "," and") */
        REZERVACIA.UBYT_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE UBYTOVANIE because REZERVACIA exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* UBYTOVANIE REST_UBYT_FK RESTAURACIA ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from RESTAURACIA
      where
        /*  %JoinFKPK(RESTAURACIA,:%Old," = "," and") */
        RESTAURACIA.UBYT_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE UBYTOVANIE because RESTAURACIA exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* UBYTOVANIE ZAR_UBYT_FK ZARIADENIE ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from ZARIADENIE
      where
        /*  %JoinFKPK(ZARIADENIE,:%Old," = "," and") */
        ZARIADENIE.UBYT_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE UBYTOVANIE because ZARIADENIE exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 15:23:13 2004
end

create trigger tD_RESTAURACIA
  AFTER DELETE
  on RESTAURACIA
  
  for each row
DECLARE
numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* RESTAURACIA KON_REST_FK KONTAKTY ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from KONTAKTY
      where
        /*  %JoinFKPK(KONTAKTY,:%Old," = "," and") */
        KONTAKTY.REST_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE RESTAURACIA because KONTAKTY exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* RESTAURACIA KAL_REST_FK KALENDAR ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from KALENDAR
      where
        /*  %JoinFKPK(KALENDAR,:%Old," = "," and") */
        KALENDAR.REST_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE RESTAURACIA because KALENDAR exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* RESTAURACIA ZP_REST_FK ZAR_PIKT ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from ZAR_PIKT
      where
        /*  %JoinFKPK(ZAR_PIKT,:%Old," = "," and") */
        ZAR_PIKT.REST_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE RESTAURACIA because ZAR_PIKT exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* RESTAURACIA ZAR_REST_FK ZARIADENIE ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from ZARIADENIE
      where
        /*  %JoinFKPK(ZARIADENIE,:%Old," = "," and") */
        ZARIADENIE.REST_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE RESTAURACIA because ZARIADENIE exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 15:23:13 2004
end

create trigger tI_RESTAURACIA after INSERT on RESTAURACIA for each row
-- ERwin Builtin Thu Feb 05 16:50:53 2004
-- INSERT trigger on RESTAURACIA 
declare numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 16:50:53 2004 */
    /* RESTAURACIA  ZARIADENIE ON PARENT INSERT RESTRICT */
    select count(*) into numrows from ZARIADENIE
      where
        /* %JoinFKPK(ZARIADENIE,:%New," = "," and") */
        ZARIADENIE.REST_ID = :new.ID;
    if (numrows = 0)
    then
      raise_application_error(
        -20011,
        'Cannot INSERT RESTAURACIA because ZARIADENIE does not.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 16:50:53 2004
end;
/

create trigger tD_ZARIADENIE
  AFTER DELETE
  on ZARIADENIE
  
  for each row
DECLARE
numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* ZARIADENIE CEN_ZAR_FK CENNIK ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from CENNIK
      where
        /*  %JoinFKPK(CENNIK,:%Old," = "," and") */
        CENNIK.ZAR_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE ZARIADENIE because CENNIK exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* ZARIADENIE KON_ZAR_FK KONTAKTY ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from KONTAKTY
      where
        /*  %JoinFKPK(KONTAKTY,:%Old," = "," and") */
        KONTAKTY.ZAR_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE ZARIADENIE because KONTAKTY exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* ZARIADENIE ZP_ZAR_FK ZAR_PIKT ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from ZAR_PIKT
      where
        /*  %JoinFKPK(ZAR_PIKT,:%Old," = "," and") */
        ZAR_PIKT.ZAR_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE ZARIADENIE because ZAR_PIKT exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 15:23:13 2004
end

create trigger tD_TYP_SLUZBY
  AFTER DELETE
  on TYP_SLUZBY
  
  for each row
DECLARE
numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* TYP_SLUZBY SL_TSL_FK SLUZBY ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from SLUZBY
      where
        /*  %JoinFKPK(SLUZBY,:%Old," = "," and") */
        SLUZBY.TSL_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE TYP_SLUZBY because SLUZBY exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 15:23:13 2004
end

create trigger tD_SLUZBY
  AFTER DELETE
  on SLUZBY
  
  for each row
DECLARE
numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* SLUZBY KON_SL_FK KONTAKTY ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from KONTAKTY
      where
        /*  %JoinFKPK(KONTAKTY,:%Old," = "," and") */
        KONTAKTY.SL_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE SLUZBY because KONTAKTY exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 15:23:13 2004
end

create trigger tD_OBCHOD
  AFTER DELETE
  on OBCHOD
  
  for each row
DECLARE
numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* OBCHOD KON_OBC_FK KONTAKTY ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from KONTAKTY
      where
        /*  %JoinFKPK(KONTAKTY,:%Old," = "," and") */
        KONTAKTY.OBC_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE OBCHOD because KONTAKTY exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 15:23:13 2004
end

create trigger tD_NAR_PARK
  AFTER DELETE
  on NAR_PARK
  
  for each row
DECLARE
numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* NAR_PARK ONP_NP_FK OBEC_NP ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from OBEC_NP
      where
        /*  %JoinFKPK(OBEC_NP,:%Old," = "," and") */
        OBEC_NP.NP_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE NAR_PARK because OBEC_NP exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* NAR_PARK KON_NP_FK KONTAKTY ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from KONTAKTY
      where
        /*  %JoinFKPK(KONTAKTY,:%Old," = "," and") */
        KONTAKTY.NP_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE NAR_PARK because KONTAKTY exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* NAR_PARK KAL_NP_FK KALENDAR ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from KALENDAR
      where
        /*  %JoinFKPK(KALENDAR,:%Old," = "," and") */
        KALENDAR.NP_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE NAR_PARK because KALENDAR exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* NAR_PARK ZP_NP_FK ZAR_PIKT ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from ZAR_PIKT
      where
        /*  %JoinFKPK(ZAR_PIKT,:%Old," = "," and") */
        ZAR_PIKT.NP_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE NAR_PARK because ZAR_PIKT exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 15:23:13 2004
end

create trigger tD_TYP_KULT_ZAR
  AFTER DELETE
  on TYP_KULT_ZAR
  
  for each row
DECLARE
numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* TYP_KULT_ZAR GM_TKZ_FK GAL_MUZEUM ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from GAL_MUZEUM
      where
        /*  %JoinFKPK(GAL_MUZEUM,:%Old," = "," and") */
        GAL_MUZEUM.TKZ_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE TYP_KULT_ZAR because GAL_MUZEUM exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 15:23:13 2004
end

create trigger tD_GAL_MUZEUM
  AFTER DELETE
  on GAL_MUZEUM
  
  for each row
DECLARE
numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* GAL_MUZEUM CEN_GM_FK CENNIK ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from CENNIK
      where
        /*  %JoinFKPK(CENNIK,:%Old," = "," and") */
        CENNIK.GM_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE GAL_MUZEUM because CENNIK exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* GAL_MUZEUM KON_GM_FK KONTAKTY ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from KONTAKTY
      where
        /*  %JoinFKPK(KONTAKTY,:%Old," = "," and") */
        KONTAKTY.GM_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE GAL_MUZEUM because KONTAKTY exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* GAL_MUZEUM KAL_GM_FK KALENDAR ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from KALENDAR
      where
        /*  %JoinFKPK(KALENDAR,:%Old," = "," and") */
        KALENDAR.GM_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE GAL_MUZEUM because KALENDAR exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* GAL_MUZEUM ZP_GM_FK ZAR_PIKT ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from ZAR_PIKT
      where
        /*  %JoinFKPK(ZAR_PIKT,:%Old," = "," and") */
        ZAR_PIKT.GM_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE GAL_MUZEUM because ZAR_PIKT exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 15:23:13 2004
end

create trigger tD_KONTAKTY
  AFTER DELETE
  on KONTAKTY
  
  for each row
DECLARE
numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* KONTAKTY WWW_KON_FK WWW ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from WWW
      where
        /*  %JoinFKPK(WWW,:%Old," = "," and") */
        WWW.KON_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE KONTAKTY because WWW exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* KONTAKTY GAL_KON_FK GALERIAS ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from GALERIAS
      where
        /*  %JoinFKPK(GALERIAS,:%Old," = "," and") */
        GALERIAS.KON_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE KONTAKTY because GALERIAS exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* KONTAKTY NAS_KON_FK NASTENKA ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from NASTENKA
      where
        /*  %JoinFKPK(NASTENKA,:%Old," = "," and") */
        NASTENKA.KON_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE KONTAKTY because NASTENKA exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 15:23:13 2004
end

create trigger tU_KONTAKTY after UPDATE on KONTAKTY for each row
-- ERwin Builtin Thu Feb 05 16:50:53 2004
-- UPDATE trigger on KONTAKTY 
declare numrows INTEGER;
begin
  /* ERwin Builtin Thu Feb 05 16:50:53 2004 */
  /* KONTAKTY R/54 MAPY_KONTAKTY ON PARENT UPDATE RESTRICT */
  if
    /* %JoinPKPK(:%Old,:%New," <> "," or ") */
    :old.ID <> :new.ID
  then
    select count(*) into numrows
      from MAPY_KONTAKTY
      where
        /*  %JoinFKPK(MAPY_KONTAKTY,:%Old," = "," and") */
        MAPY_KONTAKTY.ID = :old.ID;
    if (numrows > 0)
    then 
      raise_application_error(
        -20005,
        'Cannot UPDATE KONTAKTY because MAPY_KONTAKTY exists.'
      );
    end if;
  end if;

  /* KONTAKTY R/51 GALERIA ON PARENT UPDATE SET NULL */
  if
    /* %JoinPKPK(:%Old,:%New," <> "," or " */
    :old.ID <> :new.ID
  then
    update GALERIA
      set
        /* %SetFK(GALERIA,NULL) */
        GALERIA.KON_ID = NULL
      where
        /* %JoinFKPK(GALERIA,:%Old," = ",",") */
        GALERIA.KON_ID = :old.ID;
  end if;


-- ERwin Builtin Thu Feb 05 16:50:53 2004
end;
/

create trigger tD_MAPY after DELETE on MAPY for each row
-- ERwin Builtin Thu Feb 05 16:50:53 2004
-- DELETE trigger on MAPY 
declare numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 16:50:53 2004 */
    /* MAPY R/53 MAPY_KONTAKTY ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from MAPY_KONTAKTY
      where
        /*  %JoinFKPK(MAPY_KONTAKTY,:%Old," = "," and") */
        MAPY_KONTAKTY.ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE MAPY because MAPY_KONTAKTY exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 16:50:53 2004
end;
/

create trigger tU_MAPY after UPDATE on MAPY for each row
-- ERwin Builtin Thu Feb 05 16:50:53 2004
-- UPDATE trigger on MAPY 
declare numrows INTEGER;
begin
  /* ERwin Builtin Thu Feb 05 16:50:53 2004 */
  /* MAPY R/53 MAPY_KONTAKTY ON PARENT UPDATE RESTRICT */
  if
    /* %JoinPKPK(:%Old,:%New," <> "," or ") */
    :old.ID <> :new.ID
  then
    select count(*) into numrows
      from MAPY_KONTAKTY
      where
        /*  %JoinFKPK(MAPY_KONTAKTY,:%Old," = "," and") */
        MAPY_KONTAKTY.ID = :old.ID;
    if (numrows > 0)
    then 
      raise_application_error(
        -20005,
        'Cannot UPDATE MAPY because MAPY_KONTAKTY exists.'
      );
    end if;
  end if;


-- ERwin Builtin Thu Feb 05 16:50:53 2004
end;
/

create trigger tI_MAPY_KONTAKTY after INSERT on MAPY_KONTAKTY for each row
-- ERwin Builtin Thu Feb 05 16:50:53 2004
-- INSERT trigger on MAPY_KONTAKTY 
declare numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 16:50:53 2004 */
    /* KONTAKTY R/54 MAPY_KONTAKTY ON CHILD INSERT RESTRICT */
    select count(*) into numrows
      from KONTAKTY
      where
        /* %JoinFKPK(:%New,KONTAKTY," = "," and") */
        :new.ID = KONTAKTY.ID;
    if (
      /* %NotnullFK(:%New," is not null and") */
      
      numrows = 0
    )
    then
      raise_application_error(
        -20002,
        'Cannot INSERT MAPY_KONTAKTY because KONTAKTY does not exist.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 16:50:53 2004 */
    /* MAPY R/53 MAPY_KONTAKTY ON CHILD INSERT RESTRICT */
    select count(*) into numrows
      from MAPY
      where
        /* %JoinFKPK(:%New,MAPY," = "," and") */
        :new.ID = MAPY.ID;
    if (
      /* %NotnullFK(:%New," is not null and") */
      
      numrows = 0
    )
    then
      raise_application_error(
        -20002,
        'Cannot INSERT MAPY_KONTAKTY because MAPY does not exist.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 16:50:53 2004
end;
/

create trigger tU_MAPY_KONTAKTY after UPDATE on MAPY_KONTAKTY for each row
-- ERwin Builtin Thu Feb 05 16:50:53 2004
-- UPDATE trigger on MAPY_KONTAKTY 
declare numrows INTEGER;
begin
  /* ERwin Builtin Thu Feb 05 16:50:53 2004 */
  /* KONTAKTY R/54 MAPY_KONTAKTY ON CHILD UPDATE RESTRICT */
  select count(*) into numrows
    from KONTAKTY
    where
      /* %JoinFKPK(:%New,KONTAKTY," = "," and") */
      :new.ID = KONTAKTY.ID;
  if (
    /* %NotnullFK(:%New," is not null and") */
    
    numrows = 0
  )
  then
    raise_application_error(
      -20007,
      'Cannot UPDATE MAPY_KONTAKTY because KONTAKTY does not exist.'
    );
  end if;

  /* ERwin Builtin Thu Feb 05 16:50:53 2004 */
  /* MAPY R/53 MAPY_KONTAKTY ON CHILD UPDATE RESTRICT */
  select count(*) into numrows
    from MAPY
    where
      /* %JoinFKPK(:%New,MAPY," = "," and") */
      :new.ID = MAPY.ID;
  if (
    /* %NotnullFK(:%New," is not null and") */
    
    numrows = 0
  )
  then
    raise_application_error(
      -20007,
      'Cannot UPDATE MAPY_KONTAKTY because MAPY does not exist.'
    );
  end if;


-- ERwin Builtin Thu Feb 05 16:50:53 2004
end;
/

create trigger tD_PIKTOGRAMY
  AFTER DELETE
  on PIKTOGRAMY
  
  for each row
DECLARE
numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* PIKTOGRAMY ZP_PIKT_FK ZAR_PIKT ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from ZAR_PIKT
      where
        /*  %JoinFKPK(ZAR_PIKT,:%Old," = "," and") */
        ZAR_PIKT.PIKT_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE PIKTOGRAMY because ZAR_PIKT exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 15:23:13 2004
end

create trigger tI_GALERIA after INSERT on GALERIA for each row
-- ERwin Builtin Thu Feb 05 16:50:53 2004
-- INSERT trigger on GALERIA 
declare numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 16:50:53 2004 */
    /* KONTAKTY R/51 GALERIA ON CHILD INSERT SET NULL */
    update GALERIA
      set
        /* %SetFK(GALERIA,NULL) */
        GALERIA.KON_ID = NULL
      where
        not exists (
          select * from KONTAKTY
            where
              /* %JoinFKPK(:%New,KONTAKTY," = "," and") */
              :new.KON_ID = KONTAKTY.ID
        ) and
        /* %JoinPKPK(GALERIA,:%New," = "," and") */
        GALERIA.ID = :new.ID;


-- ERwin Builtin Thu Feb 05 16:50:53 2004
end;
/

create trigger tU_GALERIA after UPDATE on GALERIA for each row
-- ERwin Builtin Thu Feb 05 16:50:53 2004
-- UPDATE trigger on GALERIA 
declare numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 16:50:53 2004 */
    /* KONTAKTY R/51 GALERIA ON CHILD UPDATE SET NULL */
    update GALERIA
      set
        /* %SetFK(GALERIA,NULL) */
        GALERIA.KON_ID = NULL
      where
        not exists (
          select * from KONTAKTY
            where
              /* %JoinFKPK(:%New,KONTAKTY," = "," and") */
              :new.KON_ID = KONTAKTY.ID
        ) and
        /* %JoinPKPK(GALERIA,:%New," = "," and") */
        GALERIA.ID = :new.ID;


-- ERwin Builtin Thu Feb 05 16:50:53 2004
end;
/

create trigger tD_OBEC_NP after DELETE on OBEC_NP for each row
-- ERwin Builtin Thu Feb 05 16:50:53 2004
-- DELETE trigger on OBEC_NP 
declare numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 16:50:53 2004 */
    /* OBEC  OBEC_NP ON CHILD DELETE RESTRICT */
    select count(*) into numrows from OBEC
      where
        /* %JoinFKPK(:%Old,OBEC," = "," and") */
        :old.OBE_ID = OBEC.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20010,
        'Cannot DELETE OBEC_NP because OBEC exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 16:50:53 2004
end;
/

create trigger tD_DOPR_BOD
  AFTER DELETE
  on DOPR_BOD
  
  for each row
DECLARE
numrows INTEGER;
begin
    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* DOPR_BOD CP_DB_FK CEST_PORIADOK ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from CEST_PORIADOK
      where
        /*  %JoinFKPK(CEST_PORIADOK,:%Old," = "," and") */
        CEST_PORIADOK.DB_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE DOPR_BOD because CEST_PORIADOK exists.'
      );
    end if;

    /* ERwin Builtin Thu Feb 05 15:23:13 2004 */
    /* DOPR_BOD ZP_DB_FK ZAR_PIKT ON PARENT DELETE RESTRICT */
    select count(*) into numrows
      from ZAR_PIKT
      where
        /*  %JoinFKPK(ZAR_PIKT,:%Old," = "," and") */
        ZAR_PIKT.DB_ID = :old.ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE DOPR_BOD because ZAR_PIKT exists.'
      );
    end if;


-- ERwin Builtin Thu Feb 05 15:23:13 2004
end

