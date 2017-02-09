#include <string.h>

#include "vstup.h"
#include "data.h"

void pripravZreby()
{
	int i = 0;
	vyherneZreby[i].cislo = i + 1;
	strcpy(vyherneZreby[i].majitel, "A");

	i++;
	if (i >= POCET_ZREBOV)
		return;

	vyherneZreby[i].cislo = i + 1;
	strcpy(vyherneZreby[i].majitel, "B");
	i++;
	if (i >= POCET_ZREBOV)
		return;

	vyherneZreby[i].cislo = i + 1;
	strcpy(vyherneZreby[i].majitel, "C");
	i++;
	if (i >= POCET_ZREBOV)
		return;

	vyherneZreby[i].cislo = i + 1;
	strcpy(vyherneZreby[i].majitel, "D");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	vyherneZreby[i].cislo = i + 1;
	strcpy(vyherneZreby[i].majitel, "E");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	vyherneZreby[i].cislo = i + 1;
	strcpy(vyherneZreby[i].majitel, "F");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	vyherneZreby[i].cislo = i + 1;
	strcpy(vyherneZreby[i].majitel, "G");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	vyherneZreby[i].cislo = i + 1;
	strcpy(vyherneZreby[i].majitel, "H");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	vyherneZreby[i].cislo = i + 1;
	strcpy(vyherneZreby[i].majitel, "I");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	vyherneZreby[i].cislo = i + 1;
	strcpy(vyherneZreby[i].majitel, "J");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	vyherneZreby[i].cislo = i + 1;
	strcpy(vyherneZreby[i].majitel, "K");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	vyherneZreby[i].cislo = i + 1;
	strcpy(vyherneZreby[i].majitel, "L");
	i++;
	if (i >= POCET_ZREBOV)
		return;
	vyherneZreby[i].cislo = i + 1;
	strcpy(vyherneZreby[i].majitel, "M");
	i++;
	if (i >= POCET_ZREBOV)
		return;
}