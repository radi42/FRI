#include <stdio.h>

#include "vystup.h"
#include "Data.h"

void vypis(int pocet)
{
	for (int i = 0; i < pocet && i >= 0 && i < POCET_ZREBOV; i++)
	{
		printf("%2d. miesto: %2d\t%s\n", i + 1, zreby[i].cislo, zreby[i].majitel);
	}
}
