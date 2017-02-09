#include <cstdio>
#include "vstup.h"
#include "zasobnik.h"
#include "vypis.h"

//#define testy

#ifdef testy
#include "test.h"
#endif

int main()
{
	bool ok {true};

	Zasobnik z;	//tento zasobnik ma naroziel od inych pevne stanovene mieste pamati
	init(&z);


#ifdef testy
	ok = runtest(&z);
#endif
	if (ok == true)
	{
		vypis("Zadaj hodnoty \n");
		nacitaj(&z);
		while (z.sp != NULL)
		{
			int iret = pop(&z);	//hodnota vrcheho vrvku zasobnika
			char text[100];
			sprintf(text, "\n" , iret);
			vypis(text);
		}
	}
	else
	{
		printf("Chyba");
	}
	zrus(&z);

	return 0;
}