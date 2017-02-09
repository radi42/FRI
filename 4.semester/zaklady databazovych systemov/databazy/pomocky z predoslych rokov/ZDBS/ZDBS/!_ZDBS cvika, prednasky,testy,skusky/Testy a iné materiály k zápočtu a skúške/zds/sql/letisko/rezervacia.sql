CREATE OR REPLACE PACKAGE rezervacia AS

PROCEDURE Vyber;
PROCEDURE Trasa(letiskoodkial varchar2, letiskokam varchar2);

END rezervacia;


/

CREATE OR REPLACE PACKAGE BODY rezervacia AS
PROCEDURE Vyber IS
        cursor c is
        select * from letiskos;
BEGIN

HTP.P('<form action=knapko.rezervacia.Trasa method=post>');
htp.p('<select name="letiskoodkial" size=1>');
        for let_rec in c loop
htp.p('<option value='||let_rec.kod||' >');
        htp.p(let_rec.nazov);
        end loop;
htp.p('</select>');
htp.p('<select name="letiskokam" size=1>');
        for let_rec in c loop
htp.p('<option value='||let_rec.kod||' >');
        htp.p(let_rec.nazov);
        end loop;
htp.p('</select>');
HTP.P('</form>');
HTP.P('<form action=knapko.rezervacia.nic2 method=post>');
HTP.P('<TABLE>');
HTP.P('<TR>');
HTP.P('<TD>');
HTP.P('Datum rezervacie:');
HTP.P('</TD><TD>');
HTP.P('<input type=text name=datum value="datum">');
HTP.P('</TD>');
HTP.P('</TR><TR>');
HTP.P('</TD><TD>');
htp.p('<input type=submit name=submit value="vyber">');
HTP.P('</TD>');
HTP.P('</TR>');
HTP.P('</TABLE>');
HTP.P('</form>');


END Vyber;

PROCEDURE Trasa(letiskoodkial varchar2, letiskokam varchar2) as
        cursor c is
        select * from trasy where (trasy.odkial=letiskoodkial) and (trasy.kam=letiskokam);
BEGIN

HTP.P('<form action=knapko.rezervacia.nic2 method=post>');
HTP.P('<TABLE>');
HTP.P('<TR>');
HTP.P('<TD>');
HTP.P('ID vybranej trasy:');
HTP.P('</TD><TD>');
HTP.P(c);
HTP.P('</TD>');
HTP.P('</TR><TR>');
HTP.P('<TD>');
HTP.P('<input type=submit name ="action" value="Pokracuj">');
HTP.P('</TD>');
HTP.P('</TR>');
HTP.P('</TABLE>');
HTP.P('</form>');

end Trasa;

end rezervacia;

/
