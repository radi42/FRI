#include <string.h>

#include "vstup.h"
#include "data.h"

void pripravZreby()
{
	int i = 0;
	// 1.zreb
	vyherneZreby[i].cislo = 12345;
	strcpy(vyherneZreby[i].majitel, "A");
	i++;
	// 2.zreb
	vyherneZreby[i].cislo = 12345 + i;
	strcpy(vyherneZreby[i].majitel, "B");
	i++;
	// 3.zreb
	vyherneZreby[i].cislo = 12345 + i;
	strcpy(vyherneZreby[i].majitel, "C");
	i++;
	// 4.zreb
	vyherneZreby[i].cislo = 12345 + i;
	strcpy(vyherneZreby[i].majitel, "D");
	i++;
	// 5.zreb
	vyherneZreby[i].cislo = 12345 + i;
	strcpy(vyherneZreby[i].majitel, "E");
	i++;
	// 6.zreb
	vyherneZreby[i].cislo = 12345 + i;
	strcpy(vyherneZreby[i].majitel, "F");
	i++;
	// 7.zreb
	vyherneZreby[i].cislo = 12345 + i;
	strcpy(vyherneZreby[i].majitel, "G");
	i++;
	// 8.zreb
	vyherneZreby[i].cislo = 12345 + i;
	strcpy(vyherneZreby[i].majitel, "H");
	i++;
	// 9.zreb
	vyherneZreby[i].cislo = 12345 + i;
	strcpy(vyherneZreby[i].majitel, "I");
	i++;
	// 10.zreb
	vyherneZreby[i].cislo = 12345 + i;
	strcpy(vyherneZreby[i].majitel, "J");
	i++;
}