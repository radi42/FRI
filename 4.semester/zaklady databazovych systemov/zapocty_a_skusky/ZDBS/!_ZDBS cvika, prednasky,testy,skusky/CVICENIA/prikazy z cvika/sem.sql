/*
-- 1, 2, 3
set pagesize 25
set linesize 120

ttitle center "Zoznam studentov" 
btitle right sql.pno
column os_cislo heading "Osobne|cislo" format 999999
column meno heading "Meno" format A15
column priezvisko heading "Priezvisko" format A15

select st.os_cislo, ou.meno, ou.priezvisko 
  from student st, os_udaje ou
  where 
	ou.rod_cislo = st.rod_cislo;

-- 4
set pagesize 25
set linesize 120

ttitle center "Zoznam studentov" 
btitle right sql.pno
column rocnik heading "Rocnik" format 9
column os_cislo heading "Osobne|cislo" format 999999
column meno heading "Meno" format A15
column priezvisko heading "Priezvisko" format A15
column titul heading "Stupen" format A6
column meno_priezv heading "Meno a Priezvisko" format A30

select rocnik, st.os_cislo, ou.meno ||' '|| ou.priezvisko as meno_priezv, 
	case 
	  when(st_odbor between 100 and 199) then 'bc.'
	  when(st_odbor between 200 and 299) then 'ing.'
	end as titul,
  from student st, os_udaje ou
  where 
	ou.rod_cislo = st.rod_cislo 
  order by rocnik;

-- 5
set pagesize 25
set linesize 120

ttitle center "Zoznam studentov" 
btitle right sql.pno
column rocnik heading "Rocnik" format 9
column os_cislo heading "Osobne|cislo" format 999999
column meno heading "Meno" format A15
column priezvisko heading "Priezvisko" format A15
column titul heading "Stupen" format A6
column meno_priezv heading "Meno a Priezvisko" format A30
column priemer heading "Priemer" format 9.00
column min heading "Min.|znamka" format A6
column max heading "Max.|znamka" format A6
column pocet heading "Pocet" format 9

select rocnik, st.os_cislo, ou.meno ||' '|| ou.priezvisko as meno_priezv, 
	case 
	  when(st_odbor between 100 and 199) then 'bc.'
	  when(st_odbor between 200 and 299) then 'ing.'
	end as titul,
	avg(decode(vysledok,'A',1,'B',1.5,'C',2,'D',2.5,'E',3,4)) as priemer,
	min(nvl(vysledok,'F')) as min,
	max(nvl(vysledok,'F')) as max,
	count(*) as pocet
  from student st, os_udaje ou, zap_predmety zp
  where 
	ou.rod_cislo = st.rod_cislo 
	and st.os_cislo = zp.os_cislo
  group by st.os_cislo, ou.meno, ou.priezvisko, st.rocnik, st.st_odbor
  order by rocnik;


-- 6,7
set pagesize 25
set linesize 120

ttitle center "Zoznam studentov" right datum
btitle right sql.pno
column rocnik heading "   Rocnik" format 9
column os_cislo heading "Osobne|cislo" format 999999
column meno heading "Meno" format A15
column priezvisko heading "Priezvisko" format A15
column titul heading "Stupen" format A6
column meno_priezv heading "Meno a Priezvisko" format A30
column priemer heading "Priemer" format 9.00
column min heading "Min.|znamka" format A6
column max heading "Max.|znamka" format A6
column pocet heading "Pocet" format 99
COLUMN datum NEW_VALUE datum NOPRINT
break on rocnik skip 2
compute min label 'za rocnik' of min on rocnik
compute max label '' of max on rocnik
compute sum label '' of pocet on rocnik

select rocnik, st.os_cislo, ou.meno ||' '|| ou.priezvisko as meno_priezv, 
	case 
	  when(st_odbor between 100 and 199) then 'bc.'
	  when(st_odbor between 200 and 299) then 'ing.'
	end as titul,
	avg(decode(vysledok,'A',1,'B',1.5,'C',2,'D',2.5,'E',3,4)) as priemer,
	min(nvl(vysledok,'F')) as min,
	max(nvl(vysledok,'F')) as max,
	count(*) as pocet,
	TO_CHAR(SYSDATE,'DD.MM.RRRR') datum
  from student st, os_udaje ou, zap_predmety zp
  where 
	ou.rod_cislo = st.rod_cislo 
	and st.os_cislo = zp.os_cislo
  group by st.os_cislo, ou.meno, ou.priezvisko, st.rocnik, st.st_odbor
  order by rocnik;

*/
-- 8
set pagesize 25
set linesize 120

ttitle center "Zoznam studentov" right datum
btitle right sql.pno
column rocnik heading "   Rocnik" format 9
column os_cislo heading "Osobne|cislo" format 999999
column meno heading "Meno" format A15
column priezvisko heading "Priezvisko" format A15
column titul heading "Stupen" format A6
column meno_priezv heading "Meno a Priezvisko" format A30
column priemer heading "Priemer" format 9.00
column min heading "Min.|znamka" format A6
column max heading "Max.|znamka" format A6
column pocet heading "Pocet" format 99
COLUMN datum NEW_VALUE datum NOPRINT
break on rocnik skip 2
compute min label 'za rocnik' of min on rocnik
compute max label '' of max on rocnik
compute sum label '' of pocet on rocnik

select rocnik, st.os_cislo, ou.meno ||' '|| ou.priezvisko as meno_priezv,
        case
          when(st_odbor between 100 and 199) then 'bc.'
          when(st_odbor between 200 and 299) then 'ing.'
        end as titul,
        avg(decode(vysledok,'A',1,'B',1.5,'C',2,'D',2.5,'E',3,4)) as priemer,
        min(nvl(vysledok,'F')) as min,
        max(nvl(vysledok,'F')) as max,
        count(*) as pocet,
        TO_CHAR(SYSDATE,'DD.MM.RRRR') datum
  from student st, os_udaje ou, zap_predmety zp
  where
        ou.rod_cislo = st.rod_cislo
        and st.os_cislo = zp.os_cislo
	and rocnik like '&rocnik'
  group by st.os_cislo, ou.meno, ou.priezvisko, st.rocnik, st.st_odbor
  order by rocnik;
