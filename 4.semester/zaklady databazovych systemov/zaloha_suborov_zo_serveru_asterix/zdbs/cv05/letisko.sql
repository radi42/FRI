/*
Created		9. 2. 2015
Modified		10. 3. 2015
Project		
Model		
Company		
Author		
Version		
Database		Oracle 10g 
*/


-- Create Types section


-- Create Tables section


Create table L_osoba (
	cislo_dokladu Varchar2 (20) NOT NULL ,
	typ_dokladu Char (1) NOT NULL  Check (typ_dokladu IN ( 'P', 'O')  ) ,
	meno Varchar2 (30) NOT NULL ,
	priezvisko Varchar2 (30) NOT NULL ,
	id_krajiny Char (3) NOT NULL ,
primary key (cislo_dokladu,typ_dokladu) 
) 
/

Create table L_mesto (
	psc Char (5) NOT NULL ,
	id_krajiny Char (3) NOT NULL ,
	nazov Varchar2 (60) NOT NULL ,
primary key (psc,id_krajiny) 
) 
/

Create table L_krajina (
	id_krajiny Char (3) NOT NULL ,
	nazov_krajiny Varchar2 (30) NOT NULL ,
primary key (id_krajiny) 
) 
/

Create table L_zamestnanec (
	id_zamestnanca Integer NOT NULL ,
	id_spolocnosti Integer NOT NULL ,
	psc Char (5) NOT NULL ,
	cislo_dokladu Varchar2 (20) NOT NULL ,
	typ_dokladu Char (1) NOT NULL  Check (typ_dokladu IN ( 'P', 'O')  ) ,
	datum_prijatia Date NOT NULL ,
	datum_zrusenia Date,
	pozicia Varchar2 (30) NOT NULL ,
	rod_cislo Char (11),
	id_krajiny Char (3) NOT NULL ,
primary key (id_zamestnanca) 
) 
/

Create table L_let (
	id_letu Integer NOT NULL ,
	id_spolocnosti Integer NOT NULL ,
	letisko_z Char (3) NOT NULL ,
	letisko_do Char (3) NOT NULL ,
	datum_letu Date NOT NULL ,
	dlzka_letu Integer NOT NULL ,
	plan_cas_odletu Timestamp(6) with local time zone,
	plan_cas_priletu Timestamp(6) with local time zone,
	cena_letu Number(12,2) NOT NULL ,
	skut_cas_odletu Timestamp(6) with local time zone,
	skut_cas_priletu Timestamp(6) with local time zone,
	id_lietadla Integer,
primary key (id_letu) 
) 
/

Create table L_letisko (
	id_letiska Char (3) NOT NULL ,
	nazov_letiska Varchar2 (50) NOT NULL ,
	dlzka_drahy Number,
	ulica Varchar2 (60),
	psc Char (5) NOT NULL ,
	id_krajiny Char (3) NOT NULL ,
primary key (id_letiska) 
) 
/

Create table L_Lietadlo (
	id_lietadla Integer NOT NULL ,
	id_spolocnosti Integer NOT NULL ,
	id_typu Integer NOT NULL ,
	kapacita Integer,
primary key (id_lietadla) 
) 
/

Create table L_let_spolocnost (
	id_spolocnosti Integer NOT NULL ,
	nazov_spol Varchar2 (60) NOT NULL ,
	ulica Varchar2 (30),
	psc Char (5) NOT NULL ,
	id_krajiny Char (3) NOT NULL ,
primary key (id_spolocnosti) 
) 
/

Create table L_typ_lietadla (
	id_typu Integer NOT NULL ,
	nazov Varchar2 (30) NOT NULL ,
	kapacita Number NOT NULL ,
	min_prist_draha Number,
	min_odlet_draha Number,
primary key (id_typu) 
) 
/

Create table L_triedy (
	id_letu Integer NOT NULL ,
	id_triedy Integer NOT NULL ,
	kapacita Number NOT NULL ,
primary key (id_letu,id_triedy) 
) 
/

Create table L_letenka (
	id_letenky Integer NOT NULL ,
	id_letu Integer NOT NULL ,
	id_triedy Integer NOT NULL ,
	cislo_dokladu Varchar2 (20) NOT NULL ,
	typ_dokladu Char (1) NOT NULL  Check (typ_dokladu IN ( 'P', 'O')  ) ,
	id_zamestnanca Integer,
	datum_rezervacie Date NOT NULL ,
	datum_platby Date,
	datum_zrusenia Date,
	cena Number(12,2) NOT NULL ,
	miesto Char (3),
primary key (id_letenky,id_letu,id_triedy) 
) 
/


-- Create Indexes section


-- Create Foreign keys section

Alter table L_zamestnanec add  foreign key (cislo_dokladu,typ_dokladu) references L_osoba (cislo_dokladu,typ_dokladu) 
/

Alter table L_letenka add  foreign key (cislo_dokladu,typ_dokladu) references L_osoba (cislo_dokladu,typ_dokladu) 
/

Alter table L_zamestnanec add  foreign key (psc,id_krajiny) references L_mesto (psc,id_krajiny) 
/

Alter table L_letisko add  foreign key (psc,id_krajiny) references L_mesto (psc,id_krajiny) 
/

Alter table L_let_spolocnost add  foreign key (psc,id_krajiny) references L_mesto (psc,id_krajiny) 
/

Alter table L_mesto add  foreign key (id_krajiny) references L_krajina (id_krajiny) 
/

Alter table L_osoba add  foreign key (id_krajiny) references L_krajina (id_krajiny) 
/

Alter table L_letenka add  foreign key (id_zamestnanca) references L_zamestnanec (id_zamestnanca) 
/

Alter table L_triedy add  foreign key (id_letu) references L_let (id_letu) 
/

Alter table L_let add  foreign key (letisko_z) references L_letisko (id_letiska) 
/

Alter table L_let add  foreign key (letisko_do) references L_letisko (id_letiska) 
/

Alter table L_let add  foreign key (id_lietadla) references L_Lietadlo (id_lietadla) 
/

Alter table L_let add  foreign key (id_spolocnosti) references L_let_spolocnost (id_spolocnosti) 
/

Alter table L_Lietadlo add  foreign key (id_spolocnosti) references L_let_spolocnost (id_spolocnosti) 
/

Alter table L_zamestnanec add  foreign key (id_spolocnosti) references L_let_spolocnost (id_spolocnosti) 
/

Alter table L_Lietadlo add  foreign key (id_typu) references L_typ_lietadla (id_typu) 
/

Alter table L_letenka add  foreign key (id_letu,id_triedy) references L_triedy (id_letu,id_triedy) 
/


-- Create Object Tables section


-- Create XMLType Tables section


-- Create Functions section


-- Create Sequences section


-- Create Packages section


-- Create Synonyms section


-- Create Table comments section


-- Create Attribute comments section


