
CREATE TABLE st_odbory (
       st_odbor             NUMBER(38) NOT NULL,
       st_zameranie         NUMBER(38) NOT NULL,
       popis_odboru         VARCHAR2(40) NOT NULL,
       popis_zamerania      VARCHAR2(40) NULL
);


ALTER TABLE st_odbory
       ADD  ( PRIMARY KEY (st_odbor, st_zameranie) ) ;


CREATE TABLE ucitel (
       os_cislo             VARCHAR2(5) NOT NULL,
       meno                 VARCHAR2(15) NULL,
       katedra              VARCHAR2(4) NULL,
       priezvisko           VARCHAR2(15) NOT NULL
);


ALTER TABLE ucitel
       ADD  ( PRIMARY KEY (os_cislo) ) ;


CREATE TABLE predmet (
       cis_predm            VARCHAR2(5) NOT NULL,
       gestor               VARCHAR2(5) NOT NULL,
       nazov                VARCHAR2(180) NOT NULL,
       kredit               NUMBER(2) NULL
);


ALTER TABLE predmet
       ADD  ( PRIMARY KEY (cis_predm) ) ;


CREATE TABLE os_udaje (
       rod_cislo            VARCHAR2(11) NOT NULL,
       meno                 VARCHAR2(15) NOT NULL,
       priezvisko           VARCHAR2(15) NOT NULL,
       ulica                VARCHAR2(20) NULL,
       obec                 VARCHAR2(20) NULL,
       psc                  VARCHAR2(5) NULL,
       st_prisl             VARCHAR2(2) NULL,
       okres                VARCHAR2(4) NULL
);


ALTER TABLE os_udaje
       ADD  ( PRIMARY KEY (rod_cislo) ) ;


CREATE TABLE student (
       os_cislo             NUMBER(38) NOT NULL,
       st_odbor             NUMBER(38) NOT NULL,
       st_zameranie         NUMBER(38) NOT NULL,
       rod_cislo            VARCHAR2(11) NOT NULL,
       rocnik               NUMBER(1) NULL,
       st_skupina           VARCHAR2(5) NULL,
       opakovanie           VARCHAR2(1) NULL,
       prerusenie           VARCHAR2(1) NULL,
       forma                VARCHAR2(20) NULL,
       ukoncenie            DATE NULL,
       stav                 VARCHAR2(1) NULL,
       dat_prv_zap          DATE NULL
);


ALTER TABLE student
       ADD  ( PRIMARY KEY (os_cislo) ) ;


CREATE TABLE zap_predmety (
       os_cislo             NUMBER(38) NOT NULL,
       skrok                NUMBER NOT NULL,
       cis_predm            VARCHAR2(5) NOT NULL,
       prednasajuci         VARCHAR2(5) NOT NULL,
       vysledok             CHAR(2) NULL,
       datum_sk             DATE NULL,
       termin               NUMBER(1) NULL,
       zapocet              DATE NULL,
       kredity              NUMBER(2) NULL
);


ALTER TABLE zap_predmety
       ADD  ( PRIMARY KEY (os_cislo, skrok, cis_predm) ) ;


ALTER TABLE predmet
       ADD  ( FOREIGN KEY (gestor)
                             REFERENCES ucitel ) ;


ALTER TABLE student
       ADD  ( FOREIGN KEY (st_odbor, st_zameranie)
                             REFERENCES st_odbory ) ;


ALTER TABLE student
       ADD  ( FOREIGN KEY (rod_cislo)
                             REFERENCES os_udaje ) ;


ALTER TABLE zap_predmety
       ADD  ( FOREIGN KEY (cis_predm)
                             REFERENCES predmet ) ;


ALTER TABLE zap_predmety
       ADD  ( FOREIGN KEY (prednasajuci)
                             REFERENCES ucitel ) ;


ALTER TABLE zap_predmety
       ADD  ( FOREIGN KEY (os_cislo)
                             REFERENCES student ) ;



