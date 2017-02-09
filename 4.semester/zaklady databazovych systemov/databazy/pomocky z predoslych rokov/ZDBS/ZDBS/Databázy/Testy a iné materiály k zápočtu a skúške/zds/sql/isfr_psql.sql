create table  zamestnavatel 
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

create unique index  ix112_1 on  zamestnavatel (ico);
    
create table  cis_asist 
  (
    druh smallint not null ,
    nazov char(10) not null 
  );

create unique index  ix237_1 on  cis_asist (druh);
    
create table  kalendar 
  (
    id serial not null ,
    datum date not null ,
    udalost1 char(70) not null ,
    udalost2 char(70),
    udalost3 char(70),
    zodpovednost char(10)
  );

create unique index  ix2186_1 on  kalendar (id);

create table  statut 
  (
    id serial not null ,
    popis char(70) not null ,
    subor text not null 
  );

create unique index  ix2333_1 on  statut (id);

create table  prav 
  (
    uzivatel char(20),
    uzivatel_1 char(20),
    datum date not null 
  );


create table  ucitel_pr 
  (
    cis_predm char(4) not null ,
    skrok smallint not null ,
    os_cis char(5) not null ,
    priznak char(1) not null 
  );

create index  ix241_2 on  ucitel_pr (skrok);
create index  ix240_1 on  ucitel_pr (cis_predm);
create index  ix240_6 on  ucitel_pr (os_cis);
create unique index  up_spo on  ucitel_pr (skrok,cis_predm,
    os_cis);
create index  up_sp on  ucitel_pr (skrok,cis_predm);
    

create table  ucitel_cin 
  (
    os_cis char(5) not null ,
    cinnost varchar(255)
  );

create unique index  ix224_1 on  ucitel_cin (os_cis);
    

create table  druh_asist 
  (
    iddp char(4) not null ,
    id_asistent char(5) not null ,
    druh smallint not null 
  );

create unique index  da_ia on  druh_asist (iddp,id_asistent);
    
create unique index  da_id on  druh_asist (iddp,druh);
    
create index  ix208_1 on  druh_asist (iddp);
create unique index  da_dad on  druh_asist (iddp,druh,
    id_asistent);
create index  ix120_2 on  druh_asist (id_asistent);
    
create table  tel_zoz 
  (
    os_cis char(5) not null ,
    c_tel char(20) not null ,
    druh char(20),
    poznamka char(30)
  );

create index  ix293_1 on  tel_zoz (os_cis);
create index  ix293_2 on  tel_zoz (c_tel);

create table  zostavy 
  (
    idz smallint,
    fcia char(15),
    meno char(60),
    help1 char(928),
    help2 char(928)
  );


create table  asistent_dp 
  (
    id_asistent char(5) not null ,
    meno char(25) not null ,
    ico char(8),
    uziv char(20),
    dat_zmen date
  );

create unique index  ix127_1 on  asistent_dp (id_asistent);
    
create index  ix127_4 on  asistent_dp (ico);

create table  ucitel 
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

create index  ix213_25 on  ucitel (cis_kat);
create unique index  ix183_1 on  ucitel (os_cis);
create index  ix203_24 on  ucitel (pr_kat);
create index  ix183_2 on  ucitel (rod_cis);
create index  ix183_3 on  ucitel (meno);
create index  ix117_26 on  ucitel (stav);
alter table  ucitel add constraint u117_223  primary key (os_cis) 
   ;

create table  bod_limit 
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

create unique index  bl_sos on  bod_limit (skrok,rocnik,
    c_st_odboru,c_specializacie);
create index  bl_os on  bod_limit (c_st_odboru,c_specializacie);
    
create index  ix129_1 on  bod_limit (rocnik);
alter table  bod_limit add constraint u127_227  primary key (skrok,
    rocnik,c_st_odboru,c_specializacie) 
     ;

create table  katedra 
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

create unique index  ix214_1 on  katedra (cis_kat);
    
alter table  katedra add constraint u129_225  primary key (cis_kat) 
   ;

create table  obec 
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


create table  test 
  (
    rok smallint,
    meno char(50),
    priezvisko char(50),
    dnar date,
    rc char(11),
    oc integer
  );

create table  predmet_eng 
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

create unique index  p_eng_cp on  predmet_eng (cis_predm);
    
create index  p_eng_gestor on  predmet_eng (gestor);
    
alter table  predmet_eng add constraint u135_191  primary key (cis_predm) 
    ;

create table  sk_spravy 
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

create unique index  ix167_1 on  sk_spravy (id);
create index  ix167_2 on  sk_spravy (os_cislo);

create table  predmet_stsk 
  (
    skrok smallint not null ,
    cis_predm char(4) not null ,
    miesto char(1) not null ,
    poc_stsk smallint,
    uziv char(20),
    dat_zmen date
  );

create index  ixx267_1 on  predmet_stsk (skrok);
create index  ixx267_2 on  predmet_stsk (cis_predm);
    
create unique index  xpb_sk on  predmet_stsk (skrok,
    cis_predm,miesto);

create table  sysmenus 
  (
    menuname char(18),
    title char(60)
  );

create unique index  sysmenidx on  sysmenus (menuname);
    

create table  sysmenuitems 
  (
    imenuname char(18),
    itemnum integer,
    mtext char(60),
    mtype char(1),
    progname char(60)
  );

create unique index  meniidx on  sysmenuitems (imenuname,
    itemnum);

create table  neuspesne_2 
  (
    os_cislo smallint,
    cis_predm char(4)
  );

create table  neuspesne_3 
  (
    os_cislo smallint,
    cis_predm char(4)
  );


create table  profesia 
  (
    id_profes smallint not null ,
    popis char(30) not null 
  );

create unique index  ix163_1 on  profesia (id_profes);
    
alter table  profesia add constraint u163_202  primary key (id_profes) 
    ;

create table  os_udaje 
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
    primary key (rod_cislo)
  );

create index  os_mp on  os_udaje (priezvisko,meno);
    
create index  ix134_3 on  os_udaje (priezvisko);

create table  zap_predmety 
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

create index  jx118_2 on  zap_predmety (cis_predm);
    
create index  jx195_9 on  zap_predmety (prednasajuci);
    
create index  jx124_7 on  zap_predmety (skrok);
create index  ix168_14 on  zap_predmety (c_st_odboru);
    

create table  st_odbory 
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

create index  ix139_1 on  st_odbory (c_st_odboru);
    
create index  ix169_2 on  st_odbory (c_specializacie);
    

create table  okres 
  (
    cisokr char(4) not null ,
    nazov char(20) not null ,
    primary key (cisokr) 
  );


create table  narodnost 
  (
    id smallint,
    popis char(20) not null ,
    primary key (id) 
  );


create table  predmet 
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

create index  ix181_4 on  predmet (gestor);


create table  predmet_bod 
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

create index  ix267_1 on  predmet_bod (skrok);

create table  otvorenie 
  (
    cis_predm char(4) not null ,
    skrok smallint not null ,
    pracovisko char(1) not null ,
    kapacita smallint,
    primary key (cis_predm,skrok,pracovisko) 
  );


create table  ucitel_novy 
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


create table  cis_stp 
  (
    cis_stp smallint not null ,
    popis char(30) not null ,
    skratka char(2) not null ,
    suma smallint,
    primary key (cis_stp) 
  );

create table  stip 
  (
    cis_stp smallint not null ,
    os_cislo smallint not null ,
    datum date not null ,
    suma smallint not null ,
    primary key (cis_stp,os_cislo,datum) 
  );


create table  param 
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


create table  st_program 
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

create index  sp_sp on  st_program (skrok,cis_predm);
    
create index  sp_sps on  st_program (skrok,cis_predm,
    semester);
create index  ix198_2 on  st_program (cis_predm);
create index  ix198_1 on  st_program (skrok);
create index  ix132_6 on  st_program (c_st_odboru);
    
create index  ix184_4 on  st_program (zabezpecuje);
    

create table  prerusenia 
  (
    os_cislo smallint not null ,
    od_date date not null ,
    do_date date,
    sk_rok smallint not null ,
    rocnik smallint,
    primary key (os_cislo,od_date,sk_rok) 
  );


create table  pozicky 
  (
    os_cislo smallint not null ,
    sk_rok smallint not null ,
    suma smallint not null ,
    typ char(1) not null ,
    primary key (os_cislo,sk_rok,typ) 
  );

create index  poz_rok on  pozicky (sk_rok);

create table  druh_uvazku 
  (
    druh smallint not null ,
    popis char(15) not null ,
    norma float,
    primary key (druh) 
  );


create table  uvazok 
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

create index  ix206_7 on  uvazok (skrok);
create index  uv_spo on  uvazok (skrok,cis_predm,os_cis);
    
create index  ix107_2 on  uvazok (cis_predm);
create index  uv_sps on  uvazok (skrok,cis_predm,semester);
    
create index  uv_sp on  uvazok (skrok,cis_predm);
create unique index  uv_spod on  uvazok (skrok,cis_predm,
    os_cis,druh);

create table  diplomka 
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

create index  ix165_2 on  diplomka (iddp);
create index  ix165_4 on  diplomka (pracovisko);
create unique index  i_dipl on  diplomka (os_cislo,
    pracovisko,rok_zadania);
create unique index  i_dipl2 on  diplomka (rod_cislo,
    pracovisko,rok_zadania);
create index  ix291_4 on  diplomka (rok_zadania);
create index  ix158_1 on  diplomka (rod_cislo);

create table  hist_skupin 
  (
    os_cislo integer not null ,
    skrok smallint not null ,
    st_skupina char(5) not null ,
    stav char(1) not null ,
    uziv char(20),
    datum date
  );

create index  ix192_1 on  hist_skupin (os_cislo);
create index  ix192_2 on  hist_skupin (skrok);
create index  ix192_3 on  hist_skupin (st_skupina);


create table  zp_st_prog 
  (
    skrok smallint not null ,
    cis_predm char(4) not null ,
    c_st_odboru smallint not null ,
    primary key (skrok,cis_predm,c_st_odboru) 
  );

create table  ldap_st 
  (
    os_cislo smallint,
    login char(8) not null ,
    heslo char(30) not null ,
    telefon char(40),
    stav char(1),
    datum date not null ,
    uziv char(15) not null 
  );

create unique index  ldap_st_log on  ldap_st (login);
    
create index  ldap_st_stav on  ldap_st (stav);

create table  ldap_uc 
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

create unique index  ldap_uc_log on  ldap_uc (login);
    
create index  ldap_uc_stav on  ldap_uc (stav);

create table  abeceda 
  (
    id serial not null ,
    pismeno char(1) not null 
  );

create unique index  ix152_1 on  abeceda (id);
    

create table  ldap_serv 
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

create table  tab1 
  (
    id char(8)
  );

create table  prerekvizity 
  (
    co char(4) not null ,
    od_coho char(4) not null ,
    skrok smallint not null,
    mnozina smallint not null ,
    primary key (co,od_coho,skrok,mnozina) 
  );

create index  prop1 on  prerekvizity (skrok);
create index  prop2 on  prerekvizity (co,mnozina);
    
create index  prop3 on  prerekvizity (skrok,co,mnozina);
    

create table  zp2 
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

create index  zp2_cp on  zp2 (cis_predm);
create index  zp2_skrok on  zp2 (skrok);
create index  zp2_odb on  zp2 (c_st_odboru);

create table  poc_st 
  (
    pocet smallint,
    datum date,
    primary key (datum) 
  );


create table  student_iny 
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

create index  st_iny on  student_iny (st_skupina);
    

create table  student 
  (
    os_cislo smallint not null,
    rod_cislo char(11) not null,
    rocnik smallint not null ,
    opakovanie char(1),
    st_skupina char(5) not null ,
    st_sk_old char(5),
    prerusenie char(1),
    dat_prv_zap date,
    prdp_zam smallint,
    c_specializacie smallint not null ,
    c_st_odboru smallint not null ,
    ukoncenie date,
    pozicka smallint,
    soc_stipko smallint,
    stipko smallint,
    bakalar char(1),
    bc_datum date,
    datumop date,
    datumpr date,
    ziadost char(1),
    forma char(1) not null ,
    rocnikop smallint,
    skrok_op smallint,
    stsk char(5),
    stav char(1) not null ,
    uziv char(20),
    dat_zmen date,
    primary key (os_cislo)
);

create index  ix160_6 on  student (st_skupina);
create index  ix121_10 on  student (c_st_odboru);


create table  ucitel_iny 
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

create unique index  uc_i_oc on  ucitel_iny (os_cis);
    
create index  uc_i_m on  ucitel_iny (meno);
create index  uc_i_s on  ucitel_iny (stav);
alter table  ucitel_iny add constraint uc_i_pk
 primary key (os_cis)   ;

alter table  stip add foreign key (cis_stp) 
    references  cis_stp ;

alter table  stip add foreign key (os_cislo) 
    references  student ;

alter table  uvazok add foreign key (cis_predm,
    skrok) references  predmet_bod ;

alter table  uvazok add foreign key (os_cis) 
    references  ucitel_novy ;

alter table  uvazok add foreign key (druh) 
    references  druh_uvazku ;

alter table  student add foreign key (rod_cislo) 
    references  os_udaje ;

alter table  student add foreign key (c_st_odboru,
    c_specializacie) references  st_odbory ;

alter table  st_program add foreign key (c_st_odboru,
    c_specializacie) references  st_odbory ;

alter table  predmet_bod add foreign key (cis_predm) 
    references  predmet ;

alter table  os_udaje add foreign key (narodnost) 
    references  narodnost;

alter table  predmet_eng add foreign key (cis_predm) 
    references  predmet ;

alter table  pozicky add foreign key (os_cislo) 
    references  student ;

alter table  diplomka add foreign key (os_cislo) 
    references  student ;

alter table  prerusenia add foreign key (os_cislo) 
    references  student ;

alter table  ucitel add foreign key (pr_kat) 
    references  profesia ;

alter table  otvorenie add foreign key (cis_predm,
    skrok) references  predmet_bod ;

alter table  prerekvizity add foreign key (od_coho) 
    references  predmet  ;

alter table  ucitel_novy add foreign key (os_cis) 
    references  ucitel ;

alter table  ucitel_novy add foreign key (cis_kat) 
    references  katedra ;

alter table  bod_limit add foreign key (c_st_odboru,
    c_specializacie) references  st_odbory ;

alter table  zap_predmety add foreign key (os_cislo) 
    references  student ;

alter table  st_program add foreign key (zabezpecuje) 
    references  ucitel_novy ;

alter table  zap_predmety add foreign key (skrok,
    cis_predm,c_st_odboru) references  zp_st_prog ;

alter table  diplomka add foreign key (rod_cislo) 
    references  os_udaje ;

alter table  zp2 add foreign key (os_cislo) 
    references  student ;

alter table  zp2 add foreign key (skrok,cis_predm,
    c_st_odboru) references  zp_st_prog ;


