#include <cstdlib>

#include "Zasobnik.h"
#include "Vstup.h"

using namespace cppvstup;

void init(Zasobnik *zasobnik)
{
	if (zasobnik != NULL)
	{
		zasobnik->pocet = 0;
		zasobnik->sp = NULL;
	}
}

void zrus(Zasobnik *zasobnik)
{
	if (zasobnik != NULL)
	{
		while (zasobnik->pocet)
			pop(zasobnik);
	}
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
		Zasobnik::InfoBox *novybox = new Zasobnik::InfoBox;
		novybox->info = val;

		novybox->dalsi = zasobnik->sp != NULL ? zasobnik->sp : NULL;

		zasobnik->sp = novybox;

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
	while (cislo > NEPLATNA_HODNOTA)
	{
		push(zasobnik, cislo);
		cislo = vstup();
	}
}


void insert(Zasobnik *cielzasobnik, Zasobnik::InfoBox *box)
{
	if (box->dalsi != NULL)
		insert(cielzasobnik, box->dalsi);
	push(cielzasobnik, box->info);
}

void kopiruj(Zasobnik *cielzasobnik, const Zasobnik *zdrojzasobnik)
{
	if (cielzasobnik != NULL && zdrojzasobnik != NULL &&
		zdrojzasobnik->pocet > 0 && cielzasobnik != zdrojzasobnik)
	{
		if (cielzasobnik->pocet > 0)
			zrus(cielzasobnik);
		insert(cielzasobnik, zdrojzasobnik->sp);
	}
}

