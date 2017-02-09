/*
Created		5. 3. 2012
Modified		10. 4. 2012
Project		
Model		
Company		
Author		
Version		
Database		Oracle 10g 
*/


-- Create Types section


-- Create Tables section


Create table "Osoba" (
	"rod_cislo" Char (10) NOT NULL ,
	"meno" Varchar2 (30) NOT NULL ,
	"priezvisko" Varchar2 (30) NOT NULL ,
	"ulica" Varchar2 (30) NOT NULL ,
	"cislo_obcianskeho" Char (8) NOT NULL ,
	"narodnost" Varchar2 (30) NOT NULL ,
	"PSC" Char (5) NOT NULL ,
primary key ("rod_cislo") 
) 
/

Create table "Strana" (
	"volebne_cislo" Number NOT NULL ,
	"nazov" Varchar2 (30) NOT NULL ,
	"id_volby" Number,
primary key ("volebne_cislo") 
) 
/

Create table "Kandidat" (
	"id_kandidat" Number NOT NULL ,
	"volebne_cislo" Number NOT NULL ,
	"zamestnanie" Varchar2 (30) NOT NULL ,
	"rod_cislo" Char (10) NOT NULL ,
	"cislo_na_kandidatke" Number NOT NULL ,
primary key ("id_kandidat") 
) 
/

Create table "Sponzor" (
	"id_sponzor" Number NOT NULL ,
	"prispevok" Number,
	"volebne_cislo" Number NOT NULL ,
primary key ("id_sponzor") 
) 
/

Create table "Volic" (
	"rod_cislo" Char (10) NOT NULL ,
	"ucast" Char (1) Default 0 NOT NULL ,
	"narodnost" Varchar2 (30) NOT NULL ,
primary key ("rod_cislo") 
) 
/

Create table "Hlas" (
	"id_hlas" Number NOT NULL ,
	"platnost_hlasu" Char (1) Default 0 NOT NULL ,
	"volebne_cislo" Number NOT NULL ,
primary key ("id_hlas") 
) 
/

Create table "volby" (
	"id_volby" Number NOT NULL ,
	"platnost_volieb" Char (1) Default 0 NOT NULL ,
	"datum" Date,
primary key ("id_volby") 
) 
/

Create table "kampan" (
	"id_kampan" Number NOT NULL ,
	"datum" Date,
	"ulica" Varchar2 (30),
	"volebne_cislo" Number NOT NULL ,
	"PSC" Char (5) NOT NULL ,
primary key ("id_kampan") 
) 
/

Create table "Zakruzkovanie" (
	"id_kandidat" Number NOT NULL ,
	"id_hlas" Number NOT NULL ,
primary key ("id_kandidat","id_hlas") 
) 
/

Create table "Mesto" (
	"PSC" Char (5) NOT NULL ,
	"nazov" Varchar2 (30) NOT NULL ,
primary key ("PSC") 
) 
/


-- Create Indexes section


-- Create Foreign keys section

Alter table "Kandidat" add  foreign key ("rod_cislo") references "Osoba" ("rod_cislo") 
/

Alter table "Volic" add  foreign key ("rod_cislo") references "Osoba" ("rod_cislo") 
/

Alter table "Kandidat" add  foreign key ("volebne_cislo") references "Strana" ("volebne_cislo") 
/

Alter table "kampan" add  foreign key ("volebne_cislo") references "Strana" ("volebne_cislo") 
/

Alter table "Hlas" add  foreign key ("volebne_cislo") references "Strana" ("volebne_cislo") 
/

Alter table "Sponzor" add  foreign key ("volebne_cislo") references "Strana" ("volebne_cislo") 
/

Alter table "Zakruzkovanie" add  foreign key ("id_kandidat") references "Kandidat" ("id_kandidat") 
/

Alter table "Zakruzkovanie" add  foreign key ("id_hlas") references "Hlas" ("id_hlas") 
/

Alter table "Strana" add  foreign key ("id_volby") references "volby" ("id_volby") 
/

Alter table "Osoba" add  foreign key ("PSC") references "Mesto" ("PSC") 
/

Alter table "kampan" add  foreign key ("PSC") references "Mesto" ("PSC") 
/


-- Create Object Tables section


-- Create XMLType Tables section


-- Create Functions section


-- Create Sequences section


-- Create Packages section


-- Create Synonyms section


-- Create Table comments section

Comment on table "Volic" is 'Volic moze byt len clovek ktory ma aspon 18 rokov.'
/

-- Create Attribute comments section


