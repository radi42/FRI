#include <cstdlib>

#include "Testy.h"
#include "vystup.h"

bool runtesty(Zasobnik *zasobnik)
{
	bool result;
	int iresult;

	if (zasobnik == NULL)
		return false;

	for (int i = 0; i < 10; i++)
	{
		result = push(zasobnik, i + 1);
		if (result == false)
			return false;
	}

	result = push(zasobnik, 0);
	if (result == true)
		return false;

	result = push(zasobnik, -1000);
	if (result == true)
		return false;

	for (int i = 0; i < 10; i++)
	{
		iresult = pop(zasobnik);
		vypis(iresult);
		if (iresult != (10 - i))
			return false;
	}

	iresult = pop(zasobnik);
	if (iresult != NEPLATNA_HODNOTA)
		return false;

	result = push(NULL, 1);
	if (result != NEPLATNA_HODNOTA)
		return false;

	result = pop(NULL);
	if (result != NEPLATNA_HODNOTA)
		return false;

	return true;
}