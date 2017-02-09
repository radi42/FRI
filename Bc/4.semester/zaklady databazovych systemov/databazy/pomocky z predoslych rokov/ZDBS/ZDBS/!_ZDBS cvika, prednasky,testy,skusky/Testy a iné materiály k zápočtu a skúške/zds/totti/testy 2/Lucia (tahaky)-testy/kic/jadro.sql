
CREATE TABLE predmet (
       id_predmet           CHAR(5) NOT NULL,
       nazov                VARCHAR2(30) NOT NULL,
       kredit               SMALLINT DEFAULT 0 NULL
);


ALTER TABLE predmet
       ADD  ( PRIMARY KEY (id_predmet) ) ;


CREATE TABLE stat (
       nazov                VARCHAR2(20) NULL,
       skratka              CHAR(3) NOT NULL
);


ALTER TABLE stat
       ADD  ( PRIMARY KEY (skratka) ) ;


CREATE TABLE narodnost (
       id_nar               INTEGER NOT NULL,
       nazov                VARCHAR2(20) NOT NULL
);


ALTER TABLE narodnost
       ADD  ( PRIMARY KEY (id_nar) ) ;


CREATE TABLE kraj (
       id_kraj              INTEGER NOT NULL,
       skratka              CHAR(3) NOT NULL,
       nazov                VARCHAR2(20) NOT NULL
);


ALTER TABLE kraj
       ADD  ( PRIMARY KEY (id_kraj) ) ;


CREATE TABLE okres (
       id_okres             INTEGER NOT NULL,
       id_kraj              INTEGER NOT NULL,
       nazov                VARCHAR2(20) NOT NULL
);


ALTER TABLE okres
       ADD  ( PRIMARY KEY (id_okres) ) ;


CREATE TABLE obec (
       id_obec              INTEGER NOT NULL,
       id_okres             INTEGER NOT NULL,
       nazov                VARCHAR2(20) NOT NULL,
       PSC                  CHAR(5) NOT NULL
);


ALTER TABLE obec
       ADD  ( PRIMARY KEY (id_obec) ) ;


CREATE TABLE osoba (
       rod_cislo            CHAR(10) NOT NULL,
       stav                 CHAR(1) NOT NULL,
       statna_prislusnost   CHAR(3) NOT NULL,
       narodnost            INTEGER NOT NULL,
       obec                 INTEGER NOT NULL,
       priezvisko           VARCHAR2(20) NOT NULL,
       meno                 VARCHAR2(20) NOT NULL,
       rodne_priezvisko     VARCHAR2(20) NOT NULL,
       cislo_OP             CHAR(8) NOT NULL,
       cislo_PAS            VARCHAR2(15) NOT NULL,
       ulica_cislo          VARCHAR2(30) NOT NULL
);


ALTER TABLE osoba
       ADD  ( PRIMARY KEY (rod_cislo) ) ;


CREATE TABLE osobne_cisla (
       os_cislo             INTEGER NOT NULL,
       rod_cislo            CHAR(10) NOT NULL,
       datum                DATE NULL
);


ALTER TABLE osobne_cisla
       ADD  ( PRIMARY KEY (os_cislo) ) ;


CREATE TABLE stud_program (
       id_stud_prog         INTEGER NOT NULL,
       id_zameranie         INTEGER NOT NULL,
       popis_zamerania      VARCHAR2(30) NULL,
       popis_odboru         VARCHAR2(30) NULL
);


ALTER TABLE stud_program
       ADD  ( PRIMARY KEY (id_stud_prog, id_zameranie) ) ;


CREATE TABLE student (
       os_cislo             INTEGER NOT NULL,
       id_zameranie         INTEGER NOT NULL,
       id_stud_prog         INTEGER NOT NULL,
       rocnik               SMALLINT DEFAULT 1 NOT NULL
                                   CHECK (rocnik BETWEEN 1 AND 5),
       stupen               SMALLINT DEFAULT 1 NOT NULL
                                   CHECK (stupen BETWEEN 1 AND 3),
       forma                CHAR(1) DEFAULT 'D' NOT NULL
                                   CHECK (forma IN ('D', 'E')),
       studijna_skupina     CHAR(5) NOT NULL
);


ALTER TABLE student
       ADD  ( PRIMARY KEY (os_cislo) ) ;


CREATE TABLE zap_predmety (
       cis_predm            CHAR(5) NOT NULL,
       skrok                INTEGER NOT NULL,
       os_cislo             INTEGER NOT NULL,
       vysledok             CHAR(1) NULL
                                   CHECK (vysledok IN ('A', 'B', 'C', 'D', 'E', 'F')),
       datum_sk             DATE NOT NULL,
       zapocet              DATE NULL
);

CREATE INDEX IND_skolsky_rok ON zap_predmety
(
       skrok                          ASC
);


ALTER TABLE zap_predmety
       ADD  ( PRIMARY KEY (cis_predm, skrok, os_cislo) ) ;


CREATE TABLE pracovisko (
       id_pracovisko        INTEGER NOT NULL,
       nazov                VARCHAR2(50) NOT NULL,
       os_cislo_veduci      INTEGER NOT NULL
);


ALTER TABLE pracovisko
       ADD  ( PRIMARY KEY (id_pracovisko) ) ;


CREATE TABLE zameranie (
       id_zameranie         INTEGER NOT NULL,
       nazov                VARCHAR2(30) NOT NULL
);


ALTER TABLE zameranie
       ADD  ( PRIMARY KEY (id_zameranie) ) ;


CREATE TABLE ucitel (
       id_pracovisko        INTEGER NOT NULL,
       id_zameranie         INTEGER NOT NULL,
       os_cislo             INTEGER NOT NULL,
       tarifa               SMALLINT NOT NULL,
       titul_pred           CHAR(18) NULL,
       titul_za             CHAR(18) NULL
);


ALTER TABLE ucitel
       ADD  ( PRIMARY KEY (os_cislo) ) ;


CREATE TABLE zamestnanec (
       id_pracovisko        INTEGER NOT NULL,
       id_zameranie         INTEGER NOT NULL,
       os_cislo             INTEGER NOT NULL,
       tarifa               SMALLINT NOT NULL
);


ALTER TABLE zamestnanec
       ADD  ( PRIMARY KEY (os_cislo) ) ;


ALTER TABLE kraj
       ADD  ( FOREIGN KEY (skratka)
                             REFERENCES stat ) ;


ALTER TABLE okres
       ADD  ( FOREIGN KEY (id_kraj)
                             REFERENCES kraj ) ;


ALTER TABLE obec
       ADD  ( FOREIGN KEY (id_okres)
                             REFERENCES okres ) ;


ALTER TABLE osoba
       ADD  ( FOREIGN KEY (statna_prislusnost)
                             REFERENCES stat ) ;


ALTER TABLE osoba
       ADD  ( FOREIGN KEY (narodnost)
                             REFERENCES narodnost ) ;


ALTER TABLE osoba
       ADD  ( FOREIGN KEY (obec)
                             REFERENCES obec ) ;


ALTER TABLE osobne_cisla
       ADD  ( FOREIGN KEY (rod_cislo)
                             REFERENCES osoba ) ;


ALTER TABLE student
       ADD  ( FOREIGN KEY (os_cislo)
                             REFERENCES osobne_cisla ) ;


ALTER TABLE student
       ADD  ( FOREIGN KEY (id_stud_prog, id_zameranie)
                             REFERENCES stud_program ) ;


ALTER TABLE zap_predmety
       ADD  ( FOREIGN KEY (cis_predm)
                             REFERENCES predmet ) ;


ALTER TABLE zap_predmety
       ADD  ( FOREIGN KEY (os_cislo)
                             REFERENCES student ) ;


ALTER TABLE pracovisko
       ADD  ( FOREIGN KEY (os_cislo_veduci)
                             REFERENCES ucitel ) ;


ALTER TABLE ucitel
       ADD  ( FOREIGN KEY (id_pracovisko)
                             REFERENCES pracovisko ) ;


ALTER TABLE ucitel
       ADD  ( FOREIGN KEY (id_zameranie)
                             REFERENCES zameranie ) ;


ALTER TABLE ucitel
       ADD  ( FOREIGN KEY (os_cislo)
                             REFERENCES osobne_cisla ) ;


ALTER TABLE zamestnanec
       ADD  ( FOREIGN KEY (id_pracovisko)
                             REFERENCES pracovisko ) ;


ALTER TABLE zamestnanec
       ADD  ( FOREIGN KEY (id_zameranie)
                             REFERENCES zameranie ) ;


ALTER TABLE zamestnanec
       ADD  ( FOREIGN KEY (os_cislo)
                             REFERENCES osobne_cisla ) ;



