#include <cstdio>
#include <cstring>
#include "pomocnik.h"

int lengthFile(const char *meno)
{
	FILE *f = fopen(meno, "rb");
	if (f != NULL)
	{
		fseek(f, 0, SEEK_END);
		int velkost = ftell(f);
		fclose(f);
		return velkost;
	}
	return 0;
}

char *copyString(const char *zdrojtext)
{
	if (zdrojtext && *zdrojtext)
	{
		int dlzka = strlen(zdrojtext);
		char *vystupnyText = new char[dlzka + 1];
		strcpy(vystupnyText, zdrojtext);
		return vystupnyText;
	}
	return NULL;
}