#include <cstdlib>
#include "Zasobnik.h"
#include "Vstup.h"

using namespace cppvstup;

void init(Zasobnik *z)
{
	z->pocet = 0;
	z->sp = NULL;

}

unsigned int pop(Zasobnik *zasobnik)
{
	if (zasobnik != NULL && zasobnik->pocet > 0)
	{
		unsigned int retval = zasobnik->sp->info;
		Zasobnik::InfoBox *pom = zasobnik->sp->dalsi;
		delete zasobnik->sp;
		zasobnik->sp = pom;
		zasobnik->pocet--;
		return retval;
	}
	return NEPLATNA_HODNOTA;
}

bool push(Zasobnik *zasobnik, unsigned int val)
{
	if (zasobnik != NULL && val > NEPLATNA_HODNOTA)
	{
		Zasobnik::InfoBox *box = new Zasobnik::InfoBox;
		box->info = val;
		box->dalsi = zasobnik->sp != NULL ? zasobnik->sp : NULL;
		zasobnik->sp = box;
		zasobnik->pocet++;

		return true;
	}
	return false;
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
	while (cislo != NEPLATNA_HODNOTA)
	{
		push(zasobnik, cislo);
		cislo = vstup();
	}
}

void zrus(Zasobnik *zasobnik)
{
	while (zasobnik->pocet > 0)
		pop(zasobnik);
}

void vlozjeden(Zasobnik *cielzasobnik, Zasobnik::InfoBox *box)
{
	if (box->dalsi != NULL)
		vlozjeden(cielzasobnik, box->dalsi);
	push(cielzasobnik, box->info);
}

void kopiruj(Zasobnik *cielzasobnik, const Zasobnik *zdrojzasobnik)
{
	if (cielzasobnik != NULL && zdrojzasobnik != NULL && zdrojzasobnik->pocet > 0)
	{
		if (cielzasobnik->pocet > 0)
			zrus(cielzasobnik);
		vlozjeden(cielzasobnik, zdrojzasobnik->sp);
	}
}