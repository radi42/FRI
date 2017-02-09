
CREATE TABLE dodavatel (
       id                   VARCHAR2(11) NOT NULL
                                   CHECK (id like ('d%') or id like ('o%') or id like ('p%')),
       nazov                VARCHAR2(20) NULL
);


ALTER TABLE dodavatel
       ADD  ( PRIMARY KEY (id) ) ;


CREATE TABLE zakaznik (
       cislodokladu         VARCHAR2(11) NOT NULL
                                   CHECK (cislodokladu like ('d%') or id like ('o%') or id like ('p%')),
       meno                 VARCHAR2(15) NULL,
       priezvisko           VARCHAR2(20) NULL
);


ALTER TABLE zakaznik
       ADD  ( PRIMARY KEY (cislodokladu) ) ;


CREATE TABLE kontakt (
       subjekt              VARCHAR2(11) NOT NULL
                                   CHECK (subjekt like ('d%') or id like ('o%') or id like ('p%')),
       id                   NUMBER NOT NULL,
       mesto                VARCHAR2(20) NULL,
       ulica                VARCHAR2(20) NULL,
       psc                  CHAR(5) NULL,
       telefon              CHAR(12) NULL
);


ALTER TABLE kontakt
       ADD  ( PRIMARY KEY (subjekt, id) ) ;


CREATE TABLE typ_vozidla (
       id                   SMALLINT NOT NULL,
       popis                VARCHAR2(30) NULL
);


ALTER TABLE typ_vozidla
       ADD  ( PRIMARY KEY (id) ) ;


CREATE TABLE vozidlo (
       id                   VARCHAR2(11) NOT NULL
                                   CHECK (id like ('d%') or id like ('o%') or id like ('p%')),
       typ_id               SMALLINT NOT NULL,
       spotreba             NUMBER NULL,
       spz                  CHAR(7) NOT NULL,
       cenaKupy             NUMBER NULL,
       kupeneDat            DATE NULL,
       najazdene            NUMBER NULL,
       vyradeneDat          DATE NULL,
       vek                  NUMBER NULL
);


ALTER TABLE vozidlo
       ADD  ( PRIMARY KEY (spz) ) ;


CREATE TABLE pozicanie (
       spz                  CHAR(7) NOT NULL,
       od                   DATE NOT NULL,
       cena                 NUMBER NULL,
       do                   DATE NOT NULL,
       cislodokladu         VARCHAR2(11) NOT NULL
                                   CHECK (cislodokladu like ('d%') or id like ('o%') or id like ('p%'))
);


ALTER TABLE pozicanie
       ADD  ( PRIMARY KEY (spz, od) ) ;


CREATE TABLE udalost (
       spz                  CHAR(7) NOT NULL,
       od                   DATE NOT NULL
                                   CHECK (od IN ('havaria', 'oprava', 'dan', 'poistka', 'stk', 'porucha')),
       do                   DATE NULL,
       typudal              VARCHAR2(30) NOT NULL
                                   CHECK (typudal IN ('havaria', 'oprava', 'dan', 'poistka', 'stk', 'porucha')),
       cena                 NUMBER NULL
);


ALTER TABLE udalost
       ADD  ( PRIMARY KEY (od, spz, typudal) ) ;


CREATE TABLE rezervacia (
       spz                  CHAR(7) NOT NULL,
       cislodokladu         VARCHAR2(11) NOT NULL
                                   CHECK (cislodokladu like ('d%') or id like ('o%') or id like ('p%'))),
       od                   DATE NOT NULL,
       do                   DATE NULL
);


ALTER TABLE rezervacia
       ADD  ( PRIMARY KEY (spz, od) ) ;


ALTER TABLE kontakt
       ADD  ( FOREIGN KEY (subjekt)
                             REFERENCES dodavatel ) ;


ALTER TABLE kontakt
       ADD  ( FOREIGN KEY (subjekt)
                             REFERENCES zakaznik ) ;


ALTER TABLE vozidlo
       ADD  ( FOREIGN KEY (id)
                             REFERENCES dodavatel ) ;


ALTER TABLE vozidlo
       ADD  ( FOREIGN KEY (typ_id)
                             REFERENCES typ_vozidla ) ;


ALTER TABLE pozicanie
       ADD  ( FOREIGN KEY (spz)
                             REFERENCES vozidlo ) ;


ALTER TABLE pozicanie
       ADD  ( FOREIGN KEY (cislodokladu)
                             REFERENCES zakaznik ) ;


ALTER TABLE udalost
       ADD  ( FOREIGN KEY (spz)
                             REFERENCES vozidlo ) ;


ALTER TABLE rezervacia
       ADD  ( FOREIGN KEY (spz)
                             REFERENCES vozidlo ) ;


ALTER TABLE rezervacia
       ADD  ( FOREIGN KEY (cislodokladu)
                             REFERENCES zakaznik ) ;



