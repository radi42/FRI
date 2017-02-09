#pragma once

#define NEPLATNA_HODNOTA 0

struct InfoBox
{
	int info;
	InfoBox *dalsi;
};

struct Zasobnik
{
	int pocet;
	InfoBox *sp; // Stack Pointer - ukazovatko na prvy dostupny prvok zasobnika, 
				 // ukazovatko na vrchol zasobnika
};

void init(Zasobnik *zasobnik);

int pop(Zasobnik *zasobnik);
bool push(Zasobnik *zasobnik, int val);
int peek(Zasobnik *zasobnik);

void zrus(Zasobnik *zasobnik);
void nacitaj(Zasobnik *zasobnik);
void kopiruj(Zasobnik *cielzasobnik, const Zasobnik *zdrojzasobnik);
