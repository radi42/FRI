#pragma once		//zabranuje duplicitnemu definovaniu premennych (definovanie viacerych duplicitnych premennych bude ignorovat)

#define pocetZrebov	10	//definovanie poctu zrebov

struct zreb			//struct je premenna, ktora uklada
{
	int cislo;
	char majitel [21];	//pole znakov, pole sa ukoncuje ukoncovacim znakom, a za ukoncovacim znakom musi byt este jedno miesto volne
};					//bodkociarka tu musi byt, lebo je to definicia premennej nie metody ;)

extern struct zreb vyherneZreby[pocetZrebov];	//extern - rozsirenie 