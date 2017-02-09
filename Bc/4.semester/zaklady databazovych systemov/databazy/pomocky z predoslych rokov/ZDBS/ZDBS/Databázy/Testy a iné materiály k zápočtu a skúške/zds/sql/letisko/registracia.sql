CREATE OR REPLACE PACKAGE registracia AS

PROCEDURE Vyber;
PROCEDURE ;

END registracia;


/

CREATE OR REPLACE PACKAGE BODY registracia AS
PROCEDURE Vyber IS
        cursor c is
        select * from letiskos;
BEGIN

HTP.P('<form action=knapko.registracia.nic method=post>');
htp.p('<select name="letiskoodkial" size=1>');
        for ou_rec in c loop
htp.p('<option value='||ou_rec.kod||' >');
        htp.p(ou_rec.nazov);
        end loop;
htp.p('</select>');
htp.p('<select name="letiskokam" size=1>');
        for ou_rec in c loop
htp.p('<option value='||ou_rec.kod||' >');
        htp.p(ou_rec.nazov);
        end loop;
htp.p('</select>');
htp.p('<input type=submit name=datum value="vyber">');
HTP.P('</form>');

END Vyber;




end registracia;

/