create or replace function fVyskladaj_skupinu
(v_pracovisko       IN  CHAR,
v_odbor     IN st_odbory.st_odbor%TYPE,
v_zameranie  IN st_odbory.st_zameranie%TYPE,
v_rocnik IN CHAR,
v_kruzok IN CHAR)
return CHAR
AS
v_st_skupina student.st_skupina%type :='';
BEGIN
SELECT '5'||v_pracovisko||so.sk_odbor||so.sk_zamer||v_rocnik||v_kruzok
INTO v_st_skupina
FROM priklad_db2.st_odbory so
WHERE so.c_st_odboru = v_odbor and so.c_specializacie = v_zameranie;
return v_st_skupina;
EXCEPTION
WHEN NO_DATA_FOUND then return '';
END;
/

show error;