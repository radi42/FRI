#include <cstdio>

#include "Zasobnik.h"
#include "vystup.h"

//#define TESTY

#ifdef TESTY
	#include "Testy.h"
#endif


int main()
{
	bool ok { true };
	Zasobnik z;
	init(&z);

#ifdef TESTY
	ok = runtesty(&z);
#endif
	if (ok == true)
	{
		// citanie z klavesnice
		nacitaj(&z);
		//while (z.pocetPrvkov > 0)
		//	vypis(pop(&z));
		
		kopirujDoPola(&z);

	}
	else
		printf("POZOR!!! TESTY NEPRESLI!!!\n");

	return 0;
}