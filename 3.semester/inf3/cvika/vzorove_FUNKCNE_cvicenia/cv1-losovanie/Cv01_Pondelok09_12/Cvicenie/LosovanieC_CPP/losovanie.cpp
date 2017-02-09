#include <stdlib.h>
#include <time.h>
#include <string.h>

#include <stdlib.h>
#include "data.h"

#include "losovanie.h"

void vymen(int idx1, int idx2);

void zrebuj(int pocetVyhernychZrebov)
{
	srand((unsigned)time(NULL));

	int pocet = pocetVyhernychZrebov < POCET_ZREBOV ? pocetVyhernychZrebov : POCET_ZREBOV;

	for (int i = 1; i < pocet; i++)
	{
		int index = rand() % (POCET_ZREBOV - i) + i;
		vymen(index, i - 1);
	}
}


void vymen(int idx1, int idx2)
{
	struct zreb c;

	c.cislo = vyherneZreby[idx1].cislo;
	strcpy(c.majitel, vyherneZreby[idx1].majitel);

	vyherneZreby[idx1].cislo = vyherneZreby[idx2].cislo;
	strcpy(vyherneZreby[idx1].majitel, vyherneZreby[idx2].majitel);

	vyherneZreby[idx2].cislo = c.cislo;
	strcpy(vyherneZreby[idx2].majitel, c.majitel);
}
