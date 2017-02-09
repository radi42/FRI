
CREATE TABLE sem_predmet (
       id_predmetu          NUMBER NOT NULL,
       nazov                VARCHAR2(20) NOT NULL,
       vydavatelstvo        VARCHAR2(20) NOT NULL,
       typ                  VARCHAR2(20) NOT NULL
                                   CHECK (typ IN ('kni', 'cla', 'zbo',
'cas', 'dip', 'cd')),
       info                 VARCHAR2(20) NULL,
       nadradeny            NUMBER NULL,
       vyradeny             VARCHAR(1) NOT NULL,
       pozicatelny          VARCHAR(1) NOT NULL
);


ALTER TABLE sem_predmet
       ADD  ( PRIMARY KEY (id_predmetu) ) ;


CREATE TABLE sem_autor (
       id_autor             NUMBER NOT NULL,
       meno                 VARCHAR2(20) NOT NULL,
       priezvisko           VARCHAR2(20) NOT NULL
);


ALTER TABLE sem_autor
       ADD  ( PRIMARY KEY (id_autor) ) ;


CREATE TABLE sem_predmet_autor (
       id_predmetu          NUMBER NOT NULL,
       id_autor             NUMBER NOT NULL
);


ALTER TABLE sem_predmet_autor
       ADD  ( PRIMARY KEY (id_predmetu, id_autor) ) ;


CREATE TABLE sem_citatel (
       id_citatela          NUMBER NOT NULL,
       meno                 VARCHAR2(20) NOT NULL,
       priezvisko           VARCHAR2(20) NOT NULL
);


ALTER TABLE sem_citatel
       ADD  ( PRIMARY KEY (id_citatela) ) ;


CREATE TABLE sem_pozicka (
       datum_pozicky        DATE NOT NULL,
       id_predmetu          NUMBER NOT NULL,
       id_citatela          NUMBER NOT NULL,
       datum_pred_vratenia  DATE NOT NULL,
       datum_vratenia       DATE NULL
);


ALTER TABLE sem_pozicka
       ADD  ( PRIMARY KEY (datum_pozicky, id_predmetu) ) ;


CREATE TABLE sem_kontakt (
       id_kontakt           NUMBER NOT NULL,
       id_citatela          NUMBER NOT NULL,
       typ_kontaktu         CHAR(18) NOT NULL
                                   CHECK (typ_kontaktu IN ('tel', 'mob',
'email', 'adr', 'fax')),
       kontakt              VARCHAR2(20) NOT NULL
);


ALTER TABLE sem_kontakt
       ADD  ( PRIMARY KEY (id_kontakt) ) ;


CREATE TABLE sem_rezervacia (
       datum_rezervacie     DATE NOT NULL,
       id_predmetu          NUMBER NOT NULL,
       id_citatela          NUMBER NOT NULL,
       datum_konca_rez      DATE NOT NULL
);


ALTER TABLE sem_rezervacia
       ADD  ( PRIMARY KEY (datum_rezervacie, id_predmetu) ) ;


CREATE TABLE sem_klucove_slova (
       klucove_slovo        VARCHAR2(20) NOT NULL,
       id_predmetu          NUMBER NOT NULL
);


ALTER TABLE sem_klucove_slova
       ADD  ( PRIMARY KEY (klucove_slovo, id_predmetu) ) ;


ALTER TABLE sem_predmet
       ADD  ( FOREIGN KEY (nadradeny)
                             REFERENCES sem_predmet ) ;


ALTER TABLE sem_predmet_autor
       ADD  ( FOREIGN KEY (id_autor)
                             REFERENCES sem_autor ) ;


ALTER TABLE sem_predmet_autor
       ADD  ( FOREIGN KEY (id_predmetu)
                             REFERENCES sem_predmet ) ;


ALTER TABLE sem_pozicka
       ADD  ( FOREIGN KEY (id_citatela)
                             REFERENCES sem_citatel ) ;


ALTER TABLE sem_pozicka
       ADD  ( FOREIGN KEY (id_predmetu)
                             REFERENCES sem_predmet ) ;


ALTER TABLE sem_kontakt
       ADD  ( FOREIGN KEY (id_citatela)
                             REFERENCES sem_citatel ) ;


ALTER TABLE sem_rezervacia
       ADD  ( FOREIGN KEY (id_citatela)
                             REFERENCES sem_citatel ) ;


ALTER TABLE sem_rezervacia
       ADD  ( FOREIGN KEY (id_predmetu)
                             REFERENCES sem_predmet ) ;


ALTER TABLE sem_klucove_slova
       ADD  ( FOREIGN KEY (id_predmetu)
                             REFERENCES sem_predmet ) ;



