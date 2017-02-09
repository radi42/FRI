#include <stdlib.h>
#include <time.h>
#include <string.h>

#include "losovanie.h"

#include "Data.h"

void vymen(int ixd1, int idx2);

void zrebuj(int pocet)
{
	srand((unsigned)time(NULL));
	for (int i = 1; i<pocet && i>0 && i < POCET_ZREBOV; i++)
	{
		int idx = rand() % (POCET_ZREBOV - i) + i;
		vymen(idx, i - 1);
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