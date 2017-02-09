#include <stdio.h>

#include "vystup.h"
#include "data.h"

void vypis(unsigned int pocetNaVypis)
{
	for (int i = 0; i < pocetNaVypis && i < POCET_ZREBOV; i++)
		printf("%2d. miesto: %2d\t%s\n", i + 1, zreby[i].cislo, zreby[i].majitel);
}