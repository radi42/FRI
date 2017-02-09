CREATE OR REPLACE PACKAGE cena AS

--PROCEDURE vyhladanie;
--PROCEDURE zistenie_id_letenky;
--PROCEDURE cena_letenky (id number default'%');

END cena;

/

CREATE OR REPLACE PACKAGE BODY cena AS

--PROCEDURE vyhladanie IS
--        cursor c is
--        select * from let_spols;
--BEGIN
--htp.p('<table>');
--        for ls_rec in c loop
--        htp.p('</td><td>'||ls_rec.adresa);
--        htp.p('</td><td>'||ls_rec.nazov);
--        htp.p('</td><td>'||ls_rec.kontakt);
--        htp.p('</td></tr>');
--        end loop;
--htp.p('</table>');
--END vyhladanie;

--PROCEDURE zistenie_id_letenky
--BEGIN
--END zistenie_id_letenky;


--PROCEDURE cena_letenky is select sum(cena) from letenka_leties where
--letenka_leties.let_id=
--BEGIN


--END cena_letenky;


END cena;

/
