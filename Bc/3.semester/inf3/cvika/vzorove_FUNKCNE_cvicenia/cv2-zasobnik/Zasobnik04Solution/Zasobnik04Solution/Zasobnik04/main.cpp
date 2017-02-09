#define TESTY

#ifdef TESTY
#include "Testy.h"
#endif

#include <iostream>
#include "Zasobnik.h"

int main()
{
	bool ok{ true };
#ifdef TESTY
	ok = runtest();
#endif
	if (ok == true)
	{
		Zasobnik z;
		
		init(&z);
		nacitaj(&z);

		Zasobnik z2;
		init(&z2);

		kopiruj(&z2, &z);

		while (z2.pocet)
			std::cout << pop(&z2) << std::endl;

		zrus(&z2);
		zrus(&z);
	}
	else
		std::cout << "TESTY NEPRESLI!!!" << std::endl;

	return 0;
}