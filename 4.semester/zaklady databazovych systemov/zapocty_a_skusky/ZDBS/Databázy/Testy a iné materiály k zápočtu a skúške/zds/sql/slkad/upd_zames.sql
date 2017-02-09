alter table zamestnanec
  add constraint fk_rola_id foreign key(rola_id) references rola(id); 
