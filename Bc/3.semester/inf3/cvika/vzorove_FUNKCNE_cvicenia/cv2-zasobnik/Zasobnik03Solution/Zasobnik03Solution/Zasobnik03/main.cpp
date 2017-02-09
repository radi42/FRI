//#define TESTY

#ifdef TESTY
#include "Testy.h"
#endif
#include <cstdio> // C++99, C stdio.h

#include <iostream>
#include "Zasobnik.h"


int main()
{
	Zasobnik z;
	init(&z);

	bool ok{ true };
#ifdef TESTY
	ok = runtesty();
#endif
	if (ok == true)
	{
		nacitaj(&z);
		while (z.pocet)
			std::cout << pop(&z) << std::endl;
		zrus(&z);
	}
	else
		printf("TESTY NEPRESLI!!!\n");
	return 0;
}