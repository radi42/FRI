
	select sum(surovina.kcal*zlozenie.pocet_gramov)
	from surovina 
	join zlozenie on (surovina.id_suroviny = zlozenie.id_suroviny)
	join jedlo on (jedlo.id_jedla = zlozenie.id_jedla)
	where zlozenie.id_jedla = :new.id_jedla;