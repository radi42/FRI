create or replace procedure Vytvor_umrtie
(v_rc IN osobne_udaje.rodne_cislo%type,
 v_oc_zam IN zamestnanec.oc_zamestnanca%type, 
 v_datum IN char)
IS
  jeOsoba number default 0;
  jeZam number default 0;
  uzZomrel number;
  p_id_umrtia umrtie.id_umrtia%type;
BEGIN
  select count(*) into uzZomrel from umrtie
    where v_rc=umrtie.rodne_cislo;
  
  if uzZomrel = 0 then raise_application_error(-20000,'Zadana osoba uz zomrela');
  else
    select count(*) into jeOsoba from osobne_udaje
      where rodne_cislo=v_rc;

    if jeOsoba = 0 then raise_application_error(-20000,'Zadana osoba neexistuje');
    else
      select count(*) into jeZam from zamestnanec
        where v_oc_zam=oc_zamestnanca;
      if jeZam = 0 then raise_application_error(-20000,'Neexistujuci zamestnanec?');
      else
        select seq_id_umrtia.nextval into p_id_umrtia from dual;
        insert into umrtie values(p_id_umrtia,v_rc,v_oc_zam,to_date(v_datum,'dd.mm.yyyy'));
      end if;
    end if;
  end if;
END Vytvor_umrtie;
/