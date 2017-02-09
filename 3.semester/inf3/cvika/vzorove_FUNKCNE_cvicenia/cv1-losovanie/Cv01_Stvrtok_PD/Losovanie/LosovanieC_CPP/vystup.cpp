#include <stdio.h>

#include "vystup.h"
#include "data.h"

void vypis(int maxPoradie)
{
	for (int i = 0; i < maxPoradie && i < POCET_ZREBOV; i++)
	{
		printf("%d. miesto: %d - %s\n", i + 1, vyherneZreby[i].cislo, vyherneZreby[i].majitel);
	}
}