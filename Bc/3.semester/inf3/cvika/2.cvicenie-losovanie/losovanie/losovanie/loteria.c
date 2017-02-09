#include <stdlib.h>			//kniznica obsahujuca funkciu min
#include "loteria.h"
#include "data.h"

void vymen(int cislo1, int cislo2);		//kedze funkciu nemame definovanu v hlavickovom subore, mozeme ju dodatocne definovat v zdrojovom subore

void zrebuj(int paPocet)	//paPocet - pocet losovanych zrebov
{
	int pom = min(paPocet, pocetZrebov);
	int index;

	for (int i = 0; i < pom; i++)
	{
		index = rand() % (pocetZrebov - i) + i;	//vyberame nahodne cisla a dolnu hranicu posuvame o 1
		vymen(index, i);	//vymen 
	}
}

void vymen(int cislo1, int cislo2)
{
	struct zreb temp;		//pomocny zreb
	temp.cislo = vyherneZreby[cislo1].cislo;
	strcpy(temp.majitel, vyherneZreby[cislo1].majitel);

	vyherneZreby[cislo1].cislo = vyherneZreby[cislo2].cislo;
	strcpy(vyherneZreby[cislo1].majitel, vyherneZreby[cislo2].majitel);

	vyherneZreby[cislo2].cislo = temp.cislo;
	strcpy(vyherneZreby[cislo2].majitel, temp.majitel);
}