#include <cstdlib>

#include "Zasobnik.h"
#include "Vstup.h"

using namespace cppvstup; // tu je rozhodnutie, ktory vstup pouzijeme

void init(Zasobnik *zasobnik)
{
	if(zasobnik != NULL)
	{
		zasobnik->pocet = 0;
		(*zasobnik).sp = NULL;
	}
}

bool push(Zasobnik *zasobnik, int x)
{
	if(x > 0)
	{
		if(zasobnik != NULL)
		{
			InfoBox *novyBox = new InfoBox;
			if(novyBox != NULL)
			{
				novyBox->cislo = x;
				novyBox->dalsi = NULL;
				if(zasobnik->sp == NULL) //zasobnik->pocet==0
				{
					zasobnik->sp = novyBox;
				}
				else
				{
					novyBox->dalsi = zasobnik->sp;
					zasobnik->sp = novyBox;
				}
				zasobnik->pocet++;
				return true;
			}
		}
	}
	return false;
}

int pop(Zasobnik *zasobnik)
{
	int retval = 0;
	if(zasobnik->sp != NULL)
	{
		retval = zasobnik->sp->cislo;
		InfoBox *novysp = zasobnik->sp->dalsi;
		delete zasobnik->sp;
		zasobnik->sp = novysp;
		zasobnik->pocet--;
	}
	return retval;
}

int peek(Zasobnik *zasobnik)
{
	if(zasobnik->sp)
	{
		return zasobnik->sp->cislo;
	}
	return 0;
	//return zasobnik->sp != NULL ? zasobnik->sp->cislo : 0;
}

void clear(Zasobnik *zasobnik)
{
	if(zasobnik != NULL/* && zasobnik->sp != NULL*/)
		while(zasobnik->pocet > 0) 
		{
			pop(zasobnik);
		}
}

void vloz(Zasobnik *cielZasobnik, InfoBox * box)
{
	if(box->dalsi != NULL)
		vloz(cielZasobnik, box->dalsi);
	push(cielZasobnik, box->cislo);
}

void copy(Zasobnik *cielZasobnik, const Zasobnik *zdrojZasobnik)
{
	if(zdrojZasobnik != NULL && zdrojZasobnik->sp != NULL &&
		cielZasobnik != NULL)
	{
		vloz(cielZasobnik, zdrojZasobnik->sp);
	}
}

void nacitaj(Zasobnik *cielZasobnik)
{
	char oznam[] = "Zadavaj prirodzene cislo (koniec = 0)\n"
					"-------------------------------------\n";
	int cislo = vstup(oznam);
	while (cislo > 0)
	{
		push(cielZasobnik, cislo);
		cislo = vstup(NULL);
	}
}
