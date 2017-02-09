#include <cstdlib> // len C++11, je to to iste ako #include <stdlib.h> v C++99

#include "Zasobnik.h"
#include "vstup.h"

using namespace cvstup;

void init(Zasobnik *zasobnik)
{
	if (zasobnik != NULL)
	{
		zasobnik->pocet = 0;
		zasobnik->sp = NULL;
	}
}

int pop(Zasobnik *zasobnik)
{
	if (zasobnik != NULL && zasobnik->sp != NULL)
	{
		int retval = zasobnik->sp->info;
		InfoBox *novesp = zasobnik->sp->dalsi;
		delete zasobnik->sp;
		zasobnik->sp = novesp;

		zasobnik->pocet--;
		return retval;
	}
	return NEPLATNA_HODNOTA;
}

bool push(Zasobnik *zasobnik, int val)
{
	if (zasobnik != NULL && val > NEPLATNA_HODNOTA)
	{
		InfoBox *novybox = new InfoBox;
		novybox->info = val;
		novybox->dalsi = NULL;

		if (zasobnik->sp != NULL)
			novybox->dalsi = zasobnik->sp;
		zasobnik->sp = novybox;

		zasobnik->pocet++;
		return true;
	}
	return false;
}

int peek(Zasobnik *zasobnik)
{
	if (zasobnik != NULL && zasobnik->sp != NULL)  // if(!zasobnik)
	{
		return zasobnik->sp->info;
	}
	return NEPLATNA_HODNOTA;
}

void nacitaj(Zasobnik *zasobnik)
{
	int cislo = vstup();
	while (cislo > NEPLATNA_HODNOTA)
	{
		push(zasobnik, cislo);
		cislo = vstup();
	}
}


//void nacitaj(Zasobnik *zasobnik)
//{
//	int cislo = NEPLATNA_HODNOTA;
//	do
//	{
//		cislo = vstup();
//		if (cislo > NEPLATNA_HODNOTA)
//			push(zasobnik, cislo);
//	} while (cislo > NEPLATNA_HODNOTA);
//}

void zrus(Zasobnik *zasobnik)
{
	if (zasobnik != NULL)
	{
		while (zasobnik->sp != NULL)
			pop(zasobnik);
	}
}


//void zrus(Zasobnik *zasobnik)
//{
//	if (zasobnik != NULL)
//	{
//		int pocet = zasobnik->pocet;
//		for (int i = 0; i < pocet; i++)
//			pop(zasobnik);
//	}
//}

//void zrus(Zasobnik *zasobnik)
//{
//	if (zasobnik != NULL)
//	{
//		for (int i = 0; i < zasobnik->pocet; i++)
//		{
//			pop(zasobnik);
//			zasobnik->pocet++;
//		}
//		zasobnik->pocet = 0;
//	}
//}


void vloz(Zasobnik *cielzasobnik, InfoBox *box)
{
	if (box->dalsi != NULL)
		vloz(cielzasobnik, box->dalsi);
	push(cielzasobnik, box->info);
}

void kopiruj(Zasobnik *cielzasobnik, const Zasobnik *zdrojzasobnik)
{
	if (cielzasobnik != NULL && zdrojzasobnik != NULL && zdrojzasobnik->pocet > 0)
	{
		if (cielzasobnik->pocet > 0)
			zrus(cielzasobnik);
		vloz(cielzasobnik, zdrojzasobnik->sp);
	}
}
