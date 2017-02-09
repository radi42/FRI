select nazov_spol, count(*) as pocet
from l_let_spolocnost JOIN l_zamestnanec using(id_spolocnosti)
group by id_spolocnosti, nazov_spol
having count(*) > 30;