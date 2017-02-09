create or replace procedure Vyskladaj_skupinu
(v_pracovisko       IN  CHAR,
v_odbor     IN st_odbory.st_odbor%TYPE,
v_zameranie  IN st_odbory.st_zameranie%TYPE,
v_rocnik IN CHAR,
v_kruzok IN CHAR,
v_st_skupina OUT CHAR)
AS
BEGIN
SELECT '5'||v_pracovisko||so.sk_odbor||so.sk_zamer||v_rocnik||v_kruzok
INTO v_st_skupina
FROM priklad_db2.st_odbory so
WHERE so.c_st_odboru = v_odbor and so.c_specializacie = v_zameranie;
EXCEPTION
WHEN NO_DATA_FOUND then dbms_output.put_line ('Nic nevratilo');
END;
/

show error;