#include <cstdio>
#include "Vstup.h"
#include "pomocnik.h"


Vstup::Vstup(const char *menoSuboru)
{
	aMenoSuboru = copyString(menoSuboru);
}


Vstup::~Vstup()
{
	if (aMenoSuboru)
		delete[] aMenoSuboru;
}

unsigned char *Vstup::nacitaj(){
	unsigned char *text { NULL };	//*text { NULL } je to iste ako *text = NULL
	if (aMenoSuboru){
		FILE *f;
		f = fopen(aMenoSuboru, "rb");
		if (f != NULL){
			int dlzka = lengthFile(aMenoSuboru);
			if (dlzka > 0){
				text = new unsigned char[dlzka + 1];
				fread(text, dlzka, 1, f);
				text[dlzka] = '\0';
			}
			fclose(f);
		}
	}
	return text;
}
