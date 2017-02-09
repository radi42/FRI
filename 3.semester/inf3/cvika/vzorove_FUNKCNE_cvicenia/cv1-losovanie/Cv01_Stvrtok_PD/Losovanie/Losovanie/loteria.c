#include <stdlib.h>

#include "loteria.h"
#include "data.h"

void vymen(int idx1, int idx2);

void zrebuj(int pocetMiest)
{
	int index;
	int pocet = min(pocetMiest, POCET_ZREBOV);
	for (int i = 1; i < pocet; i++)
	{
		index = rand() % (POCET_ZREBOV - i) + i;
		vymen(index, i - 1);
	}
}

void vymen(int idx1, int idx2)
{
	struct zreb bufer;
	bufer.cislo = vyherneZreby[idx1].cislo;
	strcpy(bufer.majitel, vyherneZreby[idx1].majitel);

	vyherneZreby[idx1].cislo = vyherneZreby[idx2].cislo;
	strcpy(vyherneZreby[idx1].majitel, vyherneZreby[idx2].majitel);

	vyherneZreby[idx2].cislo = bufer.cislo;
	strcpy(vyherneZreby[idx2].majitel, bufer.majitel);
}