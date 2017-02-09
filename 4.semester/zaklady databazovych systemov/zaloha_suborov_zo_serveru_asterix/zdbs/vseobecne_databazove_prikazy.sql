--vypise zoznam vsetkych tabuliek
SELECT table_name
  FROM user_tables

--zoznam triggrov
SELECTtrigger_name FROM user_triggers WHERE table_name = 'zap_predmety';

--alebo
DESC user_triggers;
