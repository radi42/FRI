SELECT nazov_suroviny,id_suroviny
FROM surovina
WHERE upper(nazov_suroviny) LIKE upper('%&nazov_suroviny%');
