
CREATE TABLE objekt (
       obj_id               CHAR(18) NOT NULL,
       nazov                VARCHAR(50) NOT NULL,
       popis                NUMBER NULL
);


ALTER TABLE objekt
       ADD  ( PRIMARY KEY (obj_id) ) ;


CREATE TABLE www (
       linka                VARCHAR(50) NOT NULL,
       obj_id               NUMBER NOT NULL,
       popis                NUMBER NULL,
       nazov                VARCHAR(50) NULL
);


ALTER TABLE www
       ADD  ( PRIMARY KEY (linka) ) ;


CREATE TABLE obchod (
       obj_id               NUMBER NOT NULL,
       popis                NUMBER NULL
);


ALTER TABLE obchod
       ADD  ( PRIMARY KEY (obj_id) ) ;


CREATE TABLE typ_celku (
       typ_uz               NUMBER NOT NULL,
       nazov                NUMBER NULL
);


ALTER TABLE typ_celku
       ADD  ( PRIMARY KEY (typ_uz) ) ;


CREATE TABLE uz_celok (
       uz_id                NUMBER NOT NULL,
       nadradeny_uz         NUMBER NULL,
       skratka              VARCHAR2(20) NULL,
       nazov                VARCHAR2(20) NULL,
       typ_uz               NUMBER NOT NULL,
       ident                VARCHAR2(20) NULL
);


ALTER TABLE uz_celok
       ADD  ( PRIMARY KEY (uz_id) ) ;


CREATE TABLE bod (
       bod_id               NUMBER NOT NULL,
       sur_x                NUMBER NOT NULL,
       sur_y                NUMBER NOT NULL,
       uz_id                NUMBER NOT NULL,
       obj_id               NUMBER NOT NULL
);


ALTER TABLE bod
       ADD  ( PRIMARY KEY (bod_id) ) ;


CREATE TABLE cest_poriadok (
       cp_id                NUMBER NOT NULL,
       z_bod                NUMBER NOT NULL,
       do_id                NUMBER NULL,
       ciel                 VARCHAR2(20) NULL,
       spoj                 NUMBER NULL,
       hod                  NUMBER NULL,
       min                  NUMBER NULL,
       poznamka             NUMBER NULL
);


ALTER TABLE cest_poriadok
       ADD  ( PRIMARY KEY (cp_id) ) ;


CREATE TABLE typ_info (
       typ_info             NUMBER NOT NULL,
       popis                NUMBER NOT NULL
);


ALTER TABLE typ_info
       ADD  ( PRIMARY KEY (typ_info) ) ;


CREATE TABLE info (
       info_id              NUMBER NOT NULL,
       obj_id               NUMBER NOT NULL,
       popis                NUMBER NOT NULL
);


ALTER TABLE info
       ADD  ( PRIMARY KEY (info_id) ) ;


CREATE TABLE typ_kul_zar (
       typ_kz               NUMBER NOT NULL,
       popis                NUMBER NULL
);


ALTER TABLE typ_kul_zar
       ADD  ( PRIMARY KEY (typ_kz) ) ;


CREATE TABLE typ_sluzby (
       typ_sluz             NUMBER NOT NULL,
       nazov                NUMBER NULL,
       popis                NUMBER NULL
);


ALTER TABLE typ_sluzby
       ADD  ( PRIMARY KEY (typ_sluz) ) ;


CREATE TABLE nar_park (
       obj_id               NUMBER NOT NULL,
       typ_np               VARCHAR2(20) NULL,
       popis                NUMBER NULL
);


ALTER TABLE nar_park
       ADD  ( PRIMARY KEY (obj_id) ) ;


CREATE TABLE uz_celok_nar_park (
       uz_id                NUMBER NOT NULL,
       obj_id               NUMBER NOT NULL
);


ALTER TABLE uz_celok_nar_park
       ADD  ( PRIMARY KEY (uz_id, obj_id) ) ;


CREATE TABLE cennik (
       obj_id               NUMBER NOT NULL,
       cen_id               NUMBER NOT NULL,
       typ_sluz             NUMBER NULL,
       platne_od            DATE NOT NULL,
       platne_do            DATE NULL,
       cena                 NUMBER(10,2) NOT NULL,
       mena                 CHAR(3) NULL,
       popis                NUMBER NOT NULL
);


ALTER TABLE cennik
       ADD  ( PRIMARY KEY (cen_id) ) ;


CREATE TABLE typ_rezervacie (
       typ_rez              NUMBER NOT NULL,
       nazov                VARCHAR2(20) NOT NULL
);


ALTER TABLE typ_rezervacie
       ADD  ( PRIMARY KEY (typ_rez) ) ;


CREATE TABLE typ_ubytovania (
       typ_ubyt             NUMBER NOT NULL,
       popis                NUMBER NULL
);


ALTER TABLE typ_ubytovania
       ADD  ( PRIMARY KEY (typ_ubyt) ) ;


CREATE TABLE texty (
       text_id              NUMBER NOT NULL,
       jazyk                VARCHAR2(20) NOT NULL,
       text                 VARCHAR(500) NOT NULL,
       dalej                NUMBER NULL
);


ALTER TABLE texty
       ADD  ( PRIMARY KEY (text_id, jazyk) ) ;


CREATE TABLE file (
       file_id              NUMBER NOT NULL,
       nazov                VARCHAR(20) NOT NULL,
       cesta                VARCHAR(100) NOT NULL
);


ALTER TABLE file
       ADD  ( PRIMARY KEY (file_id) ) ;


CREATE TABLE icony (
       file_id              NUMBER NOT NULL,
       obj_id               NUMBER NOT NULL,
       poradie              NUMBER DEFAULT 1 NOT NULL,
       popis                NUMBER NULL
);


ALTER TABLE icony
       ADD  ( PRIMARY KEY (file_id, obj_id) ) ;


CREATE TABLE typ_udalosti (
       typ_udal             NUMBER NOT NULL,
       text_id              NUMBER NULL
);


ALTER TABLE typ_udalosti
       ADD  ( PRIMARY KEY (typ_udal) ) ;


CREATE TABLE udalosti (
       obj_id               NUMBER NOT NULL,
       event_id             NUMBER NOT NULL,
       typ_udal             NUMBER NOT NULL,
       DFrom                DATE NULL,
       Dto                  DATE NULL,
       popis                NUMBER NOT NULL
);


ALTER TABLE udalosti
       ADD  ( PRIMARY KEY (event_id) ) ;


CREATE TABLE obrazky (
       file_id              NUMBER NOT NULL,
       obj_id               NUMBER NOT NULL,
       popis                NUMBER NULL
);


ALTER TABLE obrazky
       ADD  ( PRIMARY KEY (file_id, obj_id) ) ;


CREATE TABLE mapy (
       file_id              NUMBER NOT NULL,
       obj_id               NUMBER NOT NULL,
       poradie              NUMBER NULL,
       popis                NUMBER NULL
);


ALTER TABLE mapy
       ADD  ( PRIMARY KEY (file_id, obj_id) ) ;


CREATE TABLE klient (
       klient_id            NUMBER NOT NULL,
       meno                 VARCHAR(15) NULL,
       priezvisko           VARCHAR(20) NOT NULL,
       rating               NUMBER NULL
);


ALTER TABLE klient
       ADD  ( PRIMARY KEY (klient_id) ) ;


CREATE TABLE rezervacie (
       obj_id               NUMBER NOT NULL,
       rezerv_id            NUMBER NOT NULL,
       typ_rez              NUMBER NOT NULL,
       klient_id            NUMBER NOT NULL,
       poziadavky           VARCHAR2(20) NULL,
       pocet                NUMBER NOT NULL,
       pocet_d              NUMBER DEFAULT 0 NOT NULL,
       zavaznost            CHAR(1) NOT NULL,
       Dod                  DATE NOT NULL,
       Ddo                  DATE NULL,
       poznamka             VARCHAR(50) NULL,
       datum                DATE NOT NULL,
       strava               CHARACTER(1) NOT NULL,
       uziv                 VARCHAR(15) NULL
);


ALTER TABLE rezervacie
       ADD  ( PRIMARY KEY (rezerv_id) ) ;


CREATE TABLE sluzby (
       obj_id               NUMBER NOT NULL,
       typ_sluz             NUMBER NOT NULL,
       popis                NUMBER NULL
);


ALTER TABLE sluzby
       ADD  ( PRIMARY KEY (obj_id) ) ;


CREATE TABLE stredisko (
       obj_id               NUMBER NOT NULL,
       typ_stred            NUMBER NULL,
       popis                NUMBER NULL
);


ALTER TABLE stredisko
       ADD  ( PRIMARY KEY (obj_id) ) ;


CREATE TABLE ubytovanie (
       obj_id               NUMBER NOT NULL,
       typ_ubyt             NUMBER NOT NULL,
       poc_lozok            NUMBER NULL,
       ranajky              CHAR(1) NULL,
       popis                NUMBER NULL
);


ALTER TABLE ubytovanie
       ADD  ( PRIMARY KEY (obj_id) ) ;


CREATE TABLE gal_muzeum (
       obj_id               NUMBER NOT NULL,
       typ_kz               NUMBER NOT NULL,
       expozicia            NUMBER NULL
);


ALTER TABLE gal_muzeum
       ADD  ( PRIMARY KEY (obj_id) ) ;


CREATE TABLE zariadenie (
       obj_id               NUMBER NOT NULL
);


ALTER TABLE zariadenie
       ADD  ( PRIMARY KEY (obj_id) ) ;


CREATE TABLE restauracia (
       obj_id               NUMBER NOT NULL,
       kapacita             NUMBER NULL,
       kuchyna              NUMBER NULL,
       popis                NUMBER NULL
);


ALTER TABLE restauracia
       ADD  ( PRIMARY KEY (obj_id) ) ;


CREATE TABLE kontakty (
       kont_id              NUMBER NOT NULL,
       obj_id               NUMBER NOT NULL,
       klient_id            NUMBER NULL,
       telefon              NUMBER NULL,
       mobil                NUMBER NULL,
       email                VARCHAR2(20) NULL,
       osoba                VARCHAR2(20) NULL
);


ALTER TABLE kontakty
       ADD  ( PRIMARY KEY (kont_id) ) ;


CREATE TABLE adresy (
       adr_id               NUMBER NOT NULL,
       klient_id            NUMBER NULL,
       obj_id               NUMBER NULL
);


ALTER TABLE adresy
       ADD  ( PRIMARY KEY (adr_id) ) ;


ALTER TABLE objekt
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt ) ;


ALTER TABLE www
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt ) ;


ALTER TABLE obchod
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt
                             ON DELETE CASCADE ) ;


ALTER TABLE uz_celok
       ADD  ( FOREIGN KEY (typ_uz)
                             REFERENCES typ_celku ) ;


ALTER TABLE uz_celok
       ADD  ( FOREIGN KEY (nadradeny_uz)
                             REFERENCES uz_celok ) ;


ALTER TABLE bod
       ADD  ( FOREIGN KEY (uz_id)
                             REFERENCES uz_celok ) ;


ALTER TABLE bod
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt ) ;


ALTER TABLE cest_poriadok
       ADD  ( FOREIGN KEY (do_id)
                             REFERENCES bod ) ;


ALTER TABLE cest_poriadok
       ADD  ( FOREIGN KEY (z_bod)
                             REFERENCES bod ) ;


ALTER TABLE info
       ADD  ( FOREIGN KEY (info_id)
                             REFERENCES typ_info ) ;


ALTER TABLE info
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt ) ;


ALTER TABLE nar_park
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt
                             ON DELETE CASCADE ) ;


ALTER TABLE uz_celok_nar_park
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES nar_park ) ;


ALTER TABLE uz_celok_nar_park
       ADD  ( FOREIGN KEY (uz_id)
                             REFERENCES uz_celok ) ;


ALTER TABLE cennik
       ADD  ( FOREIGN KEY (typ_sluz)
                             REFERENCES typ_sluzby ) ;


ALTER TABLE cennik
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt ) ;


ALTER TABLE texty
       ADD  ( FOREIGN KEY (dalej, jazyk)
                             REFERENCES texty ) ;


ALTER TABLE icony
       ADD  ( FOREIGN KEY (file_id)
                             REFERENCES file ) ;


ALTER TABLE icony
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt ) ;


ALTER TABLE udalosti
       ADD  ( FOREIGN KEY (typ_udal)
                             REFERENCES typ_udalosti ) ;


ALTER TABLE udalosti
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt ) ;


ALTER TABLE obrazky
       ADD  ( FOREIGN KEY (file_id)
                             REFERENCES file ) ;


ALTER TABLE obrazky
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt ) ;


ALTER TABLE mapy
       ADD  ( FOREIGN KEY (file_id)
                             REFERENCES file ) ;


ALTER TABLE mapy
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt ) ;


ALTER TABLE rezervacie
       ADD  ( FOREIGN KEY (klient_id)
                             REFERENCES klient ) ;


ALTER TABLE rezervacie
       ADD  ( FOREIGN KEY (typ_rez)
                             REFERENCES typ_rezervacie ) ;


ALTER TABLE rezervacie
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt ) ;


ALTER TABLE sluzby
       ADD  ( FOREIGN KEY (typ_sluz)
                             REFERENCES typ_sluzby ) ;


ALTER TABLE sluzby
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt
                             ON DELETE CASCADE ) ;


ALTER TABLE stredisko
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt
                             ON DELETE CASCADE ) ;


ALTER TABLE ubytovanie
       ADD  ( FOREIGN KEY (typ_ubyt)
                             REFERENCES typ_ubytovania ) ;


ALTER TABLE ubytovanie
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt
                             ON DELETE CASCADE ) ;


ALTER TABLE gal_muzeum
       ADD  ( FOREIGN KEY (typ_kz)
                             REFERENCES typ_kul_zar ) ;


ALTER TABLE gal_muzeum
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt
                             ON DELETE CASCADE ) ;


ALTER TABLE zariadenie
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt
                             ON DELETE CASCADE ) ;


ALTER TABLE restauracia
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt
                             ON DELETE CASCADE ) ;


ALTER TABLE kontakty
       ADD  ( FOREIGN KEY (klient_id)
                             REFERENCES klient ) ;


ALTER TABLE kontakty
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt ) ;


ALTER TABLE adresy
       ADD  ( FOREIGN KEY (klient_id)
                             REFERENCES klient ) ;


ALTER TABLE adresy
       ADD  ( FOREIGN KEY (obj_id)
                             REFERENCES objekt ) ;



