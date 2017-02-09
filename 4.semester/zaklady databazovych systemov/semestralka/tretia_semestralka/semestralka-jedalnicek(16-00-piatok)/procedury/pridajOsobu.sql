-- Lukas Kabat

create or replace procedure pridajOsobu(
p_meno IN osoba.meno%type,
p_priezvisko IN osoba.priezvisko%type,
p_vaha_zac IN osoba.vaha_zaciatocna%type,
p_vaha_ciel IN osoba.vaha_ciel%type,
p_datum_narodenia IN osoba.datum_narodenia%type,
p_pohlavie IN osoba.pohlavie%type,
p_tuky_ciel IN osoba.tuky_ciel%type,
p_sach_ciel IN osoba.sach_ciel%type,
p_bielk_ciel IN osoba.bielk_ciel%type,
p_kcal_ciel IN osoba.kcal_ciel%type)
as
begin
insert into osoba
values(
NULL,
p_meno,
p_priezvisko,
p_vaha_zac,
p_vaha_ciel,
NULL,
p_datum_narodenia,
p_pohlavie,
p_tuky_ciel,
p_sach_ciel,
p_bielk_ciel,
p_kcal_ciel
);
end;
/

show err;

--Lukas Kabat