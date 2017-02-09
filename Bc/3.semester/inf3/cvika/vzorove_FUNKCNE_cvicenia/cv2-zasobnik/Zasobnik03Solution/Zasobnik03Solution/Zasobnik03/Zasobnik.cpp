#include <cstdlib>

#include "Zasobnik.h"
#include "vstup.h"

using namespace cvstup;

bool push(Zasobnik *zasobnik, unsigned int val)
{
	if (zasobnik != NULL && val > NEPLATNA_HODNOTA)
	{
		InfoBox *box = new InfoBox;
		box->info = val;
		box->dalsi = zasobnik->pocet != 0 ? zasobnik->sp : NULL;
		zasobnik->sp = box;
		zasobnik->pocet++;
		return true;
	}
	return false;
}

unsigned int pop(Zasobnik *zasobnik)
{
	if (zasobnik != NULL && zasobnik->pocet > 0)
	{
		InfoBox *pom = zasobnik->sp->dalsi;
		unsigned int retval = zasobnik->sp->info;
		delete zasobnik->sp;
		zasobnik->sp = pom;
		zasobnik->pocet--;
		return retval;
	}
	return NEPLATNA_HODNOTA;
}

unsigned int peek(Zasobnik *zasobnik)
{
	if (zasobnik != NULL && zasobnik->pocet > 0)
		return zasobnik->sp->info;
	return NEPLATNA_HODNOTA;
}

void nacitaj(Zasobnik *zasobnik)
{
	unsigned int cislo = vstup();
	while (cislo == NEPLATNA_HODNOTA)
	{
		push(zasobnik, cislo);
		cislo = vstup();
	}
}

void zrus(Zasobnik *zasobnik)
{
	while (zasobnik->pocet)
		pop(zasobnik);
}

void vloz(Zasobnik *zasobnik, InfoBox *box)
{
	if (box->dalsi != NULL)
		vloz(zasobnik, box->dalsi);
	push(zasobnik, box->info);
}


void kopiruj(Zasobnik *cielzasobnik, const Zasobnik *zdrojzasobnik)
{
	if (cielzasobnik != NULL && zdrojzasobnik != NULL &&zdrojzasobnik->pocet > 0)
	{
		if (cielzasobnik->pocet > 0)
			zrus(cielzasobnik);
		vloz(cielzasobnik, zdrojzasobnik->sp);
	}
}

void init(Zasobnik *zasobnik)
{
	zasobnik->sp = NULL;
	zasobnik->pocet = 0;
}
