#pragma once

#define NEPLATNA_HODNOTA 0

struct InfoBox 
{
	unsigned int info;
	InfoBox *dalsi;
};

struct Zasobnik 
{
	unsigned int pocet;
	InfoBox *sp;
};

void init(Zasobnik *zasobnik);
void zrus(Zasobnik *zasobnik);

bool push(Zasobnik *zasobnik, unsigned int val);
unsigned int pop(Zasobnik *zasobnik);
unsigned int peek(Zasobnik *zasobnik);

void nacitaj(Zasobnik *zasobnik);
void kopiruj(Zasobnik *cielzasobnik, const Zasobnik *zdrojzasobnik);