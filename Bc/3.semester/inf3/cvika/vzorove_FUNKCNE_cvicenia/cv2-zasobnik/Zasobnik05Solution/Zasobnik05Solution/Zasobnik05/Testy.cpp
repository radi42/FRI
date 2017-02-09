#include <cstdlib>

#include "Testy.h"
#include "Zasobnik.h"

bool runtesty()
{
	Zasobnik z;
	init(&z);

	bool res;
	for (int i = 0; i < 10; i++)
	{
		res = push(&z, i + 1);
		if (res == false)
			return false;
	}
	res = push(&z, NEPLATNA_HODNOTA);
	if (res == true)
		return false;

	res = push(NULL, 11);
	if (res == true)
		return false;

	unsigned int val = peek(&z);
	if (val != 10)
		return false;

	val = pop(NULL);
	if (val != NEPLATNA_HODNOTA)
		return false;

	for (int i = 0; i < 8; i++)
	{
		val = pop(&z);
		if (val != 10 - i)
			return false;
	}
	zrus(&z);

	return true;
}
