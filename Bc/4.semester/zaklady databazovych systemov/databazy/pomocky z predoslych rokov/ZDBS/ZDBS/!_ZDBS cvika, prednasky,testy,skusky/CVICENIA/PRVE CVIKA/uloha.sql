
CREATE TABLE ucitel (
       os_cislo             INTEGER NOT NULL,
       meno                 VARCHAR2(20) NOT NULL,
       priezvisko           VARCHAR2(50) NOT NULL
);


ALTER TABLE ucitel
       ADD  ( PRIMARY KEY (os_cislo) ) ;


CREATE TABLE predmet (
       cis_predm            VARCHAR2(20) NOT NULL,
       gestor               INTEGER NOT NULL,
       nazov                VARCHAR2(20) NOT NULL,
       kredit               NUMBER NOT NULL
);


ALTER TABLE predmet
       ADD  ( PRIMARY KEY (cis_predm) ) ;


CREATE TABLE st_odbory (
       st_zameranie         VARCHAR2(20) NOT NULL,
       st_odbor             VARCHAR2(20) NOT NULL,
       popis_odboru         VARCHAR2(20) NULL,
       popis_zamerania      VARCHAR2(20) NULL
);


ALTER TABLE st_odbory
       ADD  ( PRIMARY KEY (st_zameranie, st_odbor) ) ;


CREATE TABLE st_odbory_predmet (
       st_zameranie         VARCHAR2(20) NOT NULL,
       st_odbor             VARCHAR2(20) NOT NULL,
       cis_predm            VARCHAR2(20) NOT NULL
);


ALTER TABLE st_odbory_predmet
       ADD  ( PRIMARY KEY (st_zameranie, st_odbor, cis_predm) ) ;


CREATE TABLE os_udaje (
       rod_cislo            CHARACTER(11) NOT NULL,
       priezvisko           VARCHAR2(50) NOT NULL,
       meno                 VARCHAR2(20) NOT NULL,
       ulica                VARCHAR2(100) NOT NULL,
       st_prisl             CHARACTER(3) NOT NULL
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


CREATE TABLE zap_predmety (
       os_cislo             INTEGER NOT NULL,
       cis_predm            VARCHAR2(20) NOT NULL,
       skrok                SMALLINT NOT NULL,
       prednasajuci         INTEGER NOT NULL,
       datum_sk             DATE NULL,
       termin               INTEGER NULL,
       zapocet              DATE NULL,
       vysledok             CHAR(18) NULL
                                   CHECK (vysledok IN ('A','B','C','D','E','Fx')),
       kredity              INTEGER NOT NULL
);


ALTER TABLE zap_predmety
       ADD  ( PRIMARY KEY (os_cislo, cis_predm, skrok) ) ;


ALTER TABLE predmet
       ADD  ( FOREIGN KEY (gestor)
                             REFERENCES ucitel ) ;


ALTER TABLE st_odbory_predmet
       ADD  ( FOREIGN KEY (cis_predm)
                             REFERENCES predmet ) ;


ALTER TABLE st_odbory_predmet
       ADD  ( FOREIGN KEY (st_zameranie, st_odbor)
                             REFERENCES st_odbory ) ;


ALTER TABLE student
       ADD  ( FOREIGN KEY (st_zameranie, st_odbor)
                             REFERENCES st_odbory ) ;


ALTER TABLE student
       ADD  ( FOREIGN KEY (rod_cislo)
                             REFERENCES os_udaje ) ;


ALTER TABLE zap_predmety
       ADD  ( FOREIGN KEY (prednasajuci)
                             REFERENCES ucitel ) ;


ALTER TABLE zap_predmety
       ADD  ( FOREIGN KEY (cis_predm)
                             REFERENCES predmet ) ;


ALTER TABLE zap_predmety
       ADD  ( FOREIGN KEY (os_cislo)
                             REFERENCES student ) ;



