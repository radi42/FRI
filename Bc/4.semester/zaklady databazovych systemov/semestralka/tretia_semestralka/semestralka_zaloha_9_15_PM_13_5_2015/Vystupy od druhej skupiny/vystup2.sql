Select nazov_jedla 
from jedlo je join zlozenie zl ON (je.id_jedla = zl.id_jedla)
where je.kategoria = 'obed'
and (zl.id_suroviny = 333 or zl.id_suroviny = 334 or zl.id_suroviny = 335);