create table sklad
(id number not null,
 nazov varchar2(15) not null unique,
 ulica varchar2(20) not null,
 obec varchar2(15) not null,
 psc char(5) not null,
 primary key(id)
)
/
          
create table zamestnanec
(id number not null,
 rodne_cislo char(11) not null unique,
 meno varchar2(15) not null,
 priezvisko varchar2(20) not null,
 ulica varchar2(20) not null,
 obec varchar2(15) not null,
 psc char(5) not null,
 dat_nastupu date not null,
 dat_vystupu date null,
 heslo varchar2(32) not null,
 skl_id number not null,
 login varchar2(32) not null unique,
 primary key(id),
 foreign key(skl_id) references sklad(id)
)
/
		 
create table skupina
(id number not null,
 nazov varchar2(15) not null unique,
 skl_id number not null,
 sku_id number null,
 primary key(id),
 foreign key(skl_id) references sklad(id),
 foreign key(sku_id) references skupina(id)
)
/
		       
create table material
(cislo varchar2(8) not null,
 merna_jednotka varchar2(5) not null,
 rozmer varchar2(16) null,
 nazov varchar2(15) not null,
 primary key(cislo)
)
/

create table rola
(zam_id number not null,
 skl_id number not null,
 mat_cislo varchar2(8) not null,
 vyber char(1) not null,
 vklad char(1) not null,
 primary key(zam_id,skl_id,mat_cislo),
 foreign key(zam_id) references zamestnanec(id),
 foreign key(skl_id) references sklad(id),
 foreign key(mat_cislo) references material(cislo)
)
/

create table karta
(cislo number not null,
 zasoba number not null,
 cena_jednotky number not null,
 ocenenie char(3) not null,
 mat_cislo varchar2(8) not null,
 sku_id number not null,
 skl_id number not null,
 primary key(cislo),
 foreign key(mat_cislo) references material(cislo),
 foreign key(sku_id) references skupina(id),
 foreign key(skl_id) references sklad(id)
)
/

create table pohyb
(cislo number not null,
 ucel varchar2(6) not null,
 datum date not null,
 mnozstvo number not null,
 cena_jednotky number not null,
 vysl_mnozstvo number not null,
 vysl_cena_jednotky number not null,
 zam_id number not null,
 kar_cislo number not null,
 primary key(cislo),
 foreign key(zam_id) references zamestnanec(id),
 foreign key(kar_cislo) references karta(cislo)
)
/

create table presun
(cislo number not null,
 datum date not null,
 kar_cislo number not null,
 skl_id_zdroj number not null,
 skl_id_ciel number not null,
 primary key(cislo),
 foreign key(kar_cislo) references karta(cislo),
 foreign key(skl_id_zdroj) references sklad(id),
 foreign key(skl_id_ciel) references sklad(id)
)
/

create table prevod
(cislo number not null,
 poh_cislo_zdroj number not null,
 poh_cislo_ciel number not null,
 primary key(cislo),
 foreign key(poh_cislo_zdroj) references pohyb(cislo),
 foreign key(poh_cislo_ciel) references pohyb(cislo)
)
/
