SELECT nazov_jedla,id_jedla
FROM jedlo
WHERE upper(nazov_jedla) LIKE upper('%&nazov_jedla%');