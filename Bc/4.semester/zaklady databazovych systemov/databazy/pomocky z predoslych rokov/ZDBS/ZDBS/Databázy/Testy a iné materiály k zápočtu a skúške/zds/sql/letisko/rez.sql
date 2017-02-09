CREATE OR REPLACE PACKAGE rez AS

PROCEDURE Vyber;
PROCEDURE Trasa(letiskoodkial varchar2, letiskokam varchar2, action varchar2);
PROCEDURE Vyhladanie(id_trasy number);

END rez;


/

CREATE OR REPLACE PACKAGE BODY rez AS
PROCEDURE Vyber IS
        cursor c is
        select * from letiskos;
BEGIN

HTP.P('<form action=knapko.rez.Trasa method=post>');
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
HTP.P('<TABLE>');
HTP.P('<TR>');
HTP.P('<TD>');
htp.p('<input type=submit name=action value=Vyber>');
HTP.P('</TD>');
HTP.P('</TR>');
HTP.P('</TABLE>');
HTP.P('</form>');


END Vyber;


PROCEDURE Trasa(letiskoodkial varchar2, letiskokam varchar2, action varchar2) as
          trasa_rec number;
BEGIN
IF action = 'Vyber' THEN
HTP.P('<form action=knapko.rez.Vyhladanie method=post>');
HTP.P('<select id into trasa_rec from trasy where (odkial=letiskoodkial) and (kam=letiskokam)>');
HTP.P('<TABLE>');
HTP.P('<TR>');
HTP.P('<TD>');
HTP.P('Datum rezervacie:');
HTP.P('</TD><TD>');
HTP.P('<TD>'||'<input type=text name=datum value=datum>');
HTP.P('</TD>');
HTP.P('</TR><TR>');
HTP.P('<TD>');
HTP.P('<Id vybranej trasy:');
HTP.P('</TD>');
HTP.P('<TD>');
HTP.P('<input type=text name=id_trasy value='||trasa_rec||'>');
HTP.P('</TR><TR>');
HTP.P('<TD>');
HTP.P('<input type=submit name=action value=Pokracuj>');
HTP.P('</TD>');
HTP.P('</TR>');
HTP.P('</TABLE>');
HTP.P('</form>');
END IF;
end Trasa;

PROCEDURE Vyhladanie(id_trasy number) as
        cursor c1(ide number) is
        select * from trasy_zlozenie where (trasa_id=ide);
        odkial varchar2;
        kam varchar2;
BEGIN

HTP.P('<form action=knapko.rez.nic method=post>');
htp.p('<table>');
        htp.p('<tr><td>');
        for l_rec in c1(id_trasy) loop
        kam:=l_rec.letisko_kod;
        htp.p('<tr><td>');
	for l_rec in c1(id_trasy) loop
        kam:=l_rec.letisko_kod;
	htp.p('</td></tr>');
        end loop;
        htp.p('</table>');
htp.p('<input type=submit name=sumbit value="vyber">');
HTP.P('</form>');

END Vyhladanie;

end rez;

/