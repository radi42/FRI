#include <stdlib.h>
#include <string.h>

#include <time.h>

#include "loteria.h"
#include "data.h"

void vymen(int idx1, int idx2);

void zrebuj(int pocet)
{
	srand((unsigned)time(NULL));

	int maxpocet = pocet > POCET_ZREBOV ? POCET_ZREBOV : pocet;

	for (int i = 1; i < maxpocet; i++)
	{
		int index = rand() % (POCET_ZREBOV - i + 1) + i - 1;
		vymen(index, i - 1);
	}
}

void vymen(int idx1, int idx2)
{
	struct zreb c;

	c.cislo = zreby[idx1].cislo;
	strcpy(c.majitel, zreby[idx1].majitel);

	zreby[idx1].cislo = zreby[idx2].cislo;
	strcpy(zreby[idx1].majitel, zreby[idx2].majitel);

	zreby[idx2].cislo = c.cislo;
	strcpy(zreby[idx2].majitel, c.majitel);
}

//void vymen(int idx1, int idx2)
//{
//	struct zreb c;
//
//	memmove(&c, &zreby[idx1], sizeof(c));
//	memmove(&zreby[idx1], &zreby[idx2], sizeof(c));
//	memmove(&zreby[idx2], &c,sizeof(c));
//}