#pragma once

#define NeplatnaHodnota 0

struct InfoBox
{
	int hodnota;
	InfoBox *pointer;
};

struct Zasobnik
{
	int pocet;
	InfoBox *sp;					//sp = stackpointer
};

void init(Zasobnik *zasobnik);	//pocet bude 0 a smernik bude ukazovat na nulu, pamatame si oba adresy na dalsi prvok, preto pointer (*)
bool push(Zasobnik *zasobnik, int x);//vloz kam, vloz co
int pop(Zasobnik *zasobnik);	//vyber
int peek(Zasobnik *zasobnik);	//vyhladaj

void nacitaj(Zasobnik *mojZasobnik);	//nacitaj
void zrus(Zasobnik *zasobnik);			//zrusi cely zasobnik
void copy(Zasobnik *mojZasobnik, const Zasobnik *zdrojZasobnik);				//kopiruj zo zdroja do mojho zasobnika, zdroj sa nesmie menit
