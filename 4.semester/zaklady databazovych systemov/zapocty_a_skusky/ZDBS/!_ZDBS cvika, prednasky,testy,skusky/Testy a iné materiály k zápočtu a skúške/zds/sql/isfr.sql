{ DATABASE isfr  delimiter | }

grant dba to "isfr";
grant dba to "informix";
grant dba to "kmat";
grant dba to "novakova";
grant dba to "sicova";
grant dba to "grondzak";
grant dba to "jamrich";
grant dba to "vajsova";
grant dba to "sleziak";
grant connect to "mano";
grant connect to "oweis";



{ TABLE "isfr".zamestnavatel row size = 153 number of columns = 8 index size = 18 
              }
{ unload file name = zames00100.unl number of rows = 0 }

create table "isfr".zamestnavatel 
  (
    ico char(8) not null ,
    nazov char(40) not null ,
    ulica char(20),
    obec char(20),
    psc char(5),
    telefon char(20),
    fax char(20),
    telex char(20)
  );
revoke all on "isfr".zamestnavatel from "public";

create unique index "isfr".ix112_1 on "isfr".zamestnavatel (ico);
    
{ TABLE "isfr".cis_asist row size = 12 number of columns = 2 index size = 9 }
{ unload file name = cis_a00101.unl number of rows = 3 }

create table "isfr".cis_asist 
  (
    druh smallint not null ,
    nazov char(10) not null 
  );
revoke all on "isfr".cis_asist from "public";

create unique index "isfr".ix237_1 on "isfr".cis_asist (druh);
    
{ TABLE "isfr".kalendar row size = 228 number of columns = 6 index size = 12 }
{ unload file name = kalen00102.unl number of rows = 187 }

create table "isfr".kalendar 
  (
    id serial not null ,
    datum date not null ,
    udalost1 char(70) not null ,
    udalost2 char(70),
    udalost3 char(70),
    zodpovednost char(10)
  );
revoke all on "isfr".kalendar from "public";

create unique index "isfr".ix2186_1 on "isfr".kalendar (id);
{ TABLE "isfr".statut row size = 130 number of columns = 3 index size = 12 }
{ unload file name = statu00103.unl number of rows = 7 }

create table "isfr".statut 
  (
    id serial not null ,
    popis char(70) not null ,
    subor text not null 
  );
revoke all on "isfr".statut from "public";

create unique index "isfr".ix2333_1 on "isfr".statut (id);
{ TABLE "isfr".prav row size = 44 number of columns = 3 index size = 0 }
{ unload file name = prav_00104.unl number of rows = 0 }

create table "isfr".prav 
  (
    uzivatel char(20),
    uzivatel_1 char(20),
    datum date not null 
  );
revoke all on "isfr".prav from "public";

{ TABLE "isfr".ucitel_pr row size = 12 number of columns = 4 index size = 72 }
{ unload file name = ucite00105.unl number of rows = 679 }

create table "isfr".ucitel_pr 
  (
    cis_predm char(4) not null ,
    skrok smallint not null ,
    os_cis char(5) not null ,
    priznak char(1) not null 
  );
revoke all on "isfr".ucitel_pr from "public";

create index "isfr".ix241_2 on "isfr".ucitel_pr (skrok);
create index "isfr".ix240_1 on "isfr".ucitel_pr (cis_predm);
create index "isfr".ix240_6 on "isfr".ucitel_pr (os_cis);
create unique index "isfr".up_spo on "isfr".ucitel_pr (skrok,cis_predm,
    os_cis);
create index "isfr".up_sp on "isfr".ucitel_pr (skrok,cis_predm);
    
{ TABLE "isfr".ucitel_cin row size = 261 number of columns = 2 index size = 13 }
{ unload file name = ucite00106.unl number of rows = 3 }

create table "isfr".ucitel_cin 
  (
    os_cis char(5) not null ,
    cinnost varchar(255)
  );
revoke all on "isfr".ucitel_cin from "public";

create unique index "isfr".ix224_1 on "isfr".ucitel_cin (os_cis);
    
{ TABLE "isfr".druh_asist row size = 11 number of columns = 3 index size = 82 }
{ unload file name = druh_00107.unl number of rows = 14 }

create table "isfr".druh_asist 
  (
    iddp char(4) not null ,
    id_asistent char(5) not null ,
    druh smallint not null 
  );
revoke all on "isfr".druh_asist from "public";

create unique index "isfr".da_ia on "isfr".druh_asist (iddp,id_asistent);
    
create unique index "isfr".da_id on "isfr".druh_asist (iddp,druh);
    
create index "isfr".ix208_1 on "isfr".druh_asist (iddp);
create unique index "isfr".da_dad on "isfr".druh_asist (iddp,druh,
    id_asistent);
create index "isfr".ix120_2 on "isfr".druh_asist (id_asistent);
    
{ TABLE "isfr".tel_zoz row size = 75 number of columns = 4 index size = 49 }
{ unload file name = tel_z00108.unl number of rows = 3 }

create table "isfr".tel_zoz 
  (
    os_cis char(5) not null ,
    c_tel char(20) not null ,
    druh char(20),
    poznamka char(30)
  );
revoke all on "isfr".tel_zoz from "public";

create index "isfr".ix293_1 on "isfr".tel_zoz (os_cis);
create index "isfr".ix293_2 on "isfr".tel_zoz (c_tel);
{ TABLE "isfr".zostavy row size = 1933 number of columns = 5 index size = 0 }
{ unload file name = zosta00109.unl number of rows = 51 }

create table "isfr".zostavy 
  (
    idz smallint,
    fcia char(15),
    meno char(60),
    help1 char(928),
    help2 char(928)
  );
revoke all on "isfr".zostavy from "public";

{ TABLE "isfr".asistent_dp row size = 62 number of columns = 5 index size = 31 }
{ unload file name = asist00110.unl number of rows = 0 }

create table "isfr".asistent_dp 
  (
    id_asistent char(5) not null ,
    meno char(25) not null ,
    ico char(8),
    uziv char(20),
    dat_zmen date
  );
revoke all on "isfr".asistent_dp from "public";

create unique index "isfr".ix127_1 on "isfr".asistent_dp (id_asistent);
    
create index "isfr".ix127_4 on "isfr".asistent_dp (ico);
{ TABLE "isfr".ucitel row size = 268 number of columns = 28 index size = 106 }
{ unload file name = ucite00111.unl number of rows = 396 }

create table "isfr".ucitel 
  (
    os_cis char(5) not null ,
    rod_cis char(10) not null ,
    meno char(25) not null ,
    rod_meno char(15),
    titul char(15),
    ped_hod char(8),
    ped_ovz smallint,
    ped_dat date,
    ved_hod char(5),
    ved_ovz smallint,
    ved_dat date,
    narod smallint,
    rod_stav smallint,
    dat_zrs date,
    poc_deti smallint,
    obec_s char(25),
    ulica_s char(25),
    psc_s char(5),
    tel_s char(11),
    obec_p char(25),
    ulica_p char(25),
    psc_p char(5),
    tel_p char(11),
    pr_kat smallint,
    cis_kat char(4) not null ,
    stav char(1),
    uziv char(20),
    dat_zmen date
  );
revoke all on "isfr".ucitel from "public";

create index "isfr".ix213_25 on "isfr".ucitel (cis_kat);
create unique index "isfr".ix183_1 on "isfr".ucitel (os_cis);
create index "isfr".ix203_24 on "isfr".ucitel (pr_kat);
create index "isfr".ix183_2 on "isfr".ucitel (rod_cis);
create index "isfr".ix183_3 on "isfr".ucitel (meno);
create index "vajsova".ix117_26 on "isfr".ucitel (stav);
alter table "isfr".ucitel add constraint primary key (os_cis) 
    constraint "isfr".u117_223  ;
{ TABLE "isfr".bod_limit row size = 26 number of columns = 8 index size = 39 }
{ unload file name = bod_l00112.unl number of rows = 222 }

create table "isfr".bod_limit 
  (
    rocnik smallint not null ,
    bod_postup smallint not null ,
    bod_opak smallint not null ,
    skrok smallint not null ,
    c_st_odboru smallint not null ,
    c_specializacie smallint not null ,
    uziv char(10),
    dat_zmen date
  );
revoke all on "isfr".bod_limit from "public";

create unique index "isfr".bl_sos on "isfr".bod_limit (skrok,rocnik,
    c_st_odboru,c_specializacie);
create index "isfr".bl_os on "isfr".bod_limit (c_st_odboru,c_specializacie);
    
create index "isfr".ix129_1 on "isfr".bod_limit (rocnik);
alter table "isfr".bod_limit add constraint primary key (skrok,
    rocnik,c_st_odboru,c_specializacie) constraint "isfr".u127_227 
     ;
{ TABLE "isfr".katedra row size = 700 number of columns = 18 index size = 12 }
{ unload file name = kated00113.unl number of rows = 16 }

create table "isfr".katedra 
  (
    cis_kat char(4) not null ,
    nazov char(40) not null ,
    skratka char(6) not null ,
    cinnost varchar(255),
    cinnost2 varchar(255),
    adr_psc char(5),
    adr_ulica char(20),
    adr_mesto char(20),
    adr_telefon1 char(11),
    adr_telefon2 char(11),
    adr_telefon3 char(11),
    adr_fax char(11),
    adr_email char(20),
    ved_kat char(5),
    z_ved_kat char(5),
    sekrt_kat char(5),
    uziv char(10),
    dat_zmen date
  );
revoke all on "isfr".katedra from "public";

create unique index "isfr".ix214_1 on "isfr".katedra (cis_kat);
    
alter table "isfr".katedra add constraint primary key (cis_kat) 
    constraint "isfr".u129_225  ;
{ TABLE "isfr".obec row size = 142 number of columns = 10 index size = 0 }
{ unload file name = obec_00114.unl number of rows = 2910 }

create table "isfr".obec 
  (
    krj char(1),
    oks char(3),
    okres char(4),
    iczuj char(6),
    psc char(5),
    nazzuj char(55),
    nazkrj char(16),
    nazoks char(25),
    nazokres char(25),
    skr char(2)
  );
revoke all on "isfr".obec from "public";

{ TABLE "isfr".test row size = 121 number of columns = 6 index size = 0 }
{ unload file name = test_00115.unl number of rows = 741 }

create table "isfr".test 
  (
    rok smallint,
    meno char(50),
    priezvisko char(50),
    dnar date,
    rc char(11),
    oc integer
  );
revoke all on "isfr".test from "public";

{ TABLE "isfr".predmet_eng row size = 219 number of columns = 8 index size = 25 }
{ unload file name = predm00116.unl number of rows = 888 }

create table "isfr".predmet_eng 
  (
    cis_predm char(4) not null ,
    nazov char(180) not null ,
    gestor char(5),
    zrok smallint,
    prok smallint,
    rrok smallint,
    uziv char(20),
    dat_zmen date
  );
revoke all on "isfr".predmet_eng from "public";

create unique index "isfr".p_eng_cp on "isfr".predmet_eng (cis_predm);
    
create index "isfr".p_eng_gestor on "isfr".predmet_eng (gestor);
    
alter table "isfr".predmet_eng add constraint primary key (cis_predm) 
    constraint "isfr".u135_191  ;
{ TABLE "isfr".sk_spravy row size = 34 number of columns = 10 index size = 21 }
{ unload file name = sk_sp00117.unl number of rows = 4963 }

create table "isfr".sk_spravy 
  (
    id integer not null ,
    os_cislo smallint not null ,
    st_skupina char(5) not null ,
    cis_predm char(4) not null ,
    dat_zap date,
    dat_prv date,
    dat_drh date,
    dat_dek date,
    znamka char(1),
    skrok smallint
  );
revoke all on "isfr".sk_spravy from "public";

create unique index "isfr".ix167_1 on "isfr".sk_spravy (id);
create index "isfr".ix167_2 on "isfr".sk_spravy (os_cislo);
{ TABLE "isfr".predmet_stsk row size = 33 number of columns = 6 index size = 37 }
{ unload file name = predm00118.unl number of rows = 324 }

create table "isfr".predmet_stsk 
  (
    skrok smallint not null ,
    cis_predm char(4) not null ,
    miesto char(1) not null ,
    poc_stsk smallint,
    uziv char(20),
    dat_zmen date
  );
revoke all on "isfr".predmet_stsk from "public";

create index "isfr".ixx267_1 on "isfr".predmet_stsk (skrok);
create index "isfr".ixx267_2 on "isfr".predmet_stsk (cis_predm);
    
create unique index "isfr".xpb_sk on "isfr".predmet_stsk (skrok,
    cis_predm,miesto);
{ TABLE "isfr".sysmenus row size = 78 number of columns = 2 index size = 33 }
{ unload file name = sysme00119.unl number of rows = 63 }

create table "isfr".sysmenus 
  (
    menuname char(18),
    title char(60)
  );
revoke all on "isfr".sysmenus from "public";

create unique index "isfr".sysmenidx on "isfr".sysmenus (menuname);
    
{ TABLE "isfr".sysmenuitems row size = 143 number of columns = 5 index size = 39 
              }
{ unload file name = sysme00120.unl number of rows = 214 }

create table "isfr".sysmenuitems 
  (
    imenuname char(18),
    itemnum integer,
    mtext char(60),
    mtype char(1),
    progname char(60)
  );
revoke all on "isfr".sysmenuitems from "public";

create unique index "isfr".meniidx on "isfr".sysmenuitems (imenuname,
    itemnum);
{ TABLE "isfr".neuspesne_2 row size = 6 number of columns = 2 index size = 0 }
{ unload file name = neusp00121.unl number of rows = 0 }

create table "isfr".neuspesne_2 
  (
    os_cislo smallint,
    cis_predm char(4)
  );
revoke all on "isfr".neuspesne_2 from "public";

{ TABLE "isfr".neuspesne_3 row size = 6 number of columns = 2 index size = 0 }
{ unload file name = neusp00122.unl number of rows = 0 }

create table "isfr".neuspesne_3 
  (
    os_cislo smallint,
    cis_predm char(4)
  );
revoke all on "isfr".neuspesne_3 from "public";

{ TABLE "isfr".profesia row size = 32 number of columns = 2 index size = 9 }
{ unload file name = profe00123.unl number of rows = 81 }

create table "isfr".profesia 
  (
    id_profes smallint not null ,
    popis char(30) not null 
  );
revoke all on "isfr".profesia from "public";

create unique index "isfr".ix163_1 on "isfr".profesia (id_profes);
    
alter table "isfr".profesia add constraint primary key (id_profes) 
    constraint "isfr".u163_202  ;
{ TABLE "isfr".os_udaje row size = 198 number of columns = 18 index size = 111 }
{ unload file name = os_ud00124.unl number of rows = 4974 }

create table "isfr".os_udaje 
  (
    rod_cislo char(11) not null ,
    meno char(15) not null ,
    priezvisko char(15) not null ,
    ulica char(20),
    obec char(20),
    psc char(5),
    narodnost smallint,
    st_prisl char(2),
    telefon char(20),
    mobil char(13),
    email char(40),
    okres char(4),
    drstsk char(1),
    vp char(2),
    body smallint,
    celkom smallint,
    uziv char(20),
    dat_zmen date,
    primary key (rod_cislo)  constraint "isfr".ou_pk
  );
revoke all on "isfr".os_udaje from "public";

create index "isfr".os_mp on "isfr".os_udaje (priezvisko,meno);
    
create index "isfr".ix134_3 on "isfr".os_udaje (priezvisko);
{ TABLE "isfr".zap_predmety row size = 66 number of columns = 16 index size = 88 
              }
{ unload file name = zap_p00125.unl number of rows = 100089 }

create table "isfr".zap_predmety 
  (
    os_cislo smallint not null ,
    cis_predm char(4) not null ,
    vysledok smallint,
    datum_sk date,
    termin smallint,
    zapocet date,
    skrok smallint not null ,
    body smallint,
    ects smallint,
    prednasajuci char(5),
    skusajuci char(5),
    cviciaci char(5),
    miesto char(1),
    c_st_odboru smallint,
    uziv char(20),
    dat_zmen date,
    primary key (os_cislo,cis_predm,skrok) 
  );
revoke all on "isfr".zap_predmety from "public";

create index "isfr".jx118_2 on "isfr".zap_predmety (cis_predm);
    
create index "isfr".jx195_9 on "isfr".zap_predmety (prednasajuci);
    
create index "isfr".jx124_7 on "isfr".zap_predmety (skrok);
create index "vajsova".ix168_14 on "isfr".zap_predmety (c_st_odboru);
    
{ TABLE "isfr".st_odbory row size = 185 number of columns = 9 index size = 30 }
{ unload file name = st_od00126.unl number of rows = 23 }

create table "isfr".st_odbory 
  (
    c_st_odboru smallint not null ,
    c_specializacie smallint not null ,
    popis_odboru char(40) not null ,
    popis_special char(40),
    odbor_eng char(40),
    special_eng char(40),
    cis_odb char(7),
    uziv char(10),
    dat_zmen date,
    primary key (c_st_odboru,c_specializacie) 
  );
revoke all on "isfr".st_odbory from "public";

create index "isfr".ix139_1 on "isfr".st_odbory (c_st_odboru);
    
create index "vajsova".ix169_2 on "isfr".st_odbory (c_specializacie);
    
{ TABLE "isfr".okres row size = 24 number of columns = 2 index size = 12 }
{ unload file name = okres00128.unl number of rows = 207 }

create table "isfr".okres 
  (
    cisokr char(4) not null ,
    nazov char(20) not null ,
    primary key (cisokr) 
  );
revoke all on "isfr".okres from "public";

{ TABLE "isfr".narodnost row size = 22 number of columns = 2 index size = 9 }
{ unload file name = narod00129.unl number of rows = 12 }

create table "isfr".narodnost 
  (
    id smallint,
    popis char(20) not null ,
    primary key (id) 
  );
revoke all on "isfr".narodnost from "public";

{ TABLE "isfr".predmet row size = 219 number of columns = 8 index size = 25 }
{ unload file name = predm00130.unl number of rows = 936 }

create table "isfr".predmet 
  (
    cis_predm char(4) not null ,
    nazov char(180) not null ,
    gestor char(5) not null ,
    zrok smallint,
    prok smallint,
    rrok smallint,
    uziv char(20),
    dat_zmen date,
    primary key (cis_predm) 
  );
revoke all on "isfr".predmet from "public";

create index "isfr".ix181_4 on "isfr".predmet (gestor);
{ TABLE "isfr".predmet_bod row size = 41 number of columns = 10 index size = 36 }
{ unload file name = predm00131.unl number of rows = 4925 }

create table "isfr".predmet_bod 
  (
    skrok smallint not null ,
    cis_predm char(4) not null ,
    body smallint not null ,
    ects smallint,
    forma_kont char(1) not null ,
    poc_predn smallint not null ,
    poc_cvic smallint not null ,
    poc_lab smallint not null ,
    uziv char(20),
    dat_zmen date,
    primary key (cis_predm,skrok) 
  );
revoke all on "isfr".predmet_bod from "public";

create index "isfr".ix267_1 on "isfr".predmet_bod (skrok);
{ TABLE "isfr".otvorenie row size = 9 number of columns = 4 index size = 31 }
{ unload file name = otvor00132.unl number of rows = 0 }

create table "isfr".otvorenie 
  (
    cis_predm char(4) not null ,
    skrok smallint not null ,
    pracovisko char(1) not null ,
    kapacita smallint,
    primary key (cis_predm,skrok,pracovisko) 
  );
revoke all on "isfr".otvorenie from "public";

{ TABLE "isfr".ucitel_novy row size = 63 number of columns = 8 index size = 25 }
{ unload file name = ucite00133.unl number of rows = 0 }

create table "isfr".ucitel_novy 
  (
    cis_kat char(4) not null ,
    os_cis char(5) not null ,
    meno char(20) not null ,
    priezvisko char(15) not null ,
    stav char(1) not null ,
    dat_vst date not null ,
    dat_zmen date,
    uziv char(10),
    primary key (os_cis) 
  );
revoke all on "isfr".ucitel_novy from "public";

{ TABLE "isfr".cis_stp row size = 36 number of columns = 4 index size = 9 }
{ unload file name = cis_s00134.unl number of rows = 6 }

create table "isfr".cis_stp 
  (
    cis_stp smallint not null ,
    popis char(30) not null ,
    skratka char(2) not null ,
    suma smallint,
    primary key (cis_stp) 
  );
revoke all on "isfr".cis_stp from "public";

{ TABLE "isfr".stip row size = 10 number of columns = 4 index size = 36 }
{ unload file name = stip_00135.unl number of rows = 14 }

create table "isfr".stip 
  (
    cis_stp smallint not null ,
    os_cislo smallint not null ,
    datum date not null ,
    suma smallint not null ,
    primary key (cis_stp,os_cislo,datum) 
  );
revoke all on "isfr".stip from "public";

{ TABLE "isfr".param row size = 532 number of columns = 26 index size = 0 }
{ unload file name = param00136.unl number of rows = 2 }

create table "isfr".param 
  (
    skola char(30) not null ,
    fakulta char(30) not null ,
    skola_eng char(50) not null ,
    fakulta_eng char(50) not null ,
    miesto char(20),
    ulica char(20),
    psc char(5),
    cisokr char(4),
    ciskoly char(4),
    ico char(9) not null ,
    titul_rp char(15),
    rektorm char(20),
    rektorp char(20),
    titul_rz char(15),
    titul_dp char(15),
    dekanm char(20),
    dekanp char(20),
    titul_dz char(15),
    telefon char(20),
    fax char(20),
    email char(50),
    www char(50),
    skrok smallint not null ,
    cis_faklt_ek char(4),
    uziv char(20),
    dat_zmen date
  );
revoke all on "isfr".param from "public";

{ TABLE "isfr".st_program row size = 72 number of columns = 10 index size = 111 }
{ unload file name = st_pr00137.unl number of rows = 2770 }

create table "isfr".st_program 
  (
    skrok smallint not null ,
    cis_predm char(4) not null ,
    rocnik smallint not null ,
    zabezpecuje char(5),
    poznamka char(40),
    c_st_odboru smallint not null ,
    c_specializacie smallint not null ,
    semester char(1) not null ,
    uziv char(10),
    dat_zmen date,
    primary key (skrok,rocnik,cis_predm,c_st_odboru,c_specializacie) 
  );
revoke all on "isfr".st_program from "public";

create index "isfr".sp_sp on "isfr".st_program (skrok,cis_predm);
    
create index "isfr".sp_sps on "isfr".st_program (skrok,cis_predm,
    semester);
create index "isfr".ix198_2 on "isfr".st_program (cis_predm);
create index "isfr".ix198_1 on "isfr".st_program (skrok);
create index "isfr".ix132_6 on "isfr".st_program (c_st_odboru);
    
create index "isfr".ix184_4 on "isfr".st_program (zabezpecuje);
    
{ TABLE "isfr".prerusenia row size = 14 number of columns = 5 index size = 27 }
{ unload file name = preru00138.unl number of rows = 52 }

create table "isfr".prerusenia 
  (
    os_cislo smallint not null ,
    od date not null ,
    do date,
    sk_rok smallint not null ,
    rocnik smallint,
    primary key (os_cislo,od,sk_rok) 
  );
revoke all on "isfr".prerusenia from "public";

{ TABLE "isfr".pozicky row size = 7 number of columns = 4 index size = 31 }
{ unload file name = pozic00139.unl number of rows = 57 }

create table "isfr".pozicky 
  (
    os_cislo smallint not null ,
    sk_rok smallint not null ,
    suma smallint not null ,
    typ char(1) not null ,
    primary key (os_cislo,sk_rok,typ) 
  );
revoke all on "isfr".pozicky from "public";

create index "isfr".poz_rok on "isfr".pozicky (sk_rok);
{ TABLE "isfr".druh_uvazku row size = 21 number of columns = 3 index size = 9 }
{ unload file name = druh_00140.unl number of rows = 14 }

create table "isfr".druh_uvazku 
  (
    druh smallint not null ,
    popis char(15) not null ,
    norma smallfloat,
    primary key (druh) 
  );
revoke all on "isfr".druh_uvazku from "public";

{ TABLE "isfr".uvazok row size = 74 number of columns = 13 index size = 150 }
{ unload file name = uvazo00141.unl number of rows = 0 }

create table "isfr".uvazok 
  (
    id serial not null ,
    os_cis char(5) not null ,
    cis_predm char(4) not null ,
    druh smallint not null ,
    semester char(1) not null ,
    poc_hod smallint,
    poc_sk smallint,
    skrok smallint not null ,
    poznamka varchar(20),
    uziv char(20),
    dat_zmen date,
    poc_tyzd smallint,
    stsk char(5),
    primary key (id) 
  );
revoke all on "isfr".uvazok from "public";

create index "isfr".ix206_7 on "isfr".uvazok (skrok);
create index "isfr".uv_spo on "isfr".uvazok (skrok,cis_predm,os_cis);
    
create index "isfr".ix107_2 on "isfr".uvazok (cis_predm);
create index "isfr".uv_sps on "isfr".uvazok (skrok,cis_predm,semester);
    
create index "isfr".uv_sp on "isfr".uvazok (skrok,cis_predm);
create unique index "isfr".uv_spod on "isfr".uvazok (skrok,cis_predm,
    os_cis,druh);
{ TABLE "isfr".diplomka row size = 860 number of columns = 15 index size = 117 }
{ unload file name = diplo00142.unl number of rows = 744 }

create table "isfr".diplomka 
  (
    rod_cislo char(11) not null ,
    iddp integer not null ,
    os_cislo smallint not null ,
    pracovisko char(1) not null ,
    nazov varchar(200) not null ,
    anazov varchar(200),
    rok_zadania smallint not null ,
    popis varchar(255),
    veduci char(50) not null ,
    cis_katedra char(4) not null ,
    tutor char(50),
    oponent char(50),
    termin_obh date,
    uziv char(20),
    dat_zmen date,
    primary key (iddp,pracovisko,rok_zadania) 
  );
revoke all on "isfr".diplomka from "public";

create index "isfr".ix165_2 on "isfr".diplomka (iddp);
create index "isfr".ix165_4 on "isfr".diplomka (pracovisko);
create unique index "isfr".i_dipl on "isfr".diplomka (os_cislo,
    pracovisko,rok_zadania);
create unique index "isfr".i_dipl2 on "isfr".diplomka (rod_cislo,
    pracovisko,rok_zadania);
create index "isfr".ix291_4 on "isfr".diplomka (rok_zadania);
create index "isfr".ix158_1 on "isfr".diplomka (rod_cislo);
{ TABLE "isfr".hist_skupin row size = 36 number of columns = 6 index size = 34 }
{ unload file name = hist_00144.unl number of rows = 2830 }

create table "isfr".hist_skupin 
  (
    os_cislo integer not null ,
    skrok smallint not null ,
    st_skupina char(5) not null ,
    stav char(1) not null ,
    uziv char(20),
    datum date
  );
revoke all on "isfr".hist_skupin from "public";

create index "isfr".ix192_1 on "isfr".hist_skupin (os_cislo);
create index "isfr".ix192_2 on "isfr".hist_skupin (skrok);
create index "isfr".ix192_3 on "isfr".hist_skupin (st_skupina);
    
{ TABLE "isfr".zp_st_prog row size = 8 number of columns = 3 index size = 18 }
{ unload file name = zp_st00145.unl number of rows = 1539 }

create table "isfr".zp_st_prog 
  (
    skrok smallint not null ,
    cis_predm char(4) not null ,
    c_st_odboru smallint not null ,
    primary key (skrok,cis_predm,c_st_odboru) 
  );
revoke all on "isfr".zp_st_prog from "public";

{ TABLE "isfr".ldap_st row size = 100 number of columns = 7 index size = 25 }
{ unload file name = ldap_00146.unl number of rows = 1244 }

create table "isfr".ldap_st 
  (
    os_cislo smallint,
    login char(8) not null ,
    heslo char(30) not null ,
    telefon char(40),
    stav char(1),
    datum date not null ,
    uziv char(15) not null 
  );
revoke all on "isfr".ldap_st from "public";

create unique index "isfr".ldap_st_log on "isfr".ldap_st (login);
    
create index "isfr".ldap_st_stav on "isfr".ldap_st (stav);
{ TABLE "isfr".ldap_uc row size = 114 number of columns = 8 index size = 25 }
{ unload file name = ldap_00147.unl number of rows = 382 }

create table "isfr".ldap_uc 
  (
    os_cislo char(5),
    rod_cislo char(11),
    login char(8) not null ,
    heslo char(30) not null ,
    telefon char(40),
    stav char(1),
    datum date not null ,
    uziv char(15) not null 
  );
revoke all on "isfr".ldap_uc from "public";

create unique index "isfr".ldap_uc_log on "isfr".ldap_uc (login);
    
create index "isfr".ldap_uc_stav on "isfr".ldap_uc (stav);
{ TABLE "vajsova".abeceda row size = 5 number of columns = 2 index size = 12 }
{ unload file name = abece00152.unl number of rows = 7803 }

create table "vajsova".abeceda 
  (
    id serial not null ,
    pismeno char(1) not null 
  );
revoke all on "vajsova".abeceda from "public";

create unique index "vajsova".ix152_1 on "vajsova".abeceda (id);
    
{ TABLE "vajsova".ldap_serv row size = 136 number of columns = 8 index size = 0 }
{ unload file name = ldap_00153.unl number of rows = 1291 }

create table "vajsova".ldap_serv 
  (
    uid char(8),
    userpassword char(20),
    uidnumber integer,
    gindnumber integer,
    surname char(20),
    givenname char(30),
    telephonenumnber char(20),
    ou char(30)
  );
revoke all on "vajsova".ldap_serv from "public";

{ TABLE "vajsova".tab1 row size = 8 number of columns = 1 index size = 0 }
{ unload file name = tab1_00154.unl number of rows = 1 }

create table "vajsova".tab1 
  (
    id char(8)
  );
revoke all on "vajsova".tab1 from "public";

{ TABLE "isfr".prerekvizity row size = 12 number of columns = 4 index size = 78 }
{ unload file name = prere00157.unl number of rows = 940 }

create table "isfr".prerekvizity 
  (
    co char(4) not null constraint "isfr".n143_153,
    od_coho char(4) not null constraint "isfr".n143_154,
    skrok smallint not null constraint "isfr".n143_155,
    mnozina smallint not null ,
    primary key (co,od_coho,skrok,mnozina)  constraint "isfr".u143_152
  );
revoke all on "isfr".prerekvizity from "public";

create index "isfr".prop1 on "isfr".prerekvizity (skrok);
create index "isfr".prop2 on "isfr".prerekvizity (co,mnozina);
    
create index "isfr".prop3 on "isfr".prerekvizity (skrok,co,mnozina);
    
{ TABLE "isfr".zp2 row size = 66 number of columns = 16 index size = 75 }
{ unload file name = zp2__00159.unl number of rows = 1895 }

create table "isfr".zp2 
  (
    os_cislo smallint not null ,
    cis_predm char(4) not null ,
    vysledok smallint,
    datum_sk date,
    termin smallint,
    zapocet date,
    skrok smallint not null ,
    body smallint,
    ects smallint,
    prednasajuci char(5),
    skusajuci char(5),
    cviciaci char(5),
    miesto char(1),
    c_st_odboru smallint,
    uziv char(20),
    dat_zmen date,
    primary key (os_cislo,cis_predm,skrok) 
  );
revoke all on "isfr".zp2 from "public";

create index "sicova".zp2_cp on "isfr".zp2 (cis_predm);
create index "isfr".zp2_skrok on "isfr".zp2 (skrok);
create index "isfr".zp2_odb on "isfr".zp2 (c_st_odboru);
{ TABLE "isfr".poc_st row size = 6 number of columns = 2 index size = 12 }
{ unload file name = poc_s00160.unl number of rows = 52 }

create table "isfr".poc_st 
  (
    pocet smallint,
    datum date,
    primary key (datum) 
  );
revoke all on "isfr".poc_st from "public";

{ TABLE "isfr".student_iny row size = 157 number of columns = 10 index size = 22 
              }
{ unload file name = stude00165.unl number of rows = 44 }

create table "isfr".student_iny 
  (
    os_cislo smallint not null ,
    meno char(30),
    priezvisko char(30) not null ,
    rocnik smallint not null ,
    st_skupina char(5) not null ,
    specializacia char(30),
    odbor char(30),
    ukoncenie date,
    uziv char(20),
    dat_zmen date,
    primary key (os_cislo) 
  );
revoke all on "isfr".student_iny from "public";

create index "isfr".st_iny on "isfr".student_iny (st_skupina);
    
{ TABLE "isfr".student row size = 97 number of columns = 27 index size = 66 }
{ unload file name = stude00169.unl number of rows = 4983 }

create table "isfr".student 
  (
    os_cislo smallint not null constraint "isfr".n127_66,
    rod_cislo char(11) not null constraint "isfr".n127_67,
    rocnik smallint not null constraint "isfr".n127_68,
    opakovanie char(1),
    st_skupina char(5) not null constraint "isfr".n127_69,
    st_sk_old char(5),
    prerusenie char(1),
    dat_prv_zap date,
    prdp_zam smallint,
    c_specializacie smallint not null constraint "isfr".n127_70,
    c_st_odboru smallint not null constraint "isfr".n127_71,
    ukoncenie date,
    pozicka smallint,
    soc_stipko datetime year to year,
    stipko smallint,
    bakalar char(1),
    bc_datum date,
    datumop date,
    datumpr date,
    ziadost char(1),
    forma char(1) not null constraint "isfr".n127_72,
    rocnikop smallint,
    skrok_op smallint,
    stsk char(5),
    stav char(1) not null constraint "isfr".n127_73,
    uziv char(20),
    dat_zmen date,
    primary key (os_cislo)  constraint "isfr".u127_65
  );
revoke all on "isfr".student from "public";

create index "isfr".ix160_6 on "isfr".student (st_skupina);
create index "isfr".ix121_10 on "isfr".student (c_st_odboru);
{ TABLE "isfr".ucitel_iny row size = 131 number of columns = 11 index size = 64 }
{ unload file name = ucite00173.unl number of rows = 3 }

create table "isfr".ucitel_iny 
  (
    os_cis char(5) not null ,
    meno char(25) not null ,
    titul char(15),
    ped_hod char(8),
    tel_p char(11),
    pr_kat smallint,
    fakulta char(15) not null ,
    katedra char(25) not null ,
    stav char(1),
    uziv char(20),
    dat_zmen date
  );
revoke all on "isfr".ucitel_iny from "public";

create unique index "isfr".uc_i_oc on "isfr".ucitel_iny (os_cis);
    
create index "isfr".uc_i_m on "isfr".ucitel_iny (meno);
create index "vajsova".uc_i_s on "isfr".ucitel_iny (stav);
alter table "isfr".ucitel_iny add constraint primary key (os_cis) 
    constraint "isfr".uc_i_pk  ;

alter table "isfr".stip add constraint (foreign key (cis_stp) 
    references "isfr".cis_stp );

alter table "isfr".stip add constraint (foreign key (os_cislo) 
    references "isfr".student );

alter table "isfr".uvazok add constraint (foreign key (cis_predm,
    skrok) references "isfr".predmet_bod );

alter table "isfr".uvazok add constraint (foreign key (os_cis) 
    references "isfr".ucitel_novy );

alter table "isfr".uvazok add constraint (foreign key (druh) 
    references "isfr".druh_uvazku );

alter table "isfr".student add constraint (foreign key (rod_cislo) 
    references "isfr".os_udaje  constraint "isfr".r127_178);

alter table "isfr".student add constraint (foreign key (c_st_odboru,
    c_specializacie) references "isfr".st_odbory  constraint "isfr"
    .r127_179);

alter table "isfr".st_program add constraint (foreign key (c_st_odboru,
    c_specializacie) references "isfr".st_odbory );

alter table "isfr".predmet_bod add constraint (foreign key (cis_predm) 
    references "isfr".predmet );

alter table "isfr".os_udaje add constraint (foreign key (narodnost) 
    references "isfr".narodnost );

alter table "isfr".predmet_eng add constraint (foreign key (cis_predm) 
    references "isfr".predmet );

alter table "isfr".pozicky add constraint (foreign key (os_cislo) 
    references "isfr".student );

alter table "isfr".diplomka add constraint (foreign key (os_cislo) 
    references "isfr".student );

alter table "isfr".prerusenia add constraint (foreign key (os_cislo) 
    references "isfr".student );

alter table "isfr".ucitel add constraint (foreign key (pr_kat) 
    references "isfr".profesia );

alter table "isfr".otvorenie add constraint (foreign key (cis_predm,
    skrok) references "isfr".predmet_bod );

alter table "isfr".prerekvizity add constraint (foreign key (od_coho) 
    references "isfr".predmet  constraint "isfr".r143_189);

alter table "isfr".ucitel_novy add constraint (foreign key (os_cis) 
    references "isfr".ucitel );

alter table "isfr".ucitel_novy add constraint (foreign key (cis_kat) 
    references "isfr".katedra );

alter table "isfr".bod_limit add constraint (foreign key (c_st_odboru,
    c_specializacie) references "isfr".st_odbory );

alter table "isfr".zap_predmety add constraint (foreign key (os_cislo) 
    references "isfr".student );

alter table "isfr".st_program add constraint (foreign key (zabezpecuje) 
    references "isfr".ucitel_novy );

alter table "isfr".zap_predmety add constraint (foreign key (skrok,
    cis_predm,c_st_odboru) references "isfr".zp_st_prog );

alter table "isfr".diplomka add constraint (foreign key (rod_cislo) 
    references "isfr".os_udaje );

alter table "isfr".zp2 add constraint (foreign key (os_cislo) 
    references "isfr".student );

alter table "isfr".zp2 add constraint (foreign key (skrok,cis_predm,
    c_st_odboru) references "isfr".zp_st_prog );


grant select on "isfr".ucitel_pr to "oweis" as "isfr";
grant select on "isfr".ucitel_pr to "sleziak" as "isfr";
grant select on "isfr".ucitel to "mano" as "isfr";
grant select on "isfr".ucitel to "oweis" as "isfr";
grant select on "isfr".ucitel to "sleziak" as "isfr";
grant select on "isfr".sysmenus to "jamrich" as "isfr";
grant select on "isfr".sysmenus to "novakova" as "isfr";
grant select on "isfr".sysmenus to "oweis" as "isfr";
grant select on "isfr".sysmenus to "sicova" as "isfr";
grant select on "isfr".sysmenus to "sleziak" as "isfr";
grant select on "isfr".sysmenuitems to "jamrich" as "isfr";
grant select on "isfr".sysmenuitems to "novakova" as "isfr";
grant select on "isfr".sysmenuitems to "oweis" as "isfr";
grant select on "isfr".sysmenuitems to "sicova" as "isfr";
grant select on "isfr".sysmenuitems to "sleziak" as "isfr";
grant select on "isfr".profesia to "public" as "isfr";
grant update on "isfr".profesia to "public" as "isfr";
grant insert on "isfr".profesia to "public" as "isfr";
grant delete on "isfr".profesia to "public" as "isfr";
grant index on "isfr".profesia to "public" as "isfr";
grant select on "isfr".os_udaje to "mano" as "isfr";
grant select on "isfr".os_udaje to "oweis" as "isfr";
grant select on "isfr".zap_predmety to "mano" as "isfr";
grant select on "isfr".zap_predmety to "oweis" as "isfr";
grant select on "isfr".st_odbory to "oweis" as "isfr";
grant select on "isfr".student to "mano" as "isfr";
grant select on "isfr".student to "oweis" as "isfr";
grant select on "isfr".okres to "oweis" as "isfr";
grant select on "isfr".predmet to "mano" as "isfr";
grant select on "isfr".predmet to "oweis" as "isfr";
grant select on "isfr".predmet_bod to "oweis" as "isfr";
grant select on "isfr".otvorenie to "public" as "isfr";
grant update on "isfr".otvorenie to "public" as "isfr";
grant insert on "isfr".otvorenie to "public" as "isfr";
grant delete on "isfr".otvorenie to "public" as "isfr";
grant index on "isfr".otvorenie to "public" as "isfr";
grant select on "isfr".ucitel_novy to "public" as "isfr";
grant update on "isfr".ucitel_novy to "public" as "isfr";
grant insert on "isfr".ucitel_novy to "public" as "isfr";
grant delete on "isfr".ucitel_novy to "public" as "isfr";
grant index on "isfr".ucitel_novy to "public" as "isfr";
grant select on "isfr".prerusenia to "oweis" as "isfr";
grant select on "isfr".pozicky to "oweis" as "isfr";
grant select on "isfr".zp2 to "public" as "isfr";
grant update on "isfr".zp2 to "public" as "isfr";
grant insert on "isfr".zp2 to "public" as "isfr";
grant delete on "isfr".zp2 to "public" as "isfr";
grant index on "isfr".zp2 to "public" as "isfr";
grant select on "isfr".hist_skupin to "public" as "isfr";
grant update on "isfr".hist_skupin to "public" as "isfr";
grant insert on "isfr".hist_skupin to "public" as "isfr";
grant delete on "isfr".hist_skupin to "public" as "isfr";
grant index on "isfr".hist_skupin to "public" as "isfr";
grant select on "isfr".zp_st_prog to "public" as "isfr";
grant update on "isfr".zp_st_prog to "public" as "isfr";
grant insert on "isfr".zp_st_prog to "public" as "isfr";
grant delete on "isfr".zp_st_prog to "public" as "isfr";
grant index on "isfr".zp_st_prog to "public" as "isfr";
grant select on "isfr".ldap_st to "public" as "isfr";
grant update on "isfr".ldap_st to "public" as "isfr";
grant insert on "isfr".ldap_st to "public" as "isfr";
grant delete on "isfr".ldap_st to "public" as "isfr";
grant index on "isfr".ldap_st to "public" as "isfr";
grant select on "isfr".ldap_uc to "public" as "isfr";
grant update on "isfr".ldap_uc to "public" as "isfr";
grant insert on "isfr".ldap_uc to "public" as "isfr";
grant delete on "isfr".ldap_uc to "public" as "isfr";
grant index on "isfr".ldap_uc to "public" as "isfr";
grant select on "vajsova".abeceda to "public" as "vajsova";
grant update on "vajsova".abeceda to "public" as "vajsova";
grant insert on "vajsova".abeceda to "public" as "vajsova";
grant delete on "vajsova".abeceda to "public" as "vajsova";
grant index on "vajsova".abeceda to "public" as "vajsova";
grant select on "vajsova".ldap_serv to "public" as "vajsova";
grant update on "vajsova".ldap_serv to "public" as "vajsova";
grant insert on "vajsova".ldap_serv to "public" as "vajsova";
grant delete on "vajsova".ldap_serv to "public" as "vajsova";
grant index on "vajsova".ldap_serv to "public" as "vajsova";
grant select on "vajsova".tab1 to "public" as "vajsova";
grant update on "vajsova".tab1 to "public" as "vajsova";
grant insert on "vajsova".tab1 to "public" as "vajsova";
grant delete on "vajsova".tab1 to "public" as "vajsova";
grant index on "vajsova".tab1 to "public" as "vajsova";
grant select on "isfr".poc_st to "public" as "isfr";
grant update on "isfr".poc_st to "public" as "isfr";
grant insert on "isfr".poc_st to "public" as "isfr";
grant delete on "isfr".poc_st to "public" as "isfr";
grant index on "isfr".poc_st to "public" as "isfr";
grant select on "isfr".student_iny to "public" as "isfr";
grant update on "isfr".student_iny to "public" as "isfr";
grant insert on "isfr".student_iny to "public" as "isfr";
grant delete on "isfr".student_iny to "public" as "isfr";
grant index on "isfr".student_iny to "public" as "isfr";
grant select on "isfr".ucitel_iny to "public" as "isfr";
grant update on "isfr".ucitel_iny to "public" as "isfr";
grant insert on "isfr".ucitel_iny to "public" as "isfr";
grant delete on "isfr".ucitel_iny to "public" as "isfr";
grant index on "isfr".ucitel_iny to "public" as "isfr";




create procedure "vajsova".instr(kde char(100), co char(1))
returning int;

  define i,j,n int;
   
  let n = length(kde);
  let i = 1;
  while (substr(kde,i,1) <> co) and (i<n)
     let i= i+1;
  end while;
  
  if (substr(kde,i,1) =co) then 
     let j=i;
   else let j=0;
  end if;
  return j;

end procedure;

create procedure "vajsova".heslo(login char(8), dlzka int)
returning char(20);

  define i,j,n int;
  define p_heslo char(20);
  define c char(1);
   
  let p_heslo='a';
  let j=-1;
  for i = 1 to dlzka
     select min(id) into j from abeceda;
     select pismeno into c from abeceda
       where id = j;

     let p_heslo = substr(p_heslo,1,i-1)||c;
--     update abeceda 
--      set pismeno=substr(login,i,1)
--      where id = j;

--     delete from abeceda
--     where id = j;
  end for;

   
  for i = 1 to length(login) 
     let c = substr(login,i,1);
--     insert into abeceda(pismeno) values('c');
 --    insert into abeceda values (0,i);
  end for;
 return p_heslo;

end procedure;


 

grant  execute on "vajsova".instr to "public" as "vajsova";
grant  execute on "vajsova".heslo to "public" as "vajsova";

create view "isfr".skuska (cis_kat) as 
  select x0.cis_kat from "isfr".katedra x0 ;                   
                                
create view "isfr".w_sekret (cis_kat,sek) as 
  select x0.cis_kat ,x1.meno from "isfr".katedra x0 ,"isfr".ucitel 
    x1 where (x0.sekrt_kat = x1.os_cis ) ;                   
                             
create view "isfr".w_veduci (cis_kat,ved) as 
  select x0.cis_kat ,x1.meno from "isfr".katedra x0 ,"isfr".ucitel 
    x1 where (x0.ved_kat = x1.os_cis ) ;                     
                             
create view "isfr".w_zastupca (cis_kat,zas) as 
  select x0.cis_kat ,x1.meno from "isfr".katedra x0 ,"isfr".ucitel 
    x1 where (x0.z_ved_kat = x1.os_cis ) ;                   
                           
create view "isfr".ldap_login (login) as 
  select x0.login from "isfr".ldap_st x0  union select x1.login 
    from "isfr".ldap_uc x1 ; 
create view "isfr".ldap_serv_st (uid,userpassword,uidnumber,gindnumber,surname,givenname,telephonenumnber,ou) as 
  select x0.uid ,x0.userpassword ,x0.uidnumber ,x0.gindnumber 
    ,x0.surname ,x0.givenname ,x0.telephonenumnber ,x0.ou from 
    "vajsova".ldap_serv x0 where (x0.gindnumber = 14005 ) ;   
                                  





 

