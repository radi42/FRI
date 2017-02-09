#include <stdio.h>

#include "vystup.h"
#include "data.h"

void vypis(int pocet)
{
	for (int i = 0; i < POCET_ZREBOV && i < pocet; i++)
	{
		printf("%2d. miesto: %2d\t%s\n", i + 1, vyherneZreby[i].cislo, vyherneZreby[i].majitel);
	}
}