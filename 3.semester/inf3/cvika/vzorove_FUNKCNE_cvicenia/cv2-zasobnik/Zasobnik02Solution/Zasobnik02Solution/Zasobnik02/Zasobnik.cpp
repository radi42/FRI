#include <cstdlib>
#include <iostream>

#include "Zasobnik.h"
#include "vstup.h"

#define VELKOST_POLA_1 10

using namespace cvstup;
using namespace std;

void init(Zasobnik *zasobnik)
{
	if (zasobnik != NULL)
	{
		zasobnik->pocetPrvkov = 0;
		zasobnik->sp = NULL;
	}
}

int pop(Zasobnik *zasobnik)
{
	int retval = NEPLATNA_HODNOTA;
	if (zasobnik != NULL && zasobnik->pocetPrvkov > 0) // && zasobnik->sp != NULL
	{
		retval = zasobnik->sp->info;
		InfoBox *pombox = zasobnik->sp->dalsi;

		delete zasobnik->sp;
		zasobnik->sp = pombox;
		zasobnik->pocetPrvkov--;
	}
	return retval;
}

bool push(Zasobnik *zasobnik, int val)
{
	if (zasobnik != NULL && val > NEPLATNA_HODNOTA)
	{
		InfoBox *novybox = new InfoBox;
		novybox->info = val;
		novybox->dalsi = NULL;
		if (zasobnik->pocetPrvkov != 0)
			novybox->dalsi = zasobnik->sp;
		zasobnik->sp = novybox;

		zasobnik->pocetPrvkov++;

		return true;
	}
	return false;
}

int peek(Zasobnik *zasobnik)
{
	if (zasobnik != NULL && zasobnik->pocetPrvkov > 0) // && zasobnik->sp != NULL
		return zasobnik->sp->info;
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

void zrus(Zasobnik *zasobnik)
{
	if (zasobnik != NULL)
	{
		while (zasobnik->pocetPrvkov > 0)
			pop(zasobnik);
	}
}

void vloz(Zasobnik *cielzasobnik, InfoBox *box)
{
	if (box->dalsi != NULL)
		vloz(cielzasobnik, box->dalsi);
	push(cielzasobnik, box->info);
}


void kopiruj(Zasobnik *cielzasobnik, const Zasobnik *zdrojzasobnik)
{
	if (cielzasobnik != NULL && zdrojzasobnik != NULL && zdrojzasobnik->pocetPrvkov > 0)
	{
		if (cielzasobnik->pocetPrvkov > 0)
			zrus(cielzasobnik);
		vloz(cielzasobnik, zdrojzasobnik->sp);

	}
}

void kopirujDoPola(Zasobnik *zdrojzasobnik)	//funkcia je obmedzena na 10 prvkov
{
	int pole_1[10] {0};

	if (zdrojzasobnik != NULL && zdrojzasobnik->pocetPrvkov > 0)
	{
		int zaciatocnyPocetPrvkovVZasobniku = (*zdrojzasobnik).pocetPrvkov;
		int pocet = zaciatocnyPocetPrvkovVZasobniku;

		for (zaciatocnyPocetPrvkovVZasobniku; zaciatocnyPocetPrvkovVZasobniku > 0; zaciatocnyPocetPrvkovVZasobniku--)
		{
			pole_1[zaciatocnyPocetPrvkovVZasobniku - 1] = zdrojzasobnik->sp->info;

			InfoBox *pombox = zdrojzasobnik->sp->dalsi;
			delete zdrojzasobnik->sp;
			zdrojzasobnik->sp = pombox;
			zdrojzasobnik->pocetPrvkov--;
		}

		int i = 0;
		for (i; i < pocet; i++)
		{
			cout << pole_1[i] << endl;
		}
	}
}
