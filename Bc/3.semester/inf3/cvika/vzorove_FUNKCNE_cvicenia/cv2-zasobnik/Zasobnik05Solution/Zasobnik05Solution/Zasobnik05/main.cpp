#define TESTY

#ifdef TESTY
#include "Testy.h"
#endif

#include <iostream>
#include "Zasobnik.h"
#include "Vystup.h"

int main()
{
	bool ok{ true };
#ifdef TESTY
	ok = runtesty();
#endif
	if (ok == true)
	{
		Zasobnik z;
		init(&z);
		
		nacitaj(&z);
		
		Zasobnik zcopy;
		init(&zcopy);
		kopiruj(&zcopy, &z);
		
		while (zcopy.pocet)
			vypis(pop(&zcopy));

		zrus(&zcopy);
		zrus(&z);
	}
	else
		std::cout << "TESTY NEPRESLI" << std::endl;
	return 0;
}