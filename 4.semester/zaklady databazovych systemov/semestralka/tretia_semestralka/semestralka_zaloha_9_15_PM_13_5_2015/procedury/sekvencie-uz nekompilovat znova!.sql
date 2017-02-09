-- Lukas Kabat

--sekvencia pre id_osoba
CREATE SEQUENCE s_os_cislo start with 26;

--sekvencia pre id_suroviny
create sequence s_id_suroviny
increment by 1
start with 461;

--sekvencia pre id_jedlo
create sequence s_id_jedla
increment by 1
start with 1043;

--sekvencia pre id_druhSportu
create sequence s_id_druhSportu
increment by 1 start with 11;
-- ---------------------------------------