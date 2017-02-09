  set FEEDBACK off;
  UNDEFINE id_vlaku;
  UNDEFINE od;
  UNDEFINE do;
  
  create table A (        
  id_vagonu number,
  kapacita number);
  
  create table B (
  id_vagonu number,
  obsadenost number);
  
--  variable id_vlaku number;
--  variable od DATE;
--  variable do DATE;
--  execute :id_vlaku := &id_vlaku;
--  execute :od := to_date('&od','DD-MM-YYYY');
--  execute :do := to_date('&do','DD-MM-YYYY');
 
  variable pocet_prejazdov number;
  execute :pocet_prejazdov := prejazd_vlaku(&&id_vlaku,to_date('&&od','DD-MM-YYYY'),to_date('&&do','DD-MM-YYYY'));
  
  insert into A(id_vagonu, kapacita)
  select v.cislo_vagonu, tv.pocet_miest * :pocet_prejazdov
  from vagon v, typ_vagonu tv
  where v.vl_cislo_vlaku = &&id_vlaku
  and v.tv_id = tv.id;
  
  insert into b(id_vagonu, obsadenost)
  select v.cislo_vagonu, count(distinct l.id)
  from listky l, usek_listka ul, vagon v
  where v.cislo_vagonu = ul.v_cislo_vagonu
  and ul.l_id = l.id and l.zaplatene = '''A'''
  and v.vl_cislo_vlaku = &&id_vlaku
  and l.datum between to_date('&&od', 'DD-MM-YYYY') and to_date('&&do', 'DD-MM-YYYY')
  group by v.cislo_vagonu;

  select a.id_vagonu, (nvl(obsadenost, 0) / kapacita) as VYTAZENOST
  from a, b
  where a.id_vagonu = b.id_vagonu(+);
  
  drop table A;		      
  drop table B;

UNDEFINE id_vlaku;
 UNDEFINE od;
 UNDEFINE do;
 