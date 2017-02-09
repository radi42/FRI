CREATE OR REPLACE PACKAGE letisko AS

PROCEDURE uvod;
PROCEDURE menu;
PROCEDURE vyhladavanie;
PROCEDURE Zobraz;
PROCEDURE Zobraz2;
PROCEDURE uvod1(id number);
PROCEDURE uvod2;
PROCEDURE uvod3 (id number);
PROCEDURE spracuj(id number, meno varchar2,
adresa varchar2, rod_cislo varchar2, tel_cislo number, action varchar2);
END letisko;


/



CREATE OR REPLACE PACKAGE BODY letisko AS

PROCEDURE uvod IS

BEGIN

HTP.P('<a href=letiskoa.menu>Informacny system pre rezervaciu leteniek</a>');
HTP.NL;
HTP.NL;
HTP.P('Vytvorili studenti: Andrej Knapko, Pavol Lucanik, Martin Simak');
HTP.NL;
HTP.NL;
HTP.P('Copyright 2003');

END uvod;

PROCEDURE menu IS

BEGIN

HTP.P('MENU:');
HTP.NL; HTP.NL;

HTP.P('<a href=letiskoa.vyhladavanie>Vyhladavanie letov</a>');
HTP.NL; HTP.NL;
HTP.P('<a href=letiskoa.rezervacia>Rezervacia letov</a>');
HTP.NL; HTP.NL;
HTP.P('<a href=letiskoa.subsystem>Subsystem leteniek</a>');
HTP.NL; HTP.NL;
HTP.P('<a href=letiskoa.aktivity>Zoznam dennych aktivit</a>');
HTP.NL; HTP.NL;

HTP.P('<a href=letisko.uvod>[SPAT]</a>');

END menu;


PROCEDURE vyhladavanie IS

BEGIN

HTP.P('<input type=checkbox name=a value=Hello>');
HTP.P('<input type=text name=a value=Hello>');
HTP.P('<select * from letiskos>');

END vyhladavanie;


PROCEDURE Zobraz IS
        cursor c is
        select * from let_spols;
BEGIN
HTP.P('<form action=letiskoa.uvod1 method=post>');
htp.p('<table>');
        for ls_rec in c loop
        HTP.P('<tr><td>'||'<input type=radio name=id value='||ls_rec.id||' >');
        htp.p('</td><td>'||ls_rec.adresa);
        htp.p('</td><td>'||ls_rec.id);        
        htp.p('</td><td>'||ls_rec.nazov);
        htp.p('</td><td>'||ls_rec.kontakt);
        htp.p('</td></tr>');
        end loop;
HTP.P('<input type=submit>');
htp.p('</table>');
HTP.P('</form>');

END Zobraz;

PROCEDURE uvod1 (id number) is
        cursor c1 (ide number) is
        select nazov from let_spols
        where let_spols.id = ide;
begin
        htp.p('<table>');
for ls_rec in c1(id||'%') loop
        htp.p('</td><td>'||ls_rec.nazov);
        htp.p('</td></td>');
        end loop;
        htp.p('</table>');

END uvod1;

PROCEDURE uvod2 is zakazniks_rec  zakazniks%ROWTYPE;
begin

HTP.P('<form action=letiskoa.spracuj method=post>');
  HTP.P('<TABLE>');
    HTP.P('<TR>');
    HTP.P('<TD>');
    HTP.P('ID:');  
    HTP.P('</TD><TD>');
    HTP.P('<input type=text name=id size=11 value="'||zakazniks_rec.id||'">');
    HTP.P('</TD>');
    HTP.P('</TR><TR>');
    HTP.P('<TD>');
    HTP.P('Meno:');
    HTP.P('</TD><TD>');
    HTP.P('<input type=text name=meno size=30 value="'||zakazniks_rec.meno||'">');
    HTP.P('</TD>');
    HTP.P('</TR><TR>');
    HTP.P('<TD>');
    HTP.P('Adresa:');
    HTP.P('</TD><TD>');
    HTP.P('<input type=text name=adresa size=40 value="'||zakazniks_rec.adresa||'">');
    HTP.P('</TD>');
    HTP.P('</TR><TR>');
    HTP.P('<TD>');
    HTP.P('Rodne cislo:');
    HTP.P('</TD><TD>');
    HTP.P('<input type=text name=rod_cislo size=12 value="'||zakazniks_rec.rod_cislo||'">');
    HTP.P('</TD>');
    HTP.P('</TR><TR>');
    HTP.P('<TD>');
    HTP.P('Telefonne cislo:');
    HTP.P('</TD><TD>');
    HTP.P('<input type=text name=tel_cislo size=38 value="'||zakazniks_rec.tel_cislo||'">');
    HTP.P('</TD>');
    HTP.P('</TR><TR>');
    HTP.P('<TD>');
    HTP.P('<input type=submit name ="action" value="Insert">');
    HTP.P('</TD>');
    HTP.P('</TR>');
    HTP.P('</TABLE>');
    HTP.P('</form>');

END uvod2;

Procedure spracuj (id number, meno varchar2,
adresa varchar2, rod_cislo varchar2, tel_cislo number, action varchar2) 
is
sql_stm varchar2(1000);

begin

IF action = 'Insert' THEN
  IF
(length(id)>0) AND (length(meno)>0) AND (length(adresa)>0) AND
(length(rod_cislo)>0) AND (length(tel_cislo)>0) THEN
  sql_stm:='insert into zakazniks (id, meno, adresa, rod_cislo, tel_cislo)';
  sql_stm:=sql_stm||'values (:1, :2, :3, :4, :5)';
EXECUTE IMMEDIATE sql_stm USING id, meno, adresa, rod_cislo, tel_cislo;
HTP.P('Riadok bol vlozeny<BR>');
HTP.formOpen('letiskoa.uvod','POST');
      HTP.P('<INPUT TYPE="Submit" VALUE="NAVRAT">'); 
      HTP.formClose;
ELSE
         HTP.P('Polozky id, meno, adresa, rod.cislo a tel.cislo musia byt vyplnene!!!!');
       END IF; 
END IF;
END spracuj;

PROCEDURE Zobraz2 IS
        cursor c is
        select * from typ_lietadlas;

BEGIN

HTP.P('<form action=letiskoa.uvod3 method=post>');
htp.p('<table>');
        for tl_rec in c loop
        HTP.P('<tr><td>'||'<input type=radio name=id value='||tl_rec.id||' >');
        htp.p('</td><td>'||tl_rec.typ);
        htp.p('</td></tr>');
        end loop;
HTP.P('<input type=submit>');
htp.p('</table>');
HTP.P('</form>');

END Zobraz2;

PROCEDURE uvod3 (id number)as
        cursor c1(ide number) is
        select * from lietadlos
        where lietadlos.tl_id=ide;
begin
        htp.p('<table>');
        for l_rec in c1(id) loop
        htp.p('</td><td>'||l_rec.cena_buss);
        htp.p('</td></td>');
        end loop;
        htp.p('</table>');
end uvod3;



END letisko;


/

