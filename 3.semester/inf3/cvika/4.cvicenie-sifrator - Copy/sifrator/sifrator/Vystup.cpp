#include "Vystup.h"
#include "pomocnik.h"
#include <cstdio>
#include <string.h>


Vystup::Vystup(const char *aMenoSuboru)
{
	aMenoSuboru = copyString(aMenoSuboru);
}


Vystup::~Vystup()
{
	if (aMenoSuboru)
		delete[] aMenoSuboru;
}

bool Vystup::zapis(const unsigned char *text){
	if (text && *text){		//podobne ako text != NULL && *text != NULL
		FILE *f;
		f = fopen(aMenoSuboru, "wb");

		if (f != NULL){
			int dlzka = strlen((char*)text);
			fwrite(text, dlzka, 1, f);
			fclose(f);
			return true;
		}
	}
	return false;
}
