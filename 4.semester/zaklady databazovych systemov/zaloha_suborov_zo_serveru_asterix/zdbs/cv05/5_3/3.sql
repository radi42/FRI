DROP TABLE t2 CASCADE CONSTRAINTS;

CREATE TABLE t2
(
  id		integer NOT NULL references t1,
  datum	DATE NOT NULL,
  primary key( id, datum )
);