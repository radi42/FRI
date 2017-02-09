#include "test.h"
#include "zasobnik.h"
#include <cstdio>

bool runtest(Zasobnik *zasobnik)
{
	bool ret;
	int iret;
	if (zasobnik == NULL) return false;

	//test vkladania
	for (int i = 0; i < 10; i++)
	{
		ret = push(zasobnik, i + 1);
		if (ret == false) return false;
	}

	ret = push(zasobnik, 0);
		if (ret == true)
		{
			return false;
		}

	//test vyberania
		for (int i = 0; i < 10; i++)
	{
		iret = pop(zasobnik);
		sprintf(text, "%D\n", iret);
		vypis(text);

		if (iret != (10 - i))
			return false;
	}
}