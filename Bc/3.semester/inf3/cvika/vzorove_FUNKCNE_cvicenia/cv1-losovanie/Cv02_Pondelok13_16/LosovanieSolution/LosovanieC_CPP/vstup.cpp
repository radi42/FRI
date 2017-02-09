#include <string.h>

#include "vstup.h"
#include "Data.h"

void pripravZreby()
{
	int i = 0;
	zreby[i].cislo = i + 1;
	strcpy(zreby[i].majitel, "A");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	zreby[i].cislo = i + 1;
	strcpy(zreby[i].majitel, "B");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	zreby[i].cislo = i + 1;
	strcpy(zreby[i].majitel, "C");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	zreby[i].cislo = i + 1;
	strcpy(zreby[i].majitel, "D");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	zreby[i].cislo = i + 1;
	strcpy(zreby[i].majitel, "E");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	zreby[i].cislo = i + 1;
	strcpy(zreby[i].majitel, "F");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	zreby[i].cislo = i + 1;
	strcpy(zreby[i].majitel, "G");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	zreby[i].cislo = i + 1;
	strcpy(zreby[i].majitel, "H");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	zreby[i].cislo = i + 1;
	strcpy(zreby[i].majitel, "I");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	zreby[i].cislo = i + 1;
	strcpy(zreby[i].majitel, "J");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	zreby[i].cislo = i + 1;
	strcpy(zreby[i].majitel, "K");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	zreby[i].cislo = i + 1;
	strcpy(zreby[i].majitel, "L");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	zreby[i].cislo = i + 1;
	strcpy(zreby[i].majitel, "M");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	zreby[i].cislo = i + 1;
	strcpy(zreby[i].majitel, "N");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	zreby[i].cislo = i + 1;
	strcpy(zreby[i].majitel, "O");
	i++;
	if (i >= POCET_ZREBOV)
		return;
}