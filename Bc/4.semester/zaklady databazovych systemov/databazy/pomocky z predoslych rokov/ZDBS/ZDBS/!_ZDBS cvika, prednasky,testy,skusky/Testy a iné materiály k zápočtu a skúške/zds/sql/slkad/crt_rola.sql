create table rola
( id number not null,
  nazov varchar2(12) not null,
  su char(1) default '0' not null,
  vyber char(1) default '0' not null,
  vklad char(1) default '0' not null,
  primary key(id)
);