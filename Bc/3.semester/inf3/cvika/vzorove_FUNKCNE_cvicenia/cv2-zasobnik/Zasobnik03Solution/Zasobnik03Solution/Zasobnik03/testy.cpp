#include "Testy.h"
#include "Zasobnik.h"

bool runtesty()
{
	Zasobnik ztest;
	init(&ztest);
	bool res;
	for (unsigned int i = 0; i < 10; i++)
	{
		res = push(&ztest, i + 1);
		if (res == false)
			return false;
	}
	res = push(&ztest, 0);
	if (res == true)
		return false;
	unsigned int val;
	val = peek(&ztest);
	if (val != 10)
		return false;
	//while (ztest.pocet)
	//{
	//	val = pop(&ztest);
	//	if (val != ztest.pocet+1)
	//		return false;
	//}
	for (unsigned int i = 0; i < 10; i++)
	{
		val = pop(&ztest);
		if (val != (10-i))
			return false;
	}
	val = pop(&ztest);
	if (val != NEPLATNA_HODNOTA)
		return false;
	zrus(&ztest);

	return true;
}