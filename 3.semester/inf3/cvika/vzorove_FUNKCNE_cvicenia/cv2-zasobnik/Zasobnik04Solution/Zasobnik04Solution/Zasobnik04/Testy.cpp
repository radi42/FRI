#include "Testy.h"
#include "Zasobnik.h"


bool runtest()
{
	Zasobnik z;
	bool res;
	
	init(&z);
	for (int i = 0; i < 10; i++)
	{
		res = push(&z, i + 1);
		if (res == false)
			return false;
	}
	res = push(&z, NEPLATNA_HODNOTA);
	if (res == true)
		return false;

	unsigned int val;

	val = peek(&z);
	if (val != 10)
		return false;

	for (int i = 0; i < 9; i++)
	{
		val = pop(&z);
		if (val != 10 - i)
			return false;
	}

	zrus(&z);
	return true;
}