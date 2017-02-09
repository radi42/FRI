create or replace procedure pridajSurovinu(
nazov surovina.nazov_suroviny%TYPE,
calorie surovina.kcal%TYPE,
fat surovina.tuky%TYPE,
protein surovina.bielkoviny%TYPE,
carbs surovina.sacharidy%TYPE)
is
begin
insert into surovina values(NULL, nazov, calorie, fat, protein, carbs, 'Ano');
end;
/

/*
--test pridavania suroviny bez idcka (id suroviny sa pridava pomocou triggra)
insert into surovina values(NULL, 'genericka surovina', 1, 2, 3, 4);

select * from surovina where nazov_suroviny = 'genericka surovina';

delete from surovina where nazov_suroviny = 'genericka surovina';

select * from surovina where nazov_suroviny = 'genericka surovina';
*/