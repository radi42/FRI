#include "Zasobnik.h"
#include "Vystup.h"

#define TESTY

#ifdef TESTY
#include "Test.h"
#endif

int main()
{
	bool ok = true;
	Zasobnik z;
	init(&z);

#ifdef TESTY
	ok = runtest(&z);
#endif
	if (ok)
	{
		char buf[100];
		nacitaj(&z);
		int pocet = z.pocet;
		for (int i = 0; i < pocet; i++)
		{
			sprintf(buf, "%d\n", pop(&z));
			vypis(buf);
		}
	}
	else
		vypis("Chyba!!! Testy nepresli!!!\n");

	return 0;
}