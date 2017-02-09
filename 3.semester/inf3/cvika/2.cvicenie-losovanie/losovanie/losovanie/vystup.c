#include "vystup.h"
#include "data.h"
#include <stdio.h>		//kniznica, kt. obsahuje funkciu printf

void vystup(int paPocet)
{
	for (int i = 0; i < paPocet && i < pocetZrebov; i++)
	{
		printf("%2d. zreb: %d. - %4s\n", i+1, vyherneZreby[i].cislo, vyherneZreby[i].majitel); //poradie, cislo zrebu, meno
	}
}