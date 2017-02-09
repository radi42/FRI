#include "zasobnik.h"
#include <cstdlib> //potrebujeme importovat kniznicu pre NULL
#include "vstup.h"

using namespace cppVstup; //menime typ nacitania z klavesnice

void init(Zasobnik *zasobnik)
{
	if (zasobnik != NULL)
	{
		zasobnik->pocet = 0;	//sipka, lebo pracujeme s haldou
		zasobnik->sp = NULL;
	}

}

int peek(Zasobnik *zasobnik)
{
	if (zasobnik != NULL && zasobnik->pocet == 0)
	{
		return zasobnik->sp->hodnota;
	}
	return NeplatnaHodnota;
}

bool push(Zasobnik *zasobnik, int x)
{
	if (x > 0)
	{
		InfoBox *newBox = new InfoBox;
		if (zasobnik != NULL)
		{
			newBox->hodnota = x;
			newBox->pointer = NULL;
			if (zasobnik->sp == NULL)
			{
				zasobnik->sp = newBox;
			}
			else
			{
				newBox->pointer = zasobnik->sp;
				zasobnik->sp = newBox;
			}
			zasobnik->pocet++;
			return true;
		}
	}
	return false;
}

int pop(Zasobnik *zasobnik)
{
	int ret = 0;
	if (zasobnik != NULL && zasobnik->sp != NULL)
	{
		ret = zasobnik->sp->hodnota;
		InfoBox *newsp = zasobnik->sp->pointer;
		delete zasobnik->sp;
		zasobnik->sp = newsp;
		zasobnik->pocet--;
		return ret;
	}
	return NeplatnaHodnota;
}

void nacitaj(Zasobnik *mojZasobnik)
{
	int cislo = vstup();
	while (cislo > NeplatnaHodnota)
	{
		push(mojZasobnik, cislo);
		cislo = vstup();			//vyziadanie dalsieho vstupu
	}
}


void zrus(Zasobnik *zasobnik)
{
	if (zasobnik != NULL)
	{
		while (zasobnik->sp != NULL)
		{
			pop(zasobnik);
		}
		zasobnik->pocet = 0;
	}
}

void vloz(Zasobnik *mojZasobnik, InfoBox *box)
{
	if (box->pointer != NULL)
	{
		vloz(mojZasobnik, box->pointer);
	}
	push(mojZasobnik, box->hodnota);
}

void copy(Zasobnik *mojZasobnik, const Zasobnik *zdrojZasobnik)
{
	if (mojZasobnik != NULL, zdrojZasobnik != NULL && zdrojZasobnik->pocet > 0)
	{
		if (mojZasobnik->pocet > 0)
		{
			zrus(mojZasobnik);
		}
		vloz(mojZasobnik, zdrojZasobnik->sp);
	}
}