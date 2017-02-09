
CREATE TABLE katedra (
       cis_kat              CHAR(18) NOT NULL,
       veduci               INTEGER NOT NULL,
       nazov                CHAR(18) NULL,
       sekretariat          CHAR(18) NULL,
       fak_id               CHAR(18) NOT NULL
);


ALTER TABLE katedra
       ADD  ( PRIMARY KEY (cis_kat) ) ;


CREATE TABLE ucitel (
       os_cislo             INTEGER NOT NULL,
       meno                 VARCHAR2(20) NOT NULL,
       priezvisko           VARCHAR2(50) NOT NULL,
       katedra              VARCHAR2(20) NOT NULL
);


ALTER TABLE ucitel
       ADD  ( PRIMARY KEY (os_cislo) ) ;


CREATE TABLE obec (
       id                   CHAR(18) NOT NULL,
       nazov                CHAR(18) NULL,
       psc                  CHAR(18) NULL,
       okres                CHAR(18) NULL
);


ALTER TABLE obec
       ADD  ( PRIMARY KEY (id) ) ;


CREATE TABLE univerzita (
       id                   CHAR(18) NOT NULL,
       nazov                CHAR(18) NULL,
       nazov_eng            CHAR(18) NULL,
       obec_id              CHAR(18) NOT NULL
);


ALTER TABLE univerzita
       ADD  ( PRIMARY KEY (id) ) ;


CREATE TABLE fakulta (
       id                   CHAR(18) NOT NULL,
       dekan                INTEGER NOT NULL,
       nazov                CHAR(18) NULL,
       nazov_eng            CHAR(18) NULL,
       uni_id               CHAR(18) NOT NULL
);


ALTER TABLE fakulta
       ADD  ( PRIMARY KEY (id) ) ;


CREATE TABLE st_odbory (
       st_zameranie         VARCHAR2(20) NOT NULL,
       st_odbor             VARCHAR2(20) NOT NULL,
       popis_odboru         VARCHAR2(20) NULL,
       popis_zamerania      VARCHAR2(20) NULL,
       id                   NUMBER NOT NULL
);


ALTER TABLE st_odbory
       ADD  ( PRIMARY KEY (st_zameranie, st_odbor) ) ;


CREATE TABLE os_udaje (
       rod_cislo            CHARACTER(11) NOT NULL,
       priezvisko           VARCHAR2(50) NOT NULL,
       meno                 VARCHAR2(20) NOT NULL,
       ulica                VARCHAR2(100) NOT NULL,
       st_prisl             CHARACTER(3) NOT NULL,
       id                   NUMBER NOT NULL
);

CREATE UNIQUE INDEX INDEX_meno_priezvisko ON os_udaje
(
       meno                           ASC,
       priezvisko                     ASC,
       rod_cislo                      ASC
);


ALTER TABLE os_udaje
       ADD  ( PRIMARY KEY (rod_cislo) ) ;


CREATE TABLE student (
       os_cislo             INTEGER NOT NULL,
       rod_cislo            CHARACTER(11) NOT NULL,
       st_odbor             VARCHAR2(20) NOT NULL,
       st_zameranie         VARCHAR2(20) NOT NULL,
       DOM_ROCNIK           SMALLINT DEFAULT 1 NOT NULL
                                   CHECK (DOM_ROCNIK IN (0, 1, 2, 3, 4, 5)),
       st_skupina           VARCHAR2(10) NOT NULL,
       opakovanie           VARCHAR2(20) NOT NULL,
       prerusenie           DATE NULL,
       forma                VARCHAR2(20) NOT NULL,
       ukoncenie            DATE NULL,
       stav                 VARCHAR2(20) NOT NULL,
       dat_prv_zap          DATE NULL
);


ALTER TABLE student
       ADD  ( PRIMARY KEY (os_cislo) ) ;


CREATE TABLE predmet (
       cis_predm            VARCHAR2(20) NOT NULL,
       gestor               INTEGER NOT NULL,
       nazov                VARCHAR2(20) NOT NULL,
       kredit               NUMBER NOT NULL
);


ALTER TABLE predmet
       ADD  ( PRIMARY KEY (cis_predm) ) ;


CREATE TABLE st_odbory_predmet (
       st_zameranie         VARCHAR2(20) NOT NULL,
       st_odbor             VARCHAR2(20) NOT NULL,
       cis_predm            VARCHAR2(20) NOT NULL
);


ALTER TABLE st_odbory_predmet
       ADD  ( PRIMARY KEY (st_zameranie, st_odbor, cis_predm) ) ;


CREATE TABLE zap_predmety (
       os_cislo             INTEGER NOT NULL,
       cis_predm            VARCHAR2(20) NOT NULL,
       skrok                SMALLINT NOT NULL,
       prednasajuci         INTEGER NOT NULL,
       DOM_ZNAMKA           CHARACTER(2) NULL
                                   CHECK (DOM_ZNAMKA IN ['A','B','C','D','E','Fx']),
       datum_sk             DATE NULL,
       termin               INTEGER NULL,
       zapocet              DATE NULL,
       kredity              INTEGER NOT NULL
);


ALTER TABLE zap_predmety
       ADD  ( PRIMARY KEY (os_cislo, cis_predm, skrok) ) ;


CREATE TABLE info (
       skrok                CHAR(18) NOT NULL,
       fak_id               CHAR(18) NOT NULL,
       www                  CHAR(18) NULL,
       email_dek            CHAR(18) NULL,
       fax                  CHAR(18) NULL
);


ALTER TABLE info
       ADD  ( PRIMARY KEY (skrok, fak_id) ) ;


CREATE TABLE kontakty (
       id                   CHAR(18) NOT NULL,
       rod_cislo            CHARACTER(11) NOT NULL,
       popis                CHAR(18) NULL,
       kontakt              CHAR(18) NULL
);


ALTER TABLE kontakty
       ADD  ( PRIMARY KEY (id) ) ;

CREATE OR REPLACE VIEW Osoba AS
       SELECT student.os_cislo, os_udaje.meno, os_udaje.priezvisko, student.st_skupina, student.DOM_ROCNIK
       FROM os_udaje, student
       WHERE os_udaje.rod_cislo = student.rod_cislo;


ALTER TABLE katedra
       ADD  ( FOREIGN KEY (veduci)
                             REFERENCES ucitel ) ;


ALTER TABLE katedra
       ADD  ( FOREIGN KEY (fak_id)
                             REFERENCES fakulta ) ;


ALTER TABLE ucitel
       ADD  ( FOREIGN KEY (katedra)
                             REFERENCES katedra ) ;


ALTER TABLE univerzita
       ADD  ( FOREIGN KEY (obec_id)
                             REFERENCES obec ) ;


ALTER TABLE fakulta
       ADD  ( FOREIGN KEY (dekan)
                             REFERENCES ucitel ) ;


ALTER TABLE fakulta
       ADD  ( FOREIGN KEY (uni_id)
                             REFERENCES univerzita ) ;


ALTER TABLE st_odbory
       ADD  ( FOREIGN KEY (id)
                             REFERENCES fakulta ) ;


ALTER TABLE os_udaje
       ADD  ( FOREIGN KEY (id)
                             REFERENCES obec ) ;


ALTER TABLE student
       ADD  ( FOREIGN KEY (st_zameranie, st_odbor)
                             REFERENCES st_odbory ) ;


ALTER TABLE student
       ADD  ( FOREIGN KEY (rod_cislo)
                             REFERENCES os_udaje ) ;


ALTER TABLE predmet
       ADD  ( FOREIGN KEY (gestor)
                             REFERENCES ucitel ) ;


ALTER TABLE st_odbory_predmet
       ADD  ( FOREIGN KEY (cis_predm)
                             REFERENCES predmet ) ;


ALTER TABLE st_odbory_predmet
       ADD  ( FOREIGN KEY (st_zameranie, st_odbor)
                             REFERENCES st_odbory ) ;


ALTER TABLE zap_predmety
       ADD  ( FOREIGN KEY (prednasajuci)
                             REFERENCES ucitel ) ;


ALTER TABLE zap_predmety
       ADD  ( FOREIGN KEY (cis_predm)
                             REFERENCES predmet ) ;


ALTER TABLE zap_predmety
       ADD  ( FOREIGN KEY (os_cislo)
                             REFERENCES student ) ;


ALTER TABLE info
       ADD  ( FOREIGN KEY (fak_id)
                             REFERENCES fakulta ) ;


ALTER TABLE kontakty
       ADD  ( FOREIGN KEY (rod_cislo)
                             REFERENCES os_udaje ) ;



