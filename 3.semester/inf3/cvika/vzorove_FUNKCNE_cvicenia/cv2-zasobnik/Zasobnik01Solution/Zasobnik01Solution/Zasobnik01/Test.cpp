#include <cstdlib>
#include <cstdio>

#include "test.h"
#include "vystup.h"

bool runtest(Zasobnik *zasobnik)
{
	bool ret;
	int iret;
	if (zasobnik == NULL)
		return false;

	// Test vkladania do zasobnika
	for (int i = 0; i < 10; i++)
	{
		ret = push(zasobnik, i + 1);
		if (ret == false)
			return false;
	}
	ret = push(zasobnik, 0);
	if (ret == true)
		return false;
	ret = push(zasobnik, -100);
	if (ret == true)
		return false;

	// Test vyberania zo zasobnika
	iret = peek(zasobnik);
	if (iret != 10)
		return false;

	// Test vyberania zo zasobnika
	for (int i = 0; i < 10; i++)
	{
		iret = pop(zasobnik);

		char text[100];
		sprintf(text, "%d\n", iret);
		vypis(text);

		if (iret != (10-i))
			return false;
	}

	return true;
}