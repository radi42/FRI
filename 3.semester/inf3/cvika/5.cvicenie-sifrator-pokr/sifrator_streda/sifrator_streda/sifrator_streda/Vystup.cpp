#include <cstdio>
#include <cstring>
#include "Vystup.h"
#include "pomocnik.h"


Vystup::Vystup(const char *menoSuboru)
{
	aMenoSuboru = copyString(menoSuboru);
}


Vystup::~Vystup()
{
	if (aMenoSuboru)
		delete[] aMenoSuboru;
}
bool Vystup::zapis(const unsigned char *text)
{
	if (text && *text)
	{
		FILE *f;
		f = fopen(aMenoSuboru, "wb");
		if (f != NULL)
		{
			int dlzka = strlen((char *)text);
			fwrite(text, dlzka, 1, f);
			fclose(f);
			return true;
		}
	}
	return false;
}