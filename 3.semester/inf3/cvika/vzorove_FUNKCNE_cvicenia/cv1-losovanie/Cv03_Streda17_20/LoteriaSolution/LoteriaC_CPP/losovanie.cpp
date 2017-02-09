#include <time.h>
#include <stdlib.h>
#include <string.h>

#include "data.h"

#include "losovanie.h"

void vymen(int idx1, int idx2);

void zrebuj(unsigned int pocet)
{
	srand((unsigned)time(NULL));

	int maxpocet = pocet > POCET_ZREBOV ? POCET_ZREBOV : pocet;

	for (int i = 1; i < maxpocet; i++)
	{
		int index = rand() % (POCET_ZREBOV - i + 1) + i - 1;
		//int index = rand() % (POCET_ZREBOV - i) + i;
		vymen(index, i - 1);
	}
}


void vymen(int idx1, int idx2)
{
	struct zreb pom;
	pom.cislo = zreby[idx1].cislo;
	strcpy(pom.majitel, zreby[idx1].majitel);

	zreby[idx1].cislo = zreby[idx2].cislo;
	strcpy(zreby[idx1].majitel, zreby[idx2].majitel);

	zreby[idx2].cislo = pom.cislo;
	strcpy(zreby[idx2].majitel, pom.majitel);
}

