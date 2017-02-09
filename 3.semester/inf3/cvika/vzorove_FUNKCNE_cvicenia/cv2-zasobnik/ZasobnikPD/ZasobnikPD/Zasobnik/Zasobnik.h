#pragma once

struct InfoBox
{
	int cislo;
	InfoBox *dalsi;
};

struct Zasobnik
{
	int pocet;
	InfoBox *sp;
};

void init(Zasobnik *zasobnik);
bool push(Zasobnik *zasobnik, int x);
int pop(Zasobnik *zasobnik);
int peek(Zasobnik *zasobnik);
void clear(Zasobnik *zasobnik);
void copy(Zasobnik *cielZasobnik, const Zasobnik *zdrojZasobnik);
void nacitaj(Zasobnik *cielZasobnik);
