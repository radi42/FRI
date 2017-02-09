/*
Created		3. 3. 2014
Modified		13. 5. 2014
Project		
Model		
Company		
Author		
Version		
Database		Oracle 10g 
*/


-- Create Types section


-- Create Tables section


Create table BANKOMAT (
	id_bankomatu Integer NOT NULL ,
	typ_bankomatu Varchar2 (30) NOT NULL ,
	id_adresa Integer NOT NULL ,
	rok_vyroby Integer,
	datum_uvedenia Date,
	datum_vyradenia Date,
	gps_sirka Decimal(7,4) NOT NULL  Check (gps_sirka between -90 and 90  ) ,
	gps_dlzka Decimal(7,4) NOT NULL  Check (gps_dlzka between -180 and 180 ) ,
primary key (id_bankomatu) 
) 
/

Create table TYP_BANKOMATU (
	typ_bankomatu Varchar2 (30) NOT NULL ,
	vyrobca Varchar2 (30) NOT NULL ,
	model Varchar2 (30) NOT NULL ,
	popis Varchar2 (50),
primary key (typ_bankomatu) 
) 
/

Create table STAT (
	kod_stat Integer NOT NULL ,
	nazov_stat Varchar2 (30) NOT NULL ,
primary key (kod_stat) 
) 
/

Create table KRAJ (
	kod_kraj Integer NOT NULL ,
	kod_stat Integer NOT NULL ,
	nazov_kraj Varchar2 (30) NOT NULL ,
primary key (kod_kraj) 
) 
/

Create table OKRES (
	kod_okres Integer NOT NULL ,
	kod_kraj Integer NOT NULL ,
	nazov_okres Varchar2 (30) NOT NULL ,
primary key (kod_okres) 
) 
/

Create table MESTO (
	kod_mesto Integer NOT NULL ,
	kod_okres Integer NOT NULL ,
	nazov_mesto Varchar2 (30) NOT NULL ,
primary key (kod_mesto) 
) 
/

Create table OSOBA (
	rod_cislo Char (11) NOT NULL ,
	id_adresa Integer NOT NULL ,
	meno Varchar2 (30) NOT NULL ,
	priezvisko Varchar2 (30) NOT NULL ,
	vek Integer,
primary key (rod_cislo) 
) 
/

Create table ZAMESTNANEC (
	os_cislo_zam Integer NOT NULL ,
	rod_cislo Char (11) NOT NULL ,
primary key (os_cislo_zam) 
) 
/

Create table ZAKAZNIK (
	os_cislo_zak Integer NOT NULL ,
	rod_cislo Char (11) NOT NULL ,
primary key (os_cislo_zak) 
) 
/

Create table KONTAKTNE_UDAJE (
	rod_cislo Char (11) NOT NULL ,
	tel_c Varchar2 (15) NOT NULL ,
	email Varchar2 (30)
) 
/

Create table BANKOVKY_V_BANKOMATE (
	id_bankomatu Integer NOT NULL ,
	hodnota Integer NOT NULL ,
	mena Varchar2 (30) NOT NULL ,
	pocet_bank Integer NOT NULL ,
primary key (id_bankomatu,hodnota,mena) 
) 
/

Create table ADRESA (
	id_adresa Integer NOT NULL ,
	kod_mesto Integer NOT NULL ,
	ulica Varchar2 (30) NOT NULL ,
	cislo_domu Integer NOT NULL ,
	psc Integer NOT NULL ,
primary key (id_adresa) 
) 
/

Create table TRANSAKCIE (
	id_transakcie Integer NOT NULL ,
	rod_cislo Char (11) NOT NULL ,
	id_bankomatu Integer NOT NULL ,
	datum_a_cas Date NOT NULL ,
	suma_vyber Integer,
primary key (id_transakcie) 
) 
/

Create table TYP_BANKOVKY (
	hodnota Integer NOT NULL ,
	mena Varchar2 (30) NOT NULL ,
primary key (hodnota,mena) 
) 
/

Create table SERVIS (
	datum_a_cas Date NOT NULL ,
	os_cislo_zam Integer NOT NULL ,
	id_bankomatu Integer NOT NULL ,
	popis Varchar2 (50),
	vklad Integer,
primary key (datum_a_cas,os_cislo_zam,id_bankomatu) 
) 
/

Create table BANKOVKA (
	id_transakcie Integer NOT NULL ,
	hodnota Integer NOT NULL ,
	mena Varchar2 (30) NOT NULL ,
	pocet Integer NOT NULL ,
primary key (id_transakcie,hodnota,mena) 
) 
/


-- Create Indexes section


-- Create Foreign keys section

Alter table BANKOVKY_V_BANKOMATE add  foreign key (id_bankomatu) references BANKOMAT (id_bankomatu) 
/

Alter table TRANSAKCIE add  foreign key (id_bankomatu) references BANKOMAT (id_bankomatu) 
/

Alter table SERVIS add  foreign key (id_bankomatu) references BANKOMAT (id_bankomatu) 
/

Alter table BANKOMAT add  foreign key (typ_bankomatu) references TYP_BANKOMATU (typ_bankomatu) 
/

Alter table KRAJ add  foreign key (kod_stat) references STAT (kod_stat) 
/

Alter table OKRES add  foreign key (kod_kraj) references KRAJ (kod_kraj) 
/

Alter table MESTO add  foreign key (kod_okres) references OKRES (kod_okres) 
/

Alter table ADRESA add  foreign key (kod_mesto) references MESTO (kod_mesto) 
/

Alter table ZAKAZNIK add  foreign key (rod_cislo) references OSOBA (rod_cislo) 
/

Alter table ZAMESTNANEC add  foreign key (rod_cislo) references OSOBA (rod_cislo) 
/

Alter table TRANSAKCIE add  foreign key (rod_cislo) references OSOBA (rod_cislo) 
/

Alter table KONTAKTNE_UDAJE add  foreign key (rod_cislo) references OSOBA (rod_cislo) 
/

Alter table SERVIS add  foreign key (os_cislo_zam) references ZAMESTNANEC (os_cislo_zam) 
/

Alter table OSOBA add  foreign key (id_adresa) references ADRESA (id_adresa) 
/

Alter table BANKOMAT add  foreign key (id_adresa) references ADRESA (id_adresa) 
/

Alter table BANKOVKA add  foreign key (id_transakcie) references TRANSAKCIE (id_transakcie) 
/

Alter table BANKOVKY_V_BANKOMATE add  foreign key (hodnota,mena) references TYP_BANKOVKY (hodnota,mena) 
/

Alter table BANKOVKA add  foreign key (hodnota,mena) references TYP_BANKOVKY (hodnota,mena) 
/


-- Create Object Tables section


-- Create XMLType Tables section


-- Create Functions section


-- Create Views section


-- Create Sequences section


-- Create Packages section


-- Create Synonyms section


-- Create Table comments section


-- Create Attribute comments section


