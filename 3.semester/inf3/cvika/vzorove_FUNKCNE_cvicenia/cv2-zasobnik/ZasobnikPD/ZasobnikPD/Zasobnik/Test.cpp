#include "Test.h"
#include "Vystup.h"

bool runtest(Zasobnik *zasobnik)
{
	Zasobnik zkopia;
	bool res = true;
	int ires;

	init(&zkopia);

	for (int i = 0; i < 20; i++)
	{
		res = push(zasobnik, i + 1);
		if (!res)
		{
			vypis("Chyba vkladania do zasobnika!\n");
			return false;
		}
	}
	if (zasobnik->pocet!=20)
	{
		vypis("Chyba vkladania do zasobnika! Nespravny pocet prvkov!\n");
		return false;
	}
	copy(&zkopia, zasobnik);
	ires = pop(&zkopia);
	if (ires != 20)
	{
		vypis("Chyba kopirovania zasobnika! Moznost vlozenia neprirodzeneho cisla!\n");
		return false;
	}
	clear(&zkopia);
	ires = pop(&zkopia);
	if (ires != 0)
	{
		vypis("Chyba zrusenia zasobnika!\n");
		return false;
	}
	clear(zasobnik);

	return true;
}