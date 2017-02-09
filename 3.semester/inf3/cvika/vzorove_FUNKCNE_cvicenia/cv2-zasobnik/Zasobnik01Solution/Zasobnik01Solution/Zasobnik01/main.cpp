#include <cstdio>  // alebo stdio.h
#include "vystup.h"

#include "Zasobnik.h"

//#define TESTY

#ifdef TESTY
#include "test.h"
#endif


int main()
{
	bool ok{ true };

	Zasobnik z;
	init(&z);

#ifdef TESTY
	ok = runtest(&z);
#endif
	if (ok == true)
	{
		// Nacitaj zasobnik z klavesnice
		vypis("Zadaj hodnoty do zasobnika (koniec = 0)\n");
		nacitaj(&z);
		while (z.sp != NULL)
		{
			int iret = pop(&z);
			char text[100];
			sprintf(text, "%d\n", iret);
			vypis(text);
		}
	}
	else
		printf("CHYBA! TESTY NEPRESLI!!!\n");

	zrus(&z);
	return 0;
}