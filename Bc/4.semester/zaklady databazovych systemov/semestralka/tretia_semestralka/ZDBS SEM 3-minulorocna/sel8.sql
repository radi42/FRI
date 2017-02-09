set serveroutput on
CREATE OR REPLACE PROCEDURE historia
(okres_param IN varchar)
IS
  rok varchar(4);
  okres varchar(255);
  uvedenych number;
  vyradenych number;
  vsetkych number;
BEGIN 
dbms_output.put_line('Rok Okres Uvedenych Vyradenych Vsetky');

  FOR i IN 0..10 LOOP 
  SELECT to_char(SYSDATE,'yyyy')-i as rok, o.nazov_okres as okres, 
      sum(
        case when to_char(b.datum_uvedenia,'yyyy') = to_char(SYSDATE,'yyyy')-i then 1
             else 0 end
      ) AS uvedenych,
      sum(
        case when to_char(b.datum_vyradenia,'yyyy') = to_char(SYSDATE,'yyyy')-i then 1
             else 0 end
      ) AS vyradenych,
      sum(
        case when to_char(b.datum_uvedenia,'yyyy') <= to_char(SYSDATE,'yyyy')-i AND (to_char(b.datum_vyradenia,'yyyy') IS NULL OR to_char(b.datum_vyradenia,'yyyy') > to_char(SYSDATE,'yyyy')-i) then 1
             else 0 end ) AS vsetkych
into rok, okres, uvedenych, vyradenych, vsetkych
    FROM bankomat b 
    JOIN adresa a ON (b.id_adresa=a.id_adresa) 
    JOIN mesto m ON (a.kod_mesto=m.kod_mesto)
    JOIN okres o ON (m.kod_okres=o.kod_okres)
    WHERE o.nazov_okres=okres_param
    GROUP BY to_char(SYSDATE,'yyyy'), o.nazov_okres;
    dbms_output.put_line(rok||' '||okres||' '||uvedenych||' '||vyradenych||' '||vsetkych);
  end loop;

END;
/