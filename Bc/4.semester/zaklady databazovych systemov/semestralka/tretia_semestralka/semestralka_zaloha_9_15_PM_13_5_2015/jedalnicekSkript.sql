/*
Created		13.3.2015
Modified		12.5.2015
Project		
Model		
Company		
Author		
Version		
Database		Oracle 10g 
*/


-- Create Types section


-- Create Tables section


Create table osoba (
	os_cislo Integer NOT NULL ,
	meno Varchar2 (30) NOT NULL ,
	priezvisko Varchar2 (30) NOT NULL ,
	vaha_zaciatocna Integer NOT NULL ,
	vaha_ciel Integer NOT NULL  Check (vaha_ciel > 0 ) ,
	datum_nastupu Date NOT NULL ,
	datum_narodenia Date,
	pohlavie Char (1) Check (pohlavie IN ('M', 'Z') ) ,
	tuky_ciel Integer NOT NULL  Check (tuky_ciel >= 0 ) ,
	sach_ciel Integer NOT NULL  Check (sach_ciel >= 0 ) ,
	bielk_ciel Integer NOT NULL  Check (bielk_ciel >= 0 ) ,
primary key (os_cislo) 
) 
/

Create table jedlo (
	id_jedla Integer NOT NULL ,
	nazov_jedla Varchar2 (60) NOT NULL ,
	kalorie_jedla Integer Check (kalorie_jedla > 0 ) ,
	kategoria Varchar2 (30) NOT NULL  Check (kategoria IN ('ranajky', 'desiata', 'obed', 'olovrant', 'vecera') ) ,
primary key (id_jedla) 
) 
/

Create table surovina (
	id_suroviny Integer NOT NULL ,
	nazov_suroviny Varchar2 (30) NOT NULL ,
	kcal Integer NOT NULL ,
	tuky Integer NOT NULL ,
	bielkoviny Integer NOT NULL ,
	sacharidy Integer NOT NULL ,
primary key (id_suroviny) 
) 
/

Create table sport (
	datum_cas Timestamp(6) NOT NULL ,
	os_cislo Integer NOT NULL ,
	id_druhSportu Integer NOT NULL ,
	trvanieVminutach Integer NOT NULL  Check (trvanieVminutach >= 0 ) ,
	spalene_kalorie Integer,
primary key (datum_cas,os_cislo,id_druhSportu) 
) 
/

Create table stravnik (
	datum_cas Timestamp(6) NOT NULL ,
	os_cislo Integer NOT NULL ,
	id_jedla Integer NOT NULL ,
	vahaPriebezna Integer NOT NULL  Check (vahaPriebezna > 0 ) ,
primary key (datum_cas,os_cislo,id_jedla) 
) 
/

Create table druhSportu (
	id_druhSportu Integer NOT NULL ,
	nazov_sportu Varchar2 (30) NOT NULL ,
	kalorieZaMinutu Integer NOT NULL ,
	intenzita Integer NOT NULL  Check (intenzita BETWEEN 1 AND 5 ) ,
primary key (id_druhSportu) 
) 
/

Create table zlozenie (
	id_jedla Integer NOT NULL ,
	id_suroviny Integer NOT NULL ,
	pocet_gramov Integer NOT NULL ,
primary key (id_jedla,id_suroviny) 
) 
/


-- Create Foreign keys section

Alter table sport add  foreign key (os_cislo) references osoba (os_cislo) 
/

Alter table stravnik add  foreign key (os_cislo) references osoba (os_cislo) 
/

Alter table stravnik add  foreign key (id_jedla) references jedlo (id_jedla) 
/

Alter table zlozenie add  foreign key (id_jedla) references jedlo (id_jedla) 
/

Alter table zlozenie add  foreign key (id_suroviny) references surovina (id_suroviny) 
/

Alter table sport add  foreign key (id_druhSportu) references druhSportu (id_druhSportu) 
/


-- Create Object Tables section


-- Create XMLType Tables section


-- Create Functions section


-- Create Sequences section


-- Create Packages section


-- Create Synonyms section


-- Create Table comments section


-- Create Attribute comments section


