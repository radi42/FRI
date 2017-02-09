#pragma once

#define NEPLATNA_HODNOTA 0

struct Zasobnik
{
	struct InfoBox
	{
		unsigned int info;
		InfoBox *dalsi;
	} *sp;

	unsigned int pocet;
};

void init(Zasobnik *zasobnik);
void zrus(Zasobnik *zasobnik);
unsigned int pop(Zasobnik *zasobnik);
bool push(Zasobnik *zasobnik, unsigned int val);
unsigned int peek(Zasobnik *zasobnik);
void nacitaj(Zasobnik *zasobnik);
void kopiruj(Zasobnik *cielzasobnik, const Zasobnik *zdrojzasobnik);

